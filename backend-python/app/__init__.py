from flask import Flask
from flask_cors import CORS

from app.config.db import db
from app.routes.leave_routes import leave_bp

def create_app():

    app = Flask(__name__)

    app.config[
        "SQLALCHEMY_DATABASE_URI"
    ] = "mysql+pymysql://root:@localhost/student_leave_db"

    app.config[
        "SQLALCHEMY_TRACK_MODIFICATIONS"
    ] = False

    db.init_app(app)

    CORS(app)

    app.register_blueprint(
        leave_bp,
        url_prefix="/leave"
    )

    return app