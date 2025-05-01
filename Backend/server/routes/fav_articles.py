from sys import path
import os
from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from server.models.db_fav_articles import fav_articles
from database.connection import db

fav_articles_bp = Blueprint("fav_articles", __name__)


@favourites_bp.route("/favourites/articles", methods=["GET"])
def get_fav_articles():
    articles = fav_articles.query.all()
    return jsonify([article.to_dict() for article in articles)

@fav_articles_bp.route('/favorite/add/article', methods=['POST'])
@jwt_required()
def add_favorite_article():
    """
    Add an article to the user's favorites
    
    POST data:
    - article_id: ID of the article to favorite
    - notes: Optional notes about the favorited article
    
    Returns:
    - JSON with the created favorite article
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Get the request data
        data = request.get_json()
        
        if not data or 'article_id' not in data:
            return jsonify({'error': 'Article ID is required'}), 400
        
        # Check if the article is already favorited by this user
        existing_favorite = fav_articles.query.filter_by(
            title=title, # TEMP
            user_id=current_user_id
        ).first()
        
        if existing_favorite:
            return jsonify({'error': 'Article already in favorites'}), 409
        
        # Create a new favorite article
        new_favorite = fav_articles(
            user_id=current_user_id,
            # Copy all data from the original article
            score=article.score,
            question_id=article.question_id,
            api_source=article.api_source,
            title=article.title,
            description=article.description,
            content=article.content,
            url=article.url,
            urlToImage=article.urlToImage,
            publishedAt=article.publishedAt
        )
        
        # Add to database and commit
        db.session.add(new_favorite)
        db.session.commit()
        
        # Return the favorite article as JSON
        return jsonify({
            'message': 'Article added to favorites successfully',
            'favorite': new_favorite.to_dict()
        }), 201
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error adding favorite: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500
