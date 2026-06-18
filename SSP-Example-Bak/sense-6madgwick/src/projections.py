from dataclasses import dataclass
from typing_extensions import override
from typing import Literal
from typing import TYPE_CHECKING, TypeAlias

import bpy
import serial
import math
import mathutils


if TYPE_CHECKING:
    from bpy.stub_internal import rna_enums

OperatorReturnItems: TypeAlias = "rna_enums.OperatorReturnItems"


@dataclass
class FingerProjection:
    source_obj: bpy.types.Object
    twist_proj_obj: bpy.types.Object
    curl_proj_obj: bpy.types.Object
    splay_min_vec_obj: bpy.types.Object
    splay_max_vec_obj: bpy.types.Object
    splay_vec_obj: bpy.types.Object
    target_obj: bpy.types.Object

    curl_min_rad: float
    curl_max_rad: float

    q_offset: mathutils.Quaternion


@dataclass
class FingerAbductionParams:
    curr: float
    curr_clamped: float
    min: float
    max: float


@dataclass
class AbductionParams:
    thumb: FingerAbductionParams
    index: FingerAbductionParams
    middle: FingerAbductionParams
    ring: FingerAbductionParams
    little: FingerAbductionParams


@dataclass
class FingerAbductionalDeltas:
    tm: float
    """Thumb-middle."""
    im: float
    """Index-middle."""
    mr: float
    """Middle-ring."""
    ml: float
    """Middle-little."""


@dataclass
class ProjectionSystem:
    thumb: FingerProjection
    index: FingerProjection
    middle: FingerProjection
    ring: FingerProjection
    little: FingerProjection

    flex_clearance: float
    abduction_dt: FingerAbductionalDeltas


def wrap_angle(angle: float) -> float:
    return (angle + math.pi) % (2 * math.pi) - math.pi


def angle_diff(a: float, b: float) -> float:
    d = wrap_angle(a - b)
    return abs(d)


def lerp(a: float, b: float, t: float) -> float:
    return a + (b - a) * t


def clamp(x: float, min_x: float, max_x: float) -> float:
    return max(min_x, min(max_x, x))


