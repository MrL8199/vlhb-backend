import uuid
from functools import wraps
from datetime import datetime

from flask_jwt_extended.utils import get_jwt_identity

from app.extensions import db, logger
from app.utils import send_error, get_datetime_now_s
from app.models import User, Cart


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


def cart_required(fn):
    """
    Kiểm tra giỏ hàng, tạo giỏ hàng nếu user chưa có giỏ hàng
    :return:
    """

    @wraps(fn)
    def wrapper(*args, **kwargs):
        current_cart = Cart.find_by_user_id(get_jwt_identity())
        if not current_cart:
            _id = str(uuid.uuid1())

            data = {
                'id': _id,
                'status': None,
                'content': None,
                'user_id': get_jwt_identity()
            }
            current_cart = Cart()
            for key in data.keys():
                current_cart.__setattr__(key, data[key])
        else:
            current_cart.__setattr__('updated_at', get_datetime_now_s())
        db.session.add(current_cart)
        db.session.commit()
        return fn(*args, **kwargs)
    return wrapper
