from app.models import User
from ..extensions import db
from werkzeug.security import generate_password_hash

def import_sample_users():
    try:
        if User.query.count() == 0:
            sample_users_data = [
                {'username': 'admin', 'fullname': 'Admin đây', 'email': 'admin@gmail.com', 'password': '000','role':"ADMIN"},
                {'username': 'user', 'fullname': 'User đâyyy', 'email': 'user@gmail.com', 'password': '000','role':"USER"},
            ]
            
            sample_users = []
            for user_data in sample_users_data:
                user = User(
                    username=user_data['username'],
                    fullname=user_data['fullname'],
                    email=user_data['email'],
                    password_hash=generate_password_hash(user_data['password']),
                    role=user_data['role']
                )
                sample_users.append(user)
            
            db.session.bulk_save_objects(sample_users)
            db.session.commit()
    except Exception as err:
        print("===> Error: ", err)

