from flask import Blueprint, jsonify
from Server.models.db_topic import topics

topics_bp = Blueprint("topics", __name__)

@topics_bp.route("/topics", methods=["GET"])
def get_topics():
    list_topic = topics.query.all()
    return jsonify([topic.to_dict() for topic in list_topic])
