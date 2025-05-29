/// @description Inicializar leitor de texto

// Controle de visibilidade e estado
visible = true;
text_active = true;
full_screen = true;

// Variáveis de texto
current_text = "";
text_speed = 0.5;
char_index = 0;
typing_complete = false;

// Variáveis de scroll
scroll_position = 0;
scroll_speed = 20;
max_scroll = 0;

// Dimensões do texto
text_width = 800;
text_height = 600;
text_margin = 40;

// Fonte e formatação
text_font = fnt_text;
draw_set_font(text_font);
line_height = string_height("M") * 1.5;

// Callback para quando o leitor for fechado
on_close = noone;

/// @function setup_text(text)
/// @param {string} text O texto a ser exibido
function setup_text(text) {
    current_text = text;
    char_index = 0;
    typing_complete = false;
    scroll_position = 0;
    
    // Calcula a altura máxima do texto para o scroll
    var str_w = text_width - (text_margin * 2);
    var wrapped_text = string_wrap(current_text, str_w);
    var num_lines = string_count("\n", wrapped_text) + 1;
    max_scroll = max(0, (num_lines * line_height) - (text_height - (text_margin * 2)));
}

/// @function close_reader()
function close_reader() {
    if (on_close != noone) {
        on_close();
    }
    instance_destroy();
}