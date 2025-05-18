from sys import path
import os
from flask import Blueprint, jsonify, request, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import select

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db
from server.models.db_fav_articles import fav_articles
from Backend.server.models.db_articles import articles

fav_articles_bp = Blueprint("fav_articles", __name__)


@fav_articles_bp.route("/favorites/articles", methods=["GET"])
@jwt_required()
def get_fav_articles():
    
    # Get the current user's ID from the JWT token
    current_user_id = get_jwt_identity()
    
    articles = fav_articles.query.filter_by(user_id=current_user_id).all()
    
    return jsonify([article.to_dict() for article in articles])

@fav_articles_bp.route('/favorites/add/article', methods=['POST'])
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
        
        article_id = data['article_id']
        
        # Check if the article exists
        article = articles.query.get(article_id)
        if not article:
            return jsonify({'error': 'Article not found'}), 404
            
        # Check if the article is already favorited by this user
        existing_favorite = fav_articles.query.filter_by(
            article_id=article_id,
            user_id=current_user_id
        ).first()
        
        if existing_favorite:
            return jsonify({'error': 'Article already in favorites'}), 409
        
        # Create a new favorite article
        new_favorite = fav_articles(
            
            article_id=article_id,  # Reference to the original article
            user_id=current_user_id,
            
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

@fav_articles_bp.route("/favorites/delete/article/<int:id>", methods=["DELETE"])
def delete_article_by_id(id):
    try:
        fav_article = fav_articles.query.filter_by(id=id).one_or_none()
        if fav_article:
            db.session.delete(fav_article)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500
