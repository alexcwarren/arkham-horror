/// @desc	


depth = -200;

token_obj = obj_token;


/// @func	draw_token()
/// @desc	Draw token.
draw_token = function() {
	var _inst_token = instance_create_depth(x, y, depth - 1, token_obj);
	_inst_token.sprite_index = sprite_index;
	_inst_token.model.set_emitter(self.object_index);
}