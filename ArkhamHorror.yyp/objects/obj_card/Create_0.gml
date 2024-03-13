/// @desc	


// Allow card to create itself before being able to move
is_moveable = false;


/// @func	discard_card()
/// @desc	Discard this card to its deck's discard pile.
discard_card = function() {
	view.get_deck_object().model.discard_card(view.get_card_id());
	global.draw_order_mgr.remove(id);
	instance_destroy(self);
}


event_inherited();