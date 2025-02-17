// Verifica se o jogador existe antes de continuar
if (!instance_exists(obj_player)) return;

// Posição do personagem (obj_player)
var player_x = obj_player.x;
var player_y = obj_player.y;

// Dimensões da câmara
var camera_width = camera_get_view_width(view_camera[0]);
var camera_height = camera_get_view_height(view_camera[0]);

// Calcula a posição da câmara com suavização (lerp para suavizar o movimento)
var target_camera_x = clamp(player_x - camera_width / 2, 0, room_width - camera_width);
var target_camera_y = clamp(player_y - camera_height / 2, 0, room_height - camera_height);

var smooth_factor = 0.1; // Fator de suavização (ajuste conforme necessário)
var current_camera_x = camera_get_view_x(view_camera[0]);
var current_camera_y = camera_get_view_y(view_camera[0]);

var new_camera_x = lerp(current_camera_x, target_camera_x, smooth_factor);
var new_camera_y = lerp(current_camera_y, target_camera_y, smooth_factor);

// Atualiza a posição da câmara
camera_set_view_pos(view_camera[0], new_camera_x, new_camera_y);

// Calcula as posições dos fundos com base na posição da câmara
layer_x("bg_1", current_camera_x * -1);
layer_x("bg_1", current_camera_x * -0.5);
layer_x("bg_1", current_camera_x * -0.2);

// Debugging opcional
// show_debug_message("Background 1 X: " + string(background_x[0]));
// show_debug_message("Background 2 X: " + string(background_x[1]));
// show_debug_message("Background 3 X: " + string(background_x[2]));