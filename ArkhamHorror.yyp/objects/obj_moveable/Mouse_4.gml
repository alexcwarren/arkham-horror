/// @desc	Check movement


if (!global.is_object_active) {
	var _do_move = true;
	
	//var _overlapping_insts = ds_list_create();
	//instance_place_list(mouse_x, mouse_y, obj_moveable, _overlapping_insts, false);

	//if (!ds_list_empty(_overlapping_insts)) {
	//	for (var _i = 0; _i < ds_list_size(_overlapping_insts); ++_i) {
	//		var _inst = _overlapping_insts[| _i];
		
	//		if (global.draw_order_mgr.get_depth(_inst) < depth) {
	//			_do_move = false;
	//			break;
	//		}
	//	}
	//}
	
	if (_do_move) {
		depth = 0;
		is_moveable = true;
		global.is_object_active = true;
	}
}

//global.is_object_active = true;