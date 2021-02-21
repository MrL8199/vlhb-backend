from app.models import Coupon
from app.extensions import db


def update_coupon_status():
    """
    Update status is_enable all coupon has expired and activate
    """
    with db.app.app_context():
        # logger.debug('{} start check token expired'.format(get_datetime_now().strftime('%Y-%b-%d %H:%M:%S')))
        Coupon.prune_database()
