function ChaosBag(
	_num_plus_1,
	_num_0,
	_num_minus_1,
	_num_minus_2,
	_num_minus_3,
	_num_minus_4,
	_num_minus_5,
	_num_minus_6,
	_num_minus_8,
	_num_skull,
	_num_cultist,
	_num_tablet,
	_num_autofail,
	_num_elder_sign,
) constructor {
	token_counts = ds_map_create();
	token_counts[? "+1"] = _num_plus_1;
	token_counts[? "0"] = _num_0;
	token_counts[? "-1"] = _num_minus_1;
	token_counts[? "-2"] = _num_minus_2;
	token_counts[? "-3"] = _num_minus_3;
	token_counts[? "-4"] = _num_minus_4;
	token_counts[? "-5"] = _num_minus_5;
	token_counts[? "-6"] = _num_minus_6;
	token_counts[? "-8"] = _num_minus_8;
	token_counts[? "Skull"] = _num_skull;
	token_counts[? "Cultist"] = _num_cultist;
	token_counts[? "Tablet"] = _num_tablet;
	token_counts[? "Auto Fail"] = _num_autofail;
	token_counts[? "Elder Sign"] = _num_elder_sign;
}


function create_chaos_bag() {
	//                                +1  0 -1 -2 -3 -4 -5 -6 -8 Sk Cu Ta AF ES
	var _chaos_bag_easy = new ChaosBag(2, 3, 3, 2, 0, 0, 0, 0, 0, 2, 1, 1, 1, 1);
	var _chaos_bag_strd = new ChaosBag(1, 2, 3, 2, 1, 1, 0, 0, 0, 2, 1, 1, 1, 1);
	var _chaos_bag_hard = new ChaosBag(0, 3, 2, 2, 2, 1, 1, 0, 0, 2, 1, 1, 1, 1);
	var _chaos_bag_expt = new ChaosBag(0, 1, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1, 1, 1);

	chaos_bags = ds_map_create();
	chaos_bags[? global.difficulties.easy] = _chaos_bag_easy;
	chaos_bags[? global.difficulties.standard] = _chaos_bag_strd;
	chaos_bags[? global.difficulties.hard] = _chaos_bag_hard;
	chaos_bags[? global.difficulties.expert] = _chaos_bag_expt;

	global.chaos_bag = chaos_bags[? global.difficulty];
}


function draw_chaos_token() {
	var _all_tokens = ds_map_keys_to_array(global.chaos_bag.token_counts);
	var _total_tokens = 0;
	var _tokens = [];
	for (var _i = 0; _i < array_length(_all_tokens); ++_i) {
		var _token = _all_tokens[_i];
		var _num_token = ds_map_find_value(global.chaos_bag.token_counts, _token);
		if (_num_token == 0) {
			continue;
		}
		array_push(_tokens, _token);
		_total_tokens += _num_token;
	}
	var _rand_num = irandom(_total_tokens);
	
	var _num_tokens = array_length(_tokens);
	var _boundary = 0;
	for (var _i = 0; _i < _num_tokens - 1; ++_i) {
		var _token = _tokens[_i];
		var _num_token = ds_map_find_value(global.chaos_bag.token_counts, _token);
		if (_num_token == 0) {
			continue;
		}
		_boundary += _num_token;
		if (_rand_num < _boundary) return _token;
	}
	
	return _tokens[_num_tokens - 1];
}


function test_chaos_bag(_num_tests = 1000) {
	var _frequencies = ds_map_create();
	var _tokens = ds_map_keys_to_array(global.chaos_bag.token_counts);
	var _num_tokens = array_length(_tokens);
	for (var _i = 0; _i < _num_tokens; ++_i) {
		var _token = _tokens[_i];
		_frequencies[? _token] = 0;
	}
	
	for (var _i = 0; _i < _num_tests; ++_i) {
		var _result = draw_chaos_token();
		_frequencies[? _result] += 1;
	}
	
	for (var _i = 0; _i < _num_tokens; ++_i) {
		var _token = _tokens[_i];
		var _frequency = _frequencies[? _token];
		var _probability = _frequency / _num_tests * 100.0;
		show_debug_message(_token + " occurred " + string(_frequency) + " times: " + string(_probability) + "%");
	}
	show_debug_message("");
}