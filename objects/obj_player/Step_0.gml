//Iniciando as variáveis

var _right, _left, _jump, _attack;
var _chao = place_meeting(x, y + 1, obj_block);

_right = keyboard_check(ord("D"));
_left = keyboard_check(ord("A"));
_jump = keyboard_check_pressed(ord("K"));

// Código de movimentação

velh = (_right - _left) * velh_maxima;

//Aplicando gravidade

if (!_chao)
{
	if (velv < velv_maxima * 2) //Pra queda ser mais lenta
	{
	velv += GRAVIDADE * massa;
	}
}
else //Pular se estiver no chão OBS: pulo nao esta funcionando ainda
{
	if (_jump)
	{
		velv = -velv_maxima;
	}
}
