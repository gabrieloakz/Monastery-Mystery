// Evento DRAW GUI do obj_controller
// Transição de fade
draw_set_alpha(fade_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Menu
if (menu_active) {
    // Configurações de fonte para título
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(font_title);
    draw_set_color(c_white);
    
    // Título centralizado
    draw_text(display_get_gui_width() / 2, 30, "Monastery Mystery");
    
    // Configurações para opções do menu
    draw_set_font(font_menu);
    var start_y = 80;
    var spacing = 30;
    
    for (var i = 0; i < array_length(menu_options); i++) {
        var option_y = start_y + (i * spacing);
        
        // Play e Exit com highlight
        if (i != 1) {
            var color = (i == selected_option) ? c_yellow : c_white;
            draw_set_color(color);
            draw_text(display_get_gui_width() / 2, option_y, menu_options[i]);
        }
        // Options fixo em cinza
        else {
            draw_set_color(c_gray);
            draw_text(display_get_gui_width() / 2, option_y, "Options (Em breve)");
        }
    }
}