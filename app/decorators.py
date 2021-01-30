from functools import wraps

from flask_jwt_extended.utils import get_jwt_identity

from app.utils import send_error
from app.models import User


def admin_required():
    """
    Check admin user
    """

    def wrapper(func):
        @wraps(func)
        def inner(*args, **kwargs):
            current_user = User.find_by_id(get_jwt_identity())
            if not current_user.is_admin:
                return send_error(message='You do not have permission')
            return func(*args, **kwargs)

        return inner
    return wrapper
