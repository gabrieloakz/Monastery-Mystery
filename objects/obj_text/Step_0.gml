/// @description Step

if (global.game_state != "playing") exit;

if (visible) { // Verifica se a caixa de texto está visível
    if (!typing_complete) {
        // Incrementa o índice de caractere
        char_index += 1 / text_speed; 
        char_index = min(char_index, global.total_chars); // Limita ao tamanho do texto

        // Atualiza o texto exibido
        current_text = string_copy(global.current_dialogue, 1, floor(char_index));

        // Verifica se o texto foi completamente exibido
        if (char_index >= global.total_chars) {
            typing_complete = true;
        }
    }

    // Avanço do diálogo com a tecla 'Espaço'
    if (keyboard_check_pressed(vk_enter) && typing_complete) {
        global.current_text_index += 1; // Avança para o próximo texto

        if (global.current_text_index < array_length(global.dialogues)) {
            global.current_dialogue = global.dialogues[global.current_text_index]; // Obtém o próximo texto
            global.total_chars = string_length(global.current_dialogue); // Recalcula o número total de caracteres
            char_index = 0; // Reinicia o índice de caractere
            typing_complete = false; // Reinicia o estado de conclusão
        } else {
            visible = false; // Oculta a caixa de texto
            global.current_text_index = 0; // Reseta o índice de texto
        }
    }
}