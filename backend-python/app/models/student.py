from app.config.db import db


class Student(db.Model):

    __tablename__ = "students"

    id = db.Column(
        db.Integer,
        primary_key=True
    )

    student_name = db.Column(
        db.String(150),
        nullable=False
    )

    usn = db.Column(
        db.String(50),
        unique=True,
        nullable=False
    )

    department = db.Column(
        db.String(50),
        nullable=False
    )

    current_sem = db.Column(
        db.Integer,
        nullable=False
    )

    mentor = db.Column(
        db.String(100),
        nullable=False
    )