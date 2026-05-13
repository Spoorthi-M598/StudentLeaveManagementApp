import smtplib
import os
from email.mime.text import MIMEText
from dotenv import load_dotenv

load_dotenv()

def send_leave_email(to_email, student_name, missed_classes):

    sender = os.getenv("EMAIL_USER")
    password = os.getenv("EMAIL_PASS")

    print("EMAIL_USER =", sender)
    print("EMAIL_PASS =", password)

    subject = "Student Leave Notification"

    body = f"""
Student: {student_name}

Missed Classes:
{missed_classes}
"""

    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = sender
    msg["To"] = to_email

    with smtplib.SMTP("smtp.gmail.com", 587) as server:
        server.starttls()
        server.login(sender, password)
        server.send_message(msg)