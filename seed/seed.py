# seeds/seed.py
import sys
import os

# Add the directory containing 'app' to sys.path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from flask_sqlalchemy import SQLAlchemy
from flask import Flask
from app.models import User
from werkzeug.security import generate_password_hash
from app import create_app, db
import os

def seed_data():
    try:
        app = create_app()

        with app.app_context():
            db.create_all()
            if User.query.count() == 0:
                sample_users_data = [
                    {
                        "username": "user",
                        "fullname": "User đâyyy",
                        "email": "user@gmail.com",
                        "password": "00000000",
                        "role": "USER",
                    },
                    {
                        "username": "admin",
                        "fullname": "Admin đây",
                        "email": "smtpbotnoreply@gmail.com",
                        "password": "00000000",
                        "role": "ADMIN",
                    },
                ]

                sample_users = []
                for user_data in sample_users_data:
                    user = User(
                        username=user_data["username"],
                        fullname=user_data["fullname"],
                        email=user_data["email"],
                        password_hash=generate_password_hash(user_data["password"]),
                        role=user_data["role"],
                    )
                    sample_users.append(user)
                db.session.bulk_save_objects(sample_users)
                db.session.commit()
                print("===> Seed data successfully")
            else:
                print("===> Data already seeded")
    except Exception as err:
        print("===> Error: ", err)


if __name__ == "__main__":
    seed_data()
