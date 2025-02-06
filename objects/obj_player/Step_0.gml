// Iniciando as variáveis
var _right, _left, _jump, _attack;
var _chao = place_meeting(x, y + 1, obj_block);
var player_interacts_with_sword = false;

// Capturando entradas do teclado
_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);
_attack = keyboard_check_pressed(ord("J"));

// Aplicando movimentação horizontal
velh = (_right - _left) * velh_maxima;

// Aplicando gravidade
if (!_chao) {
    velv += gravity * massa;
}

// Anti ghosting (impedir que o jogador pressione direção oposta ao mesmo tempo)
if (_right && _left) {
    estado = "parado";
    velh = 0;
}

// Verificação de interação com a espada
if (instance_exists(obj_sword)) {
    if (place_meeting(x, y, obj_sword)) {
        player_interacts_with_sword = true; // Define a variável para indicar que o jogador interagiu com a espada
    } else {
        player_interacts_with_sword = false; // Reseta a variável quando não há interação
    }
}

// Reduzindo o cooldown entre ataques
if (combo_cooldown > 0) {
    combo_cooldown -= 1; // Diminui o cooldown a cada step
}

// Lógica de estados
switch (estado) {
    case "parado":
        {
            // Define o sprite baseado na interação com a espada
            if (player_interacts_with_sword) {
                sprite_index = spr_player_parado2; // Sprite para quando o jogador está parado com espada
            } else {
                sprite_index = spr_player_parado1; // Sprite normal sem espada
            }

            // Troca de estado
            if (_right || _left) {
                estado = "movendo";
            } else if (_jump) {
                estado = "pulando";
                velv = -velv_maxima;
                image_index = 0;
            } else if (_attack) {
                estado = "ataque";
                velh = 0;
                image_index = 0;
            }
            break;
        }

    case "movendo":
        {
            // Define o sprite baseado na interação com a espada
            if (player_interacts_with_sword) {
                sprite_index = spr_guardar_espada; // Sprite para quando o jogador guarda a espada
                image_speed = 0.001; // Controla a velocidade da animação (valor menor para mais lento)
            } else {
                sprite_index = spr_player_run; // Sprite normal de corrida (sem espada)
                image_speed = 1; // Velocidade normal da animação
            }

            // Troca de estado
            if (abs(velh) < 0.1) {
                estado = "parado";
                velh = 0;
            } else if (_jump) {
                estado = "pulando";
                velv = -velv_maxima;
            }
            break;
        }

    case "pulando":
        {
            // Define o sprite baseado na interação com a espada
            if (player_interacts_with_sword) {
                sprite_index = spr_player_parado2; // Sprite para quando o jogador está pulando com espada
            } else {
                sprite_index = spr_player_jump; // Sprite normal de pulo
            }

            // Define a sprite de queda ou pulo
            if (velv > 0) {
                sprite_index = spr_player_fall;
            } else {
                sprite_index = spr_player_jump;

                // Garantindo que a animação não se repita
                if (image_index >= image_number - 1) {
                    image_index = image_number - 1;
                }
            }

            // Troca de estado ao pousar no chão
            if (_chao) {
                estado = "parado";
            }
            break;
        }

    case "ataque":
        {
            // Parar o movimento horizontal durante o ataque
            velh = 0;

            // Define a sprite correspondente ao combo atual
            switch (combo) {
                case 0:
                    sprite_index = spr_player_attack1;
                    break;
                case 1:
                    sprite_index = spr_player_attack2;
                    break;
                case 2: // Corrigido para 2, pois o combo máximo é 3 (0, 1, 2)
                    sprite_index = spr_player_attack3;
                    break;
                default:
                    sprite_index = spr_player_parado1; // Sprite padrão se algo der errado
                    break;
            }

            // Avançar no combo se possível e se o cooldown estiver pronto
            if (_attack && combo < 2 && image_index >= (image_number - 2)) {
                if (combo_cooldown == 0) { // Verifica se o cooldown terminou
                    combo++;
                    image_index = 0; // Reinicia o frame da animação
                    combo_cooldown = 10; // Define o tempo de recarga (em steps)
                }
            }

            // Voltar ao estado "parado" ao finalizar o combo
            if (image_index >= image_number - 1) {
                estado = "parado";
                velh = 0;
                combo = 0;
                combo_cooldown = 0; // Reseta o cooldown ao finalizar o combo
            }
            break;
        }
}