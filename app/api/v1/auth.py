from datetime import timedelta

from flask import Blueprint
from flask_jwt_extended import (
    jwt_required, create_access_token,
    jwt_refresh_token_required, get_jwt_identity,
    create_refresh_token, get_raw_jwt
)
from werkzeug.security import check_password_hash

from app.extensions import jwt, logger
from app.models import TokenBlacklist, User
from app.utils import parse_req, FieldString, send_result, send_error, get_datetime_now

ACCESS_EXPIRES = timedelta(minutes=30)
REFRESH_EXPIRES = timedelta(days=30)
api = Blueprint('auth', __name__)


@api.route('/login', methods=['POST'])
def login():
    """
    :response: {"messages": "success"}
    """
    params = {
        'username': FieldString(),
        'password': FieldString()
    }

    try:
        json_data = parse_req(params)
        username = json_data.get('username', None).strip()
        password = json_data.get('password')
    except Exception as ex:
        logger.error('{} Parameters error: '.format(get_datetime_now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message='Invalid username or password.\nPlease try again')

    # log input fields
    logger.debug(f"INPUT api login: {json_data}")

    user = User.find_by_username(username=username)
    if user is None:
        return send_error(message='Invalid username or password.\nPlease try again')

    if not check_password_hash(user.password, password):
        return send_error(message='Invalid username or password.\nPlease try again')

    access_token = create_access_token(
        identity=user.id, expires_delta=ACCESS_EXPIRES)
    refresh_token = create_refresh_token(
        identity=user.id, expires_delta=REFRESH_EXPIRES)

    # Store the tokens in our store with a status of not currently revoked.
    TokenBlacklist.add_token_to_database(access_token, user.id)
    TokenBlacklist.add_token_to_database(refresh_token, user.id)

    return send_result(data={
        'access_token': access_token,
        'refresh_token': refresh_token,
        'username': user.user_name,
        'email': user.email,
        'phone': user.phone,
        'nickname': user.nickname,
        'role': 'admin' if user.is_admin else 'user'
    }, message='Login successfully!')


# The jwt_refresh_token_required decorator insures a valid refresh
# token is present in the request before calling this endpoint. We
# can use the get_jwt_identity() function to get the identity of
# the refresh token, and use the create_access_token() function again
# to make a new access token for this identity.
@api.route('/refresh', methods=['POST'])
@jwt_refresh_token_required
def refresh():
    """
    Refresh token if token is expired
    :return:
    """
    current_user_id = get_jwt_identity()
    access_token = create_access_token(identity=current_user_id)

    TokenBlacklist.add_token_to_database(access_token, current_user_id)

    ret = {
        'access_token': access_token
    }
    return send_result(data=ret)


@api.route('/logout', methods=['DELETE'])
@jwt_required
def logout():
    """
    Endpoint for revoking the current users access token
    Add token to blacklist
    :return:
    """
    jti = get_raw_jwt()['jti']

    # remove token from database
    TokenBlacklist.revoke_token(jti)

    return send_result(message='logout_successfully')


@api.route('/logout2', methods=['DELETE'])
@jwt_refresh_token_required
def logout2():
    """
    Endpoint for revoking the current users refresh token
    :return:
    """
    jti = get_raw_jwt()['jti']
    TokenBlacklist.revoke_token(jti)
    return send_result(message='logout_successfully')


@jwt.token_in_blacklist_loader
def check_if_token_is_revoked(decrypted_token):
    """
    Check token revoked_store
    :param decrypted_token:
    :return:
    """
    return TokenBlacklist.is_token_revoked(decrypted_token)
