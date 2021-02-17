import uuid
from datetime import datetime

from flask import Blueprint, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from jsonschema import validate

from app.decorators import admin_required
from app.enums import PRODUCT_NOT_FOUND_MSG, CURD_ERR_MSG, CURD_SUCCESS_MSG, NOT_FOUND_MSG, SUPER_ADMIN_ID
from app.extensions import logger, db
from app.models import Product, ProductReview, User
from app.schema.schema_validator import review_validator
from app.utils import send_result, send_error, get_datetime_now_s

api = Blueprint('reviews', __name__)


@api.route('/', methods=['POST'])
@jwt_required
def post():
    """
    Function: Create new review

    Input: title, rating, content, product_id

    Output: Success / Error Message
    """

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=review_validator)

        title = json_data.get('title', None)
        rating = json_data.get('rating', 5)
        content = json_data.get('content', None)
        product_id = json_data.get('product_id', None)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    product = Product.find_by_id(product_id)
    if not product:
        return send_error(message=PRODUCT_NOT_FOUND_MSG)

    user = User.find_by_id(get_jwt_identity())

    result = db.session.execute("SELECT '{}' in (SELECT product_id FROM order_details WHERE order_id IN (SELECT "
                                "order_id FROM orders WHERE user_id = '{}'))".format(product_id, user.id))

    is_bought = False
    is_review = False
    for row in result:
        is_bought = row[0]
    if not is_bought:
        return send_error(message="Chỉ khách hàng đã mua sản phẩm mới có thể viết đánh giá!")

    result = db.session.execute("SELECT COUNT(*) FROM reviews WHERE product_id = '{}' AND user_id = "
                                "'{}' GROUP BY product_id".format(product_id, user.id))

    for row in result:
        is_review = row[0] > 0
    if is_review:
        return send_error(message="Bạn đã đánh giá sản phẩm này rồi!")

    _id = str(uuid.uuid1())

    data = {
        'id': _id,
        'created_at': get_datetime_now_s(),
        'title': title,
        'rating': rating,
        'content': content,
        'product_id': product_id,
        'user_id': user.id,
        'user_name': user.nickname,
        'published': True,
        'published_at': get_datetime_now_s()
    }
    review = ProductReview()
    for key in data.keys():
        review.__setattr__(key, data[key])

    try:
        review.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message=CURD_ERR_MSG.format('viết', 'đánh giá'))

    return send_result(message=CURD_SUCCESS_MSG.format('Viết', 'đánh giá'), data=review.json())


@api.route('/<review_id>', methods=['PUT'])
@jwt_required
@admin_required()
def update(review_id):
    """ This is api for the vendor consider published the review.

        Request Body:

        Returns:

        Examples::

    """

    review = ProductReview.find_by_id(review_id)
    if review is None:
        return send_error(message=NOT_FOUND_MSG.format('đánh giá'))

    try:
        json_data = request.get_json()
        # Check valid params
        validate(instance=json_data, schema=review_validator)
    except Exception as ex:
        logger.error('{} Parameters error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="Parameters invalid")

    keys = ["title", "rating", "content", "product_id", "published"]
    data = {}
    for key in keys:
        if key in json_data:
            data[key] = json_data.get(key)
            review.__setattr__(key, json_data.get(key))

    try:
        review.save_to_db()
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message=CURD_ERR_MSG.format('cập nhật', 'đánh giá'))

    return send_result(data=review.json(), message=CURD_SUCCESS_MSG.format('Cập nhật', 'đánh giá'))


@api.route('/<review_id>', methods=['DELETE'])
@jwt_required
def delete(review_id):
    """ This api for the user/vendor delete the review.

        Returns:

        Examples::

    """
    review = ProductReview.find_by_id(review_id)
    if review is None:
        return send_error(message=NOT_FOUND_MSG.format('đánh giá'))

    try:
        # Also delete all children foreign key
        if review.user_id == get_jwt_identity() or get_jwt_identity() == SUPER_ADMIN_ID:
            review.delete_from_db()
        else:
            return send_error(message="Bạn không có quyền xóa đánh giá này!")
    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message=CURD_ERR_MSG.format('xóa', 'đánh giá'))

    return send_result(message=CURD_SUCCESS_MSG.format('Xóa', 'đánh giá'))


@api.route('', methods=['GET'])
@jwt_required
@admin_required()
def get_all():
    """ This api gets all coupons.

        Returns:

        Examples::

    """
    product_id = request.args.get('product_id', None, type=str)
    from_date = request.args.get('from-date', None, type=int)
    to_date = request.args.get('to-date', get_datetime_now_s(), type=int)
    limit = request.args.get('limit', 20, type=int)
    page = request.args.get('page', None, type=int)

    results = ProductReview.search(product_id, from_date, to_date, limit, page)
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json() for result in results.items),
               page=results.page,
               pages=results.pages,
               total=results.total)
    return send_result(data=res)


@api.route('/<product_id>', methods=['GET'])
def get_all_by_user(product_id):
    """ This api gets all coupons.

        Returns:

        Examples::

    """
    from_date = request.args.get('from-date', None, type=int)
    to_date = request.args.get('to-date', get_datetime_now_s(), type=int)
    limit = request.args.get('limit', 20, type=int)
    page = request.args.get('page', None, type=int)

    list_rate = {'1': 0, '2': 0, '3': 0, '4': 0, '5': 0}

    results = ProductReview.search(product_id, from_date, to_date, limit, page)
    average_rating = sum(review.rating for review in results.items) / len(results.items)
    for key in list_rate.keys():
        for review in results.items:
            list_rate.update({key: (list_rate.get(key)+1 if review.rating == int(key) else list_rate.get(key))})
        if len(results.items) > 0:
            list_rate.update({key: list_rate.get(key) / len(results.items)})
    res = dict(has_next=results.has_next,
               has_prev=results.has_prev,
               items=list(result.json() for result in results.items if result.published),
               page=results.page,
               pages=results.pages,
               total=results.total,
               average_rating=average_rating,
               list_rate=list_rate)
    return send_result(data=res)
