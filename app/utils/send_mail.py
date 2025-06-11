import os
from .. import mail
from flask_mail import Message
from flask import render_template
from datetime import timedelta
from flask_jwt_extended import create_access_token
import traceback  # để ghi lại chi tiết lỗi nếu cần

site_contact = {
    "company_name": os.environ.get("COMPANY_NAME"),
    "email": os.environ.get("ADMIN_MAIL"),
    "tel": os.environ.get("ADMIN_TEL"),
    "client_base_url": os.environ.get("CLIENT_BASE_URL"),
}


def send_reset_password_email(email):
    try:
        msg = Message(
            subject="DHT - Yêu cầu thay đổi mật khẩu.",
            sender=(os.environ.get("SENDER_NAME"), os.environ.get("SENDER_MAIL")),
            recipients=[email],
        )

        token = create_access_token(
            identity={"email": email}, expires_delta=timedelta(minutes=5)
        )

        reset_link = f"{os.environ.get('CLIENT_BASE_URL')}/reset-password/{token}"

        msg.html = render_template(
            "email_templates/password_reset.html",
            site_contact=site_contact,
            reset_link=reset_link,
            email=email,
        )

        mail.send(msg)

    except Exception as e:
        print(f"Failed to send reset password email to {email}: {str(e)}")
        traceback.print_exc()


def send_verify_email(email):
    try:
        msg = Message(
            subject="DHT - Email xác thực tài khoản.",
            sender=(os.environ.get("SENDER_NAME"), os.environ.get("SENDER_MAIL")),
            recipients=[email],
        )

        token = create_access_token(
            identity={"email": email, "verified": True},
            expires_delta=timedelta(minutes=5),
        )

        verify_link = f"{os.environ.get('CLIENT_BASE_URL')}/verify/{token}"

        msg.html = render_template(
            "email_templates/verify.html",
            site_contact=site_contact,
            reset_link=verify_link,
            email=email,
        )

        mail.send(msg)

    except Exception as e:
        print(f"Failed to send verification email to {email}: {str(e)}")
        traceback.print_exc()
