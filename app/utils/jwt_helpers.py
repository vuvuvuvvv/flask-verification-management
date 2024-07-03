from datetime import datetime
from app.models import TokenBlacklist
from app.extensions import db

def check_if_token_in_blacklist(jwt_header, jwt_payload):
    jti = jwt_payload['jti']
    token = TokenBlacklist.query.filter_by(jti=jti).first()
    return token is not None

def clean_up_blacklist():
    now = datetime.utcnow()
    expired_tokens = TokenBlacklist.query.filter(TokenBlacklist.expires_at < now).all()
    for token in expired_tokens:
        db.session.delete(token)
    db.session.commit()