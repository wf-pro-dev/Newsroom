import os
from sys import path
from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy import and_, not_

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

# Import your database models
from database.connection import db
from server.models.db_articles import articles
from server.models.db_videos import videos
from server.models.db_question import questions 
from server.models.db_hidden_articles import hidden_articles
from server.models.db_hidden_videos import hidden_videos
from server.models.db_hidden_questions import hidden_questions
from server.models.db_refresh import refresh

# Create a blueprint for content visibility routes
hidden_bp = Blueprint('hidden', __name__)

# ============= HIDE/UNHIDE CONTENT ============= #

@hidden_bp.route('/content/<string:content_type>/<int:content_id>/hide', methods=['POST'])
@jwt_required()
def hide_content(content_type, content_id):
    """
    Hide content (article or video) for the current user
    
    URL Params:
    - content_type: 'article' or 'video'
    - content_id: ID of the content to hide
    
    Returns:
    - JSON confirmation message
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Validate content type
        if content_type not in ['article', 'video']:
            return jsonify({'error': 'Invalid content type. Must be "article" or "video"'}), 400
            
        # Check if the content exists and create hidden entry based on content type
        if content_type == 'article':
            # Check if article exists
            content = articles.query.get(content_id)
            if not content:
                return jsonify({'error': 'Article not found'}), 404
                
            # Check if already hidden
            existing_hidden = hidden_articles.query.filter_by(
                article_id=content_id,
                user_id=current_user_id
            ).first()
            
            if existing_hidden:
                return jsonify({'message': 'Article is already hidden'}), 200
            
            # Create new hidden entry
            new_hidden = hidden_articles(
                article_id=content_id,
                user_id=current_user_id
            )
            
        else:  # content_type == 'video'
            # Check if video exists
            content = videos.query.get(content_id)
            if not content:
                return jsonify({'error': 'Video not found'}), 404
                
            # Check if already hidden
            existing_hidden = hidden_videos.query.filter_by(
                video_id=content_id,
                user_id=current_user_id
            ).first()
            
            if existing_hidden:
                return jsonify({'message': 'Video is already hidden'}), 200
            
            # Create new hidden entry
            new_hidden = hidden_videos(
                video_id=content_id,
                user_id=current_user_id
            )
        
        # Add to database and commit
        db.session.add(new_hidden)
        db.session.commit()
        
        return jsonify({'message': f'{content_type.capitalize()} hidden successfully'}), 200
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error hiding content: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

@hidden_bp.route('/content/<string:content_type>/<int:content_id>/unhide', methods=['POST'])
@jwt_required()
def unhide_content(content_type, content_id):
    """
    Unhide content (article or video) for the current user
    
    URL Params:
    - content_type: 'article' or 'video'
    - content_id: ID of the content to unhide
    
    Returns:
    - JSON confirmation message
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Validate content type
        if content_type not in ['article', 'video']:
            return jsonify({'error': 'Invalid content type. Must be "article" or "video"'}), 400
            
        # Find and delete the hidden entry based on content type
        if content_type == 'article':
            hidden_entry = hidden_articles.query.filter_by(
                article_id=content_id,
                user_id=current_user_id
            ).first()
        else:  # content_type == 'video'
            hidden_entry = hidden_videos.query.filter_by(
                video_id=content_id,
                user_id=current_user_id
            ).first()
        
        if not hidden_entry:
            return jsonify({'message': f'{content_type.capitalize()} is not hidden'}), 200
        
        # Delete the entry and commit
        db.session.delete(hidden_entry)
        db.session.commit()
        
        return jsonify({'message': f'{content_type.capitalize()} unhidden successfully'}), 200
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error unhiding content: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

# ============= HIDE/UNHIDE QUESTION ============= #

