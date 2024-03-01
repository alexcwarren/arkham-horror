start();

/// @func	start()
/// @desc	Start the game.
function start() {
	load_debug_settings();
	
	global.difficulties = {
		easy: "easy",
		standard: "standard",
		hard: "hard",
		expert: "expert",
	};
	global.difficulty = global.difficulties.easy;
	
	
	global.starting_counts = {
		"resources": 5,
		"health": 9,
		"sanity": 5,
		"actions": 3,
	};
	
	
	global.is_object_active = false;
	
	load_card_data();
	load_player_data();
	load_campaign_data();
	
	global.player_drawdeck_curr = obj_drawdeck_player;
	
	randomize();
}