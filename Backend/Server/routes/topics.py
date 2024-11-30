from flask import Blueprint, jsonify, request

from server.models.db_topic import topics

from database.connection import db

topics_bp = Blueprint("topics", __name__)

@topics_bp.route("/topics", methods=["GET"])
def get_topics():
    list_topic = topics.query.all()
    return jsonify([topic.to_dict() for topic in list_topic])


@topics_bp.route("/topics/<int:id>", methods=["GET"])
def get_topic(id):
    try:
        topic = topics.query.filter_by(id=id).one()
        
        return jsonify(topic.to_dict()), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 404

@topics_bp.route("/topics", methods=["POST"])
def add_topic():
    try:
        
        data = request.get_json()
        topic = topics(title=data["topic"], role=data["role"])
       
        db.session.add(topic)
        db.session.commit()
        return jsonify(topic.to_dict()), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400