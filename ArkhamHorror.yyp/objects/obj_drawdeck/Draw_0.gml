/// @desc	Draw self and discard pile


draw_self();

if (!model.get_discard_pile().is_empty()) {
	draw_discard();
}