import uuid
from datetime import datetime

from cloudinary import api as cloudinary_api
from flask import Blueprint, request
from flask_jwt_extended import jwt_required
from jsonschema import validate

from app.decorators import admin_required
from app.extensions import logger, db
from app.models import Product, Category, ProductImage, Publisher, Author
from app.schema.schema_validator import product_validator
from app.utils import send_result, send_error, get_datetime_now_s

api = Blueprint('products', __name__)


@api.route('/', methods=['POST'])
@jwt_required
@admin_required()
def post():
    """
    Function: Create new product

    Input: title, price, images, publish_year, page_number, quantity, quotes_about, discount, start_at, end_at,
    author_id, publisher_id,category_id

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=product_validator)

        title = json_data.get('title', None)
        price = json_data.get('price', None)
        images = json_data.get('images', None)
        publish_year = json_data.get('publish_year', None)
        page_number = json_data.get('page_number', None)
        quantity = json_data.get('quantity', None)
        quotes_about = json_data.get('quotes_about', None)
        discount = json_data.get('discount', None)
        start_at = json_data.get('start_at', None)
        end_at = json_data.get('end_at', None)
        author_id = json_data.get('author_id', None)
        publisher_id = json_data.get('publisher_id', None)
        category_id = json_data.get('category_id', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    category = Category.find_by_id(category_id)
    if category is None:
        return send_error(message="Category not found!")

    publisher = Publisher.find_by_id(publisher_id)
    if publisher is None:
        return send_error(message="Publisher not found!")

    author = Author.find_by_id(author_id)
    if author is None:
        return send_error(message="Author not found!")

    _id = str(uuid.uuid1())

    data = {
        'id': _id,
        'create_at': get_datetime_now_s(),
        'title': title,
        'price': (price - price * discount if discount is not None else price),
        'publish_year': publish_year,
        'page_number': page_number,
        'quantity': quantity,
        'quotes_about': quotes_about,
        'discount': discount,
        'start_at': start_at,
        'end_at': end_at,
        'author_id': author_id,
        'publisher_id': publisher_id,
        'category_id': category_id
    }
    product = Product()
    for key in data.keys():
        product.__setattr__(key, data[key])

    try:
        db.session.add(product)
        if images:
            for image_id in images:
                product_image = ProductImage.find_by_id(image_id)
                if product_image is not None:
                    product_image.product_id = product.id
                    db.session.add(product_image)
        db.session.commit()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while create product")

    return send_result(message="Create product successfully", data=product.json())


@api.route('/<product_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update_product(product_id: str):
    """ This is api for the vendor edit the product.

        Request Body: title, price, images, publish_year, page_number, quantity, quotes_about, discount, start_at,
         end_at, author_id, publisher_id,category_id

        Returns: Success / Error message

        Examples::

    """

    product = Product.find_by_id(product_id)
    if product is None:
        return send_error(message="Product not found!")

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=product_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["title", "publish_year", "page_number", "quantity", "quotes_about", "discount",
            "start_at", "end_at", "author_id", "publisher_id", "category_id"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            product.__setattr__(key, json_data.get(key))
    price = json_data.get('price')
    discount = json_data.get('discount', None)
    product.__setattr__('price', (price - price * discount if discount is not None else price))

    try:
        db.session.add(product)
        if json_data.get('images'):
            for image_id in json_data.get('images'):
                product_image = ProductImage.find_by_id(image_id)
                if product_image is not None:
                    product_image.product_id = product.id
                    db.session.add(product_image)

        db.session.commit()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while update product")

    return send_result(data=product.json(), message="Update product successfully!")


@api.route('/<product_id>', methods=['DELETE'])
@jwt_required
@admin_required()
def delete_product(product_id: str):
    """ This api for the vendor deletes the product.

        Returns:

        Examples::

    """
    product = Product.find_by_id(product_id)
    if product is None:
        return send_error(message="Product not found!")

    try:
        product_images = ProductImage.find_by_product_id(product_id)
        images = [image.filename for image in product_images]
        # Also remove from cloudinary
        if images:
            cloudinary_api.delete_resources(images)
        # for image in product_images:
        #     # Also delete file in static folder
        #     os.remove(os.path.join(PATH_IMAGE, image.filename))
        # Also delete all children foreign key
        product.delete_from_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while deleting product")

    return send_result(message="Delete product successfully!")


@api.route('', methods=['GET'])
def get_all():
    """ This api gets all products.

        Returns:

        Examples::

    """
    name = request.args.get('q', '', type=str)
    page_size = request.args.get('pageSize', 20, type=int)
    limit = request.args.get('limit', page_size, type=int)
    page = request.args.get('page', 1, type=int)
    category_id = request.args.get('category', None, type=str)
    sort = request.args.get('sort', None, type=str)
    min_price = request.args.get('min_price', 0, type=int)
    max_price = request.args.get('max_price', 9999999999, type=int)
    from_date = request.args.get('from_date', 0, type=int)
    to_date = request.args.get('to_date', 9999999999, type=int)

    results = Product.filter(name, category_id, sort, min_price, max_price, limit, page, from_date, to_date)
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json() for result in results.items),
               page=results.page,
               pages=results.pages,
               total=results.total)
    return send_result(data=res)


@api.route('/all', methods=['GET'])
def get_all_admin():
    """ This api gets all products.

        Returns:

        Examples::

    """
    name = request.args.get('q', '', type=str)
    page_size = request.args.get('pageSize', 20, type=int)
    limit = request.args.get('limit', page_size, type=int)
    page = request.args.get('page', 1, type=int)
    category_id = request.args.get('category', None, type=str)
    sort = request.args.get('sort', None, type=str)
    min_price = request.args.get('min_price', 0, type=int)
    max_price = request.args.get('max_price', 9999999999, type=int)
    from_date = request.args.get('from_date', 0, type=int)
    to_date = request.args.get('to_date', 9999999999, type=int)

    results = Product.filter(name, category_id, sort, min_price, max_price, limit, page, from_date, to_date)
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json_admin() for result in results.items),
               page=results.page,
               pages=results.pages,
               total=results.total)
    return send_result(data=res)


@api.route('/<product_id>', methods=['GET'])
def get_by_id(product_id: str):
    """ This api get information of a product.

        Returns:

        Examples::

    """

    product = Product.find_by_id(product_id)
    if not product:
        return send_error(message="Product not found!")
    return send_result(data=product.json())


@api.route('/best-seller', methods=['GET'])
def get_best_seller_products():
    try:
        # calculate best seller product from order table
        results = db.session.execute('SELECT product_id, SUM(quantity) AS TotalQuantity FROM order_details GROUP BY '
                                     'product_id ORDER BY SUM(quantity) DESC LIMIT :val', {'val': 10})

        items = []
        for row in results:
            product_id = row['product_id']
            items.append(Product.find_by_id(product_id))
        while items.__len__() < 10:
            items.append(Product.find_random())

        res = dict(has_next=False,
                   has_prev=False,
                   items=list(item.json() for item in items),
                   page=1,
                   pages=1,
                   total=10)
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while fetch data")

    return send_result(data=res)
