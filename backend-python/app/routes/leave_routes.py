from flask import Blueprint, request, jsonify

from app.models.leave import Leave
from app.models.student import Student
from app.services.email_service import send_leave_email
from app.services.leave_service import calculate_missed_classes
from app.config.db import db


leave_bp = Blueprint("leave", __name__)


@leave_bp.route("/apply", methods=["POST"])
def apply_leave():

    data = request.json

    student_id = data["student_id"]
    from_date = data["from_date"]
    to_date = data["to_date"]
    reason = data["reason"]

    missed_classes = calculate_missed_classes(
        student_id,
        from_date,
        to_date
    )

    leave = Leave(
        student_id=student_id,
        from_date=from_date,
        to_date=to_date,
        reason=reason,
        leave_type=data["leave_type"]
    )

    db.session.add(leave)
    db.session.commit()

    student = Student.query.get(student_id)

    if student:
        send_leave_email(
            student.mentor_email,
            student.name,
            missed_classes
        )

    return jsonify({
        "message": "Leave applied successfully",
        "missed_classes": missed_classes
    })


@leave_bp.route("/preview", methods=["POST"])
def preview_leave():

    data = request.json

    student_id = data["student_id"]
    from_date = data["from_date"]
    to_date = data["to_date"]
    leave_type = data["leave_type"]

    missed_classes = calculate_missed_classes(
        student_id,
        from_date,
        to_date
    )

    return jsonify({
        "missed_classes": missed_classes
    })


@leave_bp.route("/student/<int:id>", methods=["GET"])
def get_student(id):

    student = Student.query.get(id)

    if not student:
        return jsonify({
            "error": "Student not found"
        }), 404

    return jsonify({
        "id": student.id,
        "name": student.name,
        "email": student.email,
        "mentor_email": student.mentor_email
    })
@leave_bp.route("/history/<int:student_id>", methods=["GET"])
def leave_history(student_id):

    leaves = Leave.query.filter_by(
        student_id=student_id
    ).all()

    result = []

    for leave in leaves:

        result.append({
            "id": leave.id,
            "from_date": str(
                leave.from_date
            ),
            "to_date": str(
                leave.to_date
            ),
            "reason": leave.reason,
            "status": leave.status
        })

    return jsonify(result)
@leave_bp.route("/mentor/pending", methods=["GET"])
def mentor_pending():

    leaves = Leave.query.filter_by(
        status="Pending"
    ).all()

    result = []

    for leave in leaves:

        student = Student.query.get(
            leave.student_id
        )

        result.append({
            "leave_id": leave.id,
            "student_name": student.name,
            "from_date": str(
                leave.from_date
            ),
            "to_date": str(
                leave.to_date
            ),
            "reason": leave.reason,
            "status": leave.status
        })

    return jsonify(result)