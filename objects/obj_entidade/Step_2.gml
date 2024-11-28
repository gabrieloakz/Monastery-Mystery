//Sistema de colisão e movimentação


//Cadastra o valor das variáveis
var _velh  = sign(velh);
var _velv  = sign(velv);

//Horizontal
repeat(abs(velh))
{
	if (place_meeting(x + _velh, y,obj_block))
	{
		velh = 0;
		break;
	}
	
	x += _velh;
}

//Vertical
if place_meeting(x, y + velv, obj_block){
	while !place_meeting(x, y+sign(velv), obj_block){
		y = y + sign(velv);
	}
	velv = 0;
}
y = y + velv;