class ForwardKinematicModal(bpy.types.Operator):
    bl_idname = "object.imu_forward_kinematic_modal"
    bl_label = "Forward Kinematic Solution"

    def _make_projection_system(self, context: bpy.types.Context) -> ProjectionSystem:
        naming_map = {
            "source_obj": "2_{}",
            "twist_proj_obj": "2_{}_p",
            "curl_proj_obj": "2_{}_curl_p",
            "splay_min_vec_obj": "2_{}_splay_min_vector",
            "splay_max_vec_obj": "2_{}_splay_max_vector",
            "splay_vec_obj": "2_{}_splay_vector",
            "target_obj": "2_{}_t",
        }

        objs = bpy.data.objects

        finger_names = ["thumb", "index", "middle", "ring", "little"]
        finger_instances = {}

        for finger in finger_names:
            args = {}

            for attr, name_template in naming_map.items():
                obj_name = name_template.format(finger)
                obj = objs.get(obj_name)

                if attr == "source_obj":
                    # Ensure source object exists.
                    assert obj is not None, f"Missing object: {obj_name}"

                elif obj is None:
                    # Recreate missing projection objects as empties.
                    bpy.ops.object.empty_add(
                        type="SINGLE_ARROW",
                        radius=0.5 if "vector" in attr else 1.0,
                    )
                    assert context.active_object is not None
                    obj = context.active_object
                    obj.name = obj_name

                obj.rotation_mode = "QUATERNION"
                if attr != "source_obj":
                    obj.location = args["source_obj"].location
                args[attr] = obj

            curl_min_rad = wrap_angle(math.radians(-180))
            curl_max_rad = wrap_angle(math.radians(45))

            if finger == "thumb":
                curl_min_rad = wrap_angle(math.radians(-90))
                curl_max_rad = wrap_angle(math.radians(0))

            finger_instances[finger] = FingerProjection(
                **args,
                curl_min_rad=curl_min_rad,
                curl_max_rad=curl_max_rad,
                q_offset=mathutils.Quaternion(),
            )

        system = ProjectionSystem(
            **finger_instances,
            flex_clearance=math.radians(25),
            abduction_dt=FingerAbductionalDeltas(
                tm=math.radians(55.0),
                im=math.radians(17.5),
                mr=math.radians(14.8),
                ml=math.radians(32.8),
            ),
        )

        return system

    def _solve_4finger(self) -> None:
        s = self._projection_system
        self._solve_abduction_constraints()
        assert self._abd_params is not None
        for finger in ["thumb", "index", "middle", "ring", "little"]:
            self._solve_finger(getattr(s, finger), getattr(self._abd_params, finger))

    def _solve_abduction_constraints(self) -> None:
        s = self._projection_system

        t_curr = -s.thumb.source_obj.rotation_quaternion.to_euler("ZYX").z
        m_curr = -s.middle.source_obj.rotation_quaternion.to_euler("ZYX").z
        i_curr = -s.index.source_obj.rotation_quaternion.to_euler("ZYX").z
        r_curr = -s.ring.source_obj.rotation_quaternion.to_euler("ZYX").z
        l_curr = -s.little.source_obj.rotation_quaternion.to_euler("ZYX").z

        m_curl = s.middle.curl_proj_obj.rotation_quaternion.to_euler("ZYX").x
        i_curl = s.index.curl_proj_obj.rotation_quaternion.to_euler("ZYX").x
        r_curl = s.ring.curl_proj_obj.rotation_quaternion.to_euler("ZYX").x
        l_curl = s.little.curl_proj_obj.rotation_quaternion.to_euler("ZYX").x

        m_m = (m_curl + abs(s.middle.curl_min_rad)) / (
            abs(s.middle.curl_min_rad) + abs(s.middle.curl_max_rad)
        )
        i_m = (i_curl + abs(s.index.curl_min_rad)) / (
            abs(s.index.curl_min_rad) + abs(s.index.curl_max_rad)
        )
        r_m = (r_curl + abs(s.ring.curl_min_rad)) / (
            abs(s.ring.curl_min_rad) + abs(s.ring.curl_max_rad)
        )
        l_m = (l_curl + abs(s.little.curl_min_rad)) / (
            abs(s.little.curl_min_rad) + abs(s.little.curl_max_rad)
        )

        a_im = min(1.0, angle_diff(m_curl, i_curl) / s.flex_clearance)
        a_mr = min(1.0, angle_diff(m_curl, r_curl) / s.flex_clearance)
        a_rl = min(1.0, angle_diff(r_curl, l_curl) / s.flex_clearance)

        if self._abd_params is None:
            # Initial pass.
            m_min = s.abduction_dt.mr
            m_max = -s.abduction_dt.im
        else:
            # ith path, i > 0.
            m_min = lerp(r_curr, s.abduction_dt.mr, a_mr)
            m_max = lerp(i_curr, -s.abduction_dt.im, a_im)

        i_min = lerp(m_curr, s.abduction_dt.mr, a_im)
        i_max = -s.abduction_dt.im

        if self._abd_params is None:
            # Initial pass.
            r_min = s.abduction_dt.mr
        else:
            # ith path, i > 0.
            r_min = lerp(l_curr, s.abduction_dt.mr, a_rl)
        r_max = lerp(m_curr, -s.abduction_dt.im, a_mr)

        l_min = s.abduction_dt.ml
        l_max = lerp(
            r_curr,
            -s.abduction_dt.im,  # Just the same angle it seems.
            a_rl,
        )

        # Abduction ranges depend on the current corresponding curl + quadratic
        # ease-out for index and little fingers that are on the outside.
        i_min *= i_m * (2 - i_m)
        i_max *= i_m * (2 - i_m)
        m_min *= m_m
        m_max *= m_m
        r_min *= r_m
        r_max *= r_m
        l_min *= l_m * (2 - l_m)
        l_max *= l_m * (2 - l_m)

        t_min = wrap_angle(math.radians(-90))
        t_max = wrap_angle(math.radians(90))

        if i_min < i_max:
            i_curr_c = clamp(i_curr, i_min, i_max)
        else:
            i_curr_c = clamp(i_curr, i_max, i_min)
        if m_min < m_max:
            m_curr_c = clamp(m_curr, m_min, m_max)
        else:
            m_curr_c = clamp(m_curr, m_max, m_min)
        if r_min < r_max:
            r_curr_c = clamp(r_curr, r_min, r_max)
        else:
            r_curr_c = clamp(r_curr, r_max, r_min)
        if l_min < l_max:
            l_curr_c = clamp(l_curr, l_min, l_max)
        else:
            l_curr_c = clamp(l_curr, l_max, l_min)
        if t_min < t_max:
            t_curr_c = clamp(t_curr, t_min, t_max)
        else:
            t_curr_c = clamp(t_curr, t_max, t_min)

        self._abd_params = AbductionParams(
            thumb=FingerAbductionParams(
                curr=t_curr, curr_clamped=t_curr_c, min=t_min, max=t_max
            ),
            index=FingerAbductionParams(
                curr=i_curr, curr_clamped=i_curr_c, min=i_min, max=i_max
            ),
            middle=FingerAbductionParams(
                curr=m_curr, curr_clamped=m_curr_c, min=m_min, max=m_max
            ),
            ring=FingerAbductionParams(
                curr=r_curr, curr_clamped=r_curr_c, min=r_min, max=r_max
            ),
            little=FingerAbductionParams(
                curr=l_curr, curr_clamped=l_curr_c, min=l_min, max=l_max
            ),
        )

    def _solve_finger(
        self, s: FingerProjection, abd_params: FingerAbductionParams
    ) -> None:
        src_obj = s.source_obj
        p_obj = s.twist_proj_obj
        curl_p_obj = s.curl_proj_obj
        t_obj = s.target_obj
        splay_min_obj = s.splay_min_vec_obj
        splay_max_obj = s.splay_max_vec_obj
        splay_obj = s.splay_vec_obj

        q = src_obj.rotation_quaternion
        p_q = p_obj.rotation_quaternion

        q_z_onto_y = mathutils.Quaternion((0, 1, 0), abd_params.curr)
        q_90x = mathutils.Quaternion((1, 0, 0), -math.pi / 2)

        q_min_l = mathutils.Quaternion((0, 1, 0), abd_params.min)
        q_max_l = mathutils.Quaternion((0, 1, 0), abd_params.max)

        splay_min_q = p_q @ q_90x @ q_min_l
        splay_max_q = p_q @ q_90x @ q_max_l
        splay_q = p_q @ q_90x @ q_z_onto_y

        splay_v = mathutils.Vector((0, 0, 1))
        splay_v.rotate(p_q)

        splay_min_obj.location = p_obj.location + splay_v
        splay_max_obj.location = p_obj.location + splay_v
        splay_obj.location = p_obj.location + splay_v
        splay_min_obj.rotation_quaternion = splay_min_q
        splay_max_obj.rotation_quaternion = splay_max_q
        splay_obj.rotation_quaternion = splay_q

        forward = src_obj.rotation_quaternion @ mathutils.Vector((0, 0, 1))
        if forward.length > 1e-6:
            forward.normalize()

            # Angle from global Z toward global Y, in the YZ plane.
            angle_zy = math.atan2(forward.y, forward.z)
            q_swing = mathutils.Quaternion((1, 0, 0), -angle_zy)
            p_obj.rotation_quaternion = q_swing

            curl_rad = wrap_angle(-angle_zy)
            closest_curl_lim = min(
                "curl_min_rad",
                "curl_max_rad",
                key=lambda lim: angle_diff(curl_rad, getattr(s, lim)),
            )

            if not (s.curl_min_rad <= curl_rad <= s.curl_max_rad):
                curl_rad = getattr(s, closest_curl_lim)

            q_curl = mathutils.Quaternion((1, 0, 0), curl_rad)
            curl_p_obj.rotation_quaternion = q_curl

            q_abd = mathutils.Quaternion((0, 0, 1), -abd_params.curr_clamped)

            # q_target = q_swing
            q_target = q_curl @ q_abd

            # q_current = t_obj.rotation_quaternion
            # if q_current.dot(q_target) < 0.0:
            #     q_target.negate()

            w = 0.02
            # t_obj.rotation_quaternion = q_current.slerp(q_target, w)

            ideal_offset = q.inverted() @ q_target
            s.q_offset = s.q_offset.slerp(ideal_offset, w)
            t_obj.rotation_quaternion = q @ s.q_offset

    @override
    def modal(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        if event.type == "TIMER":
            self._solve_4finger()

        elif event.type in {"RIGHTMOUSE"}:
            self.cleanup(context)
            self.report({"INFO"}, "Serial connection closed.")
            return {"FINISHED"}

        return {"PASS_THROUGH"}

    @override
    def invoke(
        self, context: bpy.types.Context, event: bpy.types.Event
    ) -> set[OperatorReturnItems]:
        _ = event  # Unused.

        wm = context.window_manager
        if wm is None:
            return {"CANCELLED"}

        self._projection_system = self._make_projection_system(context)
        self._abd_params = None

        self._timer = wm.event_timer_add(0.02, window=context.window)
        wm.modal_handler_add(self)

        return {"RUNNING_MODAL"}

    def cleanup(self, context: bpy.types.Context) -> None:
        if self._timer is not None:
            wm = context.window_manager
            if wm is not None:
                wm.event_timer_remove(self._timer)
        self.report({"INFO"}, "Done.")


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
    SERIAL_PORT = "/dev/ttyACM0"
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


class SerialForwardKinematicModal(
    ABCSerialDataModal,
    ForwardKinematicModal,
):
    bl_idname = "object.imu_forward_kinematic_modal"
    bl_label = "IMU Forward Kinematic Solution"

    @override
    def on_data(self, data: bytearray) -> None:
        sensor_id, values_data = data.split(b":", 1)
        values = list(map(float, values_data.split(b",")))

        obj = self._sensor_object_map[bytes(sensor_id)]
        obj.rotation_mode = "QUATERNION"
        q_raw = mathutils.Quaternion(values[:4])
        loc_raw = mathutils.Vector(values[4:])

        obj.rotation_quaternion = q_raw
        obj.location = loc_raw

        self._solve_4finger()

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

        if len(values) < 4 + 3:
            return "INCOMPLETE"
        elif len(values) > 4 + 3:
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
        self._p2_little = bpy.data.objects["2_little"]
        self._p2_thumb = bpy.data.objects["2_thumb"]

        self._sensor_object_map = {
            b"0": self._p1_palm,
            b"2": self._p2_index,
            b"3": self._p2_middle,
            b"1": self._p2_thumb,
            b"4": self._p2_ring,
            b"5": self._p2_little,
        }

        self._projection_system = self._make_projection_system(context)
        self._abd_params = None

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
