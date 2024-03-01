/// @func	TokenModel()
/// @desc	Model for token object.
function TokenModel() constructor {
	__emitter = undefined;
	
	/// @func	get_emitter()
	/// @desc	Return this token's emitter.
	/// @return	{Asset.GMObject}
	get_emitter = function() {
		return __emitter;
	}
	
	/// @func	set_emitter(_emitter)
	/// @desc	Set this token's emitter.
	/// @arg	{Asset.GMObject}	_emitter
	set_emitter = function(_emitter) {
		__emitter = _emitter;
	}
}


/// @func	TokenView()
/// @desc	View for token object.
function TokenView() constructor {
}