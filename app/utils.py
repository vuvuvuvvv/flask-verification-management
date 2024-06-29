# File: app/utils.py

from datetime import datetime
from app.models import TokenBlacklist
from app.extensions import db

# Xóa bớt jwt black list
def clean_up_blacklist():
    now = datetime.now()
    TokenBlacklist.query.filter(TokenBlacklist.expires_at < now).delete()
    db.session.commit()
