from sys import path
import os
from flask import Blueprint, jsonify, request, current_app
from werkzeug.security import check_password_hash, generate_password_hash
from flask_jwt_extended import (
    create_access_token, set_access_cookies,
    jwt_required, get_jwt_identity, get_jwt
)
from flask_wtf.csrf import validate_csrf

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from server.models.db_users import users
from database.connection import db

auth_bp = Blueprint("auth", __name__)

@auth_bp.route("/user", methods=["GET"])
@jwt_required()
def get_current_user():
    try:
        # Convert JWT identity back to integer if stored as string
        current_user_id = get_jwt_identity()
        try:
            # Try to convert to int if it's stored as string
            current_user_id = int(current_user_id)
        except (ValueError, TypeError):
            # Already an int or some other issue
            pass
            
        user = users.query.get(current_user_id)
        if not user:
            return jsonify({"error": f"User not found: {current_user_id}"}), 404
            
        return jsonify({
            "id": user.id,
            "username": user.username,
            "email": user.email
        }), 200
    except Exception as e:
        current_app.logger.error(f"Error in get_current_user: {str(e)}")
        return jsonify({"error": "Failed to retrieve user information"}), 500

@auth_bp.route('/register', methods=['POST'])
def register():
    # Get CSRF token from header
    csrf_token = request.headers.get('X-CSRF-TOKEN')
    current_app.logger.info(f"Register attempt with CSRF Token: {csrf_token}")

    # Validate CSRF token
    try:
        validate_csrf(csrf_token)
    except Exception as e:
        current_app.logger.error(f"CSRF validation error during registration: {e}")
        return jsonify({"error": "Invalid or missing CSRF token"}), 403
    
    # Process registration data
    try:
        data = request.json
        if not data or not all(k in data for k in ['username', 'email', 'password']):
            return jsonify({"error": "Missing required fields"}), 400
            
        if users.query.filter_by(email=data['email']).first():
            return jsonify({"error": "Email already exists"}), 400
        
        user = users(username=data['username'], email=data['email'])
        user.set_password(data['password'])
        db.session.add(user)
        db.session.commit()
        
        return jsonify({"message": "User created successfully"}), 201
    except Exception as e:
        current_app.logger.error(f"Registration error: {str(e)}")
        db.session.rollback()
        return jsonify({"error": "Failed to register user"}), 500

@auth_bp.route('/login', methods=['POST'])
def login():
    # Get CSRF token from header
    csrf_token = request.headers.get('X-CSRF-TOKEN')
    current_app.logger.info(f"Login attempt with CSRF Token: {csrf_token}")
    
    # For debugging - will appear in server logs
    cookie_token = request.cookies.get('csrf_token')
    current_app.logger.debug(f"Cookie CSRF Token: {cookie_token}")

    # Validate CSRF Token
    if not csrf_token:
        return jsonify({"error": "CSRF token missing in header"}), 403

    try:
        validate_csrf(csrf_token)
        current_app.logger.info("CSRF validation successful")
    except Exception as e:
        current_app.logger.error(f"CSRF validation error: {str(e)}")
        return jsonify({"error": "Invalid CSRF token"}), 403

    # Process login
    try:
        email = request.json.get('email')
        password = request.json.get('password')
        
        if not email or not password:
            return jsonify({"error": "Email and password are required"}), 400
            
        user = users.query.filter_by(email=email).first()
        
        if not user or not check_password_hash(user.password_hash, password):
            return jsonify({"error": "Invalid email or password"}), 401
        
        # Create response with JWT token in cookies
        response = jsonify({"message": "Login successful"})
        
        # Create access token with consistent identity type (string)
        access_token = create_access_token(identity=str(user.id))
        set_access_cookies(response, access_token)
        
        # Don't generate a new CSRF token here - use the existing one from /csrf-token endpoint
        return response
    except Exception as e:
        current_app.logger.error(f"Login error: {str(e)}")
        return jsonify({"error": "Login failed due to server error"}), 500
