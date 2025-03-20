import os
import re
from datetime import datetime
from flask import Blueprint, jsonify, request, session, make_response
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
from app import db, login_manager
from app.models import User
from app.utils.jwt_helpers import clean_up_blacklist
from app.utils.send_mail import send_reset_password_email, send_verify_email
from datetime import timedelta


auth_bp = Blueprint("auth", __name__)

jwt = JWTManager()

# Cấu hình cookie phù hợp với môi trường
is_https = os.getenv("ENV") == "production"  # Xác định đang chạy ở môi trường nào
secure_flag = True if is_https else False
samesite_policy = "None" if is_https else "Lax"

def _is_valid_email(email):
    pattern = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"
    return re.match(pattern, email)

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


@auth_bp.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    username = data.get("username")
    fullname = data.get("fullname")
    password = data.get("password")
    email = data.get("email")

    if User.query.filter_by(username=username).first():
        return jsonify({"msg": "Người dùng đã tồn tại"}), 400
    if User.query.filter_by(email=email).first():
        return jsonify({"msg": "Email đã tồn tại"}), 400

    new_user = User(username=username, fullname=fullname, email=email)
    new_user.set_password(password)

    db.session.add(new_user)
    db.session.commit()

    login_user(new_user)

    access_token = create_access_token(
        identity=new_user.to_dict(),
        expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
    )
    refresh_token = create_refresh_token(
        identity=new_user.to_dict(),
        expires_delta=timedelta(days=int(os.environ.get("EXPIRE_TIME_RFT"))),
    )

    response = make_response(jsonify({"user": new_user.to_dict(), "msg": "Đăng nhập thành công!"}), 200)
        
    # Cấu hình cookie phù hợp với môi trường

    access_token_expiry = int(os.environ.get("EXPIRE_TIME_ACT")) * 60  # Chuyển phút thành giây: 30p
    refresh_token_expiry =  24 * 60 * 60  # Chuyển ngày thành giây: 1 ngay

    response.set_cookie("accessToken", access_token, 
        httponly=True, 
        secure=secure_flag,
        samesite=samesite_policy,
        path="/",
        max_age=access_token_expiry
    )
    response.set_cookie("refreshToken", refresh_token, 
        httponly=True, 
        secure=secure_flag,
        samesite=samesite_policy,
        path="/",
        max_age=refresh_token_expiry
    )

    return response


@auth_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    remember = data.get("remember")
    username = data.get("username")
    password = data.get("password")

    # user = User.query.filter_by(username=username).first()
    # Check if the username is an email
    user = User.query.filter((User.username == username) | (User.email == username)).first()

    if user and user.check_password(password):
        login_user(user)
        session["current_user"] = user.to_dict()
        access_token = create_access_token(
            identity=user.to_dict(),
            expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
        )
        refresh_token = create_refresh_token(
            identity=user.to_dict(),
            expires_delta=timedelta(days=(1 if not remember else int(os.environ.get("EXPIRE_TIME_RFT")))),
        )

        response = make_response(jsonify({"user": user.to_dict(), "msg": "Đăng nhập thành công!"}), 200)
        
        access_token_expiry = int(os.environ.get("EXPIRE_TIME_ACT")) * 60  # Chuyển phút thành giây
        refresh_token_expiry = (1 if not remember else int(os.environ.get("EXPIRE_TIME_RFT"))) * 24 * 60 * 60  # Chuyển ngày thành giây

        response.set_cookie("accessToken", access_token, 
            httponly=True, 
            secure=secure_flag,
            samesite=samesite_policy,
            path="/",
            max_age=access_token_expiry
        )
        response.set_cookie("refreshToken", refresh_token, 
            httponly=True, 
            secure=secure_flag,
            samesite=samesite_policy,
            path="/",
            max_age=refresh_token_expiry
        )

        return response
    
    return jsonify({"msg": "Sai thông tin đăng nhập! Hãy thử lại"}), 401

@auth_bp.route("/refresh", methods=["POST"])
@jwt_required(refresh=True)
def refresh():
    refresh_token = request.cookies.get('refreshToken')
    print("Received refreshToken:", refresh_token)  # Debug
    try:
        identity = get_jwt_identity()
        user = User.query.filter_by(username=identity["username"]).first()
        if user:
            access_token = create_access_token(
                identity=user.to_dict(),
                expires_delta=timedelta(minutes=int(os.environ.get("EXPIRE_TIME_ACT"))),
            )
            response = make_response(jsonify({"user": user.to_dict(), "msg": "Làm mới xác thực thành công!"}), 200)

            response.set_cookie("accessToken", access_token, 
                httponly=True, 
                secure=secure_flag,
                samesite=samesite_policy,
                path="/",
                max_age=int(os.environ.get("EXPIRE_TIME_ACT"))*60
            )
            return response
        else:
            raise Exception("User not found")
    except Exception as e:
        logout_user()  # Xóa phiên trong Flask-Login
        response = jsonify({"msg": "Phiên đăng nhập hết hạn, vui lòng đăng nhập lại."})
        response.set_cookie("accessToken", "", max_age=0)
        response.set_cookie("refreshToken", "", max_age=0)
        return response, 401

