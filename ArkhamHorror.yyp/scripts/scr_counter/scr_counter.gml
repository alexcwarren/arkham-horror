function update_counter(_counter_obj, _modifier) {
	_counter_obj.count = clamp(_counter_obj.count + _modifier, _counter_obj.count_min, _counter_obj.count_max);
}