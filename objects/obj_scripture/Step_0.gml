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
if (!is_discovered || !is_interactable || global.puzzle_controller.is_puzzle_active()) {
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

// Função para interagir com a escritura
function interact_with_scripture() {
    // Verifica se o puzzle já foi resolvido
    if (is_solved) {
        show_message("Esta escritura já foi decifrada.");
        return;
    }
    
    // Tenta abrir o puzzle
    var success = puzzle_controller.open_puzzle(puzzle_id);
    
    if (success) {
        // Som de interação
        // audio_play_sound(interaction_sound, 1, false);
        
        // Marca que esta escritura foi interagida
        is_interactable = false; // Temporariamente não interagível durante o puzzle
        
        // Opcional: Adicionar um timer para reativar a interação caso o puzzle seja fechado sem resolver
        alarm[0] = 300; // 5 segundos em 60 FPS
    } else {
        show_message("Não é possível abrir esta escritura agora.");
    }
}

// Função chamada quando o puzzle é resolvido (deve ser chamada pelo controlador)
function mark_as_solved() {
    is_solved = true;
    glow_alpha = 0;
    // Aqui poderias mudar o sprite para uma versão "resolvida"
    // sprite_index = spr_ui_books_solved;
}