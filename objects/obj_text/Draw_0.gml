/// @description Draw
if (visible) {
    var text_width = string_width(current_text); // Calcula a largura do texto
    var box_width = max(400, text_width + 64); // Aumenta o tamanho mínimo da caixa e o padding
    var box_x = (room_width - box_width) / 2; // Centraliza horizontalmente
    var box_y = room_height - 160; // Aumenta a distância do fundo

    // Desenha a caixa
    draw_set_font(fnt_text);
    draw_sprite_ext(
        spr_textbox, 0,
        box_x, box_y,
        box_width / sprite_get_width(spr_textbox), 1,
        0, c_white, 1
    );
    
    // Desenha o texto com wrapping
    var wrap_width = box_width - 48;    // Aumenta a margem interna
    var line_height = 12;               // Define a altura da linha
    draw_set_color(c_black);
    draw_text_ext(
        box_x + 24, box_y + 24,         // Aumenta o padding interno
        current_text,                    // string
        line_height,                     // altura da linha
        wrap_width                       // largura máxima antes de quebrar
    );
}