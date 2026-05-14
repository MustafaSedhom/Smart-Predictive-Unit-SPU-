import subprocess
import time
import os
import signal

print("Starting SPU System...")

# run AI Backend
ai_process = subprocess.Popen(
    [
        "python3",
        "-m",
        "Background_Process_Code.AI_Brain_Of_Project.test"
    ],
    cwd="/home/pi/SPU_System"
)

# run Flutter App
flutter_process = subprocess.Popen(
    [
        "/home/pi/SPU_System/SPU_app/build/linux/arm64/release/bundle/SPU_app"
    ],
    cwd="/home/pi/SPU_System"
)

print("SPU System Running")

try:

    while True:

        # monitor AI
        if ai_process.poll() is not None:
            print("AI Backend Stopped")

        # monitor Flutter
        if flutter_process.poll() is not None:
            print("Flutter App Stopped")

        time.sleep(2)

except KeyboardInterrupt:

    print("Stopping SPU System...")

    ai_process.send_signal(signal.SIGTERM)
    flutter_process.send_signal(signal.SIGTERM)

    ai_process.wait()
    flutter_process.wait()

    print("System Stopped")