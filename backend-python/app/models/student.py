from app.config.db import db


class Student(db.Model):
    __tablename__ = "students"

    id = db.Column(db.Integer, primary_key=True)

    name = db.Column(db.String(100), nullable=False)

    email = db.Column(db.String(120), unique=True, nullable=False)

    password = db.Column(db.String(255), nullable=False)
    usn = db.Column(db.String(50))
    course = db.Column(db.String(50))
    section = db.Column(db.String(50))
    blood_group = db.Column(db.String(20))
    address = db.Column(db.String(200))
    emergency_contact = db.Column(db.String(20))
    mentor_email = db.Column(db.String(120), nullable=False)

    created_at = db.Column(db.DateTime, server_default=db.func.now())