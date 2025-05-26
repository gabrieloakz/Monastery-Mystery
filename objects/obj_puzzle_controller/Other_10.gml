// obj_puzzle_controller User Event 0
/// @description Funções públicas do sistema de puzzles

// Função principal para abrir um puzzle
function open_puzzle(puzzle_id) {
    // Verifica se o sistema já está ativo
    if (current_state != PuzzleState.INACTIVE) {
        return false; // Não pode abrir se já houver um puzzle ativo
    }
    
    // Busca os dados do puzzle
    current_puzzle_data = puzzle_data_obj.get_puzzle_data(puzzle_id);
    if (current_puzzle_data == noone) {
        show_debug_message("Erro: Puzzle ID '" + puzzle_id + "' não encontrado!");
        return false;
    }
    
    // Configura o puzzle atual
    active_puzzle_id = puzzle_id;
    
    // Prepara o texto para exibição
    var code_template = ds_map_find_value(current_puzzle_data, "code_template");
    display_text = code_template;
    
    // Reset de variáveis
    player_input = "";
    feedback_message = "";
    feedback_timer = 0;
    cursor_blink_timer = 0;
    show_cursor = true;
    
    // Inicia a animação de abertura
    current_state = PuzzleState.OPENING;
    ui_target_alpha = 1;
    
    // Som de abertura (se tiveres)
    // audio_play_sound(sound_open, 1, false);
    
    return true;
}

// Função para fechar o puzzle
function close_puzzle() {
    if (current_state == PuzzleState.INACTIVE) {
        return; // Já está fechado
    }
    
    current_state = PuzzleState.CLOSING;
    ui_target_alpha = 0;
}

// Função para verificar se um puzzle está resolvido
function is_puzzle_solved(puzzle_id) {
    // Aqui poderias implementar um sistema de save/load
    // Por agora, retorna sempre false (puzzle não resolvido)
    return false;
}

// Função para obter informações de um puzzle
function get_puzzle_info(puzzle_id) {
    return puzzle_data_obj.get_puzzle_data(puzzle_id);
}

// Função para verificar se o sistema está ativo
function is_puzzle_active() {
    return current_state != PuzzleState.INACTIVE;
}