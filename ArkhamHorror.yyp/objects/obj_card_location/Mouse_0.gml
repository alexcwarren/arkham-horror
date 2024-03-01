/// @desc	Move / Discard


if (is_moveable) {
	
	// Move player mini to location
	if (keyboard_check_pressed(vk_space)) {
		global.mini.x = x;
		global.mini.y = y - sprite_get_height(global.mini.sprite_index);
	}

	// Discard card
	if (keyboard_check_pressed(vk_backspace)) {
		discard_card();
	}
}


event_inherited();