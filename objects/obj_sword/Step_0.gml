// obj_sword - Evento Step
if (instance_exists(obj_manuscrito)) {
    // Verifica a variável espada_visivel no manuscrito
    if (obj_manuscrito.espada_visivel) {
		visible = true; // Torna a espada visível
    } else {
        visible = false; // Torna a espada invisível
    }
} 