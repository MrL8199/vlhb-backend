import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from jsonschema import validate

from app.decorators import cart_required
from app.enums import PRODUCT_NOT_FOUND_MSG, PRODUCT_NOT_ENOUGH_MSG, ADD_TO_CART_SUCCESSFULLY_MSG, EMTPY_CART_MSG
from app.extensions import logger, db
from app.models import Cart, CartItem, Product
from app.schema.schema_validator import cart_validator
from app.utils import send_result, send_error, get_datetime_now_s

api = Blueprint('cart', __name__)


@api.route('/add_to_cart', methods=['POST'])
@jwt_required
@cart_required
def post():
    """
    Function: Add product to cart

    Input: {"product_id":"73788532","quantity":1}

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=cart_validator)

        content = json_data.get('content', None)
        product_id = json_data.get('product_id', None)
        quantity = json_data.get('quantity', 1)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    product = Product.find_by_id(product_id)
    if not product:
        return send_error(message=PRODUCT_NOT_FOUND_MSG)

    cart = Cart.find_by_user_id(get_jwt_identity())

    item = CartItem.find_by_product_id(cart.id, product_id)

    if not item:
        data = {
            'id': str(uuid.uuid1()),
            'updated_at': get_datetime_now_s(),
            'price': product.price,
            'discount': product.discount,
            'quantity': quantity,
            'content': content,
            'product_id': product_id,
            'cart_id': cart.id
        }
        item = CartItem()
        for key in data.keys():
            item.__setattr__(key, data[key])
    else:
        item.__setattr__('quantity', item.quantity + quantity)
        item.__setattr__('discount', product.discount)
        item.__setattr__('price', product.price)
        item.__setattr__('updated_at', get_datetime_now_s())
    if item.quantity > product.quantity:
        return send_error(message=PRODUCT_NOT_ENOUGH_MSG.format(product.title, product.quantity))
    try:
        db.session.add(item)
        # Tính lại các giá trị của Cart
        cart.calculator_cart()
        db.session.add(cart)
        db.session.commit()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while add to cart")

    return send_result(message=ADD_TO_CART_SUCCESSFULLY_MSG, data=item.json())


@api.route('/<cart_item_id>', methods=['PUT'])
@jwt_required
@cart_required
def update(cart_item_id):
    """ This is api for the user edit the cart item.

        Request Body: item_id

        Returns:

        Examples::

    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=cart_validator)

        product_id = json_data.get('product_id', None)
        quantity = json_data.get('quantity', 1)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    product = Product.find_by_id(product_id)
    if not product:
        return send_error(message=PRODUCT_NOT_FOUND_MSG)

    cart = Cart.find_by_user_id(get_jwt_identity())

    item = CartItem.find_by_id(cart_item_id)
    if item is None:
        return send_error(message=PRODUCT_NOT_FOUND_MSG)
    else:
        item.__setattr__('quantity', quantity)
        item.__setattr__('discount', product.discount)
        item.__setattr__('price', product.price)
        item.__setattr__('updated_at', get_datetime_now_s())
    if item.quantity > product.quantity:
        return send_error(message=PRODUCT_NOT_ENOUGH_MSG.format(product.title, product.quantity))
    try:
        db.session.add(item)
        # Tính lại các giá trị của Cart
        cart.calculator_cart()
        db.session.add(cart)
        db.session.commit()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update cart item")

    return send_result(data={'quantity': quantity})


@api.route('/<cart_item_id>', methods=['DELETE'])
@jwt_required
@cart_required
def delete(cart_item_id):
    """ This is api for the user edit the cart item.

        Request Body: item_id

        Returns:

        Examples::

    """
    cart = Cart.find_by_user_id(get_jwt_identity())
    item = CartItem.find_by_id(cart_item_id)
    if item is None:
        return send_error(message=EMTPY_CART_MSG)
    # Also delete all children foreign key
    try:
        item.delete_from_db()
        # Tính lại các giá trị của Cart
        cart.calculator_cart()
        db.session.add(cart)
        db.session.commit()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while delete cart item")

    return send_result(code=204)


@api.route('/get', methods=['GET'])
@jwt_required
@cart_required
def get_all():
    """ This api gets all item in user's cart.

        Returns:

        Examples:

    """

    cart = Cart.find_by_user_id(get_jwt_identity())
    if len(cart.cart_items) == 0:
        return send_error(message=EMTPY_CART_MSG)
    return send_result(data=cart.json())
