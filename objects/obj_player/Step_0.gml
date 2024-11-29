//Iniciando as variáveis

var _right, _left, _jump, _attack;
var _chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(vk_space);

// Código de movimentação

velh = (_right - _left) * velh_maxima;

//Aplicando gravidade

if (!_chao)
{
	velv += gravity * massa;
}
else //Pular se estiver no chão OBS: PULO AGORA FUNCIONA
{
	if (_jump)
	{
		velv =-6
	}
}

switch(estado)
{
	case "parado":
	{
		//Comportamento do estado
		sprite_index = spr_player_parado1
		
		//Condição de troca de estado 
		if (_right || _left)              
		{
			estado = "movendo"
		}
		
		break;
		
	}
	
	case "movendo":
	{
		//Comportamento do estado
		sprite_index = spr_player_run
		
		
		//Condição de troca de estado para parar
		if (abs(velh) < .1)              
		{
			estado = "parado";
			velh = 0;
		}
		
		break;
		
		
	} 
}