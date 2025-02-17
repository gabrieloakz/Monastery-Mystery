// Verifica se o jogador não existe na room e cria ele se necessário
if (!instance_exists(obj_player)) {
    instance_create_layer(0, 0, "Instances", obj_player); // Certifique-se de usar a camada correta
}

