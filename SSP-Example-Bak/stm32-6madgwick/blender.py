from typing_extensions import override
from typing import TYPE_CHECKING, Literal, TypeAlias

import bpy
import serial
import mathutils

if TYPE_CHECKING:
    from bpy.stub_internal import rna_enums

OperatorReturnItems: TypeAlias = "rna_enums.OperatorReturnItems"


class ABCOnData:
    def on_data(self, data: bytearray) -> None:
        """Process a complete chunk of serial data."""
        _ = data  # Unused.
        raise NotImplementedError

    def check_data(self, data: bytearray) -> Literal["INCOMPLETE", "COMPLETE", "ERROR"]:
        """Check if the data chunk is complete and valid."""
        _ = data  # Unused.
        raise NotImplementedError


class ABCSerialDataModal(bpy.types.Operator, ABCOnData):
    """Abstract base class for serial data processing modals."""

    MAX_SERIAL_BUFFER_SIZE = 4096
    SERIAL_PORT = "/dev/ttyACM1"
    SERIAL_BAUD = 115200
    REFRESH_RATE = 0.02  # 50Hz
    DELIM = b";"

    @override
    def modal(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        if event.type == "TIMER":
            if self._serial and self._serial.in_waiting > 0:
                raw_data = self._serial.read(self._serial.in_waiting)
                self._total_bytes_received += len(raw_data)
                self._serial_buff.extend(raw_data)

                if len(self._serial_buff) > self.MAX_SERIAL_BUFFER_SIZE:
                    self.report({"WARNING"}, "Serial buffer overflow. Truncating data.")
                    self._serial_buff.clear()
                    return {"PASS_THROUGH"}

                last_delim_index = self._serial_buff.rfind(self.DELIM)
                if last_delim_index != -1:
                    to_process = self._serial_buff[: last_delim_index + 1]

                    for chunk in to_process.split(self.DELIM):
                        chunk = chunk.strip()
                        res = self.check_data(chunk)
                        if res == "INCOMPLETE":
                            continue  # Wait for more data.
                        elif res == "ERROR":
                            print(f"ERROR Invalid data chunk: {chunk.decode()}")
                            self._total_error_bytes += len(chunk)
                            del self._serial_buff[: len(chunk) + 1]  # Drop bad chunk.
                            continue

                        self.on_data(chunk)
                        del self._serial_buff[: len(chunk) + 1]

        elif event.type in {"DEL"}:
            self.cleanup(context)
            success_ratio = (
                (self._total_bytes_received - self._total_error_bytes)
                / self._total_bytes_received
                if self._total_bytes_received > 0
                else 1.0
            )
            self.report({"INFO"}, f"Stopped. Data without errors: {success_ratio:.2%}")
            return {"FINISHED"}

        return {"PASS_THROUGH"}

    @override
    def invoke(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        _ = event  # Unused.

        try:
            self._serial = serial.Serial(
                self.SERIAL_PORT,
                self.SERIAL_BAUD,
                timeout=0,  # Non-blocking reads.
            )

            self._timer = None
            self._serial_buff = bytearray()
            self._total_bytes_received = 0
            self._total_error_bytes = 0

            self.report({"INFO"}, f"Connected to {self.SERIAL_PORT}")

        except serial.SerialException as e:
            self.report({"ERROR"}, f"Serial Error: {e}")
            return {"CANCELLED"}

        wm = context.window_manager
        if wm is None:
            self.report({"ERROR"}, "No window manager found in context!")
            return {"CANCELLED"}

        self._timer = wm.event_timer_add(self.REFRESH_RATE, window=context.window)
        wm.modal_handler_add(self)

        self.report({"INFO"}, "Started")
        return {"RUNNING_MODAL"}

    def cleanup(self, context: bpy.types.Context) -> None:
        if self._timer is not None:
            wm = context.window_manager
            if wm is not None:
                wm.event_timer_remove(self._timer)

        if self._serial and self._serial.is_open:
            self._serial.close()

        self._serial_buff.clear()
        self.report({"INFO"}, "Serial connection closed.")


def get_yaw(q: mathutils.Quaternion) -> mathutils.Quaternion:
    yaw = mathutils.Quaternion((q.w, 0.0, 0.0, q.z))
    #    if yaw.w < 0.0:
    #        yaw.negate()
    #    if yaw.magnitude < 1e-5:
    #        return mathutils.Quaternion()
    yaw.normalize()
    return yaw


def get_yaw_(q: mathutils.Quaternion) -> mathutils.Quaternion:
    eul = q.to_euler("XYZ")
    yaw_only_eul = mathutils.Euler((0.0, 0.0, eul.z), "XYZ")
    return yaw_only_eul.to_quaternion()


class ForwardKinematicModal(ABCSerialDataModal):
    bl_idname = "object.imu_forward_kinematic_modal"
    bl_label = "IMU Forward Kinematic Solution"

    @override
    def on_data(self, data: bytearray) -> None:
        sensor_id, values_data = data.split(b":", 1)
        values = list(map(float, values_data.split(b",")))

        obj = self._sensor_object_map[bytes(sensor_id)]
        obj.rotation_mode = "QUATERNION"
        q_raw = mathutils.Quaternion(values)

        if obj is self._p1_palm:
            obj.rotation_quaternion = q_raw

            p2_index_d = mathutils.Vector((1.0, 0.75, 0.0))
            p2_index_d.rotate(q_raw)
            self._p2_index.location = obj.location + p2_index_d

            p2_middle_d = mathutils.Vector((1.0, 0.25, 0.0))
            p2_middle_d.rotate(q_raw)
            self._p2_middle.location = obj.location + p2_middle_d

            p2_ring_d = mathutils.Vector((1.0, -0.25, 0.0))
            p2_ring_d.rotate(q_raw)
            self._p2_ring.location = obj.location + p2_ring_d

            p2_pinky_d = mathutils.Vector((1.0, -0.75, 0.0))
            p2_pinky_d.rotate(q_raw)
            self._p2_pinky.location = obj.location + p2_pinky_d

            p2_thumb_d = mathutils.Vector((0.0, -1.0, 0.0))
            p2_thumb_d.rotate(q_raw)
            self._p2_thumb.location = obj.location + p2_thumb_d

        elif obj in {self._p2_index, self._p2_middle, self._p2_thumb}:
            p1_yaw = get_yaw(self._p1_palm.rotation_quaternion)
            p2_yaw = get_yaw(q_raw)

            q_yaw_fixed = p1_yaw @ (q_raw @ p2_yaw.conjugated())

            obj.rotation_quaternion = q_yaw_fixed
            # obj.rotation_quaternion = q_raw

    #        if obj is self._p2_index:
    #            c_yaw = mathutils.Euler((math.radians(0), math.radians(0), math.radians(0)), 'XYZ').to_quaternion()
    #            obj.rotation_quaternion = c_yaw @ obj.rotation_quaternion
    #        elif obj is self._p2_middle:
    #            c_yaw = mathutils.Euler((0, 0, math.radians(0)), 'XYZ').to_quaternion()
    #            obj.rotation_quaternion = c_yaw @ obj.rotation_quaternion
    #        elif obj is self._p2_thumb:
    #            c_yaw = mathutils.Euler((math.radians(0), math.radians(0), math.radians(0)), 'XYZ').to_quaternion()
    #            p2_yaw = get_yaw(obj.rotation_quaternion)
    #            obj.rotation_quaternion = (c_yaw @ obj.rotation_quaternion)

    @override
    def check_data(self, data: bytearray) -> Literal["INCOMPLETE", "COMPLETE", "ERROR"]:
        if b":" not in data or b"," not in data:
            return "INCOMPLETE"

        sensor_id, values_data = data.split(b":", 1)
        if bytes(sensor_id) not in self._sensor_object_map:
            return "ERROR"

        try:
            values = list(map(float, values_data.split(b",")))
        except ValueError:
            return "ERROR"

        if len(values) < 4:
            return "INCOMPLETE"
        elif len(values) > 4:
            return "ERROR"
        else:
            return "COMPLETE"

    @override
    def invoke(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        self._p1_palm = bpy.data.objects["2_palm"]
        self._p2_index = bpy.data.objects["2_index"]
        self._p2_middle = bpy.data.objects["2_middle"]
        self._p2_ring = bpy.data.objects["2_ring"]
        self._p2_pinky = bpy.data.objects["2_pinky"]
        self._p2_thumb = bpy.data.objects["2_thumb"]

        self._sensor_object_map = {
            b"lsm6dsl": self._p1_palm,
            b"mpu6xxx_3": self._p2_index,
            b"mpu6xxx_2": self._p2_middle,
            b"mpu6xxx_1": self._p2_thumb,
        }

        return super().invoke(context, event)


cls_to_register = ForwardKinematicModal


def menu_func(self, context: bpy.types.Context) -> None:
    _ = context  # Unused.
    self.layout.operator(cls_to_register.bl_idname, text=cls_to_register.bl_label)


def register():
    bpy.utils.register_class(cls_to_register)
    bpy.types.VIEW3D_MT_object.append(menu_func)


def unregister():
    bpy.utils.unregister_class(cls_to_register)
    bpy.types.VIEW3D_MT_object.remove(menu_func)


if __name__ == "__main__":
    register()
