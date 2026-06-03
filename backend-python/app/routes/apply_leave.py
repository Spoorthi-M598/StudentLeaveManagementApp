from flask import Blueprint, request, jsonify
from app.config.db import db

leave_bp = Blueprint("leave_bp", __name__)

# =========================
# LEAVE MODEL
# =========================
class Leave(db.Model):

    __tablename__ = "leaves"

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    leave_type = db.Column(
        db.String(100)
    )

    start_date = db.Column(
        db.String(50)
    )

    end_date = db.Column(
        db.String(50)
    )

    total_days = db.Column(
        db.Integer
    )

    reason = db.Column(
        db.Text
    )

    status = db.Column(
        db.String(50),
        default="Pending"
    )

# =========================
# APPLY LEAVE API
# =========================
@leave_bp.route("/apply", methods=["POST"])
def apply_leave():

    data = request.get_json()

    new_leave = Leave(

        leave_type=data["leaveType"],
        start_date=data["startDate"],
        end_date=data["endDate"],
        total_days=data["days"],
        reason=data["reason"],
        status="Pending"
    )

    db.session.add(new_leave)

    db.session.commit()

    return jsonify({
        "message": "Leave Applied Successfully"
    })

# =========================
# GET ALL LEAVES API
# =========================
@leave_bp.route("/all", methods=["GET"])
def get_leaves():

    leaves = Leave.query.all()

    result = []

    for leave in leaves:

        result.append({

            "id": leave.id,
            "leave_type": leave.leave_type,
            "start_date": leave.start_date,
            "end_date": leave.end_date,
            "total_days": leave.total_days,
            "reason": leave.reason,
            "status": leave.status,
        })

    return jsonify(result)