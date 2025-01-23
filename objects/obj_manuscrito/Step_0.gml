// obj_manuscrito - Evento Step
if (espada_visivel) {
    // Cria a espada próxima ao manuscrito, mas só se a espada ainda não existir
    if (!instance_exists(obj_sword)) {
        instance_create_layer(x + 32, y, "Instances", obj_sword); 
    }
}
