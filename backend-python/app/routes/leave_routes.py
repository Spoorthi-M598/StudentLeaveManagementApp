from flask import Blueprint, request, jsonify
from datetime import datetime

from app.config.db import db
from app.models.leave import Leave

leave_bp = Blueprint("leave", __name__)


@leave_bp.route("/apply", methods=["POST"])
def apply_leave():

    try:

        data = request.get_json()

        leave_type = data.get("leaveType")

        start_date = data.get("startDate")

        end_date = data.get("endDate")

        reason = data.get("reason")

        start = datetime.strptime(
            start_date,
            "%d-%m-%Y"
        ).date()

        end = datetime.strptime(
            end_date,
            "%d-%m-%Y"
        ).date()

        new_leave = Leave(

            student_id=1,

            leave_type=leave_type,

            start_date=start,

            end_date=end,

            reason=reason,

            status="Pending"

        )

        db.session.add(new_leave)

        db.session.commit()

        return jsonify({

            "message":
            "Leave Applied Successfully",

            "missed_classes": 5,

            "subjects": [

                "DBMS",
                "Java",
                "OS",
                "Maths"

            ]

        })

    except Exception as e:

        return jsonify({

            "error": str(e)

        }), 500