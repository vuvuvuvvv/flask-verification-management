import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager
from flask_session import Session
from app.config import Config
from flask_cors import CORS
# from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity, decode_token
from datetime import timedelta
from .models import User
from app.extensions import db, migrate, login_manager

def create_app(config_class=Config):
    app = Flask(__name__)
    
    # CORS(app, resources={r"/api/*": {"origins": "http://localhost:3000"}}, supports_credentials=True)
    CORS(app, supports_credentials=True)
    # jwt = JWTManager(app)
    app.config.from_object(config_class)

    app.config['SESSION_TYPE'] = 'filesystem'  # Lưu trữ session trên file hệ thống
    app.config['SECRET_KEY'] = os.getenv("SECRET_KEY")
    Session(app)

    db.init_app(app)
    migrate.init_app(app, db)
    login_manager.init_app(app)

    from app.routes.auth import auth_bp
    # from app.routes.main import main_bp

    from app.models import User
    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    # app.register_blueprint(main_bp)

    return app
