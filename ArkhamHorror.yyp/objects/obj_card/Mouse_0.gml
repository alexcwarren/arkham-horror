/// @desc	Check additional card actions


if (is_moveable) {
	if (view.can_rotate() && keyboard_check_pressed(vk_space)) {
		view.rotate();
	}

	if (model.can_shuffle_back() && keyboard_check_pressed(vk_home)) {
		 view.get_deck_object().model.shuffle_back(view.get_card_id());
		 instance_destroy(self);
	}
}


event_inherited();