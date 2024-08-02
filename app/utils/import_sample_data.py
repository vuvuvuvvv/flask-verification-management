from app.models import User
from ..extensions import db

def import_sample_users():
    try:
        if User.query.count() == 0:
    except Exception as err:
        print("===> Error: ", err)

