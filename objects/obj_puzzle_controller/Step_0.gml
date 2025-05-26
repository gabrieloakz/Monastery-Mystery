// obj_puzzle_controller Step Event
/// @description Atualiza o sistema de puzzles

// Atualiza a transparência da interface com animação suave
if (ui_alpha != ui_target_alpha) {
    if (ui_target_alpha > ui_alpha) {
        ui_alpha = min(ui_alpha + fade_speed, ui_target_alpha);
    } else {
        ui_alpha = max(ui_alpha - fade_speed, ui_target_alpha);
    }
}

// Gerencia os diferentes estados do sistema
switch (current_state) {
    case PuzzleState.OPENING:
        // Durante a abertura, aumenta a transparência gradualmente
        if (ui_alpha >= 0.95) {
            current_state = PuzzleState.ACTIVE;
            ui_alpha = 1; // Garante que fica completamente opaco
        }
        break;
        
    case PuzzleState.ACTIVE:
        // Estado principal onde o jogador pode interagir
        handle_player_input();
        update_cursor_blink();
        
        // Verifica se o jogador clicou no botão de submeter resposta
        if (mouse_check_button_pressed(mb_left)) {
            var submit_button_x = ui_x + ui_width - 120;
            var submit_button_y = button_area_y;
            var submit_button_w = 100;
            var submit_button_h = 30;
            
            if (point_in_rectangle(mouse_x, mouse_y, 
                submit_button_x, submit_button_y, 
                submit_button_x + submit_button_w, 
                submit_button_y + submit_button_h)) {
                check_player_answer();
            }
            
            // Verifica clique no botão de fechar
            var close_button_x = ui_x + ui_width - 30;
            var close_button_y = ui_y + 10;
            if (point_in_rectangle(mouse_x, mouse_y, 
                close_button_x, close_button_y, 
                close_button_x + 20, close_button_y + 20)) {
                close_puzzle();
            }
        }
        
        // Permite fechar com ESC
        if (keyboard_check_pressed(vk_escape)) {
            close_puzzle();
        }
        break;
        
    case PuzzleState.CHECKING:
        // Estado temporário durante verificação da resposta
        // Automaticamente transita para SUCCESS ou volta para ACTIVE
        break;
        
    case PuzzleState.SUCCESS:
        // Mostra feedback de sucesso por alguns segundos
        feedback_timer--;
        if (feedback_timer <= 0) {
            apply_puzzle_reward();
            close_puzzle();
        }
        break;
        
    case PuzzleState.CLOSING:
        // Durante o fecho, diminui a transparência gradualmente
        if (ui_alpha <= 0.05) {
            current_state = PuzzleState.INACTIVE;
            ui_alpha = 0;
            // Limpa variáveis do puzzle atual
            active_puzzle_id = "";
            current_puzzle_data = noone;
            display_text = "";
            player_input = "";
            feedback_message = "";
        }
        break;
}

// Atualiza timer de feedback se estiver ativo
if (feedback_timer > 0) {
    feedback_timer--;
}

// Função para gerir input do jogador
function handle_player_input() {
    // Captura caracteres digitados
    var input_string = keyboard_string;
    if (string_length(input_string) > 0) {
        // Adiciona caracteres válidos ao input
        for (var i = 1; i <= string_length(input_string); i++) {
            var char = string_char_at(input_string, i);
            var char_code = ord(char);
            
            // Aceita letras, números e alguns símbolos especiais
            if ((char_code >= 32 && char_code <= 126) && char != "\"" && char != "'") {
                player_input += char;
            }
        }
        keyboard_string = ""; // Limpa o buffer do teclado
    }
    
    // Gerencia backspace para apagar caracteres
    if (keyboard_check_pressed(vk_backspace) && string_length(player_input) > 0) {
        player_input = string_delete(player_input, string_length(player_input), 1);
    }
    
    // Enter submete a resposta
    if (keyboard_check_pressed(vk_enter)) {
        check_player_answer();
    }
}

// Atualiza o piscar do cursor
function update_cursor_blink() {
    cursor_blink_timer++;
    if (cursor_blink_timer >= 30) { // Pisca a cada meio segundo (30 frames)
        show_cursor = !show_cursor;
        cursor_blink_timer = 0;
    }
}

// Verifica a resposta do jogador
function check_player_answer() {
    if (string_length(player_input) == 0) {
        show_feedback("Digite uma resposta primeiro!", error_color, 120);
        return;
    }
    
    current_state = PuzzleState.CHECKING;
    
    // Usa a função do objeto de dados para verificar a resposta
    var is_correct = puzzle_data_obj.check_puzzle_answer(active_puzzle_id, player_input);
    
    if (is_correct) {
        current_state = PuzzleState.SUCCESS;
        show_feedback("Correto! Bem feito!", success_color, 180);
        // Aqui podias adicionar um som de sucesso
        // audio_play_sound(sound_success, 1, false);
    } else {
        current_state = PuzzleState.ACTIVE; // Volta ao estado ativo
        show_feedback("Resposta incorreta. Tenta novamente!", error_color, 120);
        // Limpa o input para nova tentativa
        player_input = "";
        // Aqui podias adicionar um som de erro
        // audio_play_sound(sound_error, 1, false);
    }
}

// Aplica a recompensa do puzzle
function apply_puzzle_reward() {
    if (current_puzzle_data == noone) return;
    
    var reward_type = ds_map_find_value(current_puzzle_data, "reward_type");
    var reward_target = ds_map_find_value(current_puzzle_data, "reward_target");
    
    switch (reward_type) {
        case "unlock_door":
            // Procura e desbloqueia a porta especificada
            var door = instance_find_by_name(reward_target);
            if (door != noone) {
                door.is_locked = false;
                show_message("Uma porta foi desbloqueada!");
            }
            break;
            
        case "give_item":
            // Adiciona item ao inventário do jogador
            // Assumes que tens um sistema de inventário
            if (instance_exists(obj_player)) {
                // obj_player.add_item(reward_target);
                show_message("Recebeste um novo item: " + reward_target);
            }
            break;
            
        case "activate_mechanism":
            // Ativa um mecanismo específico
            var mechanism = instance_find_by_name(reward_target);
            if (mechanism != noone) {
                mechanism.is_active = true;
                show_message("Um mecanismo foi ativado!");
            }
            break;
    }
}

// Mostra mensagem de feedback temporária
function show_feedback(message, color, duration) {
    feedback_message = message;
    feedback_color = color;
    feedback_timer = duration;
}

// Função auxiliar para encontrar instâncias por nome (se não existir)
function instance_find_by_name(object_name) {
    // Esta é uma implementação básica - podes expandir conforme necessário
    switch (object_name) {
        case "door_biblioteca":
            return instance_find(obj_door_biblioteca, 0);
        case "sino_torre":
            return instance_find(obj_sino_torre, 0);
        // Adiciona mais casos conforme necessário
        default:
            return noone;
    }
}