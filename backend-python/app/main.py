from flask import Flask
from flask_cors import CORS

from app.config.db import db

from app.routes.student_routes import student_bp
from app.routes.timetable_routes import timetable_bp
from app.routes.leave_routes import leave_bp
from app.routes.auth_routes import auth_bp
from app.routes.mentor_routes import mentor_bp
from app.models.attendance import Attendance
from app.routes.attendance_routes import attendance_bp
from app.routes.faculty_routes import faculty_bp

app = Flask(__name__)

# Allow cross-origin requests (needed for web frontend during development)
CORS(app)

app.config["SQLALCHEMY_DATABASE_URI"] = \
    "mysql+pymysql://root:@localhost/student_leave_db"

app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)

# Import models after db setup
from app.models.student import Student
from app.models.leave import Leave
from app.models.timetable_model import Timetable
from app.models.user_model import User


# Register ALL routes here
app.register_blueprint(
    student_bp,
    url_prefix="/student"
)

app.register_blueprint(
    timetable_bp,
    url_prefix="/timetable"
)

app.register_blueprint(
    leave_bp,
    url_prefix="/leave"
)

app.register_blueprint(
    auth_bp,
    url_prefix="/auth"
)

app.register_blueprint(
    mentor_bp,
    url_prefix="/mentor"
)
app.register_blueprint(
    attendance_bp,
    url_prefix="/attendance"
)
app.register_blueprint(
    faculty_bp,
    url_prefix="/faculty"
)
@app.route("/")
def home():
    return {
        "message":
        "Student Leave API Running"
    }


if __name__ == "__main__":

    with app.app_context():
        db.create_all()

    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )