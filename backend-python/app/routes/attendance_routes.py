from flask import Blueprint, request, jsonify

from app.config.db import db
from app.models.attendance import Attendance


attendance_bp = Blueprint(
    "attendance",
    __name__
)


# Mark attendance
@attendance_bp.route(
    "/mark",
    methods=["POST"]
)
def mark_attendance():

    data = request.json

    attendance = Attendance(

        student_id=
            data["student_id"],

        subject=
            data["subject"],

        date=
            data["date"],

        status=
            data["status"]
    )

    db.session.add(
        attendance
    )

    db.session.commit()

    return jsonify({

        "message":
            "Attendance marked successfully"
    })


# View attendance of one student
@attendance_bp.route(
    "/student/<int:id>",
    methods=["GET"]
)
def get_attendance(id):

    records = Attendance.query.filter_by(
        student_id=id
    ).all()

    result = []

    for record in records:

        result.append({

            "subject":
                record.subject,

            "date":
                record.date,

            "status":
                record.status
        })

    return jsonify(
        result
    )
from sqlalchemy import func


@attendance_bp.route(
    "/percentage/<int:student_id>",
    methods=["GET"]
)
def attendance_percentage(
    student_id
):

    subjects = db.session.query(

        Attendance.subject,

        func.count(
            Attendance.id
        ).label(
            "total"
        ),

        func.sum(

            Attendance.status
            == "Present"

        ).label(
            "present"
        )

    ).filter(

        Attendance.student_id
        == student_id

    ).group_by(

        Attendance.subject

    ).all()


    result = []

    for row in subjects:

        percentage = (
            row.present
            / row.total
        ) * 100

        result.append({

            "subject":
                row.subject,

            "percentage":
                round(
                    percentage,
                    2
                )
        })

    return jsonify(
        result
    )