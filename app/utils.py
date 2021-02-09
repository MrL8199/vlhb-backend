import datetime
import imghdr

import werkzeug
from flask import jsonify
from marshmallow import fields, validate as validate_

from app.extensions import jwt, parser


def parse_req(argmap):
    """
    Parser request from client
    :param argmap:
    :return:
    """
    return parser.parse(argmap)


def send_result(data=None, message="OK", code=200, version=1, status=True):
    """
    Args:
        data: simple result object like dict, string or list
        message: message send to client, default = OK
        code: code default = 200
        version: version of api
    :param data:
    :param message:
    :param code:
    :param version:
    :param status:
    :return:
    json rendered sting result
    """
    res = {
        "jsonrpc": "2.0",
        "status": status,
        "code": code,
        "message": message,
        "data": data,
        "version": get_version(version)
    }

    return jsonify(res), 200


def send_error(data=None, message="Error", code=200, version=1, status=False):
    """

    :param data:
    :param message:
    :param code:
    :param version:
    :param status:
    :return:
    """
    res_error = {
        "jsonrpc": "2.0",
        "status": status,
        "code": code,
        "message": message,
        "data": data,
        "version": get_version(version)
    }
    return jsonify(res_error), code


def get_version(version):
    """
    if version = 1, return api v1
    version = 2, return api v2
    Returns:

    """
    return "VLHB_store v2.0" if version == 2 else "VLHB_store v1.0"


class FieldString(fields.String):
    """
    validate string field, max length = 1024
    Args:
        des:

    Returns:

    """
    DEFAULT_MAX_LENGTH = 1024  # 1 kB

    def __init__(self, validate=None, requirement=None, **metadata):
        """

        Args:
            validate:
            metadata:
        """
        if validate is None:
            validate = validate_.Length(max=self.DEFAULT_MAX_LENGTH)
        if requirement is not None:
            validate = validate_.NoneOf(error='Dau vao khong hop le!', iterable={'full_name'})
        super(FieldString, self).__init__(validate=validate, required=requirement, **metadata)


class FieldNumber(fields.Number):
    """
    validate number field, max length = 30
    Args:
        des:

    Returns:

    """
    DEFAULT_MAX_LENGTH = 30  # 1 kB

    def __init__(self, validate=None, **metadata):
        """

        Args:
            validate:
            metadata:
        """
        if validate is None:
            validate = validate_.Length(max=self.DEFAULT_MAX_LENGTH)
        super(FieldNumber, self).__init__(validate=validate, **metadata)


def hash_password(str_pass):
    return werkzeug.security.generate_password_hash(str_pass)


def is_password_contain_space(password):
    """
    Args:
        password:

    Returns:
        True if password contain space
        False if password not contain space
    """
    return ' ' in password


def validate_image(stream):
    """
    Validate image format extension
    :param stream:
    :return:
        None if file not valid image
        .jpeg or .jpg if file is valid image
    """
    header = stream.read(512)
    stream.seek(0)
    format_img = imghdr.what(None, header)
    if not format_img:
        return None
    return '.' + (format_img if format_img != 'jpeg' else 'jpg')


def get_datetime_now():
    return datetime.datetime.now()


def get_datetime_now_s():
    return int(datetime.datetime.now().timestamp())


def get_datetime_today_s():
    return datetime.datetime.today().timestamp()


@jwt.expired_token_loader
def expired_token_callback():
    """
    Callback function when token expired   
    """
    return jsonify({
        'description': 'The token has expired.',
        'error': 'token_expired'
    }), 401


@jwt.invalid_token_loader
def invalid_token_callback(error):
    """
    Callback function when token invalid   
    """
    return jsonify({
        'description': 'Signature verification failed.',
        'message': 'invalid_token',
        'error': str(error)
    }), 401


@jwt.needs_fresh_token_loader
def token_not_fresh_callback():
    """
    Callback function when token is not fresh   
    """
    return jsonify({
        'description': 'The token is not fresh.',
        'message': 'fresh_token_required'
    }), 401


@jwt.unauthorized_loader
def missing_token_callback(error):
    """
    Callback function when token is missing   
    """
    return jsonify({
        'description': 'Request does not contain an access token',
        'error': str(error),
        'message': 'authorization_required'
    }), 401


@jwt.revoked_token_loader
def revoked_token_callback():
    """
    Callback function when token revoked   
    """
    return jsonify({
        'description': 'The token has been revoked',
        'error': 'token_revoked'
    }), 401
