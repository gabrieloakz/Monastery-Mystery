// obj_scripture Draw Event
/// @description Draw - Efeitos visuais aprimorados

// Só desenha se foi descoberta
if (!is_discovered) {
    exit;
}

// Calcula o centro do sprite para efeitos como o brilho
var center_x = x;
var center_y = y; // Alterado para usar o centro real do sprite (Origin: Middle Centre)

// Se estiver expandindo, ajusta a escala e a posição para centralizar na vista
if (is_expanding) {
    var current_scale = lerp(original_scale, final_scale, expand_progress);

    // Calcula o centro da vista atual
    var view_center_x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
    var view_center_y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;

    // Interpola a posição do objeto da sua posição original para o centro da vista
    var draw_pos_x = lerp(x, view_center_x, expand_progress);
    var draw_pos_y = lerp(y, view_center_y, expand_progress);

    // MENSAGENS DE DEBUG - AJUDAM A DIAGNOSTICAR O PORQUÊ DE ESTAR A FUGIR
    show_debug_message("DEBUG: Expansão - current_scale: " + string(current_scale) + ", final_scale: " + string(final_scale));
    show_debug_message("DEBUG: Expansão - view_width: " + string(camera_get_view_width(view_camera[0])) + ", view_height: " + string(camera_get_view_height(view_camera[0])));
    show_debug_message("DEBUG: Expansão - sprite_width: " + string(sprite_width) + ", sprite_height: " + string(sprite_height));
    show_debug_message("DEBUG: Expansão - draw_pos_x: " + string(draw_pos_x) + ", draw_pos_y: " + string(draw_pos_y));

    // Desenha o sprite com a escala e posição interpoladas
    draw_sprite_ext(sprite_index, image_index, 
                    draw_pos_x, draw_pos_y, 
                    current_scale, current_scale, 0, c_white, 1);
} else {
    // Desenha efeito de brilho se não foi resolvida
    if (!is_solved && glow_alpha > 0) {
        // Brilho dourado ao redor da escritura
        draw_set_alpha(glow_alpha * 0.3);
        draw_set_color(make_color_rgb(255, 215, 0)); // Dourado
        
        // Desenha múltiplos círculos para criar efeito de brilho
        for (var i = 1; i <= 3; i++) {
            draw_circle(center_x, center_y, 25 + (i * 8), true);
        }
        
        draw_set_alpha(1);
        draw_set_color(c_white);
    }
    
    // Desenha o sprite principal na sua posição normal
    draw_self();
}

// Desenha indicador visual se resolvida
if (is_solved) {
    // Marca de "check" ou símbolo de completado
    draw_set_color(make_color_rgb(34, 139, 34)); // Verde
    draw_set_alpha(0.8);
    
    // Desenha um círculo verde pequeno no canto
    draw_circle(x + sprite_width/4, y - sprite_height/4, 8, false);
    
    // Desenha um "✓" simples
    draw_set_color(c_white);
    draw_set_alpha(1);
    var check_x = x + sprite_width/4;
    var check_y = y - sprite_height/4;
    draw_line_width(check_x - 3, check_y, check_x - 1, check_y + 2, 2);
    draw_line_width(check_x - 1, check_y + 2, check_x + 3, check_y - 2, 2);
}

// Reset das configurações de desenho
draw_set_alpha(1);
draw_set_color(c_white);