/// @func	CampaignScenarioData(_encounters, _locations, _acts, _agendas, _extras)
/// @desc	Data structure for a campaign's scenario.
/// @arg	{Array<Real>}	_encounters TODO
/// @arg	{Array<Real>}	_locations	TODO
/// @arg	{Array<Real>}	_acts		TODO
/// @arg	{Array<Real>}	_agendas	TODO
/// @arg	{Array<Real>}	_extras		(Optional).
function CampaignScenarioData(_encounters, _locations, _acts, _agendas, _extras=undefined) constructor {
	encounters = _encounters;
	locations = _locations;
	acts = _acts;
	agendas = _agendas;
	extras = _extras;
};

/// @func	CampaignData(_array_scenarios)
/// @desc	Data structure for a campaign.
/// @arg	{Array}	_array_scenarios
function CampaignData(_array_scenarios) constructor {
	__scenarios = _array_scenarios;
	__num_scenarios = array_length(_array_scenarios);
	__curr_scenario_id = 0;
	
	/// @func	get_current_scenario()
	/// @desc	Return current scenario data (CampaignScenarioData object).
	/// @return	{Struct.CampaignScenarioData}
	get_current_scenario = function() {
		return __scenarios[__curr_scenario_id];
	}
	
	/// @func	proceed_next_scenario()
	/// @desc	Move on to next scenario of this campaign.
	proceed_next_scenario = function() {
		if (__curr_scenario_id + 1 >= __num_scenarios) {
			show_debug_message("Cannot proceed to next scenario. Currenlty on last scenario.");
		}
		else {
			__curr_scenario_id += 1;
		}
	}
};

/// @func	load_campaign_data()
/// @desc	Load all campaign data.
function load_campaign_data() {
	global.campaign_names = {
		night_of_the_zealot: "night_of_the_zealot",
	};
	
	global.campaign_curr = global.campaign_names.night_of_the_zealot;
	
	
	global.campaigns_data = {};
	struct_set(
		global.campaigns_data,
		global.campaign_names.night_of_the_zealot,
		new CampaignData([
			// Scenario 1 - The Gathering
			new CampaignScenarioData(
				// Encounters
				[
					global.card_ids.ancient_evils,
					global.card_ids.crypt_chill,
					global.card_ids.dissonant_voices,
					global.card_ids.flesh_eater,
					global.card_ids.frozen_in_fear,
					global.card_ids.ghoul_minion,
					global.card_ids.grasping_hands,
					global.card_ids.icy_ghoul,
					global.card_ids.obscuring_fog,
					global.card_ids.ravenous_ghoul,
					global.card_ids.rotting_remains,
					global.card_ids.swarm_of_rats,
				],
				// Locations
				[
					global.card_ids.study_unrevealed,
					global.card_ids.hallway_unrevealed,
					global.card_ids.attic_unrevealed,
					global.card_ids.cellar_unrevealed,
					global.card_ids.parlor_unrevealed,
				],
				// Acts
				//new FlipDeck([
				[
					global.card_ids.the_gathering_act1a,
					global.card_ids.the_gathering_act1b,
					global.card_ids.the_gathering_act2a,
					global.card_ids.the_gathering_act2b,
					global.card_ids.the_gathering_act3a,
					global.card_ids.the_gathering_act3b,
				//]),
				],
				// Agendas
				//new FlipDeck([
				[
					global.card_ids.the_gathering_agenda1a,
					global.card_ids.the_gathering_agenda1b,
					global.card_ids.the_gathering_agenda2a,
					global.card_ids.the_gathering_agenda2b,
					global.card_ids.the_gathering_agenda3a,
					global.card_ids.the_gathering_agenda3b,
				//]),
				],
				// Extras
				[
					global.card_ids.lita_chantler,
					global.card_ids.ghoul_priest,
				]
			),
			// Scenario 2 - The Midnight Masks
			new CampaignScenarioData(
				// Encounters
				[
					global.card_ids.acolyte,
					global.card_ids.crypt_chill,
					global.card_ids.false_lead,
					global.card_ids.hunting_nightgaunt,
					global.card_ids.hunting_shadow,
					global.card_ids.locked_door,
					global.card_ids.mysterious_chanting,
					global.card_ids.obscuring_fog,
					global.card_ids.on_wings_of_darkness,
					global.card_ids.wizard_of_the_order,
				],
				// Locations
				[
					global.card_ids.downtown_unrevealed,
					global.card_ids.easttown_unrevealed,
					global.card_ids.graveyard_unrevealed,
					global.card_ids.miskatonic_university_unrevealed,
					global.card_ids.northside_unrevealed,
					global.card_ids.rivertown_unrevealed,
					global.card_ids.st_marys_hospital_unrevealed,
					global.card_ids.your_house_unrevealed,
				],
				// Acts
				[
					global.card_ids.the_midnight_masks_act1a,
					global.card_ids.the_midnight_masks_act1b,
				],
				// Agendas
				[
					global.card_ids.the_midnight_masks_agenda1a,
					global.card_ids.the_masked_hunter,
					global.card_ids.the_midnight_masks_agenda2a,
					global.card_ids.the_midnight_masks_agenda2b,
				],
				// Extras
				[
					global.card_ids.herman_collins,
					global.card_ids.peter_warren,
					global.card_ids.ruth_turner,
					global.card_ids.victoria_devereux,
					global.card_ids.wolf_man_drew,
				]
			),
			// Scenario 3 - The Devourer Below
			new CampaignScenarioData(
				// Encounters
				[
					global.card_ids.acolyte,
					global.card_ids.ancient_evils,
					global.card_ids.dissonant_voices,
					global.card_ids.frozen_in_fear,
					global.card_ids.ghoul_minion,
					global.card_ids.grasping_hands,
					global.card_ids.mysterious_chanting,
					global.card_ids.ravenous_ghoul,
					global.card_ids.rotting_remains,
					global.card_ids.umordhoth,
					global.card_ids.umordhoths_wrath,
				],
				// Locations
				[
					global.card_ids.arkham_woods_unrevealed,
					global.card_ids.main_path_unrevealed,
					global.card_ids.ritual_site_unrevealed,
				],
				// Acts
				//new FlipDeck([
				[
					global.card_ids.the_devourer_below_act1a,
					global.card_ids.the_devourer_below_act1b,
					global.card_ids.the_devourer_below_act2a,
					global.card_ids.the_devourer_below_act2b,
					global.card_ids.the_devourer_below_act3a,
					global.card_ids.the_devourer_below_act3b,
				//]),
				],
				// Agendas
				//new FlipDeck([
				[
					global.card_ids.the_devourer_below_agenda1a,
					global.card_ids.the_devourer_below_agenda1b,
					global.card_ids.the_devourer_below_agenda2a,
					global.card_ids.the_devourer_below_agenda2b,
					global.card_ids.the_devourer_below_agenda3a,
					global.card_ids.the_devourer_below_agenda3b,
				//]),
				],
				// Extras
				[
					global.card_ids.dreams_of_rlyeh,
					global.card_ids.young_deep_one,
					global.card_ids.screeching_byakhee,
					global.card_ids.the_yellow_sign,
					global.card_ids.goat_spawn,
					global.card_ids.relentless_dark_young,
					global.card_ids.offer_of_power,
					global.card_ids.yithian_observer,
				]
			)
		]) // end new CampaignData
	); // end struct_set
}