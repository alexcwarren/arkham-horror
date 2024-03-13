/// @desc	Set Model and View


model = new DrawDeckModel(
	global.campaigns_data[$ global.campaign_curr].get_current_scenario().encounters
);
model.shuffle();

view = new DrawDeckView(
	obj_card_encounter,
	sprite_get_width(sprite_index),
	sprite_get_height(sprite_index),
	global.direction_x.same,
	global.direction_y.below,
	10,
	true,
	global.direction_x.left,
	global.direction_y.same
);


event_inherited();