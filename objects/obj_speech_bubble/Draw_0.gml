/// @description Draw
if (!visible) return;

var text_width = string_width(current_text);
var bubble_width = max(128, text_width + 32);
var bubble_x = obj_monk.x - bubble_width / 2;
var bubble_y = obj_monk.y - spr_speech_bubble.height - 16;

draw_set_font(fnt_text);
draw_sprite_ext(spr_speech_bubble, 0, bubble_x, bubble_y, bubble_width / sprite_get_width(spr_speech_bubble), 1, 0, c_white, 1);
draw_set_color(c_black);
draw_text(bubble_x + 16, bubble_y + 16, current_text);