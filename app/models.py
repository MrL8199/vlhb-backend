# coding: utf-8

from flask_jwt_extended.utils import decode_token, get_raw_jwt
from sqlalchemy import desc, asc, func

from app.enums import DEFAULT_BOOK_COVER
from app.extensions import db
from app.utils import send_error, get_datetime_now_s


class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.String(40), primary_key=True)
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    avatar_url = db.Column(db.Text)
    nickname = db.Column(db.String(80), default=None)
    user_name = db.Column(db.String(80), nullable=False, unique=True, index=True)
    password = db.Column(db.String(255), nullable=False)
    email = db.Column(db.String(100), default=None)
    phone = db.Column(db.String(20), default=None)
    status = db.Column(db.Boolean, default=True)
    is_admin = db.Column(db.Boolean, default=False)

    def json(self):
        return dict(
            id=self.id,
            created_at=self.created_at,
            avatar_url=self.avatar_url,
            updated_at=self.updated_at,
            nickname=self.nickname,
            user_name=self.user_name,
            email=self.email,
            phone=self.phone,
            is_admin=self.is_admin,
            status=self.status
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
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())

    products = db.relationship('Product', backref='Category', lazy=True, cascade='all, delete-orphan',
                               passive_deletes=True)

    def json(self):
        return dict(
            id=self.id,
            name=self.name,
            created_at=self.created_at
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
    updated_at = db.Column(db.Integer, default=get_datetime_now_s())
    title = db.Column(db.String(80), nullable=False)
    price = db.Column(db.Float(precision=2), nullable=False)
    publish_year = db.Column(db.Integer, default=2021)
    page_number = db.Column(db.Integer, default=0)
    quantity = db.Column(db.Integer, nullable=False, default=1)
    quotes_about = db.Column(db.Text, default=None)
    discount = db.Column(db.Float(precision=2), nullable=False, default=0)  # số tiền giảm bớt của sp
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
            author=dict(
                name=self.author.name,
                id=self.author.id),
            publisher=self.publisher.json(),
            category=self.category.json(),
            images=list(image.imageURL for image in self.images),
            created_at=self.created_at,
            updated_at=self.updated_at
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_random(cls):
        return cls.query.order_by(func.rand()).first()

    @classmethod
    def filter(cls, name: str, category_id: str, sort: str, min_price: float, max_price: float, limit: int, page: int,
               from_date: int, to_date: int):
        query = cls.query
        if name:
            query = query.filter(Product.title.contains(name))
        if category_id:
            query = query.filter(Product.category_id == category_id)
        if from_date:
            query = query.filter(Product.updated_at >= from_date, Product.updated_at <= to_date)
        if min_price:
            query = query.filter(Product.price >= min_price, Product.price <= max_price)
        if sort:
            if sort == 'price,desc':
                query = query.order_by(desc(Product.price))
            elif sort == 'price,asc':
                query = query.order_by(asc(Product.price))
            elif sort == 'newest':
                query = query.order_by(desc(Product.created_at))
            elif sort == 'oldest':
                query = query.order_by(asc(Product.created_at))
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
    imageURL = db.Column(db.Text, nullable=False)
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
    content = db.Column(db.Text, default=None)

    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
    address_id = db.Column(db.String(40), db.ForeignKey('address.id', ondelete='CASCADE'), nullable=False)
    address = db.relationship('Address')
    items = db.relationship('OrderDetail', backref='Order', lazy=True, cascade='all, delete-orphan',
                            passive_deletes=True)

    def json(self):
        return dict(
            id=self.id,
            created_at=self.created_at,
            status=self.status,
            subtotal=self.subtotal,
            item_discount=self.item_discount,
            tax=self.tax,
            shipping=self.shipping,
            total=self.total,
            promo=self.promo,
            discount=self.discount,
            grand_total=self.grand_total,
            content=self.content,
            user_id=self.user_id,
            address=self.address.json(),
            items=list(detail.json() for detail in self.items),
        )

    def json_many(self):
        return dict(
            id=self.id,
            created_at=self.created_at,
            status=self.status,
            grand_total=self.grand_total,
            user_id=self.user_id,
            address=self.address.json(),
            items=list(
                dict(
                    price=detail.price,
                    quantity=detail.quantity,
                    discount=detail.discount,
                    product_name=detail.product.title
                ) for detail in self.items)
        )

    @classmethod
    def find_all(cls):
        return cls.query.all()

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_user_id(cls, user_id: str, page: int, limit: int):
        return cls.query.filter_by(user_id=user_id).paginate(page=page, per_page=limit, error_out=False)

    @classmethod
    def search(cls, from_date: int, to_date: int, limit: int, page: int):
        query = cls.query
        if from_date:
            query = query.filter(Order.created_at >= from_date, Order.created_at <= to_date)
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
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    updated_at = db.Column(db.Integer, default=None)
    product_id = db.Column(db.String(40), db.ForeignKey('products.id', ondelete='CASCADE'))
    order_id = db.Column(db.String(40), db.ForeignKey('orders.id', ondelete='CASCADE'))
    price = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    quantity = db.Column(db.SmallInteger, nullable=False, default=0)
    discount = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    content = db.Column(db.Text, default=None)

    product = db.relationship('Product')

    def json(self):
        return dict(
            id=self.id,
            created_at=self.created_at,
            price=self.price,
            quantity=self.quantity,
            discount=self.discount,
            product=self.product.json()
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
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='SET NULL'))
    default = db.Column(db.Boolean, nullable=False, default=False)
    name = db.Column(db.String(50), default=None)
    phone = db.Column(db.String(15), default=None)
    email = db.Column(db.String(50), default=None)
    address = db.Column(db.String(50), default=None)
    city = db.Column(db.String(50), nullable=False)
    state = db.Column(db.String(50), nullable=False)
    district = db.Column(db.String(50), nullable=False)

    def json(self):
        return dict(
            id=self.id,
            user_id=self.user_id,
            created_at=self.created_at,
            name=self.name,
            default=self.default,
            phone=self.phone,
            email=self.email,
            address=self.address,
            city=self.city,
            state=self.state,
            district=self.district
        )

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_userid(cls, _id: str):
        return cls.query.filter_by(user_id=_id).all()

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
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())

    def json(self):
        return {
            'id': self.id,
            'name': self.name,
            'picture': self.picture,
            'info': self.info,
            'created_at': self.created_at
        }

    @staticmethod
    def find_by_id(_id: str):
        return Author.query.filter_by(id=_id).first()

    @staticmethod
    def find_by_name(name: str):
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
    created_at = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())

    def json(self):
        return {
            'id': self.id,
            'name': self.name,
            'created_at': self.created_at
        }

    @staticmethod
    def find_by_id(_id: str):
        return Publisher.query.filter_by(id=_id).first()

    @staticmethod
    def find_by_name(name: str):
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
    code = db.Column(db.String(20), unique=True, nullable=False)
    description = db.Column(db.Text, default=None)
    value = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    max_value = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    amount = db.Column(db.SmallInteger, nullable=False, default=0)
    start_date = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    end_date = db.Column(db.Integer, nullable=False, default=get_datetime_now_s())
    is_enable = db.Column(db.Boolean, default=False)

    def json(self):
        return {
            'id': self.id,
            'code': self.code,
            'description': self.description,
            'value': self.value,
            'max_value': self.max_value,
            'amount': self.amount,
            'start_date': self.start_date,
            'end_date': self.end_date,
            'is_enable': self.is_enable,
            'created_at': self.created_at,
            'updated_at': self.updated_at
        }

    @staticmethod
    def find_by_code(code: str):
        return Coupon.query.filter_by(code=code).first()

    @staticmethod
    def find_by_id(_id: str):
        return Coupon.query.filter_by(id=_id).first()

    @staticmethod
    def find_all():
        return Coupon.query.all()

    @staticmethod
    def prune_database():
        """
        Update coupon that have expired from the database.
        How (and if) you call this is entirely up you. You could expose it to an
        endpoint that only administrators could call, you could run it as a cron,
        set it up with flask cli, etc.
        """
        now_in_seconds = get_datetime_now_s()
        expired = Coupon.query.filter(Coupon.end_date < now_in_seconds, Coupon.start_date > now_in_seconds,
                                      Coupon.is_enable is True, Coupon.amount < 1).all()
        for coupon in expired:
            coupon.is_enable = False
            db.session.add(coupon)

        activate = Coupon.query.filter(Coupon.end_date > now_in_seconds, Coupon.start_date < now_in_seconds,
                                       Coupon.is_enable is False, Coupon.amount > 0).all()
        for coupon in activate:
            coupon.is_enable = True
            db.session.add(coupon)
        db.session.commit()

    @classmethod
    def search(cls, from_date: int, to_date: int, limit: int, page: int):
        query = cls.query
        if from_date:
            query = query.filter(Coupon.created_at >= from_date, Coupon.created_at <= to_date)
        return query.paginate(page=page, per_page=limit, error_out=False)

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
        return dict(
            id=self.id,
            created_at=self.created_at,
            title=self.title,
            rating=self.rating,
            content=self.content,
            created_by=self.user_name
        )

    @staticmethod
    def find_by_id(_id: str):
        return ProductReview.query.filter_by(id=_id).first()

    @staticmethod
    def find_all():
        return ProductReview.query.all()

    @classmethod
    def search(cls, product_id: str, from_date: int, to_date: int, limit: int, page: int):
        query = cls.query
        if product_id:
            query = query.filter(ProductReview.product_id == product_id)
        if from_date:
            query = query.filter(ProductReview.created_at >= from_date, ProductReview.created_at <= to_date)
        return query.paginate(page=page, per_page=limit, error_out=False)

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
    subtotal = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    item_discount = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    tax = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    shipping = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    total = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    promo = db.Column(db.String(40), default=None)
    discount = db.Column(db.Float(precision=2), default=0)
    grand_total = db.Column(db.Float(precision=2), nullable=False, default=0.0)
    content = db.Column(db.Text, default=None)

    user_id = db.Column(db.String(40), db.ForeignKey('users.id', ondelete='NO ACTION'))
    cart_items = db.relationship('CartItem', backref='Cart', lazy=True, cascade='all, delete-orphan',
                                 passive_deletes=True)

    def json(self):
        return dict(
            id=self.id,
            created_at=self.created_at,
            subtotal=self.subtotal,
            item_discount=self.item_discount,
            tax=self.tax,
            shipping=self.shipping,
            total=self.total,
            promo=self.promo,
            discount=self.discount,
            grand_total=self.grand_total,
            items=list(detail.json() for detail in self.cart_items),
        )

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_user_id(cls, user_id: str):
        return cls.query.filter_by(user_id=user_id).first()

    @classmethod
    def find_all(cls):
        return cls.query.all()

    def calculator_cart(self):
        if len(self.cart_items) == 0:
            self.promo = str(None)
            self.discount = 0
        promo = self.promo
        subtotal = 0
        item_discount = 0
        for cart_item in self.cart_items:
            # Tổng cộng giá của các sản phẩm trong giỏ (không tính giảm giá của sản phẩm)
            subtotal += cart_item.quantity * cart_item.price
            # Tổng cộng giảm giá của các sản phẩm trong giỏ
            item_discount += cart_item.discount * cart_item.quantity
        # TODO: chỉnh sửa lại chi phí thuế và vận chuyển sau khi đã hoàn thiện
        # Thuế trước mắt cho bằng 0đ
        tax = 0
        # Phí vận chuyển, trước mắt cho bằng 20k
        shipping = 0 if len(self.cart_items) == 0 else 20000
        # Tổng cộng giá sau khi tính thuế, phí vận chuyển và giảm giá
        total = subtotal + tax + shipping - item_discount
        discount = 0
        if promo:
            coupon = Coupon.find_by_code(promo)
            if coupon:
                discount = coupon.max_value if coupon.max_value < coupon.value * item_discount else coupon.value * item_discount

        # Tổng số tiền người mua phải thanh toán
        grand_total = total - discount

        cart_data = {'subtotal': subtotal,
                     'item_discount': item_discount,
                     'tax': tax,
                     'shipping': shipping,
                     'total': total,
                     'promo': promo,
                     'discount': discount,
                     'grand_total': grand_total}

        for key in cart_data.keys():
            self.__setattr__(key, cart_data[key])

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

    product_id = db.Column(db.String(40), db.ForeignKey('products.id', ondelete='SET NULL'))
    product = db.relationship('Product')
    cart_id = db.Column(db.String(40), db.ForeignKey('carts.id', ondelete='NO ACTION'))

    def json(self):
        return dict(
            id=self.id,
            quantity=self.quantity,
            product_id=self.product.id,
            product_title=self.product.title,
            product_price=self.product.price,
            product_discount=self.product.discount,
            thumbnail_url=self.product.images[0].imageURL if len(self.product.images) > 0 else DEFAULT_BOOK_COVER
        )

    @classmethod
    def find_by_id(cls, _id: str):
        return cls.query.filter_by(id=_id).first()

    @classmethod
    def find_by_product_id(cls, cart_id: str, product_id: str):
        """
        This method to find cart item by product_id of current user via cart_id
        :param cart_id: cart_id of current user
        :param product_id: product id
        :return: cart_item found
        """
        return cls.query.filter(CartItem.product_id == product_id, CartItem.cart_id == cart_id).first()

    @classmethod
    def find_all(cls):
        return cls.query.all()

    def save_to_db(self):
        db.session.add(self)
        db.session.commit()

    def delete_from_db(self):
        db.session.delete(self)
        db.session.commit()
