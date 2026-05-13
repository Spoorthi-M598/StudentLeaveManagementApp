from flask import Flask
from app.config.db import db
from app.routes.student_routes import student_bp
from app.models.timetable_model import Timetable
from app.routes.timetable_routes import timetable_bp
from app.models.leave import Leave
from app.routes.leave_routes import leave_bp
app = Flask(__name__)

app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost/student_leave_db"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.register_blueprint(student_bp, url_prefix="/student")
app.register_blueprint(timetable_bp, url_prefix="/timetable")
app.register_blueprint(leave_bp, url_prefix="/leave")

db.init_app(app)

# import models AFTER db setup
from app.models.student import Student
from app.models.leave import Leave


@app.route("/")
def home():
    return {"message": "Student Leave API Running with MySQL"}


if __name__ == "__main__":
    with app.app_context():
        db.create_all()

    app.run(debug=True)