@hidden_bp.route('/question/<int:question_id>/hide', methods=['POST'])
@jwt_required()
def hide_question_content(question_id):
    """
    Unhide all articles and videos related to a specific question for the current user

    URL Params:
    - question_id: ID of the question whose content should be unhidden

    Returns:
    - JSON confirmation message with counts of unhidden items
    """
    try:
        
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()

        new_hidden = hidden_questions(
            question_id=question_id,
            user_id=current_user_id
        )
        
        db.session.add(new_hidden)
        db.session.commit()
        
        return jsonify({'message': f'Question {question_id}  hidden successfully'}), 200
        
    except SQLAlchemyError as e:
        db.session.rollback()
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error hiding question content: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

# ============= GET VISIBLE CONTENT ============= #

@hidden_bp.route('/articles', methods=['GET'])
@jwt_required()
def get_visible_articles():
    """
    Get all articles that are not hidden for the current user
    
    Query params:
    - question_id: Optional filter by question ID
    
    Returns:
    - JSON list of visible articles
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Get optional question_id filter
        question_id = request.args.get('question_id', type=int)
        
        # Base query
        query = articles.query
        
        # Apply question_id filter if provided
        if question_id:
            query = query.filter(articles.question_id == question_id)
        
        # Exclude articles that are hidden for this user
        hidden_article_ids = db.session.query(hidden_articles.article_id).filter(
            hidden_articles.user_id == current_user_id
        )
        query = query.filter(not_(articles.id.in_(hidden_article_ids)))
        
        # Execute query and get all visible articles
        visible_articles = query.all()
        
        # Convert to dictionary format
        result = [article.to_dict() for article in visible_articles]
        
        return jsonify({'articles': result}), 200
        
    except SQLAlchemyError as e:
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error getting articles: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

@hidden_bp.route('/videos', methods=['GET'])
@jwt_required()
def get_visible_videos():
    """
    Get all videos that are not hidden for the current user
    
    Query params:
    - question_id: Optional filter by question ID
    
    Returns:
    - JSON list of visible videos
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Get optional question_id filter
        question_id = request.args.get('question_id', type=int)
        
        # Base query
        query = videos.query
        
        # Apply question_id filter if provided
        if question_id:
            query = query.filter(videos.question_id == question_id)
        
        # Exclude videos that are hidden for this user
        hidden_video_ids = db.session.query(hidden_videos.video_id).filter(
            hidden_videos.user_id == current_user_id
        )
        query = query.filter(not_(videos.id.in_(hidden_video_ids)))
        
        # Execute query and get all visible videos
        visible_videos = query.all()
        
        # Convert to dictionary format
        result = [video.to_dict() for video in visible_videos]
        
        return jsonify({'videos': result}), 200
        
    except SQLAlchemyError as e:
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error getting videos: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500


@hidden_bp.route('/questions', methods=['GET'])
@jwt_required()
def get_visible_questions():
    """
    Get all question that are not hidden for the current user
    
    Query params:
    - question_id: Optional filter by question ID
    
    Returns:
    - JSON list of visible articles
    """
    try:
        # Get the current user's ID from the JWT token
        current_user_id = get_jwt_identity()
        
        # Get optional question_id filter
        question_id = request.args.get('question_id', type=int)
        
        # Base query
        query = questions.query 
        
        # Exclude questions that are hidden for this user
        hidden_question_ids = db.session.query(hidden_questions.question_id).filter(
            hidden_questions.user_id == current_user_id
        )
        query = query.filter(not_(questions.id.in_(hidden_question_ids)))

        # Exclude questions that come from other users refresh
        refresh_questions_ids = db.session.query(refresh.question_id).filter(
            refresh.user_id != current_user_id
        )
        
        query = query.filter(not_(questions.id.in_(refresh_questions_ids)))

        # Execute query and get all visible articles
        visible_questions = query.all()
        
        # Convert to dictionary format
        result = [question.to_dict() for question in visible_questions]
        
        return jsonify({'questions': result}), 200

    except SQLAlchemyError as e:
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error getting questions: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

