/// @description Step
if (place_meeting(x, y, obj_player)) { // Verifica colisão com o jogador
    if (keyboard_check_pressed((ord("W"))) && !dialogue_active) {
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
}