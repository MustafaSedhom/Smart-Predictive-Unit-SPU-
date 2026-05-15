# SPU_RUN.py
###################################################################################################################
import subprocess
import time
import os
###################################################################################################################

########### SPU System Runner Script ######################

# Paths
App_BASE_PATH = "C:/Users/elmoh/OneDrive/Desktop/SPU"
AI_BASE_PATH = "C:/Users/elmoh/OneDrive/Desktop/Ibrahim_mohamed_project/code_of_project"
# App details
App_name = "SPU.exe"
# AI module details
AI_module_path = "Background_Process_Code.AI_Brain_Of_Project.AI_Main_module"

###################################################################################################################

# Full app path
APP_PATH = rf"{App_BASE_PATH}\{App_name}"
AI_FILE = rf"{AI_BASE_PATH}\{AI_module_path.replace('.', os.sep)}.py"

# Check app exists
if not os.path.exists(APP_PATH):
    print("ERROR: App file not found")
    print(APP_PATH)
    exit()

# Check AI file exists
if not os.path.exists(AI_FILE):
    print("ERROR: AI file not found")
    print(AI_FILE)
    exit()


###################################################################################################################

print("Starting SPU System...")

# Hide terminal windows
CREATE_NO_WINDOW = 0x08000000

# Run AI Backend
ai_process = subprocess.Popen(
    [
        "python",
        "-m",
        AI_module_path
    ],
    cwd=AI_BASE_PATH,
    creationflags=CREATE_NO_WINDOW
)

# Run Flutter App
flutter_process = subprocess.Popen(
    [
        APP_PATH
    ],
    cwd=App_BASE_PATH,
    creationflags=CREATE_NO_WINDOW
)

print("SPU System Running")

try:

    while True:

        # monitor AI
        if ai_process.poll() is not None:
            print("AI Backend Stopped")
            print("Exit Code:", ai_process.returncode)
            break

        # monitor Flutter
        if flutter_process.poll() is not None:
            print("Flutter App Stopped")
            break

        time.sleep(2)

except KeyboardInterrupt:

    print("Stopping SPU System...")

finally:

    ai_process.terminate()
    flutter_process.terminate()

    ai_process.wait()
    flutter_process.wait()

    print("System Stopped")