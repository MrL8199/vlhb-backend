user_validator = {
    "type": "object",
    "properties": {
        "user_name": {
            "type": "string",
            "minLength": 3,
            "maxLength": 50
        },
        "password": {
            "type": "string",
            "minLength": 3,
            "maxLength": 50
        },
        "nickname": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "phone": {
            "type": "string",
            "minLength": 1,
            "maxLength": 20
        },
        "email": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "is_admin": {
            "type": "number",
            "minimum": 0,
            "maximum": 1,
        }
    },
    "required": ["user_name", "password", "phone", "email"]
}

user_update_validator = {
    "type": "object",
    "properties": {
        "nickname": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "phone": {
            "type": "string",
            "minLength": 1,
            "maxLength": 20
        },
        "email": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "is_admin": {
            "type": "number",
            "minimum": 0,
            "maximum": 1,
        }
    }
}

password_validator = {
    "type": "object",
    "properties": {
        "current_password": {
            "type": "string",
            "minLength": 3,
            "maxLength": 50
        },
        "new_password": {
            "type": "string",
            "minLength": 3,
            "maxLength": 50
        }
    },
    "required": ["new_password"]
}

category_validator = {
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        }
    },
    "required": ["name"]
}

publisher_validator = {
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        }
    },
    "required": ["name"]
}

author_validator = {
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "info": {
            "type": "string",
            "minLength": 3,
            "maxLength": 1024
        },
        "picture": {
            "type": "string",
            "minLength": 3,
            "maxLength": 1024
        }
    },
    "required": ["name"]
}

address_validator = {
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "default": {
            "type": "boolean"
        },
        "phone": {
            "type": "number",
            "minLength": 1,
            "maxLength": 15
        },
        "email": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "address": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "city": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "state": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        },
        "district": {
            "type": "string",
            "minLength": 1,
            "maxLength": 50
        }
    },
    "required": ["name", "phone", "address", "city", "state"]
}

product_validator = {
    "type": "object",
    "properties": {
        "title": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "price": {
            "type": "number",
            "minLength": 3,
            "maxLength": 20
        },
        "images": {
            "type": "array",
            "items": {
                "type": "string"
            }
        },
        "publish_year": {
            "type": "number",
            "minLength": 1,
            "maxLength": 5
        },
        "page_number": {
            "type": "number",
            "minLength": 1,
            "maxLength": 5
        },
        "quantity": {
            "type": "number",
            "minLength": 1,
            "maxLength": 9
        },
        "quotes_about": {
            "type": "string",
            "minLength": 1,
            "maxLength": 1024
        },
        "discount": {
            "type": "number",
            "minLength": 3,
            "maxLength": 20
        },
        "start_at": {
            "type": "number",
            "minLength": 1,
            "maxLength": 20
        },
        "end_at": {
            "type": "number",
            "minLength": 1,
            "maxLength": 20
        },
        "author_id": {
            "type": "string",
            "minLength": 1,
            "maxLength": 40
        },
        "publisher_id": {
            "type": "string",
            "minLength": 1,
            "maxLength": 40
        },
        "category_id": {
            "type": "string",
            "minLength": 1,
            "maxLength": 40
        },
        "cost_price": {
            "type": "number",
            "minLength": 3,
            "maxLength": 20
        }
    },
    "required": ["title", "price", "quantity", "author_id", "publisher_id", "category_id"]
}

checkout_validator = {
    "type": "object",
    "properties": {
        "address_id": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "content": {
            "type": "string",
            "minLength": 0,
            "maxLength": 1024
        },
        "promo": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        }
    },
    "required": ["address_id"]
}

order_validator = {
    "type": "object",
    "properties": {
        "status": {
            "type": "number",
            "minimum": 0,
            "maximum": 5
        }
    },
    "required": ["status"]
}

cart_validator = {
    "type": "object",
    "required": ["product_id", "quantity"],
    "properties": {
        "product_id": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "quantity": {
            "type": "number",
            "minimum": 1,
            "minLength": 1,
            "maxLength": 9
        },
        "content": {
            "type": "string",
            "minLength": 3,
            "maxLength": 1024
        }
    }
}

coupon_validator = {
    "type": "object",
    "properties": {
        "code": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "value": {
            "type": "number",
            "minimum": 0,
            "maximum": 101
        },
        "max_value": {
            "type": "number",
            "minimum": 0,
            "maxLength": 10
        },
        "start_date": {
            "type": "number",
            "minLength": 3,
            "maxLength": 80
        },
        "end_date": {
            "type": "number",
            "minLength": 3,
            "maxLength": 80
        },
        "amount": {
            "type": "number",
            "minimum": 0
        },
        "is_enable": {
            "type": "boolean"
        }
    },
    "required": ["code", "value", "max_value", "start_date", "end_date", "amount"]
}

review_validator = {
    "type": "object",
    "properties": {
        "title": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "rating": {
            "type": "number",
            "minimum": 1,
            "maximum": 5
        },
        "content": {
            "type": "string",
            "minimum": 0,
            "maxLength": 1024
        },
        "product_id": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "published": {
            "type": "boolean"
        }
    },
    "required": ["title", "rating", "content", "product_id"]
}
