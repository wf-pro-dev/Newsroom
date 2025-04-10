from sys import path
import os
from flask import Blueprint, jsonify, request
from werkzeug.security import check_password_hash
from flask_jwt_extended import (
    create_access_token, set_access_cookies,
    jwt_required, get_jwt_identity
)
from flask_wtf.csrf import generate_csrf


current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(current_dir, "../../../"))
backend_root = project_root + "/Backend"
path.append(backend_root)

from flask import Blueprint, jsonify, request
from server.models.db_users import users
from database.connection import db

auth_bp = Blueprint("auth", __name__)

@auth_bp.route("/user", methods=["GET"])
@jwt_required()
def get_current_user():
    current_user_id = get_jwt_identity()
    user = users.query.get(current_user_id)
    return jsonify({
        "id": user.id,
        "email": user.email
        # Add other user fields as needed
    }), 200

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.json
    if users.query.filter_by(email=data['email']).first():
        return jsonify({"error": "Email already exists"}), 400
    
    user = users(email=data['email'])
    user.set_password(data['password'])  # Hashes the password
    db.session.add(user)
    db.session.commit()
    
    return jsonify({"message": "User created!"}), 201

@auth_bp.route('/login', methods=['POST'])
def login():
    # 1. Validate credentials
    email = request.json.get('email')
    password = request.json.get('password')
    user = users.query.filter_by(email=email).first()
    
    if not user or not check_password_hash(user.password_hash, password):
        return jsonify({"error": "Invalid credentials"}), 401

    # 2. Create tokens
    access_token = create_access_token(identity=str(user.id))
    csrf_token = generate_csrf()

    # 3. Prepare response
    response = jsonify({
        "message": "Login successful",
        "csrf_token": csrf_token  # For frontend storage
    })
    
    # 4. Set JWT as HTTP-only cookie
    set_access_cookies(response, access_token)
    
    return response