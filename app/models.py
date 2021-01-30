# coding: utf-8

from flask_jwt_extended.utils import decode_token, get_raw_jwt
from sqlalchemy import desc, asc

from app.extensions import db
from app.utils import send_error, get_datetime_now_s


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    first_name = db.Column(db.String(80), default=None)
    last_name = db.Column(db.String(80), default=None)
    user_name = db.Column(db.String(80), nullable=False, unique=True, index=True)
    password = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(100), default=None)
    phone = db.Column(db.String(20), default=None)
    is_admin = db.Column(db.Boolean, default=False)

    def json(self):
        return dict(
            id=self.id,
            created_at=self.created_at,
            first_name=self.first_name,
            last_name=self.last_name,
            user_name=self.user_name,
            email=self.email,
            phone=self.phone
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_email(cls, email: str):
        return cls.query.filter_by(email=email).first()

    @classmethod
    def find_by_username(cls, username: str):
        return cls.query.filter_by(user_name=username).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class TokenBlacklist(db.Model):
    __tablename__ = 'tokens'

    jti = db.Column(db.String(36), primary_key=True)
    token_type = db.Column(db.String(10), nullable=False)
    user_identity = db.Column(db.String(50), nullable=False)
    revoked = db.Column(db.Boolean, nullable=False)
    expires = db.Column(db.Integer, nullable=False)

    @staticmethod
    def add_token_to_database(encoded_token, user_identity):
        """
        Adds a new token to the database. It is not revoked when it is added.
        :param user_identity:
        :param encoded_token:
        """
        decoded_token = decode_token(encoded_token)
        jti = decoded_token['jti']
        token_type = decoded_token['type']
        expires = decoded_token['exp']
        revoked = False

        db_token = TokenBlacklist(
            jti=jti,
            token_type=token_type,
            user_identity=user_identity,
            expires=expires,
            revoked=revoked,
        )
        db.session.add(db_token)
        db.session.commit()

    @staticmethod
    def is_token_revoked(decoded_token):
        """
        Checks if the given token is revoked or not. Because we are adding all the
        tokens that we create into this database, if the token is not present
        in the database we are going to consider it revoked, as we don't know where
        it was created.
        """
        jti = decoded_token['jti']
        try:
            token = TokenBlacklist.query.filter_by(jti=jti).one()
            return token.revoked
        except Exception:
            return True

    @staticmethod
    def revoke_token(jti):
        """
        Revokes the given token. Raises a TokenNotFound error if the token does
        not exist in the database
        """
        try:
            token = TokenBlacklist.query.filter_by(jti=jti).first()
            token.revoked = True
            db.session.commit()
        except Exception as ex:
            return send_error(message="Could not find the token")

    @staticmethod
    def revoke_all_token(users_identity):
        """
        Revokes the given token. Raises a TokenNotFound error if the token does
        not exist in the database.
        Set token Revoked flag is False to revoke this token.
        Args:
            users_identity: list or string, require
                list users id or user_id. Used to query all token of the user on the database
        """
        try:
            if type(users_identity) is not list:
                # convert user_id to list user_ids
                users_identity = [users_identity]

            tokens = TokenBlacklist.query.filter(TokenBlacklist.user_identity.in_(users_identity),
                                                 TokenBlacklist.revoked is False).all()

            for token in tokens:
                token.revoked = True
            db.session.commit()
        except Exception:
            return send_error(message="Could not find the user")

    @staticmethod
    def revoke_all_token2(users_identity):
        """
        Revokes all token of the given user except current token. Raises a TokenNotFound error if the token does
        not exist in the database.
        Set token Revoked flag is False to revoke this token.
        Args:
            users_identity: user id
        """
        jti = get_raw_jwt()['jti']
        try:
            tokens = TokenBlacklist.query.filter(TokenBlacklist.user_identity == users_identity,
                                                 TokenBlacklist.revoked is False, TokenBlacklist.jti != jti).all()
            for token in tokens:
                token.revoked = True
            db.session.commit()
        except Exception:
            return send_error(message="Could not find the user")

    @staticmethod
    def unrevoke_token(jti):
        """
        Unrevokes the given token. Raises a TokenNotFound error if the token does
        not exist in the database
        """
        try:
            token = TokenBlacklist.query.filter_by(jti=jti).one()
            token.revoked = False
            db.session.commit()
        except Exception:
            return send_error(message="Could not find the token")

    @staticmethod
    def prune_database():
        """
        Delete tokens that have expired from the database.
        How (and if) you call this is entirely up you. You could expose it to an
        endpoint that only administrators could call, you could run it as a cron,
        set it up with flask cli, etc.
        """
        now_in_seconds = get_datetime_now_s()
        expired = TokenBlacklist.query.filter(TokenBlacklist.expires < now_in_seconds).all()
        for token in expired:
            db.session.delete(token)
        db.session.commit()


class Category(db.Model):
    __tablename__ = 'categories'

    id = db.Column(db.String(40), primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    create_date = db.Column(db.Integer, default=get_datetime_now_s())
    modified_date = db.Column(db.Integer, default=get_datetime_now_s())

    products = db.relationship('Product', backref='Category', lazy=True, cascade='all, delete-orphan',
                               passive_deletes=True)

    def json(self):
        return dict(
            id=self.id,
            name=self.name,
            create_date=self.create_date
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Product(db.Model):
    __tablename__ = 'products'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    title = db.Column(db.String(80), nullable=False)
    price = db.Column(db.Float(precision=2), nullable=False)
    publish_year = db.Column(db.Integer, default=2021)
    page_number = db.Column(db.Integer, default=0)
    quantity = db.Column(db.Integer, nullable=False, default=1)
    quotes_about = db.Column(db.Text, default=None)
    discount = db.Column(db.Float(precision=2), nullable=False, default=0)
    start_at = db.Column(db.Integer, default=None)
    end_at = db.Column(db.Integer, default=None)

    author_id = db.Column(db.String(40), db.ForeignKey('authors.id', ondelete='CASCADE'), nullable=False)
    author = db.relationship('Author')
    publisher_id = db.Column(db.String(40), db.ForeignKey('publishers.id', ondelete='CASCADE'), nullable=False)
    publisher = db.relationship('Publisher')

    category_id = db.Column(db.String(40), db.ForeignKey('categories.id', ondelete='CASCADE'), nullable=False)
    category = db.relationship('Category')
    images = db.relationship('ProductImage', backref='Product', lazy=True, cascade='all, delete-orphan',
                             passive_deletes=True)

    def json(self):
        return dict(
            id=self.id,
            title=self.title,
            price=self.price,
            publish_year=self.publish_year,
            page_number=self.page_number,
            quantity=self.quantity,
            quotes_about=self.quotes_about,
            discount=self.discount,
            author=self.author,
            publisher=self.publisher,
            category=self.category,
            images=list(image.imageURL for image in self.images)
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def filter(cls, name: str, category_id: str, sort: str, min_price: float, max_price: float, limit: int, page: int):
        query = cls.query
        if name:
            query = query.filter(Product.name.contains(name))
        if category_id:
            query = query.filter(Product.category_id == category_id)
        if min_price:
            query = query.filter(Product.price >= min_price, Product.price <= max_price)
        if sort:
            if sort == 'price,desc':
                query = query.order_by(desc(Product.price))
            elif sort == 'price,asc':
                query = query.order_by(asc(Product.price))
            elif sort == 'newest':
                query = query.order_by(desc(Product.create_at))
        return query.paginate(page=page, per_page=limit, error_out=False)

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class ProductImage(db.Model):
    __tablename__ = 'product_images'

    id = db.Column(db.String(40), primary_key=True)
    imageURL = db.Column(db.String(80), nullable=False)
    filename = db.Column(db.String(80), nullable=False)

    product_id = db.Column(db.String(40), db.ForeignKey('products.id', ondelete='CASCADE'))

    def json(self):
        return dict(
            id=self.id,
            imageURL=self.imageURL,
            filename=self.filename,
            product_id=self.product_id
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_product_id(cls, product_id: str):
        return cls.query.filter_by(product_id=product_id).all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Order(db.Model):
    __tablename__ = 'orders'

    id = db.Column(db.String(40), primary_key=True)
    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    status = db.Column(db.SmallInteger, nullable=False, default=0)
    subtotal = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    item_discount = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    tax = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    shipping = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    total = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    promo = db.Column(db.String(40), default=None)
    discount = db.Column(db.Float(precision=2), default=0)
    grand_total = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    address_id = db.Column(db.String(40), db.ForeignKey('address.id', ondelete='CASCADE'), nullable=False)
    content = db.Column(db.Text, default=None)

    order_details = db.relationship('OrderDetail', backref='Order', lazy=True, cascade='all, delete-orphan',
                                    passive_deletes=True)

    def json(self):
        return dict(
            id=self.id,
            create_at=self.create_at,
            name=self.name,
            phone=self.phone,
            district=self.district,
            ward=self.ward,
            address=self.address,
            total=self.total,
            status=self.status,
            amount=self.amount,
            order_details=list(detail.json() for detail in self.order_details),
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def search(cls, from_date: int, to_date: int, limit: int, page: int):
        query = cls.query
        if from_date:
            query = query.filter(Order.create_at >= from_date, Order.create_at <= to_date)
        return query.paginate(page=page, per_page=limit, error_out=False)

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class OrderDetail(db.Model):
    __tablename__ = 'order_details'

    id = db.Column(db.String(40), primary_key=True)
    product_id = db.Column(db.String(40), db.ForeignKey('products.id', ondelete='CASCADE'))
    order_id = db.Column(db.String(40), db.ForeignKey('orders.id', ondelete='CASCADE'))
    price = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    quantity = db.Column(db.SmallInteger, nullable=False, default=0)
    discount = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    content = db.Column(db.Text, default=None)

    def json(self):
        return dict(
            id=self.id,
            amount=self.amount,
            product_id=self.product_id
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_order_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Address(db.Model):
    __tablename__ = 'address'

    id = db.Column(db.String(40), primary_key=True)
    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='SET NULL'))
    first_name = db.Column(db.String(50), default=None)
    last_name = db.Column(db.String(50), default=None)
    mobile = db.Column(db.String(15), default=None)
    email = db.Column(db.String(50), default=None)
    line1 = db.Column(db.String(50), nullable=False)
    line2 = db.Column(db.String(50), default=None)
    city = db.Column(db.String(50), nullable=False)
    province = db.Column(db.String(50), nullable=False)
    district = db.Column(db.String(50), default=None)

    @classmethod
    def find_by_id(cls, _id):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_userid(cls, _id):
        return cls.query.filter_by(user_id=_id).first()

    @classmethod
    def find_all(cls):
        return cls.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Author(db.Model):
    __tablename__ = 'authors'

    id = db.Column(db.String(40), primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    picture = db.Column(db.Text, default=None)
    info = db.Column(db.Text, default=None)

    def json(self):
        return {
            'id': self.id,
            'name': self.name,
            'picture': self.picture,
            'info': self.info
        }

    @staticmethod
    def find_by_id(_id):
        return Author.query.filter_by(id=_id).first()

    @staticmethod
    def find_by_name(name):
        return Author.query.filter_by(name=name).first()

    @staticmethod
    def find_all():
        return Author.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Publisher(db.Model):
    __tablename__ = 'publishers'

    id = db.Column(db.String(40), primary_key=True)
    name = db.Column(db.String(80), nullable=False)

    def json(self):
        return {
            'id': self.id,
            'name': self.name
        }

    @staticmethod
    def find_by_id(_id):
        return Publisher.query.filter_by(id=_id).first()

    @staticmethod
    def find_by_name(name):
        return Publisher.query.filter_by(name=name).first()

    @staticmethod
    def find_all():
        return Publisher.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Coupon(db.Model):
    __tablename__ = 'coupons'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    code = db.Column(db.String(10), unique=True, nullable=False)
    description = db.Column(db.Text, default=None)
    discount = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    max_value = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    count = db.Column(db.SmallInteger, nullable=False, default=0)
    valid_from = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    valid_until = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    is_enable = db.Column(db.Boolean, default=False)

    def json(self):
        return {
            'id': self.id,
            'code': self.code,
            'description': self.description,
            'discount': self.discount,
            'max_value': self.max_value,
            'count': self.count,
            'valid_from': self.valid_from,
            'valid_until': self.valid_until,
            'is_enable': self.is_enable
        }

    @staticmethod
    def find_by_code(code):
        return Coupon.query.filter_by(code=code).first()

    @staticmethod
    def find_by_id(_id):
        return Coupon.query.filter_by(id=_id).first()

    @staticmethod
    def find_all():
        return Coupon.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class ProductReview(db.Model):
    __tablename__ = 'reviews'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    user_name = db.Column(db.String(40))
    title = db.Column(db.String(80), nullable=False)
    rating = db.Column(db.SmallInteger, nullable=False, default=5)
    published = db.Column(db.Boolean, nullable=False, default=False)
    published_at = db.Column(db.Integer, default=None)
    content = db.Column(db.Text, default=None)

    product_id = db.Column(db.String(40), db.ForeignKey('products.id', ondelete='NO ACTION'))
    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='NO ACTION'))

    def json(self):
        return {
            'id': self.id,
            'title': self.title,
            'rating': self.rating,
            'content': self.content,
            'create_by': self.user_name
        }

    @staticmethod
    def find_by_id(_id):
        return Coupon.query.filter_by(id=_id).first()

    @staticmethod
    def find_all():
        return Coupon.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class Cart(db.Model):
    __tablename__ = 'carts'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    status = db.Column(db.SmallInteger, nullable=False, default=0)
    content = db.Column(db.Text, default=None)

    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='NO ACTION'))
    cart_items = db.relationship('CartItem', backref='Cart', lazy=True, cascade='all, delete-orphan',
                                 passive_deletes=True)

    def json(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'status': self.status
        }

    @classmethod
    def find_by_id(cls, _id):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_user_id(cls, user_id):
        return cls.query.filter_by(user_id=user_id).all()

    @classmethod
    def find_all(cls):
        return cls.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()


class CartItem(db.Model):
    __tablename__ = 'cart_items'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    price = db.Column(db.Float(precision=2), nullable=False, default=0)
    discount = db.Column(db.Float(precision=2), nullable=False, default=0)
    quantity = db.Column(db.SmallInteger, nullable=False, default=0)
    content = db.Column(db.Text, default=None)

    cart_id = db.Column(db.String(40), db.ForeignKey('carts.id', ondelete='NO ACTION'))

    def json(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'total': self.price * self.quantity
        }

    @classmethod
    def find_by_id(cls, _id):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_cart_id(cls, cart_id):
        return cls.query.filter_by(cart_id=cart_id).all()

    @classmethod
    def find_all(cls):
        return cls.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
