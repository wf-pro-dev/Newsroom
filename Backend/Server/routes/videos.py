from flask import Blueprint, jsonify, request
from Server.models.db_video import videos, fav_videos
from database.connection import db

videos_bp = Blueprint("videos", __name__)

@videos_bp.route("/videos", methods=["GET"])
def get_videos():
    list_video = videos.query.all()
    return jsonify([video.to_dict() for video in list_video])

@videos_bp.route("/videos/<int:question_id>", methods=["GET"])
def get_video_by_qst(question_id):
    list_video = videos.query.filter_by(question_id=question_id).all()
    return jsonify([video.to_dict() for video in list_video])

@videos_bp.route("/videos/<int:id>", methods=["DELETE"])
def delete_video_by_id(id):
    try:
        video = videos.query.get(id)
        if video:
            db.session.delete(video)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@videos_bp.route("/fav_videos", methods=["GET"])
def get_fav_video():
    favorites = fav_videos.query.all()
    return jsonify([fav.to_dict() for fav in favorites])

@videos_bp.route("/fav_videos", methods=["POST"])
def add_fav_video():
    data = request.json

    required_fields = [
        "question_id", "video_id", "description", "thumbnail", "orientation", "obj_id"
    ]

    if not all(data.get(field) for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    try:
        fav_video = fav_videos(**data)
        db.session.add(fav_video)
        db.session.commit()
        return jsonify({"message": "Item added to favorites successfully"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@videos_bp.route("/fav_videos/<int:id>", methods=["DELETE"])
def delete_fav_video_by_id(id):
    try:
        fav_video = fav_videos.query.get(id)
        if fav_video:
            db.session.delete(fav_video)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500