import subprocess
import sys
import os

# Find where Blender's internal Python resides.
python_exe = os.path.join(sys.prefix, "bin", "python")

# Upgrade `pip` and install `pyserial`.
subprocess.call([python_exe, "-m", "ensurepip"])
subprocess.call([python_exe, "-m", "pip", "install", "pyserial"])

print("Finished.")
