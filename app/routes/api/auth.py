from datetime import datetime
from flask import Blueprint, jsonify, request, session
from flask_jwt_extended import (
    JWTManager, create_access_token, create_refresh_token,
    jwt_required, get_jwt_identity
)
from flask_login import login_user, logout_user, login_required, current_user
from flask_jwt_extended import get_jwt_identity, jwt_required, get_jwt
from app.models import TokenBlacklist
from app import db
from app.models import User
from app.utils import clean_up_blacklist
from app import login_manager

from datetime import timedelta

auth_bp = Blueprint('auth', __name__)
jwt = JWTManager()

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@auth_bp.route('/test', methods=['POST'])
def test():
    return jsonify({"msg":"okey"}), 200

@auth_bp.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    email = data.get('email')
    role = "USER"
    if User.query.filter_by(username=username).first():
        return jsonify({"msg": "Người dùng đã tồn tại"}), 400
    if User.query.filter_by(email=email).first():
        return jsonify({"msg": "Email đã tồn tại"}), 400
    new_user = User(username=username,email=email, role=role)
    new_user.set_password(password)
    db.session.add(new_user)
    db.session.commit()
    
    login_user(new_user)
    access_token = create_access_token(identity={"username": username, "role": new_user.role}, expires_delta=timedelta(minutes=15))
    refresh_token = create_refresh_token(identity={"username": username, "role": new_user.role}, expires_delta=timedelta(days=7))
    return jsonify(access_token=access_token, refresh_token=refresh_token), 200

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    user = User.query.filter_by(username=username).first()
    if user and user.check_password(password):
        login_user(user)
        access_token = create_access_token(identity={"username": username, "role": user.role}, expires_delta=timedelta(minutes=15))
        refresh_token = create_refresh_token(identity={"username": username, "role": user.role}, expires_delta=timedelta(days=7))
        return jsonify(
            access_token=access_token, 
            refresh_token=refresh_token,
            user=user.to_dict(),
            msg= "Đăng nhập thành công!"
        ), 200
    return jsonify({"msg": "Bad username or password"}), 401

@auth_bp.route('/refresh', methods=['POST'])
@jwt_required(refresh=True)
def refresh():
    identity = get_jwt_identity()
    access_token = create_access_token(identity=identity)
    return jsonify(access_token=access_token), 200

@auth_bp.route('/logout', methods=['POST'])
@jwt_required()
def logout():
    try:
        logout_user()
        clean_up_blacklist()
        jti = get_jwt()['jti']  # Get JWT ID
        expires = get_jwt()['exp']  # Get expiration time
        blacklist_entry = TokenBlacklist(jti=jti, expires_at=datetime.fromtimestamp(expires))
        db.session.add(blacklist_entry)
        db.session.commit()
    except Exception as err:
        print(err)
    return jsonify({"status": 200, "msg": "Đăng xuất thành công!"}), 200

@auth_bp.route('/me', methods=['GET'])
@jwt_required()
def profile():
    # get user from jwt
    current_user_identity = get_jwt_identity()
    print("current_user_identity")
    print(current_user_identity)

    user = User.query.filter_by(username=current_user_identity['username']).first()
    if not user:
        return jsonify({"msg": "User not found"}), 404

    return jsonify(user.to_dict()), 200