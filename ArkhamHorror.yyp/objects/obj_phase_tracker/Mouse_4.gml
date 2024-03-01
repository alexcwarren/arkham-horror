/// @desc	Advance phase


phase_curr = (phase_curr + 1) % num_subimgs;

if (phase_curr == PHASE_STATE.MYTHOS) {
	obj_counter_actions.count = obj_counter_actions.count_max;
	update_counter(obj_counter_doom, 1);
}
else if (phase_curr == PHASE_STATE.UPKEEP) {
	update_counter(obj_counter_resources, 1);
	
	global.player_drawdeck_curr.draw_card_from_deck();
}