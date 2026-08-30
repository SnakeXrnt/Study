import math
import typing

import bpy
import serial
from bpy.stub_internal.rna_enums import OperatorReturnItems

PORT = "/dev/ttyACM0"
BAUD = 115200


class SerialRotationModal(bpy.types.Operator):
    """Rotate an object using Serial AHRS Data"""

    bl_idname = "object.serial_rotation_modal"
    bl_label = "Rotate an object using Serial AHRS Data"

    _timer = None
    _ser = None

    @typing.override
    def modal(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        if event.type == "TIMER":
            if self._ser and self._ser.in_waiting > 0:
                while self._ser.in_waiting > 0:
                    line = self._ser.readline().decode("utf-8", errors="ignore").strip()
                    parts = line.split(",")

                    if len(parts) == 3:
                        try:
                            roll, pitch, yaw = (float(x) for x in parts)

                            context.object.rotation_mode = "XYZ"
                            context.object.rotation_euler.x = math.radians(roll)
                            context.object.rotation_euler.y = math.radians(pitch)
                            context.object.rotation_euler.z = math.radians(yaw)
                        except ValueError as e:
                            print(f"Warning: Could not parse line: {e}")

        elif event.type in {"LEFTMOUSE", "RIGHTMOUSE", "ESC"}:
            self.cleanup(context)
            self.report({"INFO"}, "Serial connection closed.")
            return {"FINISHED"}

        return {"RUNNING_MODAL"}

    @typing.override
    def invoke(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        _ = event  # Unused.

        if not context.object:
            self.report({"WARNING"}, "Please select an Object first!")
            return {"CANCELLED"}

        try:
            # Pass `timeout=0` to make reads non-blocking.
            self._ser = serial.Serial(PORT, BAUD, timeout=0)
            print(f"Connected to {PORT}")
        except serial.SerialException as e:
            self.report({"ERROR"}, f"Serial Error: {e}")
            return {"CANCELLED"}

        # Register a timer to trigger `modal()` every 0.02 seconds (50Hz).
        wm = context.window_manager
        self._timer = wm.event_timer_add(0.02, window=context.window)
        wm.modal_handler_add(self)

        self.report({"INFO"}, "Syncing Rotation... Click to Stop.")
        return {"RUNNING_MODAL"}

    def cleanup(self, context: bpy.types.Context) -> None:
        if self._timer is not None:
            context.window_manager.event_timer_remove(self._timer)
        if self._ser and self._ser.is_open:
            self._ser.close()
        self.report({"INFO"}, "Serial connection closed.")


def menu_func(self, context: bpy.types.Context) -> None:
    _ = context  # Unused.
    self.layout.operator(
        SerialRotationModal.bl_idname, text=SerialRotationModal.bl_label
    )


def register():
    bpy.utils.register_class(SerialRotationModal)
    bpy.types.VIEW3D_MT_object.append(menu_func)


def unregister():
    bpy.utils.unregister_class(SerialRotationModal)
    bpy.types.VIEW3D_MT_object.remove(menu_func)


if __name__ == "__main__":
    register()
