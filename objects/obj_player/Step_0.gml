// Iniciando as variáveis
var _right, _left, _jump, _attack;
var _chao = place_meeting(x, y + 1, obj_block);

// Variável para verificar se o jogador interagiu com a espada
var player_interacts_with_sword = false;

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);

// Código de movimentação
velh = (_right - _left) * velh_maxima;

// Aplicando gravidade
if (!_chao)
{
    velv += gravity * massa;
}

// Anti ghosting
if (_right and _left)
{
    estado = "parado";
    velh = 0;
}

// Verificação de interação com a espada
if (instance_exists(obj_sword)) {
    if (place_meeting(x, y, obj_sword)) {
        player_interacts_with_sword = true;  // Define a variável para indicar que o jogador interagiu com a espada
    } else {
        player_interacts_with_sword = false; // Reseta a variável quando não há interação
    }
}

switch(estado)
{
    case "parado":
    {
        // Se o jogador está interagindo com a espada, muda o sprite para o "parado" com espada
        if (player_interacts_with_sword) {
            sprite_index = spr_player_parado2;  // Sprite para quando o jogador está parado com espada
        } else {
            sprite_index = spr_player_parado1;  // Sprite normal sem espada
        }

        // Comportamento do estado
        if (_right || _left) {
            estado = "movendo";
        }
        else if (_jump) {
            estado = "pulando";
            velv = -velv_maxima;
        }
        
        break;
    }

    case "movendo":
    {
        // Se o jogador está interagindo com a espada, muda o sprite para o "guardando" a espada
    if (player_interacts_with_sword) {
        sprite_index = spr_guardar_espada;  // Sprite para quando o jogador guarda a espada
        image_speed = 0.001;  // Controla a velocidade da animação (valor menor para mais lento)
    } else {
        sprite_index = spr_player_run;  // Sprite normal de corrida (sem espada)
        image_speed = 1;  // Velocidade normal da animação
    }

        // Comportamento do estado
        if (abs(velh) < .1) {
            estado = "parado";
            velh = 0;
        }
        else if (_jump) {
            estado = "pulando";
            velv = -velv_maxima;
        }
        
        break;
    }

    case "pulando":
    {
        // Se o jogador está interagindo com a espada, muda o sprite para o "pulando" com espada
        if (player_interacts_with_sword) {
            sprite_index = spr_player_parado2;  // Sprite para quando o jogador está pulando com espada
        } else {
            sprite_index = spr_player_jump;  // Sprite normal de pulo
        }

        // Se player no ar
        if(velv > 0) {
            sprite_index = spr_player_fall;
        }
        else {
            sprite_index = spr_player_jump;
            // Garantindo que a animação não se repita
            if(image_index >= image_number - 1) {
                image_index = image_number -1;
            }
        }

        // Condição de troca de estado
        if (_chao) {
            estado = "parado";
        }

        break;
    }
}
