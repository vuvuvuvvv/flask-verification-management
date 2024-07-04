from flask import Blueprint, render_template, request, current_app
from flask_login import current_user, LoginManager
import jwt
from app.models import User  # Import User model
from flask import session

main_bp = Blueprint('main', __name__)
login_manager = LoginManager()

@login_manager.request_loader
def load_user_from_request(request):
    auth_headers = request.headers.get('Authorization', '').split()
    if len(auth_headers) != 2:
        return None
    try:
        token = auth_headers[1]
        data = jwt.decode(token, current_app.config['SECRET_KEY'], algorithms=["HS256"])
        user = User.query.filter_by(email=data['sub']).first()
        if user:
            return user
    except jwt.ExpiredSignatureError:
        return None
    except (jwt.InvalidTokenError, Exception) as e:
        return None
    return None

@main_bp.route('/profile', methods=['GET'])
def profile_view():

    print(current_user.username)

    if "current_user" in session:
        user = session['current_user']
    else:
        user = None
    return render_template('profile.html', user=user)