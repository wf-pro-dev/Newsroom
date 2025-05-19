from flask import Blueprint, jsonify
from server.models.db_topic import topics
from server.models.db_question import questions
from server.models.db_articles import articles
from server.models.db_videos import videos

all_data_bp = Blueprint("all_data", __name__)


@all_data_bp.route("/all_data", methods=["GET"])
def get_aggregated_data():
    try:
        topics_data = topics.query.all()
        questions_data = questions.query.all()
        articles_data = articles.query.all()
        videos_data = videos.query.all()
        favourites_data = favourites.query.all()

        response = {
            "topics": [topic.to_dict() for topic in topics_data],
            "questions": [question.to_dict() for question in questions_data],
            "articles": [article.to_dict() for article in articles_data],
            "videos": [video.to_dict() for video in videos_data],
            "favourites": [favourite.to_dict() for favourite in favourites_data],
        }

        return jsonify(response), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
