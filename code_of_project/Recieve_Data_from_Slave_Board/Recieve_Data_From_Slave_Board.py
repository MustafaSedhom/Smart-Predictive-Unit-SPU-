import serial

class UARTReaderJSON:
    def __init__(self, port='/dev/serial0', baud=9600):
        self.ser = serial.Serial(port, baud, timeout=1)

    def read(self):
        if self.ser.in_waiting > 0:
            return self.ser.readline().decode(errors='ignore').strip()
        return None