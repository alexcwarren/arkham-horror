// @func	load_player_data()
// @desc	Load all player data.
function load_player_data() {
	global.investigators = {
		roland: "roland",
		wendy: "wendy",
	};
	global.investigator_curr = global.investigators.roland;
	
	
	global.investigator_cards = {};
	struct_set(
		global.investigator_cards,
		global.investigators.roland,
		[
			global.card_ids.roland_front,
			global.card_ids.roland_back
		]
	);
	
	
	global.player_decks = {};
	struct_set(
		global.player_decks,
		global.investigators.roland,
		// Roland's deck:
		[
			global.card_ids.rolands_38_special,
			global.card_ids.cover_up,
			global.card_ids._45_automatic,
			global.card_ids.physical_training,
			global.card_ids.beat_cop,
			global.card_ids.first_aid,
			global.card_ids.machete,
			global.card_ids.guard_dog,
			global.card_ids.evidence,
			global.card_ids.dodge,
			global.card_ids.dynamite_blast,
			global.card_ids.vicious_blow,
			global.card_ids.magnifying_glass,
			global.card_ids.old_book_of_lore,
			global.card_ids.research_librarian,
			global.card_ids.dr_milan_christopher,
			global.card_ids.hyperawareness,
			global.card_ids.medical_texts,
			global.card_ids.mind_over_matter,
			global.card_ids.working_a_hunch,
			global.card_ids.barricade,
			global.card_ids.deduction,
			global.card_ids.knife,
			global.card_ids.knife,
			global.card_ids.flashlight,
			global.card_ids.flashlight,
			global.card_ids.emergency_cache,
			global.card_ids.emergency_cache,
			global.card_ids.guts,
			global.card_ids.guts,
			global.card_ids.manual_dexterity,
			global.card_ids.manual_dexterity,
			global.card_ids.paranoia,
		]
	);
}