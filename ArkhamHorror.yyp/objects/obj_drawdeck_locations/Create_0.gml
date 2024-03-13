/// @desc	Set Model and View


model = new DrawDeckModel(
	global.campaigns_data[$ global.campaign_curr].get_current_scenario().locations,
	false
);

view = new DrawDeckView(
	obj_card_location,
	sprite_get_width(sprite_index),
	sprite_get_height(sprite_index),
	global.direction_x.same,
	global.direction_y.below,
	120
);


event_inherited();