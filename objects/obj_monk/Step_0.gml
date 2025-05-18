/// @description Step

if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id) && !dialogue_active) {
    dialogue_active = true;
    
    with (obj_text) {
        visible = true; // Torna a caixa de texto visível
        global.current_text_index = 0; // Reseta o índice de texto
        global.current_dialogue = global.dialogues[global.current_text_index]; // Obtém o primeiro texto
        global.total_chars = string_length(global.current_dialogue); // Calcula o número total de caracteres
        char_index = 0; // Reinicia o índice de caractere
        typing_complete = false; // Reinicia o estado de conclusão
    }
}
