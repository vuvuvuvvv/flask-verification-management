from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from models import User
from app.extensions import db

user_bp = Blueprint('user', __name__)

@jwt_required()
@user_bp.route('/users', methods=['GET'])
@jwt_required()
def get_users():
    users = User.query.all()
    result = [{"id": user.id, "username": user.username, "role": user.role} for user in users]
    return jsonify(result), 200

@jwt_required()
@user_bp.route('/users/<int:id>', methods=['GET'])
@jwt_required()
def get_user(id):
    user = User.query.get_or_404(id)
    result = {"id": user.id, "username": user.username, "role": user.role}
    return jsonify(result), 200

@jwt_required()
@user_bp.route('/users/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_user(id):
    user = User.query.get_or_404(id)
    db.session.delete(user)
    db.session.commit()
    return jsonify({"msg": "User deleted"}), 200
