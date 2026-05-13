from app.config.db import db


class Student(db.Model):
    __tablename__ = "students"

    id = db.Column(db.Integer, primary_key=True)

    name = db.Column(db.String(100), nullable=False)

    email = db.Column(db.String(120), unique=True, nullable=False)

    password = db.Column(db.String(255), nullable=False)

    branch = db.Column(db.String(50), nullable=False)

    semester = db.Column(db.Integer, nullable=False)

    mentor_email = db.Column(db.String(120), nullable=False)

    created_at = db.Column(db.DateTime, server_default=db.func.now())