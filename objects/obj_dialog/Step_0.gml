// obj_monge - Evento Step
if (falando && keyboard_check_pressed(vk_space)) {
    if (index_dialogo < array_length(dialogo) - 1) {
        index_dialogo++;
    } else {
        falando = false; // Termina o diálogo
        instance_create_layer(x, y, "manuscrito", obj_manuscrito); // Entrega o manuscrito
    }
}
