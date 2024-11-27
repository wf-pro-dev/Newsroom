from flask import Blueprint, jsonify, request
from Server.models.db_article import  articles, fav_articles
from database.connection import db

articles_bp = Blueprint("articles", __name__)

@articles_bp.route("/articles", methods=["GET"])
def get_articles():
    list_article = articles.query.all()
    return jsonify([article.to_dict() for article in list_article])

@articles_bp.route("/articles/<int:question_id>", methods=["GET"])
def get_article_by_qst(question_id):
    list_article = articles.query.filter_by(question_id=question_id).all()
    return jsonify([article.to_dict() for article in list_article])

@articles_bp.route("/articles/<int:id>", methods=["DELETE"])
def delete_article_by_id(id):
    try:
        article = articles.query.get(id)
        if article:
            db.session.delete(article)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@articles_bp.route("/fav_articles", methods=["GET"])
def get_fav_article():
    favorites = fav_articles.query.all()
    return jsonify([fav.to_dict() for fav in favorites])

@articles_bp.route("/fav_articles", methods=["POST"])
def add_fav_article():
    data = request.json

    required_fields = [
        "score", "id", "question_id", "title", "description", "content",
        "url", "urlToImage", "publishedAt", "api_source", "obj_id"
    ]

    if not all(data.get(field) for field in required_fields):
        return jsonify({"error": "Missing required fields"}), 400

    try:
        fav_article = fav_articles(**data)
        db.session.add(fav_article)
        db.session.commit()
        return jsonify({"message": "Item added to favorites successfully"}), 201
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@articles_bp.route("/fav_articles/<int:id>", methods=["DELETE"])
def delete_fav_article_by_id(id):
    try:
        fav_article = fav_articles.query.get(id)
        if fav_article:
            db.session.delete(fav_article)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500