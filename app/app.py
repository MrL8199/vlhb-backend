# -*- coding: utf-8 -*-
import traceback
from time import strftime
from flask import Flask, request
from flask_cors import CORS

from app.api import v1 as api_v1
from app.extensions import jwt, db, logger
from app.utils import send_error
from app.settings import ProdConfig


def create_app(config_object=ProdConfig, content='app'):
    """
    Init App
    :param config_object:
    :param content:
    :return:
    """

    app = Flask(__name__, static_url_path="", static_folder="./static", template_folder="./template")

    register_extensions(app, content, config_object)
    register_blueprints(app)
    CORS(app)
    return app


def register_extensions(app, content, config_object):
    """
    Init extension
    :param app:
    :param content:
    :param config_object
    :return:
    """
    app.config.from_object(config_object)
    db.app = app
    db.init_app(app)
    # don't start extensions if content != app
    if content == 'app':
        jwt.init_app(app)

    @app.after_request
    def after_request(response):
        # This IF avoids the duplication of registry in the logs,
        # since that 500 is already logged via @app.errorhandler.
        if response.status_code != 500:
            ts = strftime('[%Y-%b-%d %H:%M]')
            logger.error('%s %s %s %s %s %s',
                         ts,
                         request.remote_addr,
                         request.method,
                         request.scheme,
                         request.full_path,
                         response.status)
        return response

    @app.errorhandler(Exception)
    def exceptions(e):
        message = "INTERNAL SERVER ERROR"
        code = 500
        if hasattr(e, 'description'):
            message = e.description
        if hasattr(e, 'code'):
            code = e.code
        ts = strftime('[%Y-%b-%d %H:%M]')
        tb = traceback.format_exc()
        error = '{} {} {} {} {} {} {} {}\n{}'.format(
            ts, request.remote_addr, request.method,
            request.scheme, request.full_path, tb,
            code, message, str(e)
        )
        logger.error(error)
        return send_error(message=message, code=code)


def register_blueprints(app):
    """
    Init blueprint for api url
    :param app:
    :return:
    """
    app.register_blueprint(api_v1.auth.api, url_prefix='/api/v1/auth')
    app.register_blueprint(api_v1.user.api, url_prefix='/api/v1/user')
    app.register_blueprint(api_v1.products.api, url_prefix='/api/v1/products')
    app.register_blueprint(api_v1.category.api, url_prefix='/api/v1/category')
    app.register_blueprint(api_v1.author.api, url_prefix='/api/v1/authors')
    app.register_blueprint(api_v1.publisher.api, url_prefix='/api/v1/publishers')
    app.register_blueprint(api_v1.address.api, url_prefix='/api/v1/addresses')
    app.register_blueprint(api_v1.upload.api, url_prefix='/api/v1/upload')
    app.register_blueprint(api_v1.checkout.api, url_prefix='/api/v1/checkout')
    app.register_blueprint(api_v1.orders.api, url_prefix='/api/v1/orders')
