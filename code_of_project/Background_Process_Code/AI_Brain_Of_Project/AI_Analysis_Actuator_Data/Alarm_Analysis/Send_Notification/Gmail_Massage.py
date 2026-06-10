import smtplib
from email.mime.text import MIMEText

from AI_Main_module import (
    SPU_Master_User_email,
    SPU_Master_User_email_password
)

from .....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)


def send_email(
    subject: str,
    message: str
) -> bool:

    sender_email = SPU_Master_User_email
    app_password = SPU_Master_User_email_password

    DB = Access_data_Base()

    receiver_email = (
        DB.Data_Base
        .admin_settings
        .get_email()
    )

    if not receiver_email:
        print("No admin email configured")
        return False

    msg = MIMEText(
        message,
        "plain",
        "utf-8"
    )

    msg["Subject"] = subject
    msg["From"] = f"SPU SYSTEM <{sender_email}>"
    msg["To"] = receiver_email

    try:
        with smtplib.SMTP(
            "smtp.gmail.com",
            587,
            timeout=10
        ) as server:

            server.starttls()
            server.login(
                sender_email,
                app_password
            )

            server.send_message(msg)

        return True

    except Exception as e:
        print(f"Email Error: {e}")
        return False