import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger
from app.models import Publisher
from app.schema.schema_validator import publisher_validator
from app.utils import send_result, send_error

api = Blueprint('publishers', __name__)


@api.route('/', methods=['POST'])
@jwt_required
@admin_required()
def post():
    """
    Function: Create new publisher

    Input: name, imageURL

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=publisher_validator)

        name = json_data.get('name', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    _id = str(uuid.uuid1())

    data = {
        'id': _id,
        'name': name
    }
    publisher = Publisher()
    for key in data.keys():
        publisher.__setattr__(key, data[key])

    try:
        publisher.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while create publisher")

    return send_result(message="Create publisher successfully!", data=publisher.json())


@api.route('/<publisher_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update(publisher_id):
    """ This is api for the vendor edit the publisher.

        Request Body: name

        Returns:

        Examples::

    """

    publisher = Publisher.find_by_id(publisher_id)
    if publisher is None:
        return send_error(message="Publisher not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=publisher_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["name"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            publisher.__setattr__(key, json_data.get(key))

    try:
        publisher.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update publisher")

    return send_result(data=data, message="Update publisher successfully!")


@api.route('/<publisher_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete(publisher_id):
    """ This api for the vendor deletes the publisher.

        Returns:

        Examples::

    """
    publisher = Publisher.find_by_id(publisher_id)
    if publisher is None:
        return send_error(message="Publisher not found!")

    # Also delete all children foreign key
    try:
        publisher.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while delete publisher")

    return send_result(message="Delete publisher successfully!")


@api.route('', methods=['GET'])
def get_all():
    """ This api gets all publishers.

        Returns:

        Examples:

    """

    results = Publisher.find_all()
    return send_result(data=list(result.json() for result in results))


@api.route('/<publisher_id>', methods=['GET'])
def get_by_id(publisher_id):
    """ This api get information of a publisher.

        Returns:

        Examples::

    """

    publisher = Publisher.find_by_id(publisher_id)
    if not publisher:
        return send_error(message="Publisher not found!")
    return send_result(data=publisher.json())
