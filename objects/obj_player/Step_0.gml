// Verifica se os controles estão ativos
if (obj_controller.player_controls) {
    // Captura de inputs
    var _right = keyboard_check(ord("D"));
    var _left = keyboard_check(ord("A"));
    var _jump = keyboard_check_pressed(vk_space);
    var _attack = keyboard_check_pressed(ord("J"));

    // Movimento horizontal (respeita a velocidade definida no CREATE)
    var move = _right - _left;
    velh = move * velh_maxima;

    // Aplica gravidade (respeita a velocidade definida no CREATE)
    var _chao = place_meeting(x, y + 1, obj_block);
    if (!_chao) {
        velv += gravity * massa;
    } else {
        velv = 0; // Reseta a velocidade vertical ao tocar o chão
    }

    // Anti-ghosting (impede movimento simultâneo para ambos os lados)
    if (_right && _left) {
        velh = 0;
    }

    // Direção do personagem
    if (velh != 0) {
        xscale = sign(velh); // Vira o personagem para a direção do movimento
    }

    // Lógica de estados
    switch (estado) {
        case "parado":
            // Define o sprite baseado na interação com a espada
            if (player_interacts_with_sword) {
                sprite_index = spr_player_parado2; // Sprite parado com espada
            } else {
                sprite_index = spr_player_parado1; // Sprite parado sem espada
            }

            // Troca de estado
            if (velh != 0) {
                estado = "movendo";
            } else if (_jump) {
                estado = "pulando";
                velv = -velv_maxima; // Aplica força do pulo (velocidade original)
                image_index = 0; // Reinicia a animação
            } else if (_attack) {
                estado = "ataque";
                velh = 0; // Para o movimento durante o ataque
                image_index = 0; // Reinicia a animação
            }
            break;

        case "movendo":
            // Define o sprite baseado na interação com a espada
            if (player_interacts_with_sword) {
                sprite_index = spr_guardar_espada; // Sprite de corrida com espada
                image_speed = 0.001; // Animação lenta
            } else {
                sprite_index = spr_player_run; // Sprite de corrida sem espada
                image_speed = 1; // Animação normal
            }

            // Troca de estado
            if (abs(velh) < 0.1) {
                estado = "parado";
                velh = 0;
            } else if (_jump) {
                estado = "pulando";
                velv = -velv_maxima; // Aplica força do pulo (velocidade original)
                image_index = 0; // Reinicia a animação
            }
            break;

        case "pulando":
            // Define o sprite baseado na interação com a espada
            if (player_interacts_with_sword) {
                sprite_index = spr_player_parado2; // Sprite de pulo com espada
            } else {
                sprite_index = spr_player_jump; // Sprite de pulo sem espada
            }

            // Define a sprite de queda ou pulo
            if (velv > 0) {
                sprite_index = spr_player_fall; // Sprite de queda
            } else {
                sprite_index = spr_player_jump; // Sprite de pulo
                if (image_index >= image_number - 1) {
                    image_index = image_number - 1; // Congela no último frame
                }
            }

            // Troca de estado ao pousar no chão
            if (_chao) {
                estado = "parado";
            }
            break;

        case "ataque":
            // Para o movimento horizontal durante o ataque
            velh = 0;

            // Define a sprite correspondente ao combo atual
            switch (combo) {
                case 0:
                    sprite_index = spr_player_attack1;
                    break;
                case 1:
                    sprite_index = spr_player_attack2;
                    break;
                case 2:
                    sprite_index = spr_player_attack3;
                    break;
                default:
                    sprite_index = spr_player_parado1; // Sprite padrão se algo der errado
                    break;
            }

            // Avança no combo se possível e se o cooldown estiver pronto
            if (_attack && combo < 2 && image_index >= (image_number - 2)) {
                if (combo_cooldown == 0) { // Verifica se o cooldown terminou
                    combo++;
                    image_index = 0; // Reinicia o frame da animação
                    combo_cooldown = 10; // Define o tempo de recarga (em steps)
                }
            }

            // Volta ao estado "parado" ao finalizar o combo
            if (image_index >= image_number - 1) {
                estado = "parado";
                velh = 0;
                combo = 0;
                combo_cooldown = 0; // Reseta o cooldown ao finalizar o combo
            }
            break;
    }

    

    // Animação básica
    image_xscale = xscale; // Direção do personagem
    image_speed = img_spd / game_get_speed(gamespeed_fps); // Velocidade da animação
}
else {
    // Quando o menu está ativo, o player fica totalmente parado
    estado = "parado";
    velh = 0;
    velv = 0;
    image_speed = 0; // Congela a animação
    sprite_index = spr_player_parado1; // Sprite parado
    image_index = 0; // Frame inicial da animação
}