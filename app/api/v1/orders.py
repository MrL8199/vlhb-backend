from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger
from app.models import Order
from app.schema.schema_validator import order_validator
from app.utils import send_result, send_error, get_datetime_now

api = Blueprint('orders', __name__)


@api.route('/<order_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update_order(order_id):
    """ This is api for the vendor edit the order.

        Request Body:

        Returns:

        Examples::

    """

    order = Order.find_by_id(order_id)
    if order is None:
        return send_error(message="Order not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=order_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    order.__setattr__('status', json_data.get('status'))

    try:
        order.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update order")

    return send_result(data=order.json(), message="Update order successfully!")


@api.route('/<order_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete_order(order_id):
    """ This api for the vendor deletes the order.

        Returns:

        Examples::

    """
    order = Order.find_by_id(order_id)
    if order is None:
        return send_error(message="Order not found!")

    try:
        # Also delete all children foreign key
        order.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while deleting order")

    return send_result(message="Delete order successfully!")


@api.route('', methods=['GET'])
@jwt_required
@admin_required()
def get_all_orders():
    """ This api gets all orders.

        Returns:

        Examples::

    """
    from_date = request.args.get('from-date', None, type=int)
    to_date = request.args.get('to-date', get_datetime_now(), type=int)
    limit = request.args.get('limit', 20, type=int)
    page = request.args.get('page', None, type=int)

    results = Order.search(from_date, to_date, limit, page)
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json_many() for result in results.items),
               page=results.page,
               pages=results.pages,
               total=results.total)
    return send_result(data=res)


@api.route('/<order_id>', methods=['GET'])
@jwt_required
@admin_required()
def get_order_by_id(order_id):
    """ This api get information of a order.

        Returns:

        Examples::

    """

    order = Order.find_by_id(order_id)
    if not order:
        return send_error(message="Order not found!")
    return send_result(data=order.json())
