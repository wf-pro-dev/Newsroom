from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, jsonify, request
from database.operations import (
    get_all, get_by_question_id, delete_by_id, 
    insert_data
)

articles_bp = Blueprint('articles', __name__)

@articles_bp.route('/Articles', methods=['GET'])
def get_articles():
    articles = get_all("Articles")
    return jsonify(articles)

@articles_bp.route('/Articles/<question_id>', methods=['GET'])
def get_article_by_qst(question_id):
    articles = get_by_question_id("Articles", question_id)
    return jsonify(articles)

@articles_bp.route('/Articles/<id>', methods=['DELETE'])
def delete_article_by_id(id):
    try:
        delete_by_id("Articles", id)
        return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@articles_bp.route('/Fav_Articles', methods=['GET'])
def get_fav_article():
    favorites = get_all("Fav_Articles")
    return jsonify(favorites)

@articles_bp.route('/Fav_Articles', methods=['POST'])
def add_fav_article():
    data = request.json
    
    required_fields = [
        'score', 'id', 'question_id', 'title', 'description',
        'content', 'url', 'urlToImage', 'publishedAt', 
        'api_source', 'obj_id'
    ]
    
    if not all(data.get(field) for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400
    
    try:
        insert_data("Fav_Articles", data)
        return jsonify({"message": "Item added to favorites successfully"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@articles_bp.route('/Fav_Articles/<id>', methods=['DELETE'])
def delete_fav_article_by_id(id):
    try:
        delete_by_id("Fav_Articles", id)
        return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500