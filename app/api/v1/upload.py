import os
import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from werkzeug.utils import secure_filename

from app.decorators import admin_required
from app.enums import UPLOAD_EXTENSIONS, PATH_IMAGE, PATH_IMAGE_SEVER
from app.extensions import logger
from app.models import ProductImage
from app.utils import send_result, send_error, validate_image

api = Blueprint('upload', __name__)


@api.route('/', methods=['POST'])
@jwt_required
@admin_required()
def post():
    """
    Function: upload new product Image/ new recipe image

    Input: image file (jpg, png, gif)

    Output: Success / Error Message
    """

    try:
        uploaded_file = request.files['file']
        filename = secure_filename(uploaded_file.filename)
        if filename != '':
            file_ext = os.path.splitext(filename)[1]
            if file_ext not in UPLOAD_EXTENSIONS or \
                    file_ext != validate_image(uploaded_file.stream):
                return send_error(message="Image file not valid")
            filename = 'product_' + str(datetime.now().timestamp()).replace('.', '') + file_ext

            image = ProductImage()
            path_server = os.path.join(PATH_IMAGE_SEVER, filename)
            path_file = os.path.join(PATH_IMAGE, filename)
            uploaded_file.save(path_file)

            _id = str(uuid.uuid1())
            data = {
                'id': _id,
                'imageURL': path_server,
                'filename': filename
            }

            for key in data.keys():
                image.__setattr__(key, data[key])

            image.save_to_db()

            return send_result(message="Upload image successfully", data=image.json())

    except Exception as ex:
        logger.error(
            '{} An error occurred while save image file: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(
                ex))
        return send_error(message="An error occurred while save image file")


@api.route('/<image_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete_image(image_id: str):
    """ This api for the vendor deletes the product/recipe image.

        Input: image_id

        Returns:

        Examples::

    """
    try:
        type_image = request.json.get('type')
        if type_image is None:
            return send_error(message="Type image required not valid")

        image = ProductImage.find_image_by_id(image_id)
        if image is None:
            return send_result(message="File not found!")

        # Also delete file in static folder
        os.remove(os.path.join(PATH_IMAGE, image.filename))
        image.delete_from_db()
    except Exception as ex:
        logger.error(
            '{} An error occurred while delete image: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while delete image")

    return send_result(message="Delete image successfully!")
