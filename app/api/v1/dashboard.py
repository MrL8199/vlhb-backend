from datetime import datetime
from io import BytesIO

from flask import Blueprint, request, send_file
from flask_jwt_extended import jwt_required

from app.decorators import admin_required
from app.extensions import logger, db
from app.models import Product
from app.utils import send_result, send_error
import pandas as pd

api = Blueprint('dashboard', __name__)


@api.route('', methods=['GET'])
@jwt_required
@admin_required()
def get_chart_data():
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


@api.route('/revenue', methods=['GET'])
@jwt_required
@admin_required()
def get_revenue():
    """ This api gets revenue data.

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


@api.route('/profit', methods=['GET'])
@jwt_required
@admin_required()
def get_profit():
    """ This api gets profit data.

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


@api.route('/best-seller', methods=['GET'])
@jwt_required
@admin_required()
def get_best_seller_products():
    try:
        # calculate best seller product from order table
        results = db.session.execute('SELECT product_id, SUM(quantity) AS TotalQuantity FROM order_details GROUP BY '
                                     'product_id ORDER BY SUM(quantity) DESC LIMIT :val', {'val': 10})

        items = []
        for row in results:
            product_id = row['product_id']
            sale_quantity = row['TotalQuantity']
            items.append(dict(product=Product.find_by_id(product_id).mini_json(), sale_quantity=int(sale_quantity)))
        while items.__len__() < 10:
            items.append(dict(product=Product.find_random().mini_json(), sale_quantity=0))

    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while fetch data")

    return send_result(data=items)


@api.route('/best-revenue', methods=['GET'])
@jwt_required
@admin_required()
def get_best_revenue_products():
    try:
        # calculate best seller product from order table
        results = db.session.execute(
            'SELECT product_id, SUM(quantity)*SUM(price-discount) AS TotalRevenue FROM order_details GROUP BY '
            'product_id ORDER BY SUM(quantity)*SUM(price-discount) DESC LIMIT :val', {'val': 10})

        items = []
        for row in results:
            product_id = row['product_id']
            revenue = row['TotalRevenue']
            items.append(dict(product=Product.find_by_id(product_id).mini_json(), revenue=float(revenue)))
        while items.__len__() < 10:
            items.append(dict(product=Product.find_random().mini_json(), revenue=0))

    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while fetch data")

    return send_result(data=items)


@api.route('/best-revenue/excel', methods=['GET'])
def get_best_revenue_products_excel():
    try:
        # calculate best seller product from order table
        results = db.session.execute(
            'SELECT product_id, SUM(quantity)*SUM(price-discount) AS TotalRevenue FROM order_details GROUP BY '
            'product_id ORDER BY SUM(quantity)*SUM(price-discount) DESC LIMIT :val', {'val': 10})

        items = []
        for row in results:
            product_id = row['product_id']
            revenue = row['TotalRevenue']
            product = Product.find_by_id(product_id)
            items.append(dict(title=product.title,
                              price=product.price,
                              publish_year=product.publish_year,
                              page_number=product.page_number,
                              quantity=product.quantity,
                              quotes_about=product.quotes_about,
                              discount=product.discount,
                              created_at=product.created_at,
                              updated_at=product.updated_at,
                              revenue=float(revenue)))
            while items.__len__() < 10:
                product = Product.find_random()
                items.append(dict(title=product.title,
                                  price=product.price,
                                  publish_year=product.publish_year,
                                  page_number=product.page_number,
                                  quantity=product.quantity,
                                  quotes_about=product.quotes_about,
                                  discount=product.discount,
                                  created_at=product.created_at,
                                  updated_at=product.updated_at,
                                  revenue=0))

    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while fetch data")

    df = pd.DataFrame(items)

    # create an output stream
    output = BytesIO()
    writer = pd.ExcelWriter(output, engine='xlsxwriter')
    df.to_excel(writer, sheet_name='report', index=False)

    writer.save()
    output.seek(0)

    return send_file(output, attachment_filename="Report.xlsx", as_attachment=True)


@api.route('/import-statistics', methods=['GET'])
@jwt_required
@admin_required()
def get_import_statistics():
    from_date = request.args.get('from-date', 0, type=int)
    to_date = request.args.get('to-date', 9999999999, type=int)
    try:
        # calculate best seller product from order table
        results = db.session.execute(
            'SELECT product_id, products.title, AVG( product_cost.cost ) AS GiaNhapTB1SP, SUM( product_cost.quantity '
            ') AS SoLuongNhap, SUM( product_cost.total ) AS TongCong FROM product_cost INNER JOIN products ON '
            'products.id = product_cost.product_id WHERE product_cost.created_at BETWEEN :from_date AND :to_date '
            'GROUP BY product_cost.product_id ORDER BY SUM( product_cost.total ) DESC ',
            {'from_date': from_date, 'to_date': to_date})

        items = []
        for row in results:
            product_id = row['product_id']
            title = row['title']
            cost = row['GiaNhapTB1SP']
            quantity = row['SoLuongNhap']
            total = row['TongCong']
            items.append(dict(product=Product.find_by_id(product_id).mini_json(), title=title,
                              cost=float("{:.2f}".format(cost)),
                              quantity=int(quantity),
                              total=float("{:.2f}".format(total)), ))

    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while fetch data")

    return send_result(data=items)


@api.route('/import-statistics/excel', methods=['GET'])
def get_import_statistics_excel():
    from_date = request.args.get('from-date', 0, type=int)
    to_date = request.args.get('to-date', 9999999999, type=int)
    try:
        # calculate best seller product from order table
        results = db.session.execute(
            'SELECT product_id, products.title, AVG( product_cost.cost ) AS GiaNhapTB1SP, SUM( product_cost.quantity '
            ') AS SoLuongNhap, SUM( product_cost.total ) AS TongCong FROM product_cost INNER JOIN products ON '
            'products.id = product_cost.product_id WHERE product_cost.created_at BETWEEN :from_date AND :to_date '
            'GROUP BY product_cost.product_id ORDER BY SUM( product_cost.total ) DESC ',
            {'from_date': from_date, 'to_date': to_date})

        items = []
        for row in results:
            product_id = row['product_id']
            title = row['title']
            cost = row['GiaNhapTB1SP']
            quantity = row['SoLuongNhap']
            total = row['TongCong']
            product = Product.find_by_id(product_id)
            items.append(dict(id=product.id,
                              TenSanPham=product.title,
                              GiaBan=product.price,
                              GiaNhap=float("{:.2f}".format(cost)),
                              SoLuongNhap=int(quantity),
                              TongTienMua=float("{:.2f}".format(total)), ))

    except Exception as ex:
        logger.error('{} Database error: '.format(datetime.now().strftime('%Y-%b-%d %H:%M:%S')) + str(ex))
        return send_error(message="An error occurred while fetch data")

    df = pd.DataFrame(items)

    # create an output stream
    output = BytesIO()
    writer = pd.ExcelWriter(output, engine='xlsxwriter')
    df.to_excel(writer, sheet_name='report', index=False)

    writer.save()
    output.seek(0)

    return send_file(output, attachment_filename="Bao-cao-Nhap-Hang.xlsx", as_attachment=True)
