# -*- coding: utf-8 -*-
import os
import re
from datetime import datetime
from flask import Blueprint, jsonify, request, session
import traceback  # để ghi lại chi tiết lỗi nếu cần

from flask_jwt_extended import (
    JWTManager,
    create_access_token,
    create_refresh_token,
    jwt_required,
    get_jwt_identity,
    get_jwt, decode_token
)
from flask_login import login_user, logout_user, login_required, current_user
from app.models import TokenBlacklist

from app.extensions import limiter

from app import db, login_manager
from app.models import User
from app.utils.jwt_helpers import clean_up_blacklist
from app.utils.send_mail import send_reset_password_email, send_verify_email
from datetime import timedelta

auth_bp = Blueprint("auth", __name__)

jwt = JWTManager()

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@auth_bp.route("/register", methods=["POST"])
def register():
    try:
        data = request.get_json()
        username = data.get("username")
        fullname = data.get("fullname")
        password = data.get("password")
        email = data.get("email")

        if User.query.filter_by(username=username).first():
            return jsonify({"msg": "Nguoi dung da ton tai"}), 400
        if User.query.filter_by(email=email).first():
            return jsonify({"msg": "Email đã tồn tại"}), 400

        new_user = User(username=username, fullname=fullname, email=email)
        new_user.set_password(password)

        db.session.add(new_user)
        db.session.commit()

        login_user(new_user)
        session["current_user"] = new_user.to_dict()

        access_token = create_access_token(
            identity=new_user.to_dict(),
            expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
        )
        refresh_token = create_refresh_token(
            identity=new_user.to_dict(),
            expires_delta=timedelta(days=int(os.environ.get("EXPIRE_TIME_RFT"))),
        )
        return (
            jsonify(
                access_token=access_token,
                refresh_token=refresh_token,
                user=new_user.to_dict(),
                msg="Đăng ký thành công!",
            ),
            201,
        )
    except Exception as e:
        print(f"Đăng ký thất bại: {e}")
        db.session.rollback()
        return jsonify({"msg": "Lỗi trong quá trình đăng ký.", "error": str(e)}), 500


@auth_bp.route("/login", methods=["POST"])
def login():
    try: 
        data = request.get_json()
        username = data.get("username")
        password = data.get("password")

        # user = User.query.filter_by(username=username).first()
        # Check if the username is an email
        if re.match(r"[^@]+@[^@]+\.[^@]+", username):
            user = User.query.filter_by(email=username).first()
        else:
            user = User.query.filter_by(username=username).first()
        if user and user.check_password(password):
            login_user(user)
            session["current_user"] = user.to_dict()
            access_token = create_access_token(
                identity=user.to_dict(),
                expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
            )
            refresh_token = create_refresh_token(
                identity=user.to_dict(),
                expires_delta=timedelta(days=int(os.environ.get("EXPIRE_TIME_RFT"))),
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
    except Exception as e:
        print(f"Đăng nhập thất bại: {e}")
        db.session.rollback()
        return jsonify({"msg": "Lỗi trong quá trình đăng nhập.", "error": str(e)}), 500


@auth_bp.route("/refresh", methods=["POST"])
@jwt_required(refresh=True)
def refresh():
    try:
        identity = get_jwt_identity()
        user = User.query.filter_by(username=identity["username"]).first()
        if user:
            access_token = create_access_token(
                identity=user.to_dict(),
                expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
            )
            return jsonify(access_token=access_token, user=user.to_dict()), 200
        return jsonify({"msg": "Không tìm thấy người dùng!"}), 404
    except Exception as e:
        print(f"Lỗi refresh token: {e}")
        return jsonify({"msg": "Lỗi khi làm mới token.", "error": str(e)}), 500



@auth_bp.route("/logout", methods=["POST"])
@jwt_required()
@limiter.limit("5 per minute")
def logout():
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
        return jsonify({"status": 200, "msg": "Đăng xuất thành công!"}), 200
    except Exception as err:
        print(err)
        return jsonify({"status": 500, "msg": "Có lỗi xảy ra, vui lòng thử lại sau!"}), 500


@auth_bp.route("/me", methods=["GET"])
@jwt_required()
def profile():
    try:
        identity = get_jwt_identity()
        user = User.query.filter_by(username=identity["username"]).first()
        if not user:
            return jsonify({"msg": "Không tìm thấy người dùng!"}), 404
        return jsonify(user.to_dict()), 200
    except Exception as err:
        print("err: ", err)
    return jsonify({"msg": "Yêu cầu đăng nhập để thực hiện chức năng!"}), 200


@auth_bp.route("/send-password-reset-token", methods=["POST"])
def send_password_reset_mail():
    data = request.get_json()
    email = data.get("email")
    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"msg": "Email không tồn tại!", "status": 404}), 404
    else:
        try:
            send_reset_password_email(email)
            return jsonify({"msg": "Gửi email thành công!", "status": 200}), 200
        except Exception as mail_err:
            print(mail_err)
            traceback.print_exc()
            return (
                jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau.", "status": 500}),
                500,
            )

