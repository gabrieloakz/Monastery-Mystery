/// @description Draw
if (visible) {
    var text_width = string_width(current_text); // Calcula a largura do texto
    var box_width = max(256, text_width + 32); // Define o tamanho mínimo da caixa
    var box_x = (room_width - box_width) / 2; // Centraliza horizontalmente
    var box_y = room_height - 128; // Posição fixa na parte inferior

    draw_set_font(fnt_text);
    draw_sprite_ext(spr_textbox, 0, box_x, box_y, box_width / sprite_get_width(spr_textbox), 1, 0, c_white, 1); // Redimensiona a caixa
    draw_set_color(c_black);
    draw_text(box_x + 16, box_y + 16, current_text); // Desenha o texto dentro da caixa
}