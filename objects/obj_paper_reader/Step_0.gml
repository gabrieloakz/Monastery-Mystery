/// @description Controle de interação e scroll

if (!text_active) exit;

// Efeito de máquina de escrever
if (!typing_complete) {
    char_index += text_speed;
    
    // Verifica se a digitação foi concluída
    if (char_index >= string_length(current_text)) {
        char_index = string_length(current_text);
        typing_complete = true;
    }
    
    // Permite pular a digitação com Enter
    if (keyboard_check_pressed(vk_enter)) {
        char_index = string_length(current_text);
        typing_complete = true;
    }
}

// Controle de scroll após a digitação completa
if (typing_complete && max_scroll > 0) {
    // Scroll com setas
    if (keyboard_check(vk_up)) {
        scroll_position = max(0, scroll_position - scroll_speed);
    }
    if (keyboard_check(vk_down)) {
        scroll_position = min(max_scroll, scroll_position + scroll_speed);
    }
    
    // Scroll com roda do mouse
    var wheel = mouse_wheel_down() - mouse_wheel_up();
    if (wheel != 0) {
        scroll_position = clamp(scroll_position + (wheel * scroll_speed), 0, max_scroll);
    }
}

// Fechar o leitor com ESC
if (keyboard_check_pressed(vk_escape)) {
    close_reader();
}