from flask_jwt_extended.utils import get_jwt_identity
from werkzeug.security import check_password_hash

from flask import Blueprint, request
from jsonschema import validate
import uuid
from datetime import datetime
from flask_jwt_extended import jwt_required

from app.models import TokenBlacklist, User, Order
from app.utils import send_result, send_error, hash_password, is_password_contain_space, get_datetime_now_s
from app.extensions import logger
from app.schema.schema_validator import user_validator, password_validator, user_update_validator
from app.decorators import admin_required

api = Blueprint('user', __name__)


@api.route('/register', methods=['POST'])
def post():
    """
    Function: User registration account

    Input: user_name, password, nickname, email, phone, is_admin

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=user_validator)

        nickname = json_data.get('nickname', None)
        email = json_data.get('email', None).lower()
        phone = json_data.get('phone', None)
        user_name = json_data.get('user_name', None).strip().lower()
        password = json_data.get('password', None)
        is_admin = json_data.get('is_admin', 0)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    user = User.find_by_username(username=user_name)
    if user is None:
        _id = str(uuid.uuid1())

        data = {
            'id': _id,
            'nickname': nickname,
            'user_name': user_name,
            'password': hash_password(password),
            'email': email,
            'phone': phone,
            'is_admin': is_admin
        }
        user = User()
        for key in data.keys():
            user.__setattr__(key, data[key])

        user.save_to_db()
    else:
        return send_error(message="Tên tài khoản đã được sử dụng. Vui lòng thử tên khác.")

    return send_result(message="Tạo tài khoản thành công", data=user.json())


@api.route('/<user_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update_user(user_id):
    """ This is api for the user management edit the user.

        Request Body:

        Returns:

        Examples::

    """

    user = User.find_by_id(user_id)
    if user is None:
        return send_error(message="Not found user!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=user_update_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["nickname", "phone", "email", "is_admin"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            user.__setattr__(key, json_data.get(key))

    try:
        user.__setattr__('updated_at', get_datetime_now_s())
        user.save_to_db()
    except Exception as ex:
        return send_error(message="Database error: " + str(ex))

    return send_result(data=data, message="Update user successfully!")


@api.route('/<user_id>', methods=['PATCH'])
@jwt_required
@admin_required()
def set_status(user_id):
    """ This is api for the vendor edit the user (is_admin).

        Request Body:

        Returns:

        Examples::

    """

    user = User.find_by_id(user_id)
    if user is None:
        return send_error(message="User not found!")

    try:
        json_data = request.get_json()
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid", code=420)

    user.__setattr__('is_admin', json_data.get('is_admin'))
    user.__setattr__('updated_at', get_datetime_now_s())

    try:
        user.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update user")

    return send_result(data=user.json(), message="Update user successfully!")


@api.route('/profile', methods=['PUT'])
@jwt_required
def update_info():
    """ This is api for all user edit their profile.

        Request Body:

        Returns:


        Examples::

    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=user_update_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["nickname", "phone", "email"]

    user = User.find_by_id(get_jwt_identity())

    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            user.__setattr__(key, json_data.get(key))

    try:
        user.__setattr__('updated_at', get_datetime_now_s())
        user.save_to_db()
    except Exception as ex:
        return send_error(message="Database error: " + str(ex))

    return send_result(data=data, message="Update user successfully!")


@api.route('/change_password', methods=['PUT'])
@jwt_required
def change_password():
    """ This api for all user change their password.

        Request Body:

        Returns:

        Examples::

    """

    user_id = get_jwt_identity()
    current_user = User.find_by_id(user_id)

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=password_validator)

        current_password = json_data.get('current_password', None)
        new_password = json_data.get('new_password', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message='Parameters invalid')

    if not check_password_hash(current_user.password, current_password):
        return send_error(message="Current password incorrect!")

    if is_password_contain_space(new_password):
        return send_error(message='Password cannot contain spaces')

    current_user.__setattr__('password', hash_password(new_password))
    current_user.__setattr__('updated_at', get_datetime_now_s())
    try:
        current_user.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while change password")

    # revoke all token of current user  from database except current token
    TokenBlacklist.revoke_all_token2(user_id)

    return send_result(message="Change password successfully!")


@api.route('/<user_id>/reset_password', methods=['PUT'])
@jwt_required
@admin_required()
def reset_password(user_id):
    """ This api for the user management resets the users password.

        Request Body:

        Returns:

        Examples::

    """
    user = User.find_by_id(user_id)
    if user is None:
        return send_error(message="Not found user!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=password_validator)

        new_password = json_data.get('new_password', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message='Parameters invalid')

    if is_password_contain_space(new_password):
        return send_error(message='Password cannot contain spaces')

    user.__setattr__('password', hash_password(new_password))
    user.__setattr__('updated_at', get_datetime_now_s())
    try:
        user.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while change password")

    # revoke all token of reset user  from database
    TokenBlacklist.revoke_all_token(user_id)

    return send_result(data=None, message="Reset password successfully!")


@api.route('/<user_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete_user(user_id):
    """ This api for the user management deletes the users.

        Returns:

        Examples::

    """
    user = User.find_by_id(user_id)
    if user is None:
        return send_error(message="Not found user!")

    # Also delete all children foreign key
    user.delete_from_db()

    # revoke all token of reset user  from database
    TokenBlacklist.revoke_all_token(user_id)

    return send_result(data=user, message="Delete user successfully!")


@api.route('', methods=['GET'])
@jwt_required
@admin_required()
def get_all_users():
    """ This api gets all users.

        Returns:

        Examples::

    """

    results = User.find_all()
    return send_result(data=list(user.json() for user in results))


@api.route('/<user_id>', methods=['GET'])
@jwt_required
@admin_required()
def get_user_by_id(user_id):
    """ This api get information of a user.

        Returns:

        Examples::

    """

    user = User.find_by_id(user_id)
    if not user:
        return send_error(message="User not found.")
    return send_result(data=user.json())


@api.route('/profile', methods=['GET'])
@jwt_required
def get_profile():
    """ This api for the user get their information.

        Returns:

        Examples::

    """

    current_user = User.find_by_id(get_jwt_identity())

    return send_result(data=current_user.json())


@api.route('/purchase', methods=['GET'])
@jwt_required
def get_all_orders():
    """ This api for the user get their information.

        Returns:

        Examples::

    """
    user_id = get_jwt_identity()
    limit = request.args.get('limit', 20, type=int)
    page = request.args.get('page', None, type=int)

    results = Order.find_by_user_id(user_id, page, limit)
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json_many() for result in results.items),
               page=results.page,
               pages=results.pages,
               total=results.total)
    return send_result(data=res)


@api.route('/purchase/order/<order_id>', methods=['GET'])
@jwt_required
def get_order_by_id(order_id):
    """ This api get information of a order.

        Returns:

        Examples::

    """

    order = Order.find_by_id(order_id)
    if not order:
        return send_error(message="Order not found!")
    return send_result(data=order.json())


@api.route('/purchase/order/<order_id>', methods=['DELETE'])
@jwt_required
def cancel_order_by_id(order_id):
    """ This api to cancel a order.

        Returns:

        Examples::

    """

    order = Order.find_by_id(order_id)
    if not order:
        return send_error(message="Order not found!")
    if order.status > 1:
        return send_error(message="Không thể hủy đơn hàng đã xác nhận")
    order.__setattr__('status', 0)
    try:
        order.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while cancel order")

    return send_result(message="Cancel order successfully!")
