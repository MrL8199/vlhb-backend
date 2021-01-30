import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger, db
from app.models import Address, User
from app.schema.schema_validator import address_validator
from app.utils import send_result, send_error

api = Blueprint('addresses', __name__)


@api.route('/', methods=['POST'])
@jwt_required
def post():
    """
    Function: Create new address

    Input: name, imageURL

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=address_validator)
        name = json_data.get('name', None)
        default = json_data.get('default', None)
        phone = json_data.get('phone', None)
        email = json_data.get('email', None)
        address = json_data.get('address', None)
        city = json_data.get('city', None)
        state = json_data.get('state', None)
        district = json_data.get('district', None)

    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    _id = str(uuid.uuid1())
    data = {
        'id': _id,
        'user_id': get_jwt_identity(),
        'name': name,
        'default': default,
        'phone': phone,
        'email': email,
        'address': address,
        'city': city,
        'state': state,
        'district': district
    }
    address = Address()
    for key in data.keys():
        address.__setattr__(key, data[key])

    try:
        address.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while create address")

    return send_result(message="Create address successfully!", data=data)


@api.route('/<address_id>', methods=['PUT'])
@jwt_required
def update(address_id):
    """ This is api for the user edit the address.

        Request Body:

        Returns:

        Examples::

    """

    address = Address.find_by_id(address_id)
    if address is None or address.user_id != get_jwt_identity():
        return send_error(message="Address not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=address_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["name", "default", "phone", "email", "address", "city", "state", "district"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            address.__setattr__(key, json_data.get(key))

    try:
        address.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update address")

    return send_result(data=data, message="Update address successfully!")


@api.route('/<address_id>', methods=['DELETE'])
@jwt_required
def delete(address_id):
    """ This api for the vendor deletes the address.

        Returns:

        Examples::

    """
    address = Address.find_by_id(address_id)
    if address is None or address.user_id != get_jwt_identity():
        return send_error(message="Address not found!")
    # Also delete all children foreign key
    try:
        address.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while delete address")

    return send_result(message="Delete address successfully!")


@api.route('', methods=['GET'])
@jwt_required
def get_all():
    """ This api gets all addresses of user.

        Returns:

        Examples:

    """

    results = Address.find_by_userid(get_jwt_identity())
    return send_result(data=list(result.json() for result in results))


@api.route('/<address_id>', methods=['GET'])
@jwt_required
def get_by_id(address_id):
    """ This api get information of a address.

        Returns:

        Examples::

    """

    address = Address.find_by_id(address_id)
    if not address:
        return send_error(message="Address not found!")
    return send_result(data=address.json())


@api.route('/<address_id>/set_default', methods=['POST'])
@jwt_required
def set_default_address(address_id):
    """
    This API to set address to default

    Returns: success/error message

    Example::
    """

    address = Address.find_by_id(address_id)
    if not address:
        return send_error(message="Address not found!")
    user = User.find_by_id(get_jwt_identity())
    address.__setattr__('default', True)
    old_default_address = db.session.query(Address).filter(Address.user_id == user.id, Address.default is True).first()
    if old_default_address:
        old_default_address.__setattr__('default', False)
        db.session.add(old_default_address)
    try:
        db.session.commit()
        address.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update default address")
    return send_result(data=address.json())
