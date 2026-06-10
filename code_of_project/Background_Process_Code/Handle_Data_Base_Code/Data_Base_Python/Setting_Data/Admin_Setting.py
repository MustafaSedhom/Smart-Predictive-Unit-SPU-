from typing import Optional

class AdminSettingData:
    def __init__(self, data):
        self.__data = data

    # ======================
    # INTERNAL
    # ======================
    def _admin(self):
        settings = self.__data.json_data_access.setdefault(
            "Settings", {}
        )
        return settings.setdefault(
            "Admin", {}
        )

    # ======================
    # GET
    # ======================
    def get_email(self) -> str:
        return self._admin().get("Email", "")

    def get_phone(self) -> str:
        return self._admin().get("Phone", "")

    # ======================
    # SET
    # ======================
    def set_email(self, value: str):
        self.update_admin_setting_data(email=value)

    def set_phone(self, value: str):
        self.update_admin_setting_data(phone=value)

    # ======================
    # UPDATE
    # ======================
    def update_admin_setting_data(
        self,
        email: Optional[str] = None,
        phone: Optional[str] = None
    ):
        admin = self._admin()

        if email is not None:
            admin["Email"] = email

        if phone is not None:
            admin["Phone"] = phone

        self.save_data()

    # ======================
    # SAVE
    # ======================
    def save_data(self):
        self.__data.save_data()