from flask import Blueprint, request, jsonify
from app.models.student import Student

auth_bp = Blueprint('auth_bp', __name__)

@auth_bp.route('/login', methods=['POST'])

def login():

    data = request.get_json()

    usn = data.get("usn")

    student = Student.query.filter_by(
        usn=usn
    ).first()

    if student:

        return jsonify({

            "success": True,

            "student_name":
                student.student_name,

            "current_sem":
                student.current_sem

        })

    else:

        return jsonify({

            "success": False,

            "message":
                "Invalid USN"

        }), 401