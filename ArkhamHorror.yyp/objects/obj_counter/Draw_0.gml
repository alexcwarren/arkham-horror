draw_self();

draw_set_color(c_white);
draw_set_halign(fa_center);
var _x_offset = 0;
var _y_offset = -10;
draw_text_transformed(x + _x_offset, y + _y_offset, string(count), 1, 1, 0);