from app.config.db import db


class Leave(db.Model):
    __tablename__ = "leaves"

    id = db.Column(db.Integer, primary_key=True)


    student_id = db.Column(
        db.Integer,
        db.ForeignKey("students.id"),
        nullable=False
    )

    from_date = db.Column(db.Date, nullable=False)

    to_date = db.Column(db.Date, nullable=False)

    reason = db.Column(db.String(255), nullable=False)

    status = db.Column(db.String(20), default="pending")

    applied_at = db.Column(db.DateTime, server_default=db.func.now())