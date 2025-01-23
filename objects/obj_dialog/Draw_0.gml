// obj_monge - Evento Draw
draw_self();

if (falando) {
    draw_rectangle_color(50, 400, 750, 470, c_black, c_black, c_black, c_black, false);
    draw_text(70, 420, dialogo[index_dialogo]);
}
