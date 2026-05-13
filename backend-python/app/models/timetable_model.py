from app.config.db import db


class Timetable(db.Model):
    __tablename__ = "timetable"

    id = db.Column(db.Integer, primary_key=True)

    student_id = db.Column(
        db.Integer,
        db.ForeignKey("students.id"),
        nullable=False
    )

    day = db.Column(db.String(20), nullable=False)

    subject = db.Column(db.String(100), nullable=False)

    start_time = db.Column(db.String(20), nullable=False)

    end_time = db.Column(db.String(20), nullable=False)