@auth_bp.route("/send-verify-token", methods=["POST"])
def send_verify_mail():
    data = request.get_json()
    email = data.get("email")
    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"msg": "Email không tồn tại!", "status": 404}), 404
    else:
        try:
            send_verify_email(email)
            return jsonify({"msg": "Gửi email thành công!", "status": 200}), 200
        except Exception as mail_err:
            print(mail_err)
            traceback.print_exc()

            return (
                jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau.", "status": 500}),
                500,
            )

@auth_bp.route("/change/email", methods=["POST"])
@jwt_required()
def reset_email():
    try: 
        data = request.get_json()
        email = data.get("email")
        password = data.get("password")

        # get user from jwt
        current_user_identity = get_jwt_identity()

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
            identity=user.to_dict(),
            expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
        )
        refresh_token = create_refresh_token(
            identity=user.to_dict(),
            expires_delta=timedelta(days=int(os.environ.get("EXPIRE_TIME_RFT"))),
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
    
    except Exception as e:
        print(f"Reset thất bại: {e}")
        db.session.rollback()
        return jsonify({"msg": "Lỗi trong quá trình reset email.", "error": str(e)}), 500

@auth_bp.route("/reset/password", methods=["POST"])
@jwt_required()
def reset_password():
    data = request.get_json()
    new_password = data.get("new_password")
    old_password = data.get("old_password")

    # get email from jwt
    email = get_jwt_identity()["email"]

    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

    # check current password
    if old_password and not user.check_password(old_password):
        return jsonify({"msg": "Mật khẩu không chính xác!"}), 401

    # set new password
    user.set_password(new_password)
    db.session.commit()

    access_token = create_access_token(
        identity=user.to_dict(),
        expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
    )

    refresh_token = create_refresh_token(
        identity=user.to_dict(),
        expires_delta=timedelta(days=int(os.environ.get("EXPIRE_TIME_RFT"))),
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

@auth_bp.route("/verify", methods=["POST"])
def verify():
    try:
        data = request.get_json()
        verification_token = data.get("verification_token")
        if not verification_token:
            return jsonify({"msg": "Thiếu token xác thực!"}), 400

        get_token_data = decode_token(verification_token)

        # Thêm token vào blacklist nếu chưa tồn tại
        jti = get_token_data.get("jti")  # JWT ID
        expires = get_token_data.get("exp")  # Thời gian hết hạn

        # Kiểm tra xem token đã có trong blacklist chưa
        if not TokenBlacklist.query.filter_by(jti=jti).first():
            blacklist_entry = TokenBlacklist(jti=jti, expires_at=datetime.fromtimestamp(expires))
            db.session.add(blacklist_entry)
            db.session.commit()

        email = get_token_data.get("sub", {}).get("email")
        if not email:
            return jsonify({"msg": "Token không hợp lệ!"}), 400

        # Kiểm tra người dùng
        user = User.query.filter_by(email=email).first()
        if not user:
            return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

        user.confirmed = True
        db.session.commit()

        return jsonify(user=user.to_dict(), msg="Xác thực thành công!"), 200

    except KeyError as e:
        print(f"KeyError: {e}")
        return jsonify({"msg": "Token không hợp lệ!", "error": str(e)}), 400
    except Exception as e:
        print(f"Exception: {e}")
        db.session.rollback()  # Rollback nếu có lỗi
        return jsonify({"msg": "Đã xảy ra lỗi trong quá trình xác thực.", "error": str(e)}), 500