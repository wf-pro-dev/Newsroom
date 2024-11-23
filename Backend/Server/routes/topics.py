from flask import Blueprint, jsonify, request
from database.operations import get_all

topics_bp = Blueprint('topics', __name__)

@topics_bp.route('/Topics', methods=['GET'])
def get_topics():
    topics = get_all("Topics")
    return jsonify(topics)