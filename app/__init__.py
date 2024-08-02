import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask_login import LoginManager
from config import Config
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from app.utils.jwt_helpers import check_if_token_in_blacklist
# from app.utils.import_sample_data import import_sample_users

from app.extensions import *

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)
    
    CORS(app, supports_credentials=True, resources={r"/*": {"origins": os.getenv("CLIENT_BASE_URL")}})
    jwt = JWTManager(app)
    jwt.token_in_blocklist_loader(check_if_token_in_blacklist)

    db.init_app(app)
    migrate.init_app(app, db)
    login_manager.init_app(app)
    mail.init_app(app)

    from app.models import User, TokenBlacklist  # Import models here

    from app.routes.api.auth import auth_bp
    from app.routes.views import main_bp

    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    app.register_blueprint(main_bp)


    # # Create sample user
    # with app.app_context():
    #     import_sample_users()

    return app