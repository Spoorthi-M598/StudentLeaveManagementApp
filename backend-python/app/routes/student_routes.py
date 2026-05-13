from flask import Blueprint, request, jsonify
from app.config.db import db
from app.models.student import Student

student_bp = Blueprint("student_bp", __name__)


@student_bp.route("/register", methods=["POST"])
def register_student():
    data = request.json

    new_student = Student(
        name=data["name"],
        email=data["email"],
        password=data["password"],
        branch=data["branch"],
        semester=data["semester"],
        mentor_email=data["mentor_email"]
    )

    db.session.add(new_student)
    db.session.commit()

    return jsonify({
        "message": "Student registered successfully"
    }), 201


@student_bp.route("/login", methods=["POST"])
def login_student():
    data = request.json

    student = Student.query.filter_by(
        email=data["email"],
        password=data["password"]
    ).first()

    if not student:
        return jsonify({
            "message": "Invalid email or password"
        }), 401

    return jsonify({
        "message": "Login successful",
        "student_id": student.id,
        "name": student.name
    }), 200