/// @description Create
visible = false; // A caixa de texto começa invisível
current_text = "";
text_speed = 5; // Velocidade da máquina de escrever (número de frames por caractere)
char_index = 0;
typing_complete = false;

// Certifique-se de que os diálogos existem antes de acessá-los
if (!is_array(global.dialogues)) {
    global.dialogues = []; // Inicializa o array global de diálogos, caso não exista
}
if (array_length(global.dialogues) > 0) {
    global.current_dialogue = global.dialogues[0]; // Define o primeiro diálogo como atual
    global.total_chars = string_length(global.current_dialogue); // Calcula o número total de caracteres
} else {
    global.current_dialogue = "Nenhum diálogo disponível.";
    global.total_chars = string_length(global.current_dialogue);
}