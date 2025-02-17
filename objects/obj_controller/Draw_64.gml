
// Transição de fade
draw_set_alpha(fade_alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Menu
if (menu_active) {
    // Título (centralizado, mais acima)
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_font(font_title);
    draw_text(display_get_gui_width() / 2, 50, "Monastery Mystery"); // Título
    
    // Opções (centralizadas, abaixo do título)
    draw_set_font(font_menu);
    var start_y = 80; // Posição inicial das opções
    var spacing = 30; // Espaçamento entre as opções
    
    for (var i = 0; i < array_length(menu_options); i++) {
        var option_y = start_y + (i * spacing);
        
        // Play e Exit usam lógica de cor
        if (i != 1) {
            var option_color = (i == selected_option) ? c_yellow : c_white;
            draw_set_color(option_color);
            draw_text(display_get_gui_width() / 2, option_y, menu_options[i]);
        }
        // Options sempre cinza
        else {
            draw_set_color(c_gray);
            draw_text(display_get_gui_width() / 2, option_y, "Options (Em breve)");
        }
    }
    
    for (var i = 0; i < array_length(menu_options); i++) {
        var option_y = start_y + (i * spacing); // Renomeei "y" para "option_y"
        var option_color = c_white; // Cor padrão
        
        // Destacar opção selecionada
        if (i == selected_option) {
            option_color = c_yellow;
        }
        
        // Desativar "Options"
        if (menu_options[i] == "Options") {
            option_color = c_gray;
            draw_text(display_get_gui_width() / 2, option_y, "Options (Em breve)");
        } else {
            draw_set_color(option_color);
            draw_text(display_get_gui_width() / 2, option_y, menu_options[i]);
        }
    }
}