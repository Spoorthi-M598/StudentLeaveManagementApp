from app.config.db import db


class Leave(db.Model):

    __tablename__ = "leave"

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

    reason = db.Column(
        db.String(500)
    )

    status = db.Column(
        db.String(50)
    )