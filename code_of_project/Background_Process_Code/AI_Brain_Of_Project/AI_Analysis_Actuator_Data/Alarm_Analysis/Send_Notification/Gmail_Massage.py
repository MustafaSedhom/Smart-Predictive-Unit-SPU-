import smtplib
from email.mime.text import MIMEText


from .....Handle_Data_Base_Code.Data_Base_Python.SPU_main_Data_handlig import (
    Access_data_Base
)

from ....AI_Config import (
    SPU_Master_User_email,
    SPU_Master_User_email_password
)

def send_email(
    database: Access_data_Base,
    subject: str,
    message: str
) -> bool:
    receiver_email = (
        database.Data_Base
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
    msg["From"] = f"SPU SYSTEM <{SPU_Master_User_email}>"
    msg["To"] = receiver_email

    try:
        with smtplib.SMTP(
            "smtp.gmail.com",
            587,
            timeout=10
        ) as server:

            server.starttls()
            server.login(
                SPU_Master_User_email,
                SPU_Master_User_email_password
            )

            server.send_message(msg)

        return True

    except Exception as e:
        print(f"Email Error: {e}")
        return False