/// @description Draw
if (!visible) return;

var wrap_width = 200;
var line_height = 12;
var text_height = string_height_ext(current_text, line_height, wrap_width);
var bubble_width = max(128, wrap_width + 32);
var bubble_height = max(48, text_height + 32);
var bubble_x = obj_monk.x - bubble_width / 2;
var bubble_y = obj_monk.y - bubble_height - 16;

draw_set_font(fnt_text);
draw_sprite_ext(spr_speech_bubble, 0, bubble_x, bubble_y, bubble_width / sprite_get_width(spr_speech_bubble), bubble_height / sprite_get_height(spr_speech_bubble), 0, c_white, 1);
draw_set_color(c_black);
draw_text_ext(bubble_x + 16, bubble_y + 16, current_text, line_height, wrap_width);