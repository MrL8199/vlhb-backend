import logging
from logging.handlers import RotatingFileHandler

from flask_jwt_extended import JWTManager
from flask_sqlalchemy import SQLAlchemy
from webargs.flaskparser import FlaskParser

parser = FlaskParser()
db = SQLAlchemy()
jwt = JWTManager()

app_log_handler = RotatingFileHandler(
    'logs/app.log', maxBytes=1000000, backupCount=30, encoding='utf-8')
# logger
logger = logging.getLogger('api')
logger.setLevel(logging.DEBUG)
# logger.addHandler(app_log_handler)
