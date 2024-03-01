/// @desc	Check/Reset movement

if (is_moveable) {
	if (mouse_check_button(mb_left)) {
		move_instance(self);
	}
	if (mouse_check_button_released(mb_left)) {
		is_moveable = false;
	}
}

if (mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right)) {
	global.is_object_active = false;
}

event_inherited();