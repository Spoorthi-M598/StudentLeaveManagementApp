from flask import Blueprint, request, jsonify
from app.config.db import db
from app.models.timetable_model import Timetable

timetable_bp = Blueprint("timetable", __name__)


@timetable_bp.route("/add", methods=["POST"])
def add_timetable():
    data = request.get_json()

    entry = Timetable(
        student_id=data["student_id"],
        day=data["day"],
        subject=data["subject"],
        start_time=data["start_time"],
        end_time=data["end_time"]
    )

    db.session.add(entry)
    db.session.commit()

    return jsonify({
        "message": "Timetable added successfully"
    })