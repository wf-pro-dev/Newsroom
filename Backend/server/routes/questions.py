from sys import path

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, request, jsonify
from server.models.db_question import questions
from server.models.db_topic import topics
from server.models.db_article import articles
from server.models.db_video import videos
from seeds.seed_questions import seed_questions
from database.connection import db

# Create Blueprint for questions routes
questions_bp = Blueprint("questions", __name__)


@questions_bp.route("/questions", methods=["GET"])
def get_questions():
    list_question = questions.query.all()
    return jsonify([question.to_dict() for question in list_question])


@questions_bp.route("/questions/<int:id>", methods=["GET"])
def get_question(id):
    try:
        question = questions.query.filter_by(id=id).one()

        return jsonify(question.to_dict()), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 404


@questions_bp.route("/questions/<int:topic_id>", methods=["POST"])
def add_question(topic_id):
    try:

        topic = topics.query.filter_by(id=topic_id).one()
        list_question = topic.set_questions(n_qst=1)
        seed_questions(questions=list_question, topic=topic)

        response_data = []
        for question in list_question:
            question_dict = question.to_dict()
            question_dict["articles"] = [
                article.to_dict() for article in articles.query.filter_by(question_id=question.id).all()
            ]
            question_dict["videos"] = [
                video.to_dict() for video in videos.query.filter_by(question_id=question.id).all()
            ]
            response_data.append(question_dict)

        return jsonify(response_data), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 400


@questions_bp.route("/questions/delete/<int:id>", methods=["DELETE"])
def delete_question_by_id(id):
    try:
        question = questions.query.filter_by(id=id).one()
        if question:
            list_article = articles.query.filter_by(question_id=id).all()
            list_video = videos.query.filter_by(question_id=id).all()
            
            for article in list_article:
                db.session.delete(article)
            
            
            for video in list_video:
                db.session.delete(video)
            
            
            db.session.delete(question)
            db.session.commit()
            return (
                jsonify({"message": f"Question {id} deleted successfully"}),
                200,
            )
        else:
            return jsonify({"error": "Item not found"}), 404

    except Exception as e:
        return jsonify({"error": str(e)}), 404


# Add more routes as needed (PUT, DELETE, etc.)
