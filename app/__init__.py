import os
from flask import Flask, request
from config import Config
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from app.utils.jwt_helpers import check_if_token_in_blacklist
# from app.utils.import_sample_data import import_sample_users

from app.extensions import *

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    allowed_origins = [
        os.getenv("CLIENT_BASE_URL"),
        "http://localhost:3000",
    ]
    
    CORS(app, supports_credentials=True)

    @app.after_request
    def add_cors_headers(response):
        origin = request.headers.get("Origin")
        if origin in allowed_origins:
            response.headers.add("Access-Control-Allow-Origin", origin)
            response.headers.add("Vary", "Origin")
        response.headers.add("Access-Control-Allow-Credentials", "true")
        response.headers.add("Access-Control-Allow-Headers", "Content-Type,Authorization")
        response.headers.add("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE,OPTIONS")
        return response

    jwt = JWTManager(app)
    jwt.token_in_blocklist_loader(check_if_token_in_blacklist)

    db.init_app(app)
    migrate.init_app(app, db)
    login_manager.init_app(app)
    mail.init_app(app)
    
    limiter.init_app(app)

    from app.routes.api.auth import auth_bp
    from app.routes.api.pdm import pdm_bp
    from app.routes.api.dongho import dongho_bp
    from app.routes.api.download import download_bp
    from app.routes.views import main_bp

    app.register_blueprint(auth_bp, url_prefix='/api/auth')
    app.register_blueprint(pdm_bp, url_prefix='/api/pdm')
    app.register_blueprint(dongho_bp, url_prefix='/api/dongho')
    app.register_blueprint(download_bp, url_prefix='/api/download')
    app.register_blueprint(main_bp)

    return app