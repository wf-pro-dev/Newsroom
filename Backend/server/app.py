"""
This module sets up the Flask application, configures CORS, 
and registers the necessary blueprints for the server.
"""
from flask import Flask, jsonify
from flask_cors import CORS
from database.connection import db
from server.routes.articles import articles_bp
from server.routes.videos import videos_bp
from server.routes.topics import topics_bp
from server.routes.questions import questions_bp
from server.routes.favourites import favourites_bp
from server.routes.all_data import all_data_bp
from config.constants import DATABASE_URI
from sys import path
import os

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)


def create_app():
    app = Flask(__name__)

    # Configure CORS
    CORS(
        app,
        resources={
            r"/*": {
                "origins": "http://localhost:3000",
                "methods": ["GET", "POST", "DELETE", "OPTIONS"],
            }
        },
    )

    # Configure SQLAlchemy
    app.config["SQLALCHEMY_DATABASE_URI"] = DATABASE_URI
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    db.init_app(app)

    # Register blueprints
    app.register_blueprint(articles_bp)
    app.register_blueprint(videos_bp)
    app.register_blueprint(topics_bp)
    app.register_blueprint(questions_bp)
    app.register_blueprint(favourites_bp)
    app.register_blueprint(all_data_bp)

    # Error handlers
    @app.errorhandler(Exception)
    def handle_exception(e):
        app.logger.error(f"Unhandled exception: {e}")
        return jsonify({"error": "An unexpected error occurred"}), 500

    @app.route("/favicon.ico")
    def favicon():
        return "", 204

    return app
