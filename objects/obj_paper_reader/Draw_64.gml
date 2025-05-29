/// @description Renderizar texto na GUI

if (!visible || !text_active) exit;

// Calcula a posição centralizada
var screen_w = display_get_gui_width();
var screen_h = display_get_gui_height();
var x1 = (screen_w - text_width) / 2;
var y1 = (screen_h - text_height) / 2;
var x2 = x1 + text_width;
var y2 = y1 + text_height;

// Desenha o fundo e a borda
draw_set_color(c_black);
draw_set_alpha(0.9);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(c_white);
draw_set_alpha(1);
draw_rectangle(x1, y1, x2, y2, true);

// Configura a fonte
draw_set_font(text_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Cria uma superfície de clipping para o texto
var text_surface = surface_create(text_width - (text_margin * 2), text_height - (text_margin * 2));
surface_set_target(text_surface);
draw_clear_alpha(c_black, 0);

// Desenha o texto com efeito de máquina de escrever
var displayed_text = string_copy(current_text, 1, floor(char_index));
var wrapped_text = string_wrap(displayed_text, text_width - (text_margin * 2));
draw_text(0, -scroll_position, wrapped_text);

// Retorna ao surface padrão e desenha o texto
surface_reset_target();
draw_surface(text_surface, x1 + text_margin, y1 + text_margin);
surface_free(text_surface);

// Desenha o indicador de scroll se houver mais texto
if (typing_complete && max_scroll > 0) {
    var scroll_height = text_height * (text_height / (text_height + max_scroll));
    var scroll_y = y1 + (text_height * (scroll_position / (max_scroll + text_height)));
    
    draw_set_color(c_white);
    draw_set_alpha(0.5);
    draw_rectangle(x2 + 5, scroll_y, x2 + 10, scroll_y + scroll_height, false);
    draw_set_alpha(1);
}

// Reseta as configurações de desenho
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);