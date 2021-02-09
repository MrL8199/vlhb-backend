import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger
from app.models import Coupon
from app.schema.schema_validator import coupon_validator
from app.utils import send_result, send_error, get_datetime_now_s

api = Blueprint('coupons', __name__)


@api.route('/', methods=['POST'])
@jwt_required
@admin_required()
def post():
    """
    Function: Create new coupon

    Input: code, value, start_date, end_date, amount

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=coupon_validator)

        code = json_data.get('code', None)
        value = json_data.get('value', None)
        max_value = json_data.get('max_value', None)
        description = json_data.get('description', None)
        start_date = json_data.get('start_date', None)
        end_date = json_data.get('end_date', None)
        amount = json_data.get('amount', None)
        is_enable = json_data.get('is_enable', False)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    coupon = Coupon.find_by_code(code)
    if coupon:
        return send_error(message="Coupon with code '{}' has exists!".format(code))

    _id = str(uuid.uuid1())

    data = {
        'id': _id,
        'code': code,
        'value': value,
        'max_value': max_value,
        'description': description,
        'start_date': start_date,
        'end_date': end_date,
        'amount': amount,
        'is_enable': is_enable
    }
    coupon = Coupon()
    for key in data.keys():
        coupon.__setattr__(key, data[key])

    try:
        coupon.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while create coupon")

    return send_result(message="Create coupon successfully", data=coupon.json())


@api.route('/<coupon_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update(coupon_id):
    """ This is api for the vendor edit the coupon.

        Request Body:

        Returns:

        Examples::

    """

    coupon = Coupon.find_by_id(coupon_id)
    if coupon is None:
        return send_error(message="Order not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=coupon_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["code", "description", "value", "max_value", "start_date", "end_date", "amount", "is_enable"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            coupon.__setattr__(key, json_data.get(key))

    try:
        coupon.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update coupon")

    return send_result(data=coupon.json(), message="Update coupon successfully!")


@api.route('/<coupon_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete(coupon_id):
    """ This api for the vendor deletes the coupon.

        Returns:

        Examples::

    """
    coupon = Coupon.find_by_id(coupon_id)
    if coupon is None:
        return send_error(message="Coupon not found!")

    try:
        # Also delete all children foreign key
        coupon.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while deleting coupon")

    return send_result(message="Delete coupon successfully!")


@api.route('', methods=['GET'])
@jwt_required
@admin_required()
def get_all():
    """ This api gets all coupons.

        Returns:

        Examples::

    """
    from_date = request.args.get('from-date', None, type=int)
    to_date = request.args.get('to-date', get_datetime_now_s(), type=int)
    limit = request.args.get('limit', 20, type=int)
    page = request.args.get('page', None, type=int)

    results = Coupon.search(from_date, to_date, limit, page)
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json() for result in results.items),
               page=results.page,
               pages=results.pages,
               total=results.total)
    return send_result(data=res)


@api.route('/<coupon_id>', methods=['GET'])
@jwt_required
@admin_required()
def get_by_id(coupon_id):
    """ This api get information of a coupon.

        Returns:

        Examples::

    """

    coupon = Coupon.find_by_id(coupon_id)
    if not coupon:
        return send_error(message="Coupon not found!")
    return send_result(data=coupon.json())


@api.route('/get/<coupon_code>', methods=['GET'])
@jwt_required
def get_by_code(coupon_code):
    """ This api get information of a coupon.

        Returns:

        Examples::

    """

    coupon = Coupon.find_by_code(coupon_code)
    if not coupon or not coupon.is_enable:
        return send_error(message="Coupon not valid!")
    ret = {
        'code': coupon.code,
        'description': coupon.description,
        'value': coupon.value,
        'max_value': coupon.max_value
    }
    return send_result(data=ret)
