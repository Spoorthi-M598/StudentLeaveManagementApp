from flask import Blueprint, jsonify

from app.models.leave import Leave
from app.models.student import Student
from app.config.db import db

mentor_bp = Blueprint(
    "mentor",
    __name__
)


# Get all leave requests
@mentor_bp.route(
    "/leaves",
    methods=["GET"]
)
def get_all_leaves():

    leaves = Leave.query.all()

    result = []

    for leave in leaves:

        student = Student.query.get(
            leave.student_id
        )

        result.append({

            "leave_id":
                leave.id,

            "student_name":
                student.name
                if student
                else "Unknown",

            "from_date":
                str(
                    leave.from_date
                ),

            "to_date":
                str(
                    leave.to_date
                ),

            "reason":
                leave.reason,

            "status":
                leave.status
        })

    return jsonify(
        result
    )
from app.config.db import db


@mentor_bp.route(
    "/approve/<int:leave_id>",
    methods=["PUT"]
)
def approve_leave(
    leave_id
):

    leave=Leave.query.get(
            leave_id
        )

    if not leave:

        return {
            "error":
            "Leave not found"
        }, 404

    leave.status ="Approved"

    db.session.commit()

    return {
        "message":
        "Leave approved"
    }


@mentor_bp.route(
    "/reject/<int:leave_id>",
    methods=["PUT"]
)
def reject_leave(
    leave_id
):

    leave =Leave.query.get(
            leave_id
        )

    if not leave:

        return {
            "error":
            "Leave not found"
        }, 404

    leave.status = "Rejected"

    db.session.commit()

    return {
        "message":
        "Leave rejected"
    }