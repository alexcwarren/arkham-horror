enum DEBUG_LEVEL {
	TRACE,
	DEBUG,
	INFO,
	WARN,
	ERROR,
}


/// @func	load_debug_settings()
/// @desc	Load the current debug settings.
function load_debug_settings() {
	global.debug_level = DEBUG_LEVEL.DEBUG;
}


/// @func	print_log_message()
/// @desc	Print log message at provided level.
/// @arg	{String}	_message
/// @arg	{Real}		_level
function print_log_message(_message, _level) {
	if (_level >= global.debug_level) {
		show_debug_message(_message);
	}
	
	if (_level >= DEBUG_LEVEL.ERROR) {
		game_end(-1);
	}
}


function print(_string) {
	var _args = array_create(argument_count - 1);
	for (var _i = 1; _i < argument_count; ++_i) {
		_args[_i] = argument[_i];
	}
	show_debug_message(string(_string, _args));
}