import serial

class UARTReaderJSON:
    def __init__(self, port, baud):
        try:
            self.ser = serial.Serial(port, baud, timeout=1)
        except Exception as e:
            print("UART Error:", e)
            self.ser = None

    def read(self):
        if self.ser and self.ser.in_waiting > 0:
            return self.ser.readline().decode(errors='ignore').strip()
        return None