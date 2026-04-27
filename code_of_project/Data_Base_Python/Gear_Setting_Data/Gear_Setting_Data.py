from typing import Optional
from handling_Data.handling_Data import Control_Data_from_json


class GearSettingData:
    def __init__(self, file_path):
        self.__data = Control_Data_from_json(file_path)

    # ======================
    # INTERNAL
    # ======================
    def _gear(self):
        return self.__data.json_data_access.setdefault("Gear_Setting", {})

    # ======================
    # GET
    # ======================
    def get_big_gear(self):
        return self._gear().get("Big_Gear", 0)

    def get_small_gear(self):
        return self._gear().get("Small_Gear", 0)

    def get_unit(self):
        return self._gear().get("Gear_Setting_Unit", "")

    # ======================
    # SET
    # ======================
    def set_big_gear(self, value: float):
        if value <= 0:
            return
        self._gear()["Big_Gear"] = value
        self.save_data()

    def set_small_gear(self, value: float):
        if value <= 0:
            return
        self._gear()["Small_Gear"] = value
        self.save_data()

    def set_unit(self, unit: str):
        self._gear()["Gear_Setting_Unit"] = unit
        self.save_data()

    # ======================
    # UPDATE
    # ======================
    def update_gear(self,
                    big: Optional[float] = None,
                    small: Optional[float] = None,
                    unit: Optional[str] = None):

        gear = self._gear()

        if big is not None and big > 0:
            gear["Big_Gear"] = big

        if small is not None and small > 0:
            gear["Small_Gear"] = small

        if unit is not None:
            gear["Gear_Setting_Unit"] = unit

        self.save_data()

    # ======================
    # SAVE
    # ======================
    def save_data(self):
        self.__data.save_data()