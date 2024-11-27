from sys import path
path.append("/Users/williamfotso/Workspace/Newsroom/Backend/")

from flask import Flask, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy

from database.connection import db

from Server.routes.articles import articles_bp
from Server.routes.videos import videos_bp
from Server.routes.topics import topics_bp
from Server.routes.questions import questions_bp

from config.constants import DATABASE_URI



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
    app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URI
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    db.init_app(app)

    # Register blueprints
    app.register_blueprint(articles_bp)
    app.register_blueprint(videos_bp)
    app.register_blueprint(topics_bp)
    app.register_blueprint(questions_bp)

    # Error handlers
    @app.errorhandler(Exception)
    def handle_exception(e):
        app.logger.error(f"Unhandled exception: {e}")
        return jsonify({"error": "An unexpected error occurred"}), 500

    @app.route("/favicon.ico")
    def favicon():
        return "", 204

    return app
