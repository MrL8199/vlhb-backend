import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger
from app.models import Author
from app.schema.schema_validator import author_validator
from app.utils import send_result, send_error

api = Blueprint('authors', __name__)


@api.route('/', methods=['POST'])
@jwt_required
@admin_required()
def post():
    """
    Function: Create new author

    Input: name, imageURL

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=author_validator)

        name = json_data.get('name', None)
        picture = json_data.get('picture', None)
        info = json_data.get('info', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    _id = str(uuid.uuid1())

    data = {
        'id': _id,
        'name': name,
        'picture': picture,
        'info': info
    }
    author = Author()
    for key in data.keys():
        author.__setattr__(key, data[key])

    try:
        author.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while create author")

    return send_result(message="Create author successfully!", data=author.json())


@api.route('/<author_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update(author_id):
    """ This is api for the vendor edit the author.

        Request Body: name

        Returns:

        Examples::

    """

    author = Author.find_by_id(author_id)
    if author is None:
        return send_error(message="Author not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=author_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["name", "picture", "info"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            author.__setattr__(key, json_data.get(key))

    try:
        author.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update author")

    return send_result(data=data, message="Update author successfully!")


@api.route('/<author_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete(author_id):
    """ This api for the vendor deletes the author.

        Returns:

        Examples::

    """
    author = Author.find_by_id(author_id)
    if author is None:
        return send_error(message="Author not found!")

    # Also delete all children foreign key
    try:
        author.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while delete author")

    return send_result(message="Delete author successfully!")


@api.route('', methods=['GET'])
def get_all():
    """ This api gets all authors.

        Returns:

        Examples:

    """

    results = Author.find_all()
    return send_result(data=list(result.json() for result in results))


@api.route('/<author_id>', methods=['GET'])
def get_by_id(author_id):
    """ This api get information of a author.

        Returns:

        Examples::

    """

    author = Author.find_by_id(author_id)
    if not author:
        return send_error(message="Author not found!")
    return send_result(data=author.json())
