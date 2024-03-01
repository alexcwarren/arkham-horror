global.direction_x = {
	same: 0,
	left: -1,
	right: 1
};

global.direction_y = {
	same: 0,
	above: -1,
	below: 1
};


/// @func	Deck()
/// @desc	Data structure for models of drawdeck objects.
/// @arg	{Array<Real>}	_array_card_ids
function Deck(_array_card_ids = []) constructor {
	__stack = _array_card_ids;
	
	/// @func	is_empty()
	/// @desc	Return true if no cards in deck.
	/// @return {Bool}
	is_empty = function() {
		return array_length(__stack) == 0;
	}
	
	/// @func	add(_card_id)
	/// @desc	Add a card to top of the deck.
	/// @arg	{Real}	_card_id
	add = function(_card_id) {
		array_insert(__stack, 0, _card_id);
	}
	
	/// @func	get_top_card_id()
	/// @desc	Return the ID for the top card in the deck.
	/// @return	{Real}
	get_top_card_id = function() {
		return __stack[0];
	}
	
	/// @func	draw_card()
	/// @desc	Draw the top card from this deck and return its ID.
	/// @return	{Real}
	draw_card = function() {
		var _removed_card = get_top_card_id();
		array_delete(__stack, 0, 1);
		return _removed_card;
	}
}


/// @func	DrawDeckModel()
/// @desc	Model for drawdeck objects.
function DrawDeckModel(_array_card_ids, _has_discard=true) : Deck(_array_card_ids) constructor {
	__has_discard = _has_discard;
	__discard = new Deck();
	
	/// @func	shuffle()
	/// @desc	Shuffle the cards in this drawdeck.
	shuffle = function() {
		__stack = array_shuffle(__stack);
	}
	
	/// @func	shuffle_back(_card_id)
	/// @desc	Add the card to the drawdeck then shuffle the drawdeck.
	/// @arg	{Real}	_card_id
	shuffle_back = function(_card_id) {
		add(_card_id);
		self.shuffle();
	}
	
	/// @func	get_discard_pile()
	/// @desc	Return this drawdeck's discard pile instance.
	/// @return	{Struct}
	get_discard_pile = function() {
		return __discard;
	}
	
	/// @func	has_discard()
	/// @desc	Return true if this drawdeck has a discard pile.
	/// @return	{Bool}
	has_discard = function() {
		return __has_discard;
	}
	
	/// @func	discard_card(_card_id)
	/// @desc	Add the given card to this drawdeck's discard pile.
	/// @arg	{Real}	_card_id
	discard_card = function(_card_id) {
		//if (__has_discard) {
			__discard.add(_card_id);
		//}
	}
}


/// @func	DrawDeckView()
/// @desc	View for drawdeck objects.
/// @arg	{Asset.GMObject}	_card_obj		The card object that this deck is comprised of.
/// @arg	{Real}				_sprite_width	Width of drawdeck's sprite.
/// @arg	{Real}				_sprite_height	Height of drawdeck's sprite.
/// @arg	{Struct.Real}		_drawn_dir_x	Horizontal drawn card placement (value from global.drawn_direction_x).
/// @arg	{Struct.Real}		_drawn_dir_y	Vertical drawn card placement (value from global.drawn_direction_y).
/// @arg	{Real}				_offset			How many pixels to offset the discard pile (x and y direction).
/// @arg	{Bool}				_use_smalls		(Optional) Defaults to true. Whether to use regular or small sprites.
/// @arg	{Struct.Real}		_discard_dir_x	(Optional) Horizontal discard placement (value from global.drawn_direction_x).
/// @arg	{Struct.Real}		_discard_dir_y	(Optional) Vertical discard placement (value from global.drawn_direction_y).
function DrawDeckView(
	_card_obj,
	_sprite_width,
	_sprite_height,
	_drawn_dir_x,
	_drawn_dir_y,
	_offset,
	_use_smalls=true,
	_discard_dir_x=undefined,
	_discard_dir_y=undefined
) constructor {
	__card_obj = _card_obj;
	__width = _sprite_width;
	__height = _sprite_height;
	__drawn_x_direction = _drawn_dir_x;
	__drawn_y_direction = _drawn_dir_y;
	__offset = _offset;
	__use_smalls = _use_smalls;
	__discard_x_direction = _discard_dir_x;
	__discard_y_direction = _discard_dir_y;
	
	__card_drawn_not_moved = false;
	__is_overlapped = false;
	
	/// @func	get_use_smalls()
	/// @desc	Return true if this drawdeck uses small sprites.
	/// @return	{Bool}
	get_use_smalls = function() {
		return __use_smalls;
	}
	
	/// @func	drawn_card_x()
	/// @desc	Return x coordinate offset for a card drawn from this drawdeck.
	/// @return	{Real}
	drawn_card_offset_x = function() {
		return __drawn_x_direction * (__width + __offset);
	}
	
	/// @func	drawn_card_y()
	/// @desc	Return y coordinate offset for a card drawn from this drawdeck.
	/// @return	{Real}
	drawn_card_offset_y = function() {
		return __drawn_y_direction * (__height + __offset);
	}
	
	/// @func	drawn_card_x()
	/// @desc	Return x coordinate offset for a card drawn from this drawdeck.
	/// @return	{Real}
	discard_offset_x = function() {
		if (!is_undefined(__discard_x_direction)) {
			return __discard_x_direction * (__width + __offset);
		}
	}
	
	/// @func	drawn_card_y()
	/// @desc	Return y coordinate offset for a card drawn from this drawdeck.
	/// @return	{Real}
	discard_offset_y = function() {
		if (!is_undefined(__discard_y_direction)) {
			return __discard_y_direction * (__height + __offset);
		}
	}
	
	/// @func	get_card_obj()
	/// @desc	Return the card object.
	get_card_obj = function() {
		return __card_obj;
	}
}