from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, jsonify, request
from database.operations import (
    get_all, get_by_question_id, delete_by_id, 
    insert_data
)

videos_bp = Blueprint('videos', __name__)

@videos_bp.route('/Videos', methods=['GET'])
def get_videos():
    videos = get_all("Videos")
    return jsonify(videos)

@videos_bp.route('/Videos/<question_id>', methods=['GET'])
def get_video_by_qst(question_id):
    videos = get_by_question_id("Videos", question_id)
    return jsonify(videos)

@videos_bp.route('/Videos/<id>', methods=['DELETE'])
def delete_video_by_id(id):
    try:
        delete_by_id("Videos", id)
        return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@videos_bp.route('/Fav_Videos', methods=['GET'])
def get_fav_video():
    favorites = get_all("Fav_Videos")
    return jsonify(favorites)

@videos_bp.route('/Fav_Videos', methods=['POST'])
def add_fav_video():
    data = request.json
    
    required_fields = [
        'question_id', 'video_id', 'description', 
        'thumbnail', 'orientation', 'obj_id'
    ]
    
    if not all(data.get(field) for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400
    
    try:
        insert_data("Fav_Videos", data)
        return jsonify({"message": "Item added to favorites successfully"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@videos_bp.route('/Fav_Videos/<id>', methods=['DELETE'])
def delete_fav_video_by_id(id):
    try:
        delete_by_id("Fav_Videos", id)
        return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500