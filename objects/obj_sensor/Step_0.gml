//Checar se o player colidiu no sensor
var player = place_meeting(x, y, obj_player);

//Ativar transição

var w = keyboard_check_released(ord("W"))

//Se apertou a tecla espaço
if (player && w)
{
	//Transição
	var tran = instance_create_layer(0, 0, layer, obj_transition);
	tran.goal = goal;
	tran.goal_x = goal_y;
	tran.goal_y = goal_y;
	
}
