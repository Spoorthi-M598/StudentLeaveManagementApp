from app.config.db import db
from datetime import datetime


class Leave(db.Model):

    __tablename__ = "leaves"

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    student_id = db.Column(
        db.Integer,
        nullable=False
    )

    from_date = db.Column(
        db.String(20),
        nullable=False
    )

    to_date = db.Column(
        db.String(20),
        nullable=False
    )

    reason = db.Column(
        db.Text,
        nullable=False
    )

    leave_type = db.Column(
        db.String(100),
        nullable=False
    )

    status = db.Column(
        db.String(30),
        default="Pending"
    )

    applied_at = db.Column(
        db.DateTime,
        default=datetime.utcnow
    )