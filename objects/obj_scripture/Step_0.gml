// Em obj_scripture/Step_0.gml
/// @description Step
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
    is_open = !is_open;
    
    if (is_open) {
        char_index = 0;
        typing_complete = false;
    }
}

// Atualiza o fade
if (is_open) {
    fade_alpha = min(fade_alpha + fade_speed, 1);
} else {
    fade_alpha = max(fade_alpha - fade_speed, 0);
}

// Atualiza o texto
if (is_open && !typing_complete) {
    char_index += 1 / text_speed;
    char_index = min(char_index, string_length(text_content));
    
    if (char_index >= string_length(text_content)) {
        typing_complete = true;
    }
}