/// @func	FlipDeckCard
/// @desc	Data structure for models of flipdeck objects.
/// @arg	{Real}		_card_id
/// @arg	{Struct}	_prev_card	(Optional).
/// @arg	{Struct}	_next_card	(Optional).
function FlipDeckCard(_card_id, _prev_card = undefined, _next_card = undefined) constructor {
	card_id = _card_id;
	prev_card = _prev_card;
	next_card = _next_card;
}


/// @func	FlipDeckModel()
/// @desc	Model for flipdeck objects.
/// @arg	{Array.Real}	_array_card_ids
function FlipDeckModel(_array_card_ids) constructor {
	_top_card = new FlipDeckCard(_array_card_ids[0]);
	
	var _curr_card = _top_card;
	for (var _i = 1; _i < array_length(_array_card_ids); ++_i) {
		var _next_id = _array_card_ids[_i];
		var _next_card = new FlipDeckCard(_next_id, _curr_card);
		_curr_card.next_card = _next_card;
		_curr_card = _next_card;
	}
	_curr_card.next_card = _top_card
	_top_card.prev_card = _curr_card;
	
	static next_card = function() {
		_top_card = _top_card.next_card;
		return get_top_card_id();
	}
	
	static prev_card = function() {
		_top_card = _top_card.prev_card;
		return get_top_card_id();
	}
	
	static get_top_card_id = function()
	{
		return _top_card.card_id;
	}
}


/// @func	FlipDeckView(_card_id)
/// @desc	View for flipdeck objects.
/// @arg	{Bool}	_use_smalls
/// @arg	{Real}	_card_id
function FlipDeckView(_use_smalls, _card_id) : CardView(undefined, _use_smalls, false, _card_id) constructor {
}