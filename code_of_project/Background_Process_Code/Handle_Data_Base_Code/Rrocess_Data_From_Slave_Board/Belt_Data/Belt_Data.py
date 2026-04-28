class BeltDriver:
    def __init__(self, data):
        self.data = data

    def get_tension(self):
        return self.data["Tension"]

    def get_alignment(self):
        return self.data["Alignment"]

    def get_speed(self):
        return self.data["Speed"]