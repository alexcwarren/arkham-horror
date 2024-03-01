/// @func	Card(_sprite, _sprite_small, _reverse_id)
/// @desc	Data structure for card objects.
function Card(_sprite, _sprite_small=undefined, _reverse_id=0) constructor {
	sprite = _sprite;
	
	sprite_small = _sprite_small;
	if (is_undefined(sprite_small)) {
		sprite_small = spr_empty_card_h_small;
	}
	
	reverse_id = _reverse_id;
}


/// @func	load_card_data()
/// @desc	Load all card data.
function load_card_data() {
	global.card_ids = {
		_32_colt: 1,
		_41_derringer: 2,
		_45_automatic: 3,
		abandoned_and_alone: 4,
		acolyte: 5,
		amnesia: 6,
		ancient_evils: 7,
		aquinnah_1: 8,
		arkham_woods_1_revealed: 9,
		arkham_woods_2_revealed: 10,
		arkham_woods_3_revealed: 11,
		arkham_woods_4_revealed: 12,
		arkham_woods_5_revealed: 13,
		arkham_woods_6_revealed: 14,
		arkham_woods_unrevealed: 15,
		attic_revealed: 16,
		attic_unrevealed: 17,
		backstab: 18,
		back_encounter_card: 19,
		back_player_card: 20,
		barricade: 21,
		baseball_bat: 22,
		beat_cop: 23,
		beat_cop_2: 24,
		burglary: 25,
		cat_burglar_1: 26,
		cellar_revealed: 27,
		cellar_unrevealed: 28,
		close_call_2: 29,
		counter_chaos_bag: 30,
		counter_default: 31,
		counter_doom: 32,
		counter_down: 33,
		counter_health: 34,
		counter_resources: 35,
		counter_sanity: 36,
		counter_up: 37,
		cover_up: 38,
		crypt_chill: 39,
		cunning_distraction: 40,
		daring: 41,
		deduction: 42,
		dig_deep: 43,
		disc_of_itzamna_2: 44,
		dissonant_voices: 45,
		dodge: 46,
		downtown_revealed1: 47,
		downtown_revealed2: 48,
		downtown_unrevealed: 49,
		dreams_of_rlyeh: 50,
		dr_milan_christopher: 51,
		dynamite_blast: 52,
		easttown_revealed: 53,
		easttown_unrevealed: 54,
		eat_lead: 55,
		elusive: 56,
		emergency_aid: 57,
		emergency_cache: 58,
		empty_card_h: 59,
		empty_card_v: 60,
		encyclopedia_2: 61,
		evidence: 62,
		extra_ammunition_1: 63,
		false_lead: 64,
		first_aid: 65,
		first_watch: 66,
		flashlight: 67,
		flesh_eater: 68,
		frozen_in_fear: 69,
		ghoul_minion: 70,
		ghoul_priest: 71,
		goat_spawn: 72,
		grasping_hands: 73,
		graveyard_revealed: 74,
		graveyard_unrevealed: 75,
		guard_dog: 76,
		guts: 77,
		hallway_revealed: 78,
		hallway_unrevealed: 79,
		hard_knocks: 80,
		herman_collins: 81,
		hot_streak_4: 82,
		hunting_nightgaunt: 83,
		hunting_shadow: 84,
		hyperawareness: 85,
		icy_ghoul: 86,
		intrepid: 87,
		knife: 88,
		leather_coat: 89,
		leo_de_luca: 90,
		leo_de_luca_1: 91,
		lita_chantler: 92,
		locked_door: 93,
		look_what_i_found: 94,
		lucky: 95,
		lucky_2: 96,
		machete: 97,
		magnifying_glass: 98,
		magnifying_glass_1: 99,
		main_path_revealed: 100,
		main_path_unrevealed: 101,
		manual_dexterity: 102,
		medical_texts: 103,
		mind_over_matter: 104,
		miskatonic_university_revealed: 105,
		miskatonic_university_unrevealed: 106,
		mysterious_chanting: 107,
		northside_revealed: 108,
		northside_unrevealed: 109,
		obscuring_fog: 110,
		offer_of_power: 111,
		old_book_of_lore: 112,
		on_wings_of_darkness: 113,
		opportunist: 114,
		overpower: 115,
		paranoia: 116,
		parlor_revealed: 117,
		parlor_unrevealed: 118,
		peter_warren: 119,
		physical_training: 120,
		pickpocketing: 121,
		police_badge_2: 122,
		rabbits_foot: 123,
		ravenous_ghoul: 124,
		relentless_dark_young: 125,
		research_librarian: 126,
		ritual_site_revealed: 127,
		ritual_site_unrevealed: 128,
		rivertown_revealed: 129,
		rivertown_unrevealed: 130,
		rolands_38_special: 131,
		roland_back: 132,
		roland_front: 133,
		rotting_remains: 134,
		ruth_turner: 135,
		scavenging: 136,
		scene_of_the_crime: 137,
		screeching_byakhee: 138,
		second_wind: 139,
		shotgun_4: 140,
		sneak_attack: 141,
		southside_revealed1: 142,
		southside_revealed2: 143,
		southside_unrevealed: 144,
		stray_cat: 145,
		study_revealed: 146,
		study_unrevealed: 147,
		st_marys_hospital_revealed: 148,
		st_marys_hospital_unrevealed: 149,
		sure_gamble_3: 150,
		survival_instinct: 151,
		swarm_of_rats: 152,
		switchblade: 153,
		the_devourer_below_act1a: 154,
		the_devourer_below_act1b: 155,
		the_devourer_below_act2a: 156,
		the_devourer_below_act2b: 157,
		the_devourer_below_act3a: 158,
		the_devourer_below_act3b: 159,
		the_devourer_below_agenda1a: 160,
		the_devourer_below_agenda1b: 161,
		the_devourer_below_agenda2a: 162,
		the_devourer_below_agenda2b: 163,
		the_devourer_below_agenda3a: 164,
		the_devourer_below_agenda3b: 165,
		the_devourer_below_back: 166,
		the_devourer_below_front: 167,
		the_gathering_act1a: 168,
		the_gathering_act1b: 169,
		the_gathering_act2a: 170,
		the_gathering_act2b: 171,
		the_gathering_act3a: 172,
		the_gathering_act3b: 173,
		the_gathering_agenda1a: 174,
		the_gathering_agenda1b: 175,
		the_gathering_agenda2a: 176,
		the_gathering_agenda2b: 177,
		the_gathering_agenda3a: 178,
		the_gathering_agenda3b: 179,
		the_gathering_back: 180,
		the_gathering_front: 181,
		the_masked_hunter: 182,
		the_midnight_masks_act1a: 183,
		the_midnight_masks_act1b: 184,
		the_midnight_masks_agenda1a: 185,
		the_midnight_masks_agenda2a: 186,
		the_midnight_masks_agenda2b: 187,
		the_midnight_masks_back: 188,
		the_midnight_masks_front: 189,
		the_yellow_sign: 190,
		umordhoth: 191,
		umordhoths_wrath: 192,
		unexpected_courage: 193,
		vicious_blow: 194,
		victoria_devereux: 195,
		wendys_amulet: 196,
		wendy_adams_back: 197,
		wendy_adams_front: 198,
		wendy_mini: 199,
		will_to_survive_3: 200,
		wizard_of_the_order: 201,
		wolf_man_drew: 202,
		working_a_hunch: 203,
		yithian_observer: 204,
		young_deep_one: 205,
		your_house_revealed: 206,
		your_house_unrevealed: 207,
	};

	global.card_sprites = [];
	global.card_sprites[global.card_ids._32_colt] = new Card(spr_32_colt, spr_32_colt_small);
	global.card_sprites[global.card_ids._41_derringer] = new Card(spr_41_derringer, spr_41_derringer_small);
	global.card_sprites[global.card_ids._45_automatic] = new Card(spr_45_automatic, spr_45_automatic_small);
	global.card_sprites[global.card_ids.abandoned_and_alone] = new Card(spr_abandoned_and_alone, spr_abandoned_and_alone_small);
	global.card_sprites[global.card_ids.acolyte] = new Card(spr_acolyte, spr_acolyte_small);
	global.card_sprites[global.card_ids.amnesia] = new Card(spr_amnesia, spr_amnesia_small);
	global.card_sprites[global.card_ids.ancient_evils] = new Card(spr_ancient_evils, spr_ancient_evils_small);
	global.card_sprites[global.card_ids.aquinnah_1] = new Card(spr_aquinnah_1, spr_aquinnah_1_small);
	global.card_sprites[global.card_ids.arkham_woods_1_revealed] = new Card(spr_arkham_woods_1_revealed, spr_arkham_woods_1_revealed_small, global.card_ids.arkham_woods_unrevealed);
	global.card_sprites[global.card_ids.arkham_woods_2_revealed] = new Card(spr_arkham_woods_2_revealed, spr_arkham_woods_2_revealed_small, global.card_ids.arkham_woods_unrevealed);
	global.card_sprites[global.card_ids.arkham_woods_3_revealed] = new Card(spr_arkham_woods_3_revealed, spr_arkham_woods_3_revealed_small, global.card_ids.arkham_woods_unrevealed);
	global.card_sprites[global.card_ids.arkham_woods_4_revealed] = new Card(spr_arkham_woods_4_revealed, spr_arkham_woods_4_revealed_small, global.card_ids.arkham_woods_unrevealed);
	global.card_sprites[global.card_ids.arkham_woods_5_revealed] = new Card(spr_arkham_woods_5_revealed, spr_arkham_woods_5_revealed_small, global.card_ids.arkham_woods_unrevealed);
	global.card_sprites[global.card_ids.arkham_woods_6_revealed] = new Card(spr_arkham_woods_6_revealed, spr_arkham_woods_6_revealed_small, global.card_ids.arkham_woods_unrevealed);
	
	// TODO - Maybe need more unrevealeds?
	global.card_sprites[global.card_ids.arkham_woods_unrevealed] = new Card(spr_arkham_woods_unrevealed, spr_arkham_woods_unrevealed_small, global.card_ids.arkham_woods_1_revealed);

	global.card_sprites[global.card_ids.attic_revealed] = new Card(spr_attic_revealed, spr_attic_revealed_small, global.card_ids.attic_unrevealed);
	global.card_sprites[global.card_ids.attic_unrevealed] = new Card(spr_attic_unrevealed, spr_attic_unrevealed_small, global.card_ids.attic_revealed);
	global.card_sprites[global.card_ids.backstab] = new Card(spr_backstab, spr_backstab_small);
	global.card_sprites[global.card_ids.back_encounter_card] = new Card(spr_back_encounter_card, spr_back_encounter_card_small);
	global.card_sprites[global.card_ids.back_player_card] = new Card(spr_back_player_card, spr_back_player_card_small);
	global.card_sprites[global.card_ids.barricade] = new Card(spr_barricade, spr_barricade_small);
	global.card_sprites[global.card_ids.baseball_bat] = new Card(spr_baseball_bat, spr_baseball_bat_small);
	global.card_sprites[global.card_ids.beat_cop] = new Card(spr_beat_cop, spr_beat_cop_small);
	global.card_sprites[global.card_ids.beat_cop_2] = new Card(spr_beat_cop_2, spr_beat_cop_2_small);
	global.card_sprites[global.card_ids.burglary] = new Card(spr_burglary, spr_burglary_small);
	global.card_sprites[global.card_ids.cat_burglar_1] = new Card(spr_cat_burglar_1, spr_cat_burglar_1_small);
	global.card_sprites[global.card_ids.cellar_revealed] = new Card(spr_cellar_revealed, spr_cellar_revealed_small, global.card_ids.cellar_unrevealed);
	global.card_sprites[global.card_ids.cellar_unrevealed] = new Card(spr_cellar_unrevealed, spr_cellar_unrevealed_small, global.card_ids.cellar_revealed);
	global.card_sprites[global.card_ids.close_call_2] = new Card(spr_close_call_2, spr_close_call_2_small);
	global.card_sprites[global.card_ids.counter_chaos_bag] = new Card(spr_counter_chaos_bag);
	global.card_sprites[global.card_ids.counter_default] = new Card(spr_counter_default);
	global.card_sprites[global.card_ids.counter_doom] = new Card(spr_counter_doom);
	global.card_sprites[global.card_ids.counter_down] = new Card(spr_counter_down);
	global.card_sprites[global.card_ids.counter_health] = new Card(spr_counter_health);
	global.card_sprites[global.card_ids.counter_resources] = new Card(spr_counter_resources);
	global.card_sprites[global.card_ids.counter_sanity] = new Card(spr_counter_sanity);
	global.card_sprites[global.card_ids.counter_up] = new Card(spr_counter_up);
	global.card_sprites[global.card_ids.cover_up] = new Card(spr_cover_up, spr_cover_up_small);
	global.card_sprites[global.card_ids.crypt_chill] = new Card(spr_crypt_chill, spr_crypt_chill_small);
	global.card_sprites[global.card_ids.cunning_distraction] = new Card(spr_cunning_distraction, spr_cunning_distraction_small);
	global.card_sprites[global.card_ids.daring] = new Card(spr_daring, spr_daring_small);
	global.card_sprites[global.card_ids.deduction] = new Card(spr_deduction, spr_deduction_small);
	global.card_sprites[global.card_ids.dig_deep] = new Card(spr_dig_deep, spr_dig_deep_small);
	global.card_sprites[global.card_ids.disc_of_itzamna_2] = new Card(spr_disc_of_itzamna_2, spr_disc_of_itzamna_2_small);
	global.card_sprites[global.card_ids.dissonant_voices] = new Card(spr_dissonant_voices, spr_dissonant_voices_small);
	global.card_sprites[global.card_ids.dodge] = new Card(spr_dodge, spr_dodge_small);
	global.card_sprites[global.card_ids.downtown_revealed1] = new Card(spr_downtown_revealed1, spr_downtown_revealed1_small);
	global.card_sprites[global.card_ids.downtown_revealed2] = new Card(spr_downtown_revealed2, spr_downtown_revealed2_small);
	global.card_sprites[global.card_ids.downtown_unrevealed] = new Card(spr_downtown_unrevealed, spr_downtown_unrevealed_small, global.card_ids.downtown_revealed1);
	global.card_sprites[global.card_ids.dreams_of_rlyeh] = new Card(spr_dreams_of_rlyeh, spr_dreams_of_rlyeh_small);
	global.card_sprites[global.card_ids.dr_milan_christopher] = new Card(spr_dr_milan_christopher, spr_dr_milan_christopher_small);
	global.card_sprites[global.card_ids.dynamite_blast] = new Card(spr_dynamite_blast, spr_dynamite_blast_small);
	global.card_sprites[global.card_ids.easttown_revealed] = new Card(spr_easttown_revealed, spr_easttown_revealed_small, global.card_ids.easttown_unrevealed);
	global.card_sprites[global.card_ids.easttown_unrevealed] = new Card(spr_easttown_unrevealed, spr_easttown_unrevealed_small, global.card_ids.easttown_revealed);
	global.card_sprites[global.card_ids.eat_lead] = new Card(spr_eat_lead, spr_eat_lead_small);
	global.card_sprites[global.card_ids.elusive] = new Card(spr_elusive, spr_elusive_small);
	global.card_sprites[global.card_ids.emergency_aid] = new Card(spr_emergency_aid, spr_emergency_aid_small);
	global.card_sprites[global.card_ids.emergency_cache] = new Card(spr_emergency_cache, spr_emergency_cache_small);
	global.card_sprites[global.card_ids.empty_card_h] = new Card(spr_empty_card_h, spr_empty_card_h_small);
	global.card_sprites[global.card_ids.empty_card_v] = new Card(spr_empty_card_v, spr_empty_card_v_small);
	global.card_sprites[global.card_ids.encyclopedia_2] = new Card(spr_encyclopedia_2, spr_encyclopedia_2_small);
	global.card_sprites[global.card_ids.evidence] = new Card(spr_evidence, spr_evidence_small);
	global.card_sprites[global.card_ids.extra_ammunition_1] = new Card(spr_extra_ammunition_1, spr_extra_ammunition_1_small);
	global.card_sprites[global.card_ids.false_lead] = new Card(spr_false_lead, spr_false_lead_small);
	global.card_sprites[global.card_ids.first_aid] = new Card(spr_first_aid, spr_first_aid_small);
	global.card_sprites[global.card_ids.first_watch] = new Card(spr_first_watch, spr_first_watch_small);
	global.card_sprites[global.card_ids.flashlight] = new Card(spr_flashlight, spr_flashlight_small);
	global.card_sprites[global.card_ids.flesh_eater] = new Card(spr_flesh_eater, spr_flesh_eater_small);
	global.card_sprites[global.card_ids.frozen_in_fear] = new Card(spr_frozen_in_fear, spr_frozen_in_fear_small);
	global.card_sprites[global.card_ids.ghoul_minion] = new Card(spr_ghoul_minion, spr_ghoul_minion_small);
	global.card_sprites[global.card_ids.ghoul_priest] = new Card(spr_ghoul_priest, spr_ghoul_priest_small);
	global.card_sprites[global.card_ids.goat_spawn] = new Card(spr_goat_spawn, spr_goat_spawn_small);
	global.card_sprites[global.card_ids.grasping_hands] = new Card(spr_grasping_hands, spr_grasping_hands_small);
	global.card_sprites[global.card_ids.graveyard_revealed] = new Card(spr_graveyard_revealed, spr_graveyard_revealed_small, global.card_ids.graveyard_unrevealed);
	global.card_sprites[global.card_ids.graveyard_unrevealed] = new Card(spr_graveyard_unrevealed, spr_graveyard_unrevealed_small, global.card_ids.graveyard_revealed);
	global.card_sprites[global.card_ids.guard_dog] = new Card(spr_guard_dog, spr_guard_dog_small);
	global.card_sprites[global.card_ids.guts] = new Card(spr_guts, spr_guts_small);
	global.card_sprites[global.card_ids.hallway_revealed] = new Card(spr_hallway_revealed, spr_hallway_revealed_small, global.card_ids.hallway_unrevealed);
	global.card_sprites[global.card_ids.hallway_unrevealed] = new Card(spr_hallway_unrevealed, spr_hallway_unrevealed_small, global.card_ids.hallway_revealed);
	global.card_sprites[global.card_ids.hard_knocks] = new Card(spr_hard_knocks, spr_hard_knocks_small);
	global.card_sprites[global.card_ids.herman_collins] = new Card(spr_herman_collins, spr_herman_collins_small);
	global.card_sprites[global.card_ids.hot_streak_4] = new Card(spr_hot_streak_4, spr_hot_streak_4_small);
	global.card_sprites[global.card_ids.hunting_nightgaunt] = new Card(spr_hunting_nightgaunt, spr_hunting_nightgaunt_small);
	global.card_sprites[global.card_ids.hunting_shadow] = new Card(spr_hunting_shadow, spr_hunting_shadow_small);
	global.card_sprites[global.card_ids.hyperawareness] = new Card(spr_hyperawareness, spr_hyperawareness_small);
	global.card_sprites[global.card_ids.icy_ghoul] = new Card(spr_icy_ghoul, spr_icy_ghoul_small);
	global.card_sprites[global.card_ids.intrepid] = new Card(spr_intrepid, spr_intrepid_small);
	global.card_sprites[global.card_ids.knife] = new Card(spr_knife, spr_knife_small);
	global.card_sprites[global.card_ids.leather_coat] = new Card(spr_leather_coat, spr_leather_coat_small);
	global.card_sprites[global.card_ids.leo_de_luca] = new Card(spr_leo_de_luca, spr_leo_de_luca_small);
	global.card_sprites[global.card_ids.leo_de_luca_1] = new Card(spr_leo_de_luca_1, spr_leo_de_luca_1_small);
	global.card_sprites[global.card_ids.lita_chantler] = new Card(spr_lita_chantler, spr_lita_chantler_small);
	global.card_sprites[global.card_ids.locked_door] = new Card(spr_locked_door, spr_locked_door_small);
	global.card_sprites[global.card_ids.look_what_i_found] = new Card(spr_look_what_i_found, spr_look_what_i_found_small);
	global.card_sprites[global.card_ids.lucky] = new Card(spr_lucky, spr_lucky_small);
	global.card_sprites[global.card_ids.lucky_2] = new Card(spr_lucky_2, spr_lucky_2_small);
	global.card_sprites[global.card_ids.machete] = new Card(spr_machete, spr_machete_small);
	global.card_sprites[global.card_ids.magnifying_glass] = new Card(spr_magnifying_glass, spr_magnifying_glass_small);
	global.card_sprites[global.card_ids.magnifying_glass_1] = new Card(spr_magnifying_glass_1, spr_magnifying_glass_1_small);
	global.card_sprites[global.card_ids.main_path_revealed] = new Card(spr_main_path_revealed, spr_main_path_revealed_small, global.card_ids.main_path_unrevealed);
	global.card_sprites[global.card_ids.main_path_unrevealed] = new Card(spr_main_path_unrevealed, spr_main_path_unrevealed_small, global.card_ids.main_path_revealed);
	global.card_sprites[global.card_ids.manual_dexterity] = new Card(spr_manual_dexterity, spr_manual_dexterity_small);
	global.card_sprites[global.card_ids.medical_texts] = new Card(spr_medical_texts, spr_medical_texts_small);
	global.card_sprites[global.card_ids.mind_over_matter] = new Card(spr_mind_over_matter, spr_mind_over_matter_small);
	global.card_sprites[global.card_ids.miskatonic_university_revealed] = new Card(spr_miskatonic_university_revealed, spr_miskatonic_university_revealed_small, global.card_ids.miskatonic_university_unrevealed);
	global.card_sprites[global.card_ids.miskatonic_university_unrevealed] = new Card(spr_miskatonic_university_unrevealed, spr_miskatonic_university_unrevealed_small, global.card_ids.miskatonic_university_revealed);
	global.card_sprites[global.card_ids.mysterious_chanting] = new Card(spr_mysterious_chanting, spr_mysterious_chanting_small);
	global.card_sprites[global.card_ids.northside_revealed] = new Card(spr_northside_revealed, spr_northside_revealed_small, global.card_ids.northside_unrevealed);
	global.card_sprites[global.card_ids.northside_unrevealed] = new Card(spr_northside_unrevealed, spr_northside_unrevealed_small, global.card_ids.northside_revealed);
	global.card_sprites[global.card_ids.obscuring_fog] = new Card(spr_obscuring_fog, spr_obscuring_fog_small);
	global.card_sprites[global.card_ids.offer_of_power] = new Card(spr_offer_of_power, spr_offer_of_power_small);
	global.card_sprites[global.card_ids.old_book_of_lore] = new Card(spr_old_book_of_lore, spr_old_book_of_lore_small);
	global.card_sprites[global.card_ids.on_wings_of_darkness] = new Card(spr_on_wings_of_darkness, spr_on_wings_of_darkness_small);
	global.card_sprites[global.card_ids.opportunist] = new Card(spr_opportunist, spr_opportunist_small);
	global.card_sprites[global.card_ids.overpower] = new Card(spr_overpower, spr_overpower_small);
	global.card_sprites[global.card_ids.paranoia] = new Card(spr_paranoia, spr_paranoia_small);
	global.card_sprites[global.card_ids.parlor_revealed] = new Card(spr_parlor_revealed, spr_parlor_revealed_small, global.card_ids.parlor_unrevealed);
	global.card_sprites[global.card_ids.parlor_unrevealed] = new Card(spr_parlor_unrevealed, spr_parlor_unrevealed_small, global.card_ids.parlor_revealed);
	global.card_sprites[global.card_ids.peter_warren] = new Card(spr_peter_warren, spr_peter_warren_small);
	global.card_sprites[global.card_ids.physical_training] = new Card(spr_physical_training, spr_physical_training_small);
	global.card_sprites[global.card_ids.pickpocketing] = new Card(spr_pickpocketing, spr_pickpocketing_small);
	global.card_sprites[global.card_ids.police_badge_2] = new Card(spr_police_badge_2, spr_police_badge_2_small);
	global.card_sprites[global.card_ids.rabbits_foot] = new Card(spr_rabbits_foot, spr_rabbits_foot_small);
	global.card_sprites[global.card_ids.ravenous_ghoul] = new Card(spr_ravenous_ghoul, spr_ravenous_ghoul_small);
	global.card_sprites[global.card_ids.relentless_dark_young] = new Card(spr_relentless_dark_young, spr_relentless_dark_young_small);
	global.card_sprites[global.card_ids.research_librarian] = new Card(spr_research_librarian, spr_research_librarian_small);
	global.card_sprites[global.card_ids.ritual_site_revealed] = new Card(spr_ritual_site_revealed, spr_ritual_site_revealed_small, global.card_ids.ritual_site_unrevealed);
	global.card_sprites[global.card_ids.ritual_site_unrevealed] = new Card(spr_ritual_site_unrevealed, spr_ritual_site_unrevealed_small, global.card_ids.ritual_site_revealed);
	global.card_sprites[global.card_ids.rivertown_revealed] = new Card(spr_rivertown_revealed, spr_rivertown_revealed_small, global.card_ids.rivertown_unrevealed);
	global.card_sprites[global.card_ids.rivertown_unrevealed] = new Card(spr_rivertown_unrevealed, spr_rivertown_unrevealed_small, global.card_ids.rivertown_revealed);
	global.card_sprites[global.card_ids.rolands_38_special] = new Card(spr_rolands_38_special, spr_rolands_38_special_small);
	global.card_sprites[global.card_ids.roland_back] = new Card(spr_roland_back, spr_roland_back_small);
	global.card_sprites[global.card_ids.roland_front] = new Card(spr_roland_front, spr_roland_front_small);
	global.card_sprites[global.card_ids.rotting_remains] = new Card(spr_rotting_remains, spr_rotting_remains_small);
	global.card_sprites[global.card_ids.ruth_turner] = new Card(spr_ruth_turner, spr_ruth_turner_small);
	global.card_sprites[global.card_ids.scavenging] = new Card(spr_scavenging, spr_scavenging_small);
	global.card_sprites[global.card_ids.scene_of_the_crime] = new Card(spr_scene_of_the_crime, spr_scene_of_the_crime_small);
	global.card_sprites[global.card_ids.screeching_byakhee] = new Card(spr_screeching_byakhee, spr_screeching_byakhee_small);
	global.card_sprites[global.card_ids.second_wind] = new Card(spr_second_wind, spr_second_wind_small);
	global.card_sprites[global.card_ids.shotgun_4] = new Card(spr_shotgun_4, spr_shotgun_4_small);
	global.card_sprites[global.card_ids.sneak_attack] = new Card(spr_sneak_attack, spr_sneak_attack_small);
	global.card_sprites[global.card_ids.southside_revealed1] = new Card(spr_southside_revealed1, spr_southside_revealed1_small);
	global.card_sprites[global.card_ids.southside_revealed2] = new Card(spr_southside_revealed2, spr_southside_revealed2_small);
	global.card_sprites[global.card_ids.southside_unrevealed] = new Card(spr_southside_unrevealed, spr_southside_unrevealed_small, global.card_ids.southside_revealed1);
	global.card_sprites[global.card_ids.stray_cat] = new Card(spr_stray_cat, spr_stray_cat_small);
	global.card_sprites[global.card_ids.study_revealed] = new Card(spr_study_revealed, spr_study_revealed_small, global.card_ids.study_unrevealed);
	global.card_sprites[global.card_ids.study_unrevealed] = new Card(spr_study_unrevealed, spr_study_unrevealed_small, global.card_ids.study_revealed);
	global.card_sprites[global.card_ids.st_marys_hospital_revealed] = new Card(spr_st_marys_hospital_revealed, spr_st_marys_hospital_revealed_small, global.card_ids.st_marys_hospital_unrevealed);
	global.card_sprites[global.card_ids.st_marys_hospital_unrevealed] = new Card(spr_st_marys_hospital_unrevealed, spr_st_marys_hospital_unrevealed_small, global.card_ids.st_marys_hospital_revealed);
	global.card_sprites[global.card_ids.sure_gamble_3] = new Card(spr_sure_gamble_3, spr_sure_gamble_3_small);
	global.card_sprites[global.card_ids.survival_instinct] = new Card(spr_survival_instinct, spr_survival_instinct_small);
	global.card_sprites[global.card_ids.swarm_of_rats] = new Card(spr_swarm_of_rats, spr_swarm_of_rats_small);
	global.card_sprites[global.card_ids.switchblade] = new Card(spr_switchblade, spr_switchblade_small);
	global.card_sprites[global.card_ids.the_devourer_below_act1a] = new Card(spr_the_devourer_below_act1a, spr_the_devourer_below_act1a_small);
	global.card_sprites[global.card_ids.the_devourer_below_act1b] = new Card(spr_the_devourer_below_act1b, spr_the_devourer_below_act1b_small);
	global.card_sprites[global.card_ids.the_devourer_below_act2a] = new Card(spr_the_devourer_below_act2a, spr_the_devourer_below_act2a_small);
	global.card_sprites[global.card_ids.the_devourer_below_act2b] = new Card(spr_the_devourer_below_act2b, spr_the_devourer_below_act2b_small);
	global.card_sprites[global.card_ids.the_devourer_below_act3a] = new Card(spr_the_devourer_below_act3a, spr_the_devourer_below_act3a_small);
	global.card_sprites[global.card_ids.the_devourer_below_act3b] = new Card(spr_the_devourer_below_act3b, spr_the_devourer_below_act3b_small);
	global.card_sprites[global.card_ids.the_devourer_below_agenda1a] = new Card(spr_the_devourer_below_agenda1a, spr_the_devourer_below_agenda1a_small);
	global.card_sprites[global.card_ids.the_devourer_below_agenda1b] = new Card(spr_the_devourer_below_agenda1b, spr_the_devourer_below_agenda1b_small);
	global.card_sprites[global.card_ids.the_devourer_below_agenda2a] = new Card(spr_the_devourer_below_agenda2a, spr_the_devourer_below_agenda2a_small);
	global.card_sprites[global.card_ids.the_devourer_below_agenda2b] = new Card(spr_the_devourer_below_agenda2b, spr_the_devourer_below_agenda2b_small);
	global.card_sprites[global.card_ids.the_devourer_below_agenda3a] = new Card(spr_the_devourer_below_agenda3a, spr_the_devourer_below_agenda3a_small);
	global.card_sprites[global.card_ids.the_devourer_below_agenda3b] = new Card(spr_the_devourer_below_agenda3b, spr_the_devourer_below_agenda3b_small);
	global.card_sprites[global.card_ids.the_devourer_below_back] = new Card(spr_the_devourer_below_back, spr_the_devourer_below_back_small);
	global.card_sprites[global.card_ids.the_devourer_below_front] = new Card(spr_the_devourer_below_front, spr_the_devourer_below_front_small);
	global.card_sprites[global.card_ids.the_gathering_act1a] = new Card(spr_the_gathering_act1a, spr_the_gathering_act1a_small);
	global.card_sprites[global.card_ids.the_gathering_act1b] = new Card(spr_the_gathering_act1b, spr_the_gathering_act1b_small);
	global.card_sprites[global.card_ids.the_gathering_act2a] = new Card(spr_the_gathering_act2a, spr_the_gathering_act2a_small);
	global.card_sprites[global.card_ids.the_gathering_act2b] = new Card(spr_the_gathering_act2b, spr_the_gathering_act2b_small);
	global.card_sprites[global.card_ids.the_gathering_act3a] = new Card(spr_the_gathering_act3a, spr_the_gathering_act3a_small);
	global.card_sprites[global.card_ids.the_gathering_act3b] = new Card(spr_the_gathering_act3b, spr_the_gathering_act3b_small);
	global.card_sprites[global.card_ids.the_gathering_agenda1a] = new Card(spr_the_gathering_agenda1a, spr_the_gathering_agenda1a_small);
	global.card_sprites[global.card_ids.the_gathering_agenda1b] = new Card(spr_the_gathering_agenda1b, spr_the_gathering_agenda1b_small);
	global.card_sprites[global.card_ids.the_gathering_agenda2a] = new Card(spr_the_gathering_agenda2a, spr_the_gathering_agenda2a_small);
	global.card_sprites[global.card_ids.the_gathering_agenda2b] = new Card(spr_the_gathering_agenda2b, spr_the_gathering_agenda2b_small);
	global.card_sprites[global.card_ids.the_gathering_agenda3a] = new Card(spr_the_gathering_agenda3a, spr_the_gathering_agenda3a_small);
	global.card_sprites[global.card_ids.the_gathering_agenda3b] = new Card(spr_the_gathering_agenda3b, spr_the_gathering_agenda3b_small);
	global.card_sprites[global.card_ids.the_gathering_back] = new Card(spr_the_gathering_back, spr_the_gathering_back_small);
	global.card_sprites[global.card_ids.the_gathering_front] = new Card(spr_the_gathering_front, spr_the_gathering_front_small);
	global.card_sprites[global.card_ids.the_masked_hunter] = new Card(spr_the_masked_hunter, spr_the_masked_hunter_small);
	global.card_sprites[global.card_ids.the_midnight_masks_act1a] = new Card(spr_the_midnight_masks_act1a, spr_the_midnight_masks_act1a_small);
	global.card_sprites[global.card_ids.the_midnight_masks_act1b] = new Card(spr_the_midnight_masks_act1b, spr_the_midnight_masks_act1b_small);
	global.card_sprites[global.card_ids.the_midnight_masks_agenda1a] = new Card(spr_the_midnight_masks_agenda1a, spr_the_midnight_masks_agenda1a_small);
	global.card_sprites[global.card_ids.the_midnight_masks_agenda2a] = new Card(spr_the_midnight_masks_agenda2a, spr_the_midnight_masks_agenda2a_small);
	global.card_sprites[global.card_ids.the_midnight_masks_agenda2b] = new Card(spr_the_midnight_masks_agenda2b, spr_the_midnight_masks_agenda2b_small);
	global.card_sprites[global.card_ids.the_midnight_masks_back] = new Card(spr_the_midnight_masks_back, spr_the_midnight_masks_back_small);
	global.card_sprites[global.card_ids.the_midnight_masks_front] = new Card(spr_the_midnight_masks_front, spr_the_midnight_masks_front_small);
	global.card_sprites[global.card_ids.the_yellow_sign] = new Card(spr_the_yellow_sign, spr_the_yellow_sign_small);
	global.card_sprites[global.card_ids.umordhoth] = new Card(spr_umordhoth, spr_umordhoth_small);
	global.card_sprites[global.card_ids.umordhoths_wrath] = new Card(spr_umordhoths_wrath, spr_umordhoths_wrath_small);
	global.card_sprites[global.card_ids.unexpected_courage] = new Card(spr_unexpected_courage, spr_unexpected_courage_small);
	global.card_sprites[global.card_ids.vicious_blow] = new Card(spr_vicious_blow, spr_vicious_blow_small);
	global.card_sprites[global.card_ids.victoria_devereux] = new Card(spr_victoria_devereux, spr_victoria_devereux_small);
	global.card_sprites[global.card_ids.wendys_amulet] = new Card(spr_wendys_amulet, spr_wendys_amulet_small);
	global.card_sprites[global.card_ids.wendy_adams_back] = new Card(spr_wendy_adams_back, spr_wendy_adams_back_small);
	global.card_sprites[global.card_ids.wendy_adams_front] = new Card(spr_wendy_adams_front, spr_wendy_adams_front_small);
	global.card_sprites[global.card_ids.wendy_mini] = new Card(spr_wendy_mini);
	global.card_sprites[global.card_ids.will_to_survive_3] = new Card(spr_will_to_survive_3, spr_will_to_survive_3_small);
	global.card_sprites[global.card_ids.wizard_of_the_order] = new Card(spr_wizard_of_the_order, spr_wizard_of_the_order_small);
	global.card_sprites[global.card_ids.wolf_man_drew] = new Card(spr_wolf_man_drew, spr_wolf_man_drew_small);
	global.card_sprites[global.card_ids.working_a_hunch] = new Card(spr_working_a_hunch, spr_working_a_hunch_small);
	global.card_sprites[global.card_ids.yithian_observer] = new Card(spr_yithian_observer, spr_yithian_observer_small);
	global.card_sprites[global.card_ids.young_deep_one] = new Card(spr_young_deep_one, spr_young_deep_one_small);
	global.card_sprites[global.card_ids.your_house_revealed] = new Card(spr_your_house_revealed, spr_your_house_revealed_small, global.card_ids.your_house_unrevealed);
	global.card_sprites[global.card_ids.your_house_unrevealed] = new Card(spr_your_house_unrevealed, spr_your_house_unrevealed_small, global.card_ids.your_house_revealed);
}


