// Colidiu com o sensor?

if (room_change)
{
	alpha -= .01;
}
else 
{
	alpha += .01;
}

// Transição de room
if (alpha >= 1)
{
	room_goto(goal);
	
	//Levar o player
	obj_player.x = goal_x;
	obj_player.y = goal_y;
}