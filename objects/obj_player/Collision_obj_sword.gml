// Evento de colisão ou interação do jogador com a espada (obj_player)
if (instance_exists(obj_sword)) {
    // Verifica se há colisão ou proximidade com a espada
    if (place_meeting(x, y, obj_sword)) {
        player_interacts_with_sword = true;  // Define a variável para indicar que o jogador interagiu com a espada
    } else {
        player_interacts_with_sword = false; // Reseta a variável quando não há interação
    }
    
    // Se o jogador interagir com a espada, troca o sprite
    if (player_interacts_with_sword) {
        sprite_index = spr_player_parado2;
        // A posição do jogador permanece a mesma, não há alteração nas variáveis x e y
    }
}
