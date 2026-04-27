from handling_Data.handling_Data import Control_Data_from_json


class AnalysisData:
    def __init__(self, file_path):
        self.__data = Control_Data_from_json(file_path)

    # ======================
    # INTERNAL HELPERS
    # ======================
    def _analysis(self):
        return self.__data.json_data_access.setdefault("Analysis", {})

    def _points(self):
        return self._analysis().setdefault("points", {
            "x_points": [],
            "y_points": []
        })

    def _labels(self):
        return self._analysis().setdefault("labels", {
            "x_labels": [],
            "y_labels": []
        })

    # ======================
    # POINTS METHODS
    # ======================
    def add_point(self, x, y):
        points = self._points()
        points.setdefault("x_points", []).append(x)
        points.setdefault("y_points", []).append(y)
        self.save_data()

    def remove_point_by_index(self, index: int):
        points = self._points()

        if index < 0:
            return

        try:
            points["x_points"].pop(index)
            points["y_points"].pop(index)
        except IndexError:
            return

        self.save_data()

    def clear_points(self):
        self._analysis()["points"] = {
            "x_points": [],
            "y_points": []
        }
        self.save_data()

    # ======================
    # LABELS METHODS
    # ======================
    def add_label(self, x, y):
        labels = self._labels()

        labels.setdefault("x_labels", []).append(x)
        labels.setdefault("y_labels", []).append(y)

        self.save_data()

    def remove_x_label(self, index: int):
        labels = self._labels().setdefault("x_labels", [])
        if 0 <= index < len(labels):
            labels.pop(index)
            self.save_data()

    def remove_y_label(self, index: int):
        labels = self._labels().setdefault("y_labels", [])
        if 0 <= index < len(labels):
            labels.pop(index)
            self.save_data()

    def clear_labels(self):
        self._analysis()["labels"] = {
            "x_labels": [],
            "y_labels": []
        }
        self.save_data()
    # ======================
    # FULL RESET
    # ======================
    def clear_all(self):
        self._analysis()["points"] = {
            "x_points": [],
            "y_points": []
        }
        self._analysis()["labels"] = {
            "x_labels": [],
            "y_labels": []
        }
        self.save_data()

    # ======================
    # GET METHODS
    # ======================
    def get_points(self):
        return self._points()

    def get_labels(self):
        return self._labels()

    # ======================
    # SAVE
    # ======================
    def save_data(self):
        self.__data.save_data()