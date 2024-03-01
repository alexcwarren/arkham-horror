/// @desc	Set Model and View


model = new DrawDeckModel(global.player_decks[$ global.investigator_curr]);
model.shuffle();


var _width = sprite_get_width(sprite_index);
var _height = sprite_get_height(sprite_index);

view = new DrawDeckView(
	obj_card_player,
	_width,
	_height,
	global.direction_x.same,
	global.direction_y.above,
	10,
	true,
	global.direction_x.right,
	global.direction_y.same
);


event_inherited();