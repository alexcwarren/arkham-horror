/// @desc	Flip card


if (!global.is_object_active) {
	view.set_card_id(get_reverse_id(view.get_card_id()));
}


event_inherited();