/// @func	get_card_sprite(_card_id, _use_smalls)
/// @desc	Return sprite of given card ID.
/// @arg	{Real}	_card_id
/// @arg	{Bool}	_use_smalls	(Optional) Defaults to false.
/// @return	{Asset.GMSprite}
function get_card_sprite(_card_id, _use_smalls=false) {
	print_log_message(
		string("get_card_sprite(_card_id={0}, _use_smalls={1})\n", _card_id, _use_smalls), DEBUG_LEVEL.TRACE
	);
	
	var _card = array_get(global.card_sprites, _card_id);
	if (_card_id == 0 || is_undefined(_card) || _card == 0) {
		print_log_message(
			string("No such card ID: {0}\n", _card_id),
			DEBUG_LEVEL.ERROR
		);
	}
	
	var _sprite = _card.sprite;
	if (_use_smalls) {
		_sprite = _card.sprite_small;
	}
	return _sprite;
}

/// @func	get_reverse_id(_card_id)
/// @desc	Return reverse card ID of given card ID, if it exists.
/// @arg	{Real}	_card_id
/// @return	{Real}
function get_reverse_id(_card_id) {
	print_log_message(
		string("get_reverse_id(_card_id={0})\n", _card_id), DEBUG_LEVEL.TRACE
	);
	
	var _card = array_get(global.card_sprites, _card_id);
	if (is_undefined(_card) || _card == 0) {
		print_log_message(
			string("No such card ID: {0}\n", _card_id),
			DEBUG_LEVEL.ERROR
		);
	}
	
	var _reverse_id = _card.reverse_id;
	if (_reverse_id == 0) {
		print_log_message(
			string("No such card ID: {0}\n", _card_id),
			DEBUG_LEVEL.ERROR
		);
	}
	return _reverse_id;
}