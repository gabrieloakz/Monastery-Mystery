// Em obj_scripture/Draw_0.gml
/// @description Draw
// Desenha o sprite normal quando fechado
if (!is_open) {
    draw_self();
}

// Desenha a versão grande quando aberto
if (is_open) {
    // Desenha o overlay escuro
    draw_set_alpha(fade_alpha * 0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1);
    
    // Calcula o tamanho da folha (80% da tela)
    var box_width = room_width * 0.8;
    var box_height = room_height * 0.8;
    var box_x = (room_width - box_width) / 2;
    var box_y = (room_height - box_height) / 2;
    
    // Desenha o sprite da escritura em tamanho maior
    draw_sprite_ext(
        spr_ui_books, 0,
        box_x, box_y,
        box_width / sprite_get_width(spr_ui_books),
        box_height / sprite_get_height(spr_ui_books),
        0, c_white, 1
    );
    
    // Desenha o texto sobre a escritura
    var wrap_width = box_width - 128;
    var line_height = 20;
    draw_set_color(c_black);
    draw_set_font(fnt_text);
    draw_text_ext(
        box_x + 64, box_y + 64,
        string_copy(text_content, 1, floor(char_index)),
        line_height,
        wrap_width
    );
}