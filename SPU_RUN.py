# SPU_RUN.py
###################################################################################################################
import subprocess
import time
import os
###################################################################################################################

########### SPU System Runner Script ######################
# Paths
#/////////////////////////////////////////////////////////
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#if you in run in linux
# BASE_FOLDER = "/home/sedhom/SPU"
# App_BASE_PATH = f"{BASE_FOLDER}/SPU_Linux_App"
# App_name = "SPU"
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# if you run in windows
BASE_FOLDER = "C:/Users/elmoh/OneDrive/Desktop/Ibrahim_mohamed_project"
App_BASE_PATH = f"{BASE_FOLDER}/SPU_Windows_App"
App_name = "SPU.exe"
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#/////////////////////////////////////////////////////////
# AI module details
AI_module_path = "Background_Process_Code.AI_Brain_Of_Project.AI_Main_module"
AI_BASE_PATH = f"{BASE_FOLDER}/code_of_project"
###################################################################################################################

# Full app path
APP_PATH = os.path.join(App_BASE_PATH, App_name)
AI_FILE = os.path.join(AI_BASE_PATH, f"{AI_module_path.replace('.', os.sep)}.py")

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
print("Starting AI Backend...")
print("Starting SPU App...")

# Run AI Backend
ai_process = subprocess.Popen(
    [
        "python",
        # "python3",
        "-m",
        AI_module_path
    ],
    cwd=AI_BASE_PATH,
)
print("AI Backend Running")

# Run Flutter App
flutter_process = subprocess.Popen(
    [
        APP_PATH
    ],
    cwd=App_BASE_PATH
)

print("SPU App Running")

print("SPU System Running")

try:

    while True:

        # monitor AI
        if ai_process.poll() is not None:
            print("AI Backend Stopped")
            print("Exit Code:", ai_process.returncode)
            break

        # monitor SPU App
        if flutter_process.poll() is not None:
            print("SPU App Stopped")
            break

        time.sleep(2)

except KeyboardInterrupt:

    print("Stopping SPU System...")

finally:
    try:

        ai_process.terminate()
        flutter_process.terminate()

        ai_process.wait()
        flutter_process.wait()
    except NameError:
        pass

    print("All System Stopped (AI + SPU App)")