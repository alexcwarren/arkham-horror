/// @desc	Set Model and View


model = new FlipDeckModel(global.investigator_cards[$ global.investigator_curr]);

view = new FlipDeckView(false, model.get_top_card_id());


event_inherited();