@auth_bp.route("/logout", methods=["POST"])
@jwt_required()
def logout():
    try:
        jti = get_jwt()["jti"]  # Lấy ID của JWT
        expires = get_jwt()["exp"]  # Lấy thời gian hết hạn

        # Kiểm tra nếu token đã bị blacklist trước đó
        if TokenBlacklist.query.filter_by(jti=jti).first():
            return jsonify({"status": 400, "msg": "Token đã bị thu hồi!"}), 400

        # Thêm token vào danh sách blacklist
        blacklist_entry = TokenBlacklist(
            jti=jti, expires_at=datetime.fromtimestamp(expires)
        )
        db.session.add(blacklist_entry)
        db.session.commit()

        # Xóa cookie
        response = jsonify({"status": 200, "msg": "Đăng xuất thành công!"})
        response.set_cookie("accessToken", "", expires=0, path="/")
        response.set_cookie("refreshToken", "", expires=0, path="/")

        return response

    except Exception as err:
        return jsonify({"status": 500, "msg": "Lỗi máy chủ!", "error": str(err)}), 500



# Lấy user hiện tại 
@auth_bp.route("/me", methods=["GET"])
# @jwt_required()
@login_required
def profile():
    # get user from jwt
    username = None

    try:
        username = current_user.username
        user = User.query.filter_by(username=username).first()
        if not user:
            return jsonify({"msg": "Không tìm thấy người dùng!"}), 404
        return jsonify(user.to_dict()), 200
    except Exception as err:
        print("err: ", err)
    return jsonify({"msg": "Yêu cầu đăng nhập để thực hiện chức năng!"}), 200

# Gửi email chứa link đổi mật khẩu
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
            return (
                jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau.", "status": 500}),
                500,
            )

# Gửi email xác nhận tài khoản 
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
            return (
                jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau.", "status": 500}),
                500,
            )

@auth_bp.route("/change/email", methods=["POST"])
@jwt_required()
def reset_email():
    data = request.get_json()
    email = data.get("email")
    password = data.get("password")

    # Lấy thông tin người dùng từ JWT
    current_user_identity = get_jwt_identity()
    user = User.query.filter_by(username=current_user_identity["username"]).first()

    if not user:
        return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

    # Kiểm tra email hợp lệ
    if not _is_valid_email(email):
        return jsonify({"msg": "Email không hợp lệ!"}), 400

    # Kiểm tra email đã tồn tại hay chưa
    if User.query.filter_by(email=email).first():
        return jsonify({"msg": "Email đã tồn tại!"}), 400

    # Kiểm tra mật khẩu hiện tại
    if not user.check_password(password):
        return jsonify({"msg": "Mật khẩu không chính xác!"}), 401

    # Cập nhật email mới
    user.set_email(email)
    db.session.commit()

    # Đăng xuất user khỏi hệ thống để cập nhật token
    logout_user()

    response = make_response(jsonify({"msg": "Đổi email thành công, vui lòng đăng nhập lại!"}), 200)

    # Xóa JWT cũ trong cookie
    response.set_cookie("accessToken", "", max_age=0)
    response.set_cookie("refreshToken", "", max_age=0)

    return response

@auth_bp.route("/reset/password", methods=["POST"])
@jwt_required()
def reset_password():
    data = request.get_json()
    new_password = data.get("new_password")
    old_password = data.get("old_password")

    # Lấy email từ JWT
    email = get_jwt_identity()["email"]
    user = User.query.filter_by(email=email).first()

    if not user:
        return jsonify({"msg": "Không tìm thấy người dùng!"}), 404

    # Kiểm tra mật khẩu cũ
    if old_password and not user.check_password(old_password):
        return jsonify({"msg": "Mật khẩu không chính xác!"}), 401

    # Cập nhật mật khẩu mới
    user.set_password(new_password)
    db.session.commit()

    # Đăng xuất user để đảm bảo token cũ không còn giá trị
    logout_user()

    response = make_response(jsonify({"msg": "Đổi mật khẩu thành công, vui lòng đăng nhập lại!"}), 200)

    # Xóa JWT trong cookie
    response.set_cookie("accessToken", "", max_age=0)
    response.set_cookie("refreshToken", "", max_age=0)

    return response


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