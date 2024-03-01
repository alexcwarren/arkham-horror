/// @func	move_instance(_inst)
/// @desc	Move the given instance with the mouse.
/// @arg	{Id.Instance}	_inst
function move_instance(_inst) {
	_inst.x = clamp(mouse_x, 0, window_get_width());
	_inst.y = clamp(mouse_y, 0, window_get_width());
}


/// @func	check_object_boundaries(_obj_inst)
/// @desc	Provide boundary information on given instance.
/// @arg	{Id.Instance}	_obj_inst
function check_object_boundaries(_obj_inst) {
	var _x = _obj_inst.x;
	var _y = _obj_inst.y;
	var _w = sprite_get_width(_obj_inst.sprite_index) / 2.0;
	var _h = sprite_get_height(_obj_inst.sprite_index) / 2.0;
	
	show_debug_message("\n");
	show_debug_message_ext("{0}x{1}", [_w, _h]);
	show_debug_message_ext(
		"x: {0} --> {1}   y: {2} --> {3}",
		[_x - _w / 2.0, _x + _w / 2.0, _y - _h / 2.0, _y + _h / 2.0]
	);
	show_debug_message_ext("mouse = x: {0}    y: {1}", [mouse_x, mouse_y]);
	show_debug_message("\n");
}