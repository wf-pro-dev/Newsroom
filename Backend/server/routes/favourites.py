from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from flask import Blueprint, jsonify, request
from server.models.db_favourites import favourites
from database.connection import db

favourites_bp = Blueprint("favourites", __name__)


@favourites_bp.route("/favourites", methods=["GET"])
def get_favourites():
    list_topic = favourites.query.all()
    return jsonify([topic.to_dict() for topic in list_topic])


@favourites_bp.route("/favourites", methods=["POST"])
def add_favourite():
    data = request.get_json()
    if not data or "entity_id" not in data or "entity_type" not in data:
        return jsonify({"error": "Missing required fields"}), 400

    new_favourite = favourites(
        entity_id=data["entity_id"], entity_type=data["entity_type"]
    )
    db.session.add(new_favourite)
    db.session.commit()
    return jsonify(new_favourite.to_dict()), 201


@favourites_bp.route(
    "/favourites/<string:entity_type>/<int:entity_id>", methods=["DELETE"]
)
def delete_favourites_by_entity_id_and_type(entity_id, entity_type):
    try:
        favourite = favourites.query.filter_by(
            entity_id=entity_id, entity_type=entity_type
        ).first()
        if favourite:
            db.session.delete(favourite)
            db.session.commit()
            return (
                jsonify(
                    {
                        "message": f"Item with entity_type {entity_type} and entity_id {entity_id} deleted successfully"
                    }
                ),
                200,
            )
        else:
            return jsonify({"error": "Item not found"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@favourites_bp.route("/favourites/<int:id>", methods=["GET"])
def get_favourite(id):
    fav = favourites.query.get_or_404(id)
    return jsonify(fav.to_dict())
