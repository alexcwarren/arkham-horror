/// @desc	Set Model and View


model = new FlipDeckModel(
	global.campaigns_data[$ global.campaign_curr].get_current_scenario().acts
);

view = new FlipDeckView(true, model.get_top_card_id());


event_inherited();