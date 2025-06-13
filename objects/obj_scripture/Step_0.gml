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

// Garante que temos uma referência válida e atualizada ao puzzle controller.
// É fundamental que esta linha seja executada a cada passo para que 'puzzle_controller'
// contenha sempre o ID da instância correta, mesmo após carregamento de sala ou resets.
puzzle_controller = instance_find(obj_puzzle_controller, 0);
if (puzzle_controller == noone) {
    puzzle_controller = instance_create_depth(0, 0, -1000, obj_puzzle_controller);
    puzzle_controller.persistent = true; // Garante que o recém-criado também é persistente
}

// Só permite interação se foi descoberta, se o objeto pode ser interagido (is_interactable)
// E, CRUCIALMENTE, se o sistema de puzzles NÃO estiver ativo ou expandindo.
if (!is_discovered || !is_interactable || (is_expanding) || (puzzle_controller != noone && puzzle_controller.current_state != PuzzleState.INACTIVE)) {
    target_scale = 1.0;
    image_xscale = lerp(image_xscale, target_scale * 0.6, scale_speed);
    image_yscale = lerp(image_yscale, target_scale * 0.6, scale_speed);
    exit;
}

// Verifica se o mouse está sobre a escritura, usando uma área ligeiramente maior para facilitar o clique
var mouse_over = point_in_rectangle(mouse_x, mouse_y, 
                                    bbox_left - 5, bbox_top - 5, 
                                    bbox_right + 5, bbox_bottom + 5);

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
        // Usamos instance_exists aqui por segurança, apesar da atualização no início do Step.
        if (instance_exists(puzzle_controller)) {
            puzzle_controller.open_puzzle(puzzle_id);
        } else {
            // Se o controller não existir, reseta o estado
            is_interactable = true;
            is_expanding = false;
            expand_progress = 0;
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
    
    // ABRIR O PUZZLE AQUI, ANTES DE INICIAR A ANIMAÇÃO!
    if (instance_exists(puzzle_controller)) {
        if (puzzle_controller.open_puzzle(puzzle_id)) {
            // Se o puzzle abriu com sucesso, inicia a animação visual de expansão
            is_expanding = true;
            expand_progress = 0;
            is_interactable = false; // Desabilita interação enquanto o puzzle está aberto/expandindo
            alarm[0] = 300; // Opcional: Adicionar um timer para reativar a interação caso o puzzle seja fechado sem resolver
        } else {
            // Se não foi possível abrir o puzzle (talvez já esteja ativo ou ID inválido)
            show_debug_message("DEBUG: Não foi possível abrir o puzzle (obj_scripture).");
            is_interactable = true; // Reativa a interação se o puzzle não abriu
        }
    } else {
        show_debug_message("ERRO: puzzle_controller não encontrado ao tentar abrir o puzzle em obj_scripture.");
        is_interactable = true; // Reativa a interação se não há controller
    }
}

// Função chamada quando o puzzle é resolvido (deve ser chamada pelo controlador)
function mark_as_solved() {
    is_solved = true;
    glow_alpha = 0;
    // Aqui poderias mudar o sprite para uma versão "resolvida"
    // sprite_index = spr_ui_books_solved;
}