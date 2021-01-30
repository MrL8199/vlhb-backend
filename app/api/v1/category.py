import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger
from app.models import Category
from app.schema.schema_validator import category_validator
from app.utils import send_result, send_error

api = Blueprint('category', __name__)


@api.route('/', methods=['POST'])
@jwt_required
@admin_required()
def post():
    """
    Function: Create new category

    Input: name, imageURL

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=category_validator)

        name = json_data.get('name', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    _id = str(uuid.uuid1())

    data = {
        'id': _id,
        'name': name
    }
    category = Category()
    for key in data.keys():
        category.__setattr__(key, data[key])

    try:
        category.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while create category")

    return send_result(message="Create category successfully!", data=category.json())


@api.route('/<category_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update(category_id):
    """ This is api for the vendor edit the category.

        Request Body: name

        Returns:

        Examples::

    """

    category = Category.find_by_id(category_id)
    if category is None:
        return send_error(message="Category not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=category_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["name"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            category.__setattr__(key, json_data.get(key))

    try:
        category.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update category")

    return send_result(data=data, message="Update category successfully!")


@api.route('/<category_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete(category_id):
    """ This api for the vendor deletes the category.

        Returns:

        Examples::

    """
    category = Category.find_by_id(category_id)
    if category is None:
        return send_error(message="Category not found!")

    # Also delete all children foreign key
    try:
        category.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while delete category")

    return send_result(message="Delete category successfully!")


@api.route('', methods=['GET'])
def get_all_categories():
    """ This api gets all categories.

        Returns:

        Examples:

    """

    results = Category.find_all()
    return send_result(data=list(result.json() for result in results))


@api.route('/<category_id>', methods=['GET'])
def get_category_by_id(category_id):
    """ This api get information of a category.

        Returns:

        Examples::

    """

    category = Category.find_by_id(category_id)
    if not category:
        return send_error(message="Category not found!")
    return send_result(data=category.json())
