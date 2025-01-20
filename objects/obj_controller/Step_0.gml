// Posição do personagem (obj_player)
var player_x = obj_player.x;
var player_y = obj_player.y;

// Configuração da câmara
var camera_width = camera_get_view_width(view_camera[0]);
var camera_height = camera_get_view_height(view_camera[0]);

// Centraliza a câmara no jogador
var camera_x = player_x - camera_width / 2;
var camera_y = player_y - camera_height / 2;

// Impede que a câmara saia dos limites da room
camera_x = clamp(camera_x, 0, room_width - camera_width);
camera_y = clamp(camera_y, 0, room_height - camera_height);

// Atualiza a posição da câmara
camera_set_view_pos(view_camera[0], camera_x, camera_y);

// Velocidades do parallax para diferentes camadas de fundo
var parallax_speed_1 = 1;    // Velocidade para o fundo mais próximo
var parallax_speed_2 = 0.5;  // Velocidade para o fundo intermediário
var parallax_speed_3 = 0.2;  // Velocidade para o fundo mais distante

// Calcula as posições dos fundos com base na posição da câmara
background_x[0] = -camera_x * parallax_speed_1;  // Camada 1 (mais próxima)
background_x[1] = -camera_x * parallax_speed_2;  // Camada 2 (intermediária)
background_x[2] = -camera_x * parallax_speed_3;  // Camada 3 (mais distante)

// Debugging opcional para ver as posições dos fundos
show_debug_message("Background 1 X: " + string(background_x[0]));
show_debug_message("Background 2 X: " + string(background_x[1]));
show_debug_message("Background 3 X: " + string(background_x[2]));

