from flask import Blueprint, jsonify
from sqlalchemy import text

from app.config.db import db

faculty_bp = Blueprint(
    "faculty",
    __name__
)


@faculty_bp.route(
    "/attendance",
    methods=["GET"]
)
def view_attendance():

    result = db.session.execute(
        text("""

            SELECT

                s.name AS student_name,
                a.subject,
                a.status,
                a.date

            FROM attendance a

            JOIN students s
            ON a.student_id = s.id

            ORDER BY a.date DESC

        """)
    )

    data = []

    for row in result:

        data.append({

            "student_name":
                row.student_name,

            "subject":
                row.subject,

            "status":
                row.status,

            "date":
                str(row.date)
        })

    return jsonify(data)