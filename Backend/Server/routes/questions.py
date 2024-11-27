from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, request, jsonify
from Server.models.db_question import questions
from database.connection import db

# Create Blueprint for questions routes
questions_bp = Blueprint("questions", __name__)


@questions_bp.route("/questions", methods=["GET"])
def get_topics():
    list_question = questions.query.all()
    return jsonify([question.to_dict() for question in list_question])


@questions_bp.route("/questions", methods=["POST"])
def add_question():
    try:
        data = request.get_json()
        question = questions(text=data["text"])
        db.session.add(question)
        db.session.commit()
        return jsonify(question.to_dict()), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 400


@questions_bp.route("/questions/<int:question_id>", methods=["GET"])
def get_question(question_id):
    try:
        # Here you would typically fetch the article from your database
        # This is a placeholder response
        return jsonify({"message": f"Question {question_id} retrieved"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 404


# Add more routes as needed (PUT, DELETE, etc.)
