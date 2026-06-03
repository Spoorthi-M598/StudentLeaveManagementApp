from flask import Blueprint, jsonify
from app.config.db import db
from sqlalchemy import text

dashboard_bp = Blueprint('dashboard', __name__)

@dashboard_bp.route('/dashboard', methods=['GET'])
def dashboard():

    student_id = 1

    student = db.session.execute(text(
        "SELECT * FROM students WHERE id=:id"
    ), {"id": student_id}).fetchone()

    total = db.session.execute(text(
        "SELECT COUNT(*) FROM leaves WHERE student_id=:id"
    ), {"id": student_id}).scalar()

    approved = db.session.execute(text(
        "SELECT COUNT(*) FROM leaves WHERE student_id=:id AND status='Approved'"
    ), {"id": student_id}).scalar()

    pending = db.session.execute(text(
        "SELECT COUNT(*) FROM leaves WHERE student_id=:id AND status='Pending'"
    ), {"id": student_id}).scalar()

    return jsonify({
        "name": student.name,
        "total": total,
        "approved": approved,
        "pending": pending
    })