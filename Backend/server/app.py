"""
This module sets up the Flask application, configures CORS, 
and registers the necessary blueprints for the server.
"""
from sys import path
import os
from datetime import timedelta
from flask import Flask, jsonify, request
from flask_cors import CORS
from flask_jwt_extended import JWTManager
import secrets

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


def create_app():
    app = Flask(__name__)
    
    # Initialize extensions
    jwt = JWTManager(app)
    csrf = CSRFProtect(app)

    # Configure CORS
    CORS(
        app,
        resources={
            r"/*": {
                "origins": ["https://newsroom-git-development-william-fotsos-projects.vercel.app","http://localhost:3000"],
                "methods": ["GET", "POST", "DELETE", "OPTIONS"],
            }
        },
        supports_credentials=True
    )
    
    # Configure security settings in one place - no duplicate or conflicting settings
    app.config.update({
        # Basic Flask security
        'SECRET_KEY': 'dev-key-123',
        
        # Database
        'SQLALCHEMY_DATABASE_URI': DATABASE_URI,
        'SQLALCHEMY_TRACK_MODIFICATIONS': False,
       
        #Session Config
        'SESSION_COOKIE_SAMESITE': 'None',
        'SESSION_COOKIE_SECURE' : True,
    
        # CSRF Config
        'WTF_CSRF_SECRET_KEY': CSRF_SECRET_KEY,
        'WTF_CSRF_CHECK_DEFAULT': False,  # We'll validate manually
        'WTF_CSRF_SSL_STRICT': False,     # Don't require HTTPS for testing
    
        # JWT Config
        'JWT_SECRET_KEY': JWT_SECRET_KEY,
        'JWT_COOKIE_SECURE': True,       # Set to True in production
        'JWT_COOKIE_SAMESITE': 'None',     # For cross-origin, change to 'None' with HTTPS
        'JWT_COOKIE_CSRF_PROTECT': True,  # Enable CSRF for JWT
        'JWT_TOKEN_LOCATION': ['cookies'],
        'JWT_ACCESS_TOKEN_EXPIRES': timedelta(hours=1)
    })
    
    
    # Share csrf with application context
    app.csrf = csrf
    
    @app.route('/csrf-token', methods=['GET'])
    def get_csrf_token():
        # Generate the token just once
        token = generate_csrf()
    
        # Log the generated token for debugging
        app.logger.info(f"Generated CSRF token: {token}")
    
        # Create the response with the token in the JSON body
        response = jsonify({"csrfToken": token})
    
        # Set the same token in the cookie
        response.set_cookie(
            'csrf_token',
            token,
            secure=False,  # Set to True in production with HTTPS
            samesite='Lax',  # Use 'None' in production with HTTPS 
            httponly=False,  # Let JavaScript read it
            max_age=3600    # 1 hour expiry
        )
        
        return response

    # Configure SQLAlchemy
    db.init_app(app)

    # Register blueprint routes
    app.register_blueprint(auth_bp)
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
