from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, request, jsonify
from core.models.article import Article
from database.operations import get_all

# Create Blueprint for questions routes
questions_bp = Blueprint('questions', __name__)


@questions_bp.route('/Questions', methods=['GET'])
def get_topics():
    topics = get_all("Questions")
    return jsonify(topics)

@questions_bp.route('/Questions', methods=['POST'])
def add_question():
    try:
        data = request.get_json()
        
        # Create Article object from request data
        article = Article(data['article'])
        
        # Set additional properties if needed
        if 'score' in data:
            article.set_score(data['score'])
        if 'question_id' in data:
            article.set_question_id(data['question_id'])
        
        # Convert to dictionary for response
        response = article.to_dict()
        
        return jsonify(response), 201
    
    except Exception as e:
        return jsonify({'error': str(e)}), 400

@questions_bp.route('/Questions/<int:question_id>', methods=['GET'])
def get_question(question_id):
    try:
        # Here you would typically fetch the article from your database
        # This is a placeholder response
        return jsonify({'message': f'Question {question_id} retrieved'}), 200
    
    except Exception as e:
        return jsonify({'error': str(e)}), 404

# Add more routes as needed (PUT, DELETE, etc.)
