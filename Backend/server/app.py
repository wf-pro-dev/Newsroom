"""
This module sets up the Flask application, configures CORS, 
and registers the necessary blueprints for the server.
"""
from sys import path
import os
from datetime import timedelta
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_jwt_extended import JWTManager, create_access_token

from werkzeug.security import generate_password_hash, check_password_hash
from flask_wtf.csrf import CSRFProtect, generate_csrf

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from database.connection import db
from server.routes.auth import auth_bp
from server.routes.articles import articles_bp
from server.routes.videos import videos_bp
from server.routes.topics import topics_bp
from server.routes.questions import questions_bp
from server.routes.favourites import favourites_bp
from server.routes.all_data import all_data_bp
from config.constants import DATABASE_URI, JWT_SECRET_KEY, CSRF_SECRET_KEY

print(DATABASE_URI)

def create_app():
    app = Flask(__name__)

    # Configure CORS
    CORS(
        app,
        resources={
            r"/*": {
                "origins": "localhost",
                "methods": ["GET", "POST", "DELETE", "OPTIONS"],
            }
        },
        supports_credentials=True
    )
    
    # Configure JWY and Cookies_SECURITY
    app.config['SECRET_KEY'] = 'dev-key-123'
    app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
    app.config["JWT_COOKIE_SECURE"] = True 
    app.config["JWT_COOKIE_CSRF_PROTECT"] = True 
    app.config["WTF_CSRF_SECRET_KEY"] = CSRF_SECRET_KEY
    
    # Configure Cookies send/security (For jwt_token)
    app.config.update({
        'JWT_TOKEN_LOCATION': ['cookies'],
        'JWT_ACCESS_COOKIE_NAME': 'access_token',  # Customize cookie name
        'JWT_REFRESH_COOKIE_NAME': 'refresh_token',
        'JWT_COOKIE_SECURE': False,  # Set True in production (HTTPS only)
        'JWT_COOKIE_SAMESITE': 'Lax',
    })
    
    # Initialize extensions
    jwt = JWTManager(app)
    csrf = CSRFProtect(app)
    
    
    # Generate CSRF token endpoint (called by frontend on page load)
    @app.route("/csrf-token", methods=["GET"])
    def get_csrf_token():
        token = generate_csrf()
        return jsonify({"csrfToken": token})

    # Configure SQLAlchemy
    app.config["SQLALCHEMY_DATABASE_URI"] = DATABASE_URI
    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
    
    db.init_app(app)

    # Register authentication  blueprint
    app.register_blueprint(auth_bp)
    
    # Register database blueprints
    app.register_blueprint(articles_bp)
    app.register_blueprint(videos_bp)
    app.register_blueprint(topics_bp)
    app.register_blueprint(questions_bp)
    app.register_blueprint(favourites_bp)
    app.register_blueprint(all_data_bp)

    @app.before_request
    def before_request():
        scheme = request.headers.get('X-Forwarded-Proto')
        if scheme and scheme == 'https':
            request.environ['wsgi.url_scheme'] = scheme

    # Error handlers
    @app.errorhandler(Exception)
    def handle_exception(e):
        app.logger.error(f"Unhandled exception: {e}")
        return jsonify({"error": "An unexpected error occurred"}), 500

    @app.route("/favicon.ico")
    def favicon():
        return "", 204

    return app
