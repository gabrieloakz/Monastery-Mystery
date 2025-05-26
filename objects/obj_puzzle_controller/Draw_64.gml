// obj_puzzle_controller Draw GUI Event
/// @description Desenha a interface do sistema de puzzles

// Só desenha se o sistema estiver ativo
if (current_state == PuzzleState.INACTIVE || ui_alpha <= 0) {
    exit;
}

// Aplica a transparência atual
draw_set_alpha(ui_alpha);

// Desenha overlay escuro de fundo (para dar foco à interface)
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(ui_alpha * 0.7); // Overlay um pouco mais transparente

// Desenha o fundo principal da interface (simula pergaminho antigo)
draw_set_color(bg_color);
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, false);

// Desenha borda decorativa
draw_set_color(border_color);
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, true);
// Borda dupla para efeito mais elegante
draw_rectangle(ui_x + 4, ui_y + 4, ui_x + ui_width - 4, ui_y + ui_height - 4, true);

// Volta à transparência total para o texto
draw_set_alpha(ui_alpha);

// Só prossegue se tivermos dados do puzzle
if (current_puzzle_data == noone) {
    draw_set_alpha(1);
    exit;
}

// Configura fonte e cor padrão para texto
draw_set_font(fnt_text); // Assumes que tens uma fonte chamada fnt_text
draw_set_color(text_color);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Desenha o título do puzzle
var title = ds_map_find_value(current_puzzle_data, "title");
draw_set_color(accent_color);
draw_set_font(fnt_title); // Fonte maior para título, se tiveres
draw_text(ui_x + 20, title_y, title);

// Desenha a descrição
draw_set_color(text_color);
draw_set_font(fnt_text);
var description = ds_map_find_value(current_puzzle_data, "description");
draw_text_ext(ui_x + 20, description_y, description, 20, ui_width - 40);

// Desenha a área do código (com fundo diferenciado)
var code_bg_color = make_color_rgb(30, 25, 20); // Mais escuro que o fundo principal
draw_set_color(code_bg_color);
draw_rectangle(ui_x + 20, code_area_y, ui_x + ui_width - 20, code_area_y + code_area_height, false);

// Borda da área de código
draw_set_color(border_color);
draw_rectangle(ui_x + 20, code_area_y, ui_x + ui_width - 20, code_area_y + code_area_height, true);

// Desenha o código do puzzle com formatação especial
draw_set_color(make_color_rgb(200, 200, 200)); // Cor de código (cinza claro)
draw_set_font(fnt_code); // Fonte monoespaçada se tiveres, senão usa fnt_text
var code_template = ds_map_find_value(current_puzzle_data, "code_template");

// Processa o template do código para destacar as lacunas
var processed_code = process_code_template(code_template);
draw_text_ext(ui_x + 30, code_area_y + 10, processed_code, 18, ui_width - 60);

// Desenha área de input do jogador
draw_set_color(make_color_rgb(50, 45, 40));
var input_box_y = input_area_y;
var input_box_height = 35;
draw_rectangle(ui_x + 20, input_box_y, ui_x + ui_width - 20, input_box_y + input_box_height, false);

// Borda da área de input
draw_set_color(accent_color);
draw_rectangle(ui_x + 20, input_box_y, ui_x + ui_width - 20, input_box_y + input_box_height, true);

// Label da área de input
draw_set_color(text_color);
draw_text(ui_x + 25, input_box_y - 20, "Sua resposta:");

// Texto do input do jogador
draw_set_color(make_color_rgb(255, 255, 255));
draw_text(ui_x + 30, input_box_y + 8, player_input);

// Cursor piscante
if (show_cursor && current_state == PuzzleState.ACTIVE) {
    var cursor_x = ui_x + 30 + string_width(player_input);
    draw_line(cursor_x, input_box_y + 5, cursor_x, input_box_y + input_box_height - 5);
}

// Desenha dica se disponível
var hint = ds_map_find_value(current_puzzle_data, "hint");
if (hint != undefined && hint != "") {
    draw_set_color(make_color_rgb(150, 130, 100)); // Cor mais suave para dica
    draw_text_ext(ui_x + 20, hint_y, "Dica: " + hint, 16, ui_width - 40);
}

// Desenha botões de ação
draw_buttons();

// Desenha feedback se houver
if (feedback_message != "" && feedback_timer > 0) {
    draw_feedback();
}

// Desenha botão de fechar (X no canto superior direito)
draw_close_button();

// Restaura configurações de desenho
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Função para processar o template do código e destacar lacunas
function process_code_template(template) {
    // Por agora, simplesmente substitui _____ por [LACUNA]
    // Mais tarde podes fazer isto mais sofisticado
    var processed = string_replace_all(template, "_____", "[LACUNA]");
    return processed;
}

// Função para desenhar botões
function draw_buttons() {
    // Botão Submeter
    var submit_btn_x = ui_x + ui_width - 120;
    var submit_btn_y = button_area_y;
    var submit_btn_w = 100;
    var submit_btn_h = 30;
    
    // Verifica se o mouse está sobre o botão
    var mouse_over_submit = point_in_rectangle(mouse_x, mouse_y, submit_btn_x, submit_btn_y, 
                                              submit_btn_x + submit_btn_w, submit_btn_y + submit_btn_h);
    
    // Cor do botão baseada no estado
    if (mouse_over_submit) {
        draw_set_color(make_color_rgb(220, 160, 30)); // Dourado mais claro
    } else {
        draw_set_color(accent_color);
    }
    
    draw_rectangle(submit_btn_x, submit_btn_y, submit_btn_x + submit_btn_w, submit_btn_y + submit_btn_h, false);
    
    // Borda do botão
    draw_set_color(border_color);
    draw_rectangle(submit_btn_x, submit_btn_y, submit_btn_x + submit_btn_w, submit_btn_y + submit_btn_h, true);
    
    // Texto do botão
    draw_set_color(c_black);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(submit_btn_x + submit_btn_w/2, submit_btn_y + submit_btn_h/2, "Submeter");
    
    // Restaura alinhamento
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Função para desenhar feedback
function draw_feedback() {
    var feedback_y = ui_y + ui_height - 40;
    
    // Fundo do feedback
    draw_set_color(make_color_rgb(0, 0, 0));
    draw_set_alpha(ui_alpha * 0.8);
    draw_rectangle(ui_x + 20, feedback_y - 5, ui_x + ui_width - 20, feedback_y + 25, false);
    
    // Texto do feedback
    draw_set_alpha(ui_alpha);
    draw_set_color(feedback_color);
    draw_set_halign(fa_center);
    draw_text(ui_x + ui_width/2, feedback_y, feedback_message);
    draw_set_halign(fa_left);
}

// Função para desenhar botão de fechar
function draw_close_button() {
    var close_x = ui_x + ui_width - 30;
    var close_y = ui_y + 10;
    
    // Verifica se o mouse está sobre o botão
    var mouse_over_close = point_in_rectangle(mouse_x, mouse_y, close_x, close_y, close_x + 20, close_y + 20);
    
    // Cor do botão X
    if (mouse_over_close) {
        draw_set_color(error_color);
    } else {
        draw_set_color(make_color_rgb(100, 100, 100));
    }
    
    // Desenha o X
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(close_x + 10, close_y + 10, "X");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}