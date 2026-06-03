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
    # Support login by USN (used by the Flutter frontend).
    usn = data.get("usn")

    if usn:
        student = Student.query.filter_by(usn=usn).first()

        if not student:
            return jsonify({
                "success": False,
                "message": "Invalid USN"
            }), 401

        return jsonify({
            "success": True,
            "student_name": student.student_name,
            "current_sem": student.current_sem
        }), 200

    return jsonify({
        "success": False,
        "message": "USN is required"
    }), 400