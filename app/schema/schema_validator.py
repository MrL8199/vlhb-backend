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
        "name": {
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
        "description": {
            "type": "string",
            "minLength": 1,
            "maxLength": 1024
        },
        "category_id": {
            "type": "string",
            "minLength": 1,
            "maxLength": 80
        },
        "size": {
            "type": "string",
            "minLength": 1,
            "maxLength": 80
        }
    },
    "required": ["name", "price", "subcategory_id"]
}

checkout_validator = {
    "type": "object",
    "properties": {
        "name": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "phone": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "district": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "ward": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "address": {
            "type": "string",
            "minLength": 3,
            "maxLength": 80
        },
        "cart": {
            "type": "array",
            "items": {"$ref": "#/definitions/cart_item"}
        }
    },
    "definitions": {
        "cart_item": {
            "type": "object",
            "required": ["product_id", "amount"],
            "properties": {
                "product_id": {
                    "type": "string",
                    "minLength": 3,
                    "maxLength": 80
                },
                "amount": {
                    "type": "number"
                }
            }
        }
    },
    "required": ["name", "phone", "address", "cart"]
}

order_validator = {
    "type": "object",
    "properties": {
        "status": {
            "type": "string",
            "minLength": 1,
            "maxLength": 80
        }
    },
    "required": ["status"]
}

recipe_validator = {
    "type": "object",
    "properties": {
        "title": {
            "type": "string",
            "minLength": 1,
            "maxLength": 80
        },
        "ingredient": {
            "type": "string",
            "minLength": 1,
            "maxLength": 1000
        },
        "direction": {
            "type": "string",
            "minLength": 1,
            "maxLength": 1000
        },
        "subcategory_id": {
            "type": "string",
            "minLength": 1,
            "maxLength": 80
        },
        "images": {
            "type": "array",
            "items": {
                "type": "string"
            }
        }
    },
    "required": ["title", "direction", "subcategory_id"]
}
