enum ROTATED_STATE {
	UPRIGHT,
	ROTATED
}


/// @func	CardModel()
/// @desc	Model for card objects.
/// @arg	{Bool}	_can_shuffle_back
function CardModel(_can_shuffle_back) constructor {
	//__deck_obj = _deck_obj;
	__can_shuffle_back = _can_shuffle_back;
	__is_exhausted = false;
	
	///// @func	get_deck_object()
	///// @desc	Return this card's deck object.
	///// @return	{Asset.GMObject}
	//get_deck_object = function() {
	//	return __deck_obj;
	//}
	
	/// @func	can_shuffle_back()
	/// @desc	Return if card can be shuffled back to its deck.
	/// @return	{Bool}
	can_shuffle_back = function() {
		return __can_shuffle_back;
	}
};


/// @func	CardView(_deck_obj, _use_smalls, _can_rotate, _card_id)
/// @desc	View struct for card objects.
/// @arg	{Asset.GMObject}	_deck_obj	Deck object this card belongs to.
/// @arg	{Bool}				_use_smalls	Whether this card uses small sprites.
/// @arg	{Bool}				_can_rotate	Whether this card can be rotated.
/// @arg	{Real}				_card_id	(Optional) Defaults to 0. The unique ID integer value of the card sprite.
function CardView(_deck_obj, _use_smalls, _can_rotate, _card_id=0) constructor {
	__deck_obj = _deck_obj;
	__use_smalls = _use_smalls;
	__can_rotate = _can_rotate;
	__card_id = _card_id;
	
	__rotated_state = ROTATED_STATE.UPRIGHT;
	
	/// @func	get_deck_object()
	/// @desc	Return this card's deck object.
	/// @return	{Asset.GMObject}
	get_deck_object = function() {
		return __deck_obj;
	}
	
	/// @func	get_use_smalls()
	/// @desc	Return if this card uses small sprites.
	/// @return	{Bool}
	get_use_smalls = function() {
		return __use_smalls;
	}
	
	/// @func	set_card_id(_card_id)
	/// @desc	Set this card's card_id.
	/// @arg	{Real}	_card_id	The unique ID integer value of the card sprite.
	set_card_id = function(_card_id) {
		self.__card_id = _card_id;
	}
	
	/// @func	get_card_id()
	/// @desc	Get this card's card_id.
	/// @return	{Real}
	get_card_id = function() {
		return __card_id;
	}
	
	/// @func	can_rotate()
	/// @desc	Check if this card object is allowed to rotate.
	/// @return	{Bool}
	can_rotate = function() {
		return __can_rotate;
	}
	
	/// @func	get_rotated_state()
	/// @desc	Return the state of this card's rotation (in degrees).
	/// @return	{Real}
	get_rotated_state = function() {
		if (__rotated_state == ROTATED_STATE.UPRIGHT) {
			return 0;
		}
		else {
			return -90;
		}
	}
	
	/// @func	rotate()
	/// @desc	Toggle this card's rotated state.
	rotate = function() {
		if (__can_rotate) {
			if (__rotated_state == ROTATED_STATE.UPRIGHT) {
				__rotated_state = ROTATED_STATE.ROTATED;
			}
			else {
				__rotated_state = ROTATED_STATE.UPRIGHT;
			}
		}
	}
};


/// @func	draw_card_sprite(_card_inst)
/// @desc	Retrieve the given card's sprite and draw it.
/// @arg	{Id.Instance}	_card_inst
function draw_card_sprite(_card_inst) {
	print_log_message(
		string("{0}.draw_card_sprite()\n", object_get_name(_card_inst.object_index)),
		DEBUG_LEVEL.TRACE
	);
	
	var _card_id = _card_inst.view.get_card_id();
	var _use_smalls = _card_inst.view.get_use_smalls();
	var _sprite = get_card_sprite(_card_id, _use_smalls);
	_card_inst.sprite_index = _sprite;
	draw_sprite_ext(
		_card_inst.sprite_index,
		-1,
		_card_inst.x,
		_card_inst.y,
		1,
		1,
		_card_inst.view.get_rotated_state(),
		-1,
		1
	);
}