/// @description Verify Model and View

var _is_model_not_defined = !variable_instance_exists(self, "model") || is_undefined(self.model);
var _is_view_not_defined = !variable_instance_exists(self, "view") || is_undefined(self.view);

if (_is_model_not_defined || _is_view_not_defined) {
	var _error_msg = string("\nERROR: {0}: ", object_get_name(self.object_index));
	
	if (_is_model_not_defined && _is_view_not_defined) {
		_error_msg += "model and view are";
	}
	else if (_is_model_not_defined) {
		_error_msg += "model is";
	}
	else {
		_error_msg += "view is"; 
	}
	_error_msg += " not defined.\n";
	
	show_message(_error_msg);
	show_debug_message(_error_msg);
	game_end(-1);
}