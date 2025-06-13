// obj_puzzle_controller Create Event
/// @description Inicializa o sistema de controlo de puzzles

persistent = true; // Tornar o objeto persistente

show_debug_message("DEBUG: obj_puzzle_controller Create Event executado! ID: " + string(id));

// Estados do sistema
enum PuzzleState {
    INACTIVE,     // Sistema desativado
    OPENING,      // Animação de abertura
    ACTIVE,       // Puzzle ativo, jogador pode interagir
    CHECKING,     // Verificando resposta do jogador  
    SUCCESS,      // Puzzle resolvido com sucesso
    CLOSING       // Animação de fecho
}

// Variáveis de estado
current_state = PuzzleState.INACTIVE;
active_puzzle_id = "";
current_puzzle_data = noone;

// Variáveis de interface
ui_alpha = 0;              // Transparência da UI (para animações)
ui_target_alpha = 0;       // Valor alvo da transparência
fade_speed = 0.05;         // Velocidade das animações de fade

// Dimensões da interface (calculadas com base na GUI)
ui_width = display_get_gui_width() * 0.85;   // 85% da largura da GUI
ui_height = display_get_gui_height() * 0.8;  // 80% da altura da GUI
ui_x = (display_get_gui_width() - ui_width) / 2;   // Centralizado horizontalmente na GUI
ui_y = (display_get_gui_height() - ui_height) / 2; // Centralizado verticalmente na GUI

// Variáveis de texto e input
display_text = "";         // Texto formatado para exibição
player_input = "";         // Input atual do jogador
input_cursor_pos = 0;      // Posição do cursor no input
cursor_blink_timer = 0;    // Timer para piscar o cursor
show_cursor = true;        // Se o cursor está visível

// Posicionamento de elementos na UI
title_y = ui_y + 40;
description_y = ui_y + 80;
code_area_y = ui_y + 120;
code_area_height = ui_height * 0.5;
input_area_y = code_area_y + code_area_height + 20;
hint_y = input_area_y + 60;
button_area_y = ui_y + ui_height - 80;

// Cores e estilos (usando cores no formato hexadecimal)
bg_color = make_color_rgb(40, 35, 30);        // Marrom escuro pergaminho
border_color = make_color_rgb(139, 69, 19);   // Marrom médio
text_color = make_color_rgb(20, 20, 20);      // Quase preto
accent_color = make_color_rgb(184, 134, 11);  // Dourado
success_color = make_color_rgb(34, 139, 34);  // Verde
error_color = make_color_rgb(178, 34, 34);    // Vermelho

// Referência ao objeto de dados
puzzle_data_obj = instance_find(obj_puzzle_data, 0);
if (puzzle_data_obj == noone) {
    // Cria o objeto de dados se não existir
    puzzle_data_obj = instance_create_depth(0, 0, 0, obj_puzzle_data);
}

// Sistema de feedback
feedback_message = "";
feedback_color = text_color;
feedback_timer = 0;

// Sons (definir depois se tiveres recursos de áudio)
// sound_open = snd_scroll_open;
// sound_success = snd_puzzle_success;
// sound_error = snd_puzzle_error;

// FUNÇÕES PÚBLICAS DO SISTEMA DE PUZZLES (MOVIDAS DE Other_10.gml)
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