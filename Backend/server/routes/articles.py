from flask import Blueprint, jsonify, request
from Backend.server.models.db_articles import articles
from database.connection import db

articles_bp = Blueprint("articles", __name__)


@articles_bp.route("/articles/all", methods=["GET"])
def get_articles():
    list_article = articles.query.all()
    return jsonify([article.to_dict() for article in list_article])


@articles_bp.route("/articles/delete/<int:id>", methods=["DELETE"])
def delete_article_by_id(id):
    try:
        article = articles.query.filter_by(id=id).one_or_none()
        if article:
            db.session.delete(article)
            db.session.commit()
            return jsonify({"message": f"Item with id {id} deleted successfully"}), 200
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@articles_bp.route("/articles/question/<int:question_id>", methods=["GET"])
def get_article_by_qst(question_id):
    list_article = articles.query.filter_by(question_id=question_id).all()
    return jsonify([article.to_dict() for article in list_article])
