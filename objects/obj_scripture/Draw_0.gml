// obj_scripture Draw Event
/// @description Draw - Efeitos visuais aprimorados

// Só desenha se foi descoberta
if (!is_discovered) {
    exit;
}

// Calcula o centro do sprite
var center_x = x;
var center_y = y - sprite_height/4; // Ajuste vertical para centralizar o brilho

// Se estiver expandindo, ajusta a escala
if (is_expanding) {
    var current_scale = lerp(original_scale, final_scale, expand_progress);
    draw_sprite_ext(sprite_index, image_index, x, y, 
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
    
    // Desenha o sprite principal
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