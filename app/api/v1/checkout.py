import uuid
from datetime import datetime

from flask import Blueprint, request
from jsonschema import validate

from app.extensions import logger, db
from app.models import Order, OrderDetail, Product
from app.schema.schema_validator import checkout_validator
from app.utils import get_datetime_now_s, send_result, send_error

api = Blueprint('checkout', __name__)


@api.route('/', methods=['POST'])
def post():
    """
    Function: Create new order

    Input: name, phone, district, ward, address, cart

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=checkout_validator)

        name = json_data.get('name', None)
        phone = json_data.get('phone', None)
        district = json_data.get('district', None)
        ward = json_data.get('ward', None)
        address = json_data.get('address', None)
        cart = json_data.get('cart', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    # rollback db when an error occurs
    try:
        total = 0.0
        amount = 0

        _id = str(uuid.uuid1())

        data = {
            'id': _id,
            'create_at': get_datetime_now_s(),
            'name': name,
            'phone': phone,
            'district': district,
            'ward': ward,
            'address': address,
            'status': 'Pending'
        }

        order = Order()
        for key in data.keys():
            order.__setattr__(key, data[key])
        db.session.add(order)

        for cart_item in cart:
            order_detail = OrderDetail()
            product_id = cart_item.get('product_id', None)
            product = Product.find_product_by_id(product_id)
            _id_detail = str(uuid.uuid1())
            if product is None:
                return send_error(message="Product has id:{0} not found".format(product_id))
            detail = {
                'id': _id_detail,
                'product_id': product_id,
                'amount': cart_item.get('amount', 1),
                'order_id': order.id
            }
            amount += detail.get('amount')
            total += product.price * detail.get('amount')
            for key in detail.keys():
                order_detail.__setattr__(key, detail[key])
            db.session.add(order_detail)
        order.__setattr__('amount', amount)
        order.__setattr__('total', total)
        db.session.add(order)
        db.session.commit()
    except Exception as ex:
        db.session.rollback()
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while checkout")

    return send_result(message="Submit order successfully.", data=order.json())
