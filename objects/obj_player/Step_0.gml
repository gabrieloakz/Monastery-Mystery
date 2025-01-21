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

//Anti ghosting
if (_right and _left)
{
	estado = "parado";
	velh = 0;
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
		else if (_jump)
		{
			estado = "pulando";
			velv = -velv_maxima;
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
		else if (_jump)
		{
			estado = "pulando";
			velv = -velv_maxima;
		}
		
		break;
	} 
	
	case "pulando":
	{
		// Se player no ar 
		if(velv > 0)
		{
			sprite_index = spr_player_fall;
		}
		else
		{
			sprite_index = spr_player_jump;
			//Garantindo que a animação não se repita
			if(image_index >= image_number - 1)
			{
				image_index = image_number -1;
			}
		}
		
		//Condição de troca de estado
		if (_chao)
		{
			estado = "parado";
		}
		
		break;
	}
}