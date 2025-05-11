import os
from sys import path
from flask import Blueprint, request, jsonify, current_app
from flask_jwt_extended import jwt_required, get_jwt_identity
from flask_wtf.csrf import validate_csrf
from sqlalchemy.exc import SQLAlchemyError

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

# Import your database models
from database.connection import db
from server.models.db_users import users
from server.models.db_topic import topics
from server.models.db_question import questions
from server.models.db_article import articles
from server.models.db_video import videos
from server.models.db_hidden_questions import hidden_questions
from server.models.db_hidden_articles import hidden_articles
from server.models.db_hidden_videos import hidden_videos
from server.models.db_refresh import refresh
from seeds.seed_questions import seed_questions

# Create a blueprint for content visibility routes
refresh_bp = Blueprint('refresh', __name__)

# ============= HIDE/UNHIDE CONTENT ============= #

@refresh_bp.route("/refresh/<int:question_id>", methods=["POST"])
@jwt_required()
def refresh_question(question_id):
    
    # Get CSRF token from header
    csrf_token = request.headers.get('X-CSRF-TOKEN')
    current_app.logger.info(f"Register attempt with CSRF Token: {csrf_token}")

    # Validate CSRF token
    try:
        validate_csrf(csrf_token)
    except Exception as e:
        current_app.logger.error(f"CSRF validation error during registration: {e}")
        return jsonify({"error": "Invalid or missing CSRF token"}), 403

    try:
        
        question = questions.query.filter(questions.id == question_id).one() # Question to hide (object) 
        
        # get current user

        current_user_id = get_jwt_identity()


        # Hide current question from current user

        hidden_question = hidden_questions(
                question_id = question_id,
                user_id = current_user_id
        )

        db.session.add(hidden_question)
        db.session.commit()
        
        
        # Generate new question

        topic = topics.query.filter(topics.id == question.topic_id).one() # Topic related to the question (object)
        
        list_question = topic.set_questions(n_qst=1) # Generate and Save the new question object

        seed_questions(questions=list_question, topic=topic) # Generate content for new question

        new_question = list_question[0] # ONLY one new question per refresh
     
        new_question.order = question.order # Set the desired order value for the new question

        # Save the refresh
        
        new_refresh = refresh(
                question_id = new_question.id,
                user_id = current_user_id
        )

        db.session.add(new_refresh)
        db.session.commit()
        

        # Create response for client side
        
        response_data = new_question.to_dict()
        
        response_data["articles"] = [
            article.to_dict() for article in articles.query.filter_by(question_id=new_question.id).all()
        ] # Add articles data to the response
        
        response_data["videos"] = [
            video.to_dict() for video in videos.query.filter_by(question_id=new_question.id).all()
        ] # Add vidoes data to the response
        

        return jsonify(response_data), 200

    except SQLAlchemyError as e:
        current_app.logger.error(f"Database error: {str(e)}")
        return jsonify({'error': 'Database error occurred'}), 500
    except Exception as e:
        current_app.logger.error(f"Error refreshing euestions: {str(e)}")
        return jsonify({'error': 'An error occurred'}), 500

