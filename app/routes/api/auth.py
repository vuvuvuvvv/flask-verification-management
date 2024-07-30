import os
from datetime import datetime
from flask import Blueprint, jsonify, request, session
from flask_jwt_extended import (
    JWTManager,
    create_access_token,
    create_refresh_token,
    jwt_required,
    get_jwt_identity,
)
from flask_login import login_user, logout_user, login_required, current_user
from flask_jwt_extended import get_jwt_identity, jwt_required, get_jwt
from app.models import TokenBlacklist
from app import db, login_manager
from app.models import User
from app.utils.jwt_helpers import clean_up_blacklist
from app.utils.send_mail import send_reset_password_email
from datetime import timedelta

auth_bp = Blueprint("auth", __name__)

jwt = JWTManager()


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


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
    new_user = User(username=username, email=email, role=role)
    new_user.set_password(password)
    db.session.add(new_user)
    db.session.commit()

    login_user(new_user)
    session["current_user"] = new_user.to_dict()

    access_token = create_access_token(
        identity=new_user.to_dict(), expires_delta=timedelta(minutes=30)
    )
    refresh_token = create_refresh_token(
        identity=new_user.to_dict(), expires_delta=timedelta(days=3)
    )
    return (
        jsonify(
            access_token=access_token,
            refresh_token=refresh_token,
            user=new_user.to_dict(),
            msg="Đăng ký thành công!",
        ),
        200,
    )


@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")

    user = User.query.filter_by(username=username).first()
    if user and user.check_password(password):
        login_user(user)
        session["current_user"] = user.to_dict()
        access_token = create_access_token(
            identity=user.to_dict(), expires_delta=timedelta(minutes=30)
        )
        refresh_token = create_refresh_token(
            identity=user.to_dict(), expires_delta=timedelta(days=3)
        )
        return (
            jsonify(
                access_token=access_token,
                refresh_token=refresh_token,
                user=user.to_dict(),
                msg="Đăng nhập thành công!",
            ),
            200,
        )
    return jsonify({"msg": "Bad username or password"}), 401


@auth_bp.route("/refresh", methods=["POST"])
@jwt_required(refresh=True)
def refresh():
    identity = get_jwt_identity()
    user = User.query.filter_by(username=identity["username"]).first()
    if user:
        access_token = create_access_token(
            identity=user.to_dict(), expires_delta=timedelta(minutes=30)
        )
        return jsonify(access_token=access_token, user=user.to_dict()), 200
    return jsonify({"msg": "User not found"}), 404


@auth_bp.route("/logout", methods=["POST"])
# @login_required
@jwt_required()
def logout():
    # Get the IP address of the request
    # ip_address = request.remote_addr
    # print(f"Request IP address: {ip_address}")

    try:
        logout_user()
        clean_up_blacklist()
        jti = get_jwt()["jti"]  # Get JWT ID
        expires = get_jwt()["exp"]  # Get expiration time
        blacklist_entry = TokenBlacklist(
            jti=jti, expires_at=datetime.fromtimestamp(expires)
        )
        db.session.add(blacklist_entry)
        db.session.commit()
        session.clear()
    except Exception as err:
        print(err)
    return jsonify({"status": 200, "msg": "Đăng xuất thành công!"}), 200


# @auth_bp.route("/me", methods=["GET"])
# @jwt_required()
# def profile():
#     # get user from jwt
#     current_user_identity = get_jwt_identity()
#     print(current_user_identity)
#     user = User.query.filter_by(username=current_user_identity["username"]).first()
#     if not user:
#         return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

#     return jsonify(user.to_dict()), 200


@auth_bp.route("/me", methods=["GET"])
# @jwt_required()
@login_required
def profile():
    # get user from jwt
    username = None
    # if current_user.is_authenticated:
    #     print(current_user.username)
    # else:
    #     print("none")

    try:
        username=current_user.username
        user = User.query.filter_by(username=username).first()
        if not user:
            return jsonify({"msg": "Không tìm thấy người dùng!"}), 404
        return jsonify(user.to_dict()), 200
    except Exception as err:
        print("err: ", err)
    return jsonify({"msg":"Yêu cầu đăng nhập để thực hiện chức năng!"}), 200



@auth_bp.route("/send-mail", methods=["GET"])
def send_mail():
    try:
        send_reset_password_email("nguyenvu260502@gmail.com")
        return jsonify("test mail oke"), 200
    except Exception as mail_err:
        print("Mail err: ", mail_err)


@auth_bp.route("/change/email", methods=["POST"])
@jwt_required()
def reset_email():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")

    # get user from jwt
    current_user_identity = get_jwt_identity()
    print(current_user_identity)

    user = User.query.filter_by(username=current_user_identity["username"]).first()
    if not user:
        return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

    # check email exists
    if User.query.filter_by(email=email).first():
        return jsonify({"msg": "Email đã tồn tại!"}), 400

    # check current password
    if not user.check_password(password):
        return jsonify({"msg": "Mật khẩu không chính xác!"}), 401

    # set new password
    user.set_email(email)
    db.session.commit()

    access_token = create_access_token(
        identity=user.to_dict(), expires_delta=timedelta(minutes=30)
    )
    refresh_token = create_refresh_token(
        identity=user.to_dict(), expires_delta=timedelta(days=3)
    )
    return (
        jsonify(
            access_token=access_token,
            refresh_token=refresh_token,
            user=user.to_dict(),
            msg="Đổi email thành công!",
        ),
        200,
    )

@auth_bp.route('/change/password', methods=['POST'])
@jwt_required()
def reset_password():
    data = request.get_json()
    new_password = data.get("new_password")
    old_password = data.get("old_password")

    # get user from jwt
    current_user_identity = get_jwt_identity()
    print(current_user_identity)
    user = User.query.filter_by(username=current_user_identity["username"]).first()
    if not user:
        return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

    # check current password
    if not user.check_password(old_password):
        return jsonify({"msg": "Mật khẩu không chính xác!"}), 401

    # set new password
    user.set_password(new_password)
    db.session.commit()

    access_token = create_access_token(
        identity=user.to_dict(), expires_delta=timedelta(minutes=30)
    )
    refresh_token = create_refresh_token(
        identity=user.to_dict(), expires_delta=timedelta(days=3)
    )
    return (
        jsonify(
            access_token=access_token,
            refresh_token=refresh_token,
            user=user.to_dict(),
            msg="Đổi mật khẩu thành công!",
        ),
        200,
    )
