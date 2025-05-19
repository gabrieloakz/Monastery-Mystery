// Em obj_scripture_text/Step_0.gml
/// @description Step
if (visible) {
    if (!typing_complete) {
        // Incrementa o índice de caractere
        char_index += 1 / text_speed;
        char_index = min(char_index, string_length(current_text));

        // Atualiza o texto exibido
        current_text = string_copy(current_text, 1, floor(char_index));

        // Verifica se o texto foi completamente exibido
        if (char_index >= string_length(current_text)) {
            typing_complete = true;
        }
    }
}