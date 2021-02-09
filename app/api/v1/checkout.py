import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import get_jwt_identity, jwt_required
from jsonschema import validate

from app.enums import ADDRESS_NOT_FOUND_MSG, EMTPY_CART_MSG, PRODUCT_NOT_FOUND_MSG
from app.extensions import logger, db
from app.models import Order, OrderDetail, Product, Address, Cart, Coupon
from app.schema.schema_validator import checkout_validator
from app.utils import get_datetime_now_s, send_result, send_error

api = Blueprint('checkout', __name__)


@api.route('/', methods=['POST'])
@jwt_required
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

        address_id = json_data.get('address_id', None)
        content = json_data.get('content', None)
        coupon_code = json_data.get('coupon_code', None)
        user_id = get_jwt_identity()
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    address = Address.find_by_id(address_id)
    if address is None:
        return send_error(message=ADDRESS_NOT_FOUND_MSG)

    cart = Cart.find_by_user_id(user_id)
    if len(cart.cart_items) == 0:
        return send_error(message=EMTPY_CART_MSG)

    coupon = Coupon.find_by_code(coupon_code)
    if coupon and not coupon.is_enable:
        return send_error(message="Coupon not valid!")

    # rollback db when an error occurs
    try:
        _id = str(uuid.uuid1())

        data = {
            'id': _id,
            'updated_at': get_datetime_now_s(),
            'status': 1,
            'subtotal': cart.subtotal,
            'item_discount': cart.item_discount,
            'tax': cart.tax,
            'shipping': cart.shipping,
            'total': cart.total,
            'promo': cart.promo,
            'discount': cart.discount,
            'grand_total': cart.grand_total,
            'content': content,
            'user_id': user_id,
            'address_id': address_id
        }

        order = Order()
        for key in data.keys():
            order.__setattr__(key, data[key])
        db.session.add(order)

        for item in cart.cart_items:
            order_detail = OrderDetail()
            product_id = item.product_id
            product = Product.find_by_id(product_id)
            _id_detail = str(uuid.uuid1())
            if product is None:
                return send_error(message=PRODUCT_NOT_FOUND_MSG + " có mã {}".format(product_id))
            detail = {
                'id': _id_detail,
                'updated_at': get_datetime_now_s(),
                'product_id': product_id,
                'order_id': order.id,
                'price': item.price,
                'quantity': item.quantity,
                'discount': item.discount
            }
            for key in detail.keys():
                order_detail.__setattr__(key, detail[key])
            db.session.add(order_detail)

        # delete item in cart
        cart.cart_items = []
        cart.calculator_cart()
        db.session.add(cart)

        db.session.commit()
    except Exception as ex:
        db.session.rollback()
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while checkout")

    return send_result(message="Submit order successfully.", data=order.json())
