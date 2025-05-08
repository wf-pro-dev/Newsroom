from sys import path
from flask_jwt_extended import get_jwt_identity, jwt_required

path.append("/Users/williamfotso/Workspace/Newsroom/Backend")

from flask import Blueprint, request, jsonify
from server.models.db_question import questions
from server.models.db_topic import topics
from server.models.db_article import articles
from server.models.db_video import videos
from server.models.db_users import users
from server.models.db_hidden_articles import hidden_articles
from server.models.db_hidden_videos import hidden_videos
from server.models.db_hidden_questions import hidden_questions
from seeds.seed_questions import seed_questions
from database.connection import db

# Create Blueprint for questions routes
questions_bp = Blueprint("questions", __name__)

@questions_bp.route("/questions/<int:id>", methods=["GET"])
def get_question(id):
    try:
        question = questions.query.filter_by(id=id).one()

        return jsonify(question.to_dict()), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 404


@questions_bp.route("/questions/delete/<int:id>", methods=["DELETE"])
def delete_question_by_id(id):
    try:
        
        question = questions.query.filter_by(id=id).one()
        if question:
            list_article = articles.query.filter_by(question_id=id).all()
            list_video = videos.query.filter_by(question_id=id).all()
       
            for article in list_article:
                db.session.delete(article)
                db.session.commit()
            
            
            for video in list_video:
                db.session.delete(video)
                db.session.commit()
           
            
            db.session.delete(question)
            db.session.commit()
            return (
                jsonify({"message": f"Question {id} deleted successfully"}),
                200,
            )
        else:
            return jsonify({"error": "Item not found"}), 404

    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)}), 400

