/// @desc	Set Model and View


model = new DrawDeckModel(
	global.campaigns_data[$ global.campaign_curr].get_current_scenario().extras,
	false
);

view = new DrawDeckView(
	obj_card_extra,
	sprite_get_width(sprite_index),
	sprite_get_height(sprite_index),
	global.direction_x.right,
	global.direction_y.same,
	40
);


event_inherited();