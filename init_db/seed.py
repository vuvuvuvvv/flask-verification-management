import sys
import os
import traceback

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from flask_sqlalchemy import SQLAlchemy
from flask import Flask
from app.models import User, Role
from werkzeug.security import generate_password_hash
from app import create_app, db

def seed_data():
    try:
        app = create_app()

        with app.app_context():
            db.create_all()

            # Khởi tạo bảng roles
            roles_data = [
                {"name": "Viewer", "default": True, "permissions": 1},
                {"name": "Manager", "default": False, "permissions": 2},
                {"name": "Director", "default": False, "permissions": 3},
                {"name": "Administrator", "default": False, "permissions": 4},
                {"name": "SuperAdministrator", "default": False, "permissions": 5},
            ]

            for role_data in roles_data:
                role = Role.query.filter_by(name=role_data["name"]).first()
                if not role:
                    role = Role(**role_data)
                    db.session.add(role)

            db.session.commit()

            # Khởi tạo user (bỏ Viewer - per 1)
            users_data = [
                {'username': 'dht_manager', 'fullname': 'DHT Manager', 'email': 'dht_manager@gmail.com', 'password': '00000000', 'role_per': 2},
                {'username': 'dht_director', 'fullname': 'DHT Director', 'email': 'dht_director@gmail.com', 'password': '00000000', 'role_per': 3},
                {'username': 'dht_admin', 'fullname': 'DHT Admin', 'email': 'dht_admin@gmail.com', 'password': '00000000', 'role_per': 4},
                {'username': 'dht_superadmin', 'fullname': 'DHT Superadmin', 'email': 'dht_superadmin@gmail.com', 'password': '00000000', 'role_per': 5},
            ]

            for user_data in users_data:
                role = Role.query.filter_by(permissions=user_data["role_per"]).first()
                if role:
                    user = User.query.filter_by(email=user_data["email"]).first()
                    if not user:
                        user = User(
                            username=user_data['username'],
                            fullname=user_data['fullname'],
                            email=user_data['email'],
                            password_hash=generate_password_hash(user_data['password']),
                            role=role,
                            confirmed=True
                        )
                        db.session.add(user)

            db.session.commit()
            print("===> Seeding completed successfully!")

    except Exception as err:
        print("===> Error when trying to create roles and users:")
        traceback.print_exc()

if __name__ == '__main__':
    seed_data()
