/// @desc	Discard card


if (!global.is_object_active && view.get_deck_object().model.has_discard()) {
	discard_card();
}


event_inherited();