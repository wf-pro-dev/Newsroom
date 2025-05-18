from flask import Blueprint, jsonify
from Backend.server.models.db_videos import videos
from database.connection import db

videos_bp = Blueprint("videos", __name__)


@videos_bp.route("/videos/all", methods=["GET"])
def get_videos():
    list_video = videos.query.all()
    return jsonify([video.to_dict() for video in list_video])


@videos_bp.route("/videos/delete/<int:id>", methods=["DELETE"])
def delete_video_by_id(id):
    try:
        video = videos.query.filter_by(id=id).one_or_none()
        if video:
            db.session.delete(video)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@videos_bp.route("/videos/question/<int:question_id>", methods=["GET"])
def get_video_by_qst(question_id):
    list_video = videos.query.filter_by(question_id=question_id).all()
    return jsonify([video.to_dict() for video in list_video])
