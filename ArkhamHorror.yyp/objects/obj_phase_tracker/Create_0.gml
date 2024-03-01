/// @desc		


num_subimgs = sprite_get_number(sprite_index);

enum PHASE_STATE {
	INVESTIGATION,
	ENEMY,
	UPKEEP,
	MYTHOS,
}

phase_curr = PHASE_STATE.INVESTIGATION;