from flask import Flask
from flask_cors import CORS

from app.config.db import db
from app.routes.auth_routes import auth_bp
from app.routes.student_dashboard import dashboard_bp
from app.routes.student_routes import student_bp
from app.routes.timetable_routes import timetable_bp
from app.routes.apply_leave import leave_bp

app = Flask(__name__)

# =========================
# ENABLE CORS
# =========================
CORS(app)

# =========================
# DATABASE CONFIGURATION
# =========================
app.config["SQLALCHEMY_DATABASE_URI"] = \
    "mysql+pymysql://root:@localhost/student_leave_db"

app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# =========================
# INITIALIZE DATABASE
# =========================
db.init_app(app)

# =========================
# REGISTER ROUTES
# =========================
app.register_blueprint(dashboard_bp)
app.register_blueprint(auth_bp)
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

# =========================
# CREATE TABLES
# =========================
with app.app_context():
    db.create_all()

# =========================
# RUN APP
# =========================
if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000,
        debug=True
    )