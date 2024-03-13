/// @func	DrawOrderManager()
/// @desc	Data structure for managing draw order for obj_moveable instances.
function DrawOrderManager() constructor {
	__depths = {};
	__depth = 1;
	
	/// @func	register(_inst_id)
	/// @desc	Register the given instance ID.
	/// @arg	{Id.Instance}	_inst_id
	register = function(_inst_id) {
		//static _depth = 1;
		struct_set(__depths, string(_inst_id), __depth);
		++__depth;
	}
	
	/// @func	get_depth(_inst_id)
	/// @desc	Return depth belonging to given instance ID.
	/// @arg	{Id.Instance}	_inst_id
	/// @return	{Real}
	get_depth = function(_inst_id) {
		return __depths[$ string(_inst_id)];
	}
	
	/// @func	reorder(_inst_id)
	/// @desc	Reorder instance depths with given instance ID in front.
	/// @arg	{Id.Instance}	_inst_id
	reorder = function(_inst_id) {
		var _inst_strings = struct_get_names(__depths);
		var _original_depth = __depths[$ string(_inst_id)];
		
		for (var _i = 0; _i < array_length(_inst_strings); ++_i) {
			var _inst_string = _inst_strings[_i];
			if (_inst_string == string(_inst_id)) {
				__depths[$ _inst_string] = 1;
			}
			else if (__depths[$ _inst_string] < _original_depth) {
				__depths[$ _inst_string] += 1;
			}
		}
	}
	
	/// @func	remove(_inst_id)
	/// @desc	Remove the given instance ID.
	/// @arg	{Id.Instance}
	remove = function(_inst_id) {
		var _original_depth = __depths[$ string(_inst_id)];
		struct_remove(__depths, string(_inst_id));
		--__depth;
		
		var _inst_strings = struct_get_names(__depths);
		for (var _i = 0; _i < array_length(_inst_strings); ++_i) {
			var _inst_string = _inst_strings[_i];
			if (__depths[$ _inst_string] > _original_depth) {
				__depths[$ _inst_string] -= 1;
			}
		}
	}
}