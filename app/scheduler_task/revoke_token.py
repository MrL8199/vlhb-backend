from app.models import TokenBlacklist
from app.extensions import db


def remove_token_expiry():
    """
    Remove all token has expired
    """
    with db.app.app_context():
        # logger.debug('{} start check token expired'.format(get_datetime_now().strftime('%Y-%b-%d %H:%M:%S')))
        TokenBlacklist.prune_database()
