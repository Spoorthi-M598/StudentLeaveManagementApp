from flask import Blueprint, request, jsonify
from datetime import datetime, timedelta

from app.config.db import db
from app.models.leave import Leave
from app.models.timetable_model import Timetable
from app.models.student import Student
from app.services.email_service import send_leave_email
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
        reason=reason
    )

    db.session.add(leave)
    db.session.commit()

    student = Student.query.get(student_id)

    send_leave_email(
        student.mentor_email,
        student.name,
        missed_classes
    )

    return jsonify({
        "message": "Leave applied successfully",
        "missed_classes": missed_classes
    })


    return jsonify({
        "message": "Leave applied successfully",
        "missed_classes": missed_classes
    })