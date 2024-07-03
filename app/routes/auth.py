from flask import Blueprint, jsonify, request, make_response
from flask_login import login_user, logout_user, current_user, login_required
from app.models import User
from app.extensions import db

auth_bp = Blueprint("auth", __name__)


@auth_bp.route("/test", methods=["POST"])
@login_required
def test():
    if current_user.is_authenticated:
        return jsonify({"msg": "oke", "user": current_user.to_dict()}), 200
    else:
        return jsonify({"msg": "unauth"}), 401


@auth_bp.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")
    email = data.get("email")
    role = "USER"
    if User.query.filter_by(username=username).first():
        return jsonify({"msg": "Người dùng đã tồn tại"}), 400
    if User.query.filter_by(email=email).first():
        return jsonify({"msg": "Email đã tồn tại"}), 400
    new_user = User(username=username, role=role)
    new_user.set_password(password)
    db.session.add(new_user)
    db.session.commit()

    login_user(new_user)
    return jsonify(user=new_user.to_dict(), msg="Đăng ký thành công!"), 200


@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    user = User.query.filter_by(username=username).first()
    if user and user.check_password(password):
        if login_user(user):
            response = make_response(jsonify(msg="Đăng nhập thành công!"), 200)
            response.set_cookie('user_id', str(user.id), httponly=True, samesite='Lax')
            return response
        return jsonify({"msg": "Some thing went wrong!"}), 500

    return jsonify({"msg": "Bad username or password"}), 401


@auth_bp.route("/logout", methods=["POST"])
@login_required
def logout():
    try:
        logout_user()
    except Exception as err:
        print(err)
    return jsonify({"status": 200, "msg": "Đăng xuất thành công!"}), 200


@auth_bp.route("/me", methods=["GET"])
# @login_required
def get_me():
    try:
        return jsonify(current_user.to_dict()), 200
    except:
        return jsonify({"ms": "unauth"}), 401
