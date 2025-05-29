// obj_scripture Step Event
/// @description Step - Lógica de interação melhorada

// Verifica se o jogador está próximo para descobrir a escritura
if (!is_discovered && instance_exists(obj_player)) {
    var distance_to_player = point_distance(x, y, obj_player.x, obj_player.y);
    if (distance_to_player <= detection_radius) {
        is_discovered = true;
        // Aqui poderias adicionar um efeito de partículas ou som
        // effect_create_above(ef_ring, x, y, 1, c_gold);
    }
}

// Só permite interação se foi descoberta e o sistema de puzzles não estiver ativo
if (!is_discovered || !is_interactable || (puzzle_controller != noone && puzzle_controller.current_state != PuzzleState.INACTIVE)) {
    target_scale = 1.0;
    image_xscale = lerp(image_xscale, target_scale * 0.6, scale_speed);
    image_yscale = lerp(image_yscale, target_scale * 0.6, scale_speed);
    exit;
}

// Verifica se o mouse está sobre a escritura
var mouse_over = position_meeting(mouse_x, mouse_y, id);

if (mouse_over) {
    // Mouse por cima - aumenta ligeiramente o tamanho
    target_scale = 1.1;
    
    // Muda o cursor para indicar interatividade
    window_set_cursor(cr_handpoint);
    
    // Verifica clique
    if (mouse_check_button_pressed(mb_left)) {
        interact_with_scripture();
    }
} else {
    // Mouse longe - tamanho normal
    target_scale = 1.0;
}

// Aplica animação suave de escala
image_xscale = lerp(image_xscale, target_scale * 0.6, scale_speed);
image_yscale = lerp(image_yscale, target_scale * 0.6, scale_speed);

// Animação de brilho para escrituras não resolvidas
if (!is_solved) {
    glow_alpha += glow_direction * 0.02;
    if (glow_alpha >= 1) {
        glow_alpha = 1;
        glow_direction = -1;
    } else if (glow_alpha <= 0) {
        glow_alpha = 0;
        glow_direction = 1;
    }
}

// Atualiza a escala de expansão se necessário
if (is_expanding) {
    expand_progress += expand_speed;
    
    if (expand_progress >= 1) {
        expand_progress = 1;
        is_expanding = false;
        
        // Agora que a expansão terminou, abre o puzzle
        if (instance_exists(puzzle_controller)) {
            puzzle_controller.open_puzzle(puzzle_id);
        }
    }
    exit;
}

// Função para interagir com a escritura
function interact_with_scripture() {
    // Verifica se o puzzle já foi resolvido
    if (is_solved) {
        show_message("Esta escritura já foi decifrada.");
        return;
    }
    
    // Calcula a escala necessária para preencher a tela
    var view_width = view_wport[0];
    var view_height = view_hport[0];
    var scale_x = view_width / sprite_width;
    var scale_y = view_height / sprite_height;
    final_scale = min(scale_x, scale_y) * 0.8; // 80% do tamanho da tela
    
    // Inicia a animação de expansão
    is_expanding = true;
    expand_progress = 0;
    is_interactable = false;
    
    // Som de interação
    // audio_play_sound(interaction_sound, 1, false);
    
    // Opcional: Adicionar um timer para reativar a interação caso o puzzle seja fechado sem resolver
    alarm[0] = 300; // 5 segundos em 60 FPS
}

// Função chamada quando o puzzle é resolvido (deve ser chamada pelo controlador)
function mark_as_solved() {
    is_solved = true;
    glow_alpha = 0;
    // Aqui poderias mudar o sprite para uma versão "resolvida"
    // sprite_index = spr_ui_books_solved;
}