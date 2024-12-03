from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, request, jsonify
from server.models.db_question import questions
from database.connection import db

# Create Blueprint for questions routes
questions_bp = Blueprint("questions", __name__)


@questions_bp.route("/questions", methods=["GET"])
def get_topics():
    list_question = questions.query.all()
    return jsonify([question.to_dict() for question in list_question])


@questions_bp.route("/questions/<int:id>", methods=["GET"])
def get_question(id):
    try:
        question = questions.query.filter_by(id=id).one()

        return jsonify(question.to_dict()), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 404


@questions_bp.route("/questions", methods=["POST"])
def add_question():
    try:
        data = request.get_json()
        question = questions(text=data["text"], keywords=data["keywords"])
        db.session.add(question)
        db.session.commit()
        return jsonify(question.to_dict()), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400


# Add more routes as needed (PUT, DELETE, etc.)
