depth = -100;

count = 0;

count_min = 0;
count_max = 99

var _button_x_offset = 20;

button_counter_up = instance_create_depth(x + _button_x_offset, y, -1, obj_counter_button_up);
button_counter_up.counter_obj = self;

button_counter_down = instance_create_depth(x - _button_x_offset, y, -1, obj_counter_button_down);
button_counter_down.counter_obj = self;