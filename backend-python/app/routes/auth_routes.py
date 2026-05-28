from flask import Blueprint, request, jsonify
from app.config.db import db
from sqlalchemy import text

auth_bp = Blueprint(
    "auth",
    __name__
)


# Signup
@auth_bp.route(
    "/signup",
    methods=["POST"]
)
def signup():

    data = request.json

    email = data["email"]
    password = data["password"]
    role = data["role"]

    db.session.execute(
        text("""
            INSERT INTO users
            (
                email,
                password,
                role
            )
            VALUES
            (
                :email,
                :password,
                :role
            )
        """),
        {
            "email": email,
            "password": password,
            "role": role
        }
    )

    db.session.commit()

    return jsonify({
        "message":
            "Signup successful"
    })


# Login
@auth_bp.route(
    "/login",
    methods=["POST"]
)
def login():

    data = request.json

    email = data["email"]
    password = data["password"]

    result = db.session.execute(
        text("""
            SELECT *
            FROM users
            WHERE email=:email
            AND password=:password
        """),
        {
            "email": email,
            "password": password
        }
    ).fetchone()

    if not result:
        return jsonify({
            "error":
                "Invalid credentials"
        }), 401

    return jsonify({
        "message":
            "Login successful",

        "role":
            result.role
    })