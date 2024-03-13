/// @desc	


/// @func	draw_card_from_deck(_num_cards)
/// @desc	Draw a given number of cards from the deck.
/// @arg	{Real}	_num_cards	(Optional) Defaults to 1.
draw_card_from_deck = function(_num_cards=1) {
	print_log_message(
		string("{0}.draw_card()\n", object_get_name(self.object_index)),
		DEBUG_LEVEL.TRACE
	);
	
	if (model.is_empty())
	{
		show_debug_message("No cards left in " + object_get_name(self.object_index));
		return;
	}
	
	for (var _i = 0; _i < _num_cards; ++_i)
	{
		// model
		var _drawn_card_id = model.draw_card();
		
		//// view
		var _x = x + view.drawn_card_offset_x();
		var _y = y + view.drawn_card_offset_y();
		//var _depth = 200 + _i;
		//var _card_inst = instance_create_depth(_x, _y, _depth, view.get_card_obj());
		var _card_inst = instance_create_layer(_x, _y, "CardInstances", view.get_card_obj());
		_card_inst.view.set_card_id(_drawn_card_id);
		//_card_inst.view.set_depth(_depth);
	}
}


/// @func	draw_discard()
/// @desc	Draw this deck's discard.
draw_discard = function() {
	var _card_id = model.get_discard_pile().get_top_card_id();
	var _x = x + view.discard_offset_x();
	var _y = y + view.discard_offset_y();
	var _sprite = get_card_sprite(_card_id, view.get_use_smalls());
	draw_sprite(_sprite, -1, _x, _y);
}


event_inherited();