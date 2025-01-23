//Checar se o player colidiu no sensor
var player = place_meeting(x, y, obj_player);

//Ativar transição

var space = keyboard_check_released(vk_space)

//Se apertou a tecla espaço
if (player && space)
{
	//Transição
	var tran = instance_create_layer(0, 0, layer, obj_transition);
	tran.goal = goal;
	tran.goal_x = goal_y;
	tran.goal_y = goal_y;
	
}