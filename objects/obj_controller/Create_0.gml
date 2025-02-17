// Configuração de resolução e câmera
global.base_width = 320;
global.base_height = 180;

var screen_width = display_get_width();
var screen_height = display_get_height();
var scale_factor = min(screen_width / global.base_width, screen_height / global.base_height);

window_set_size(global.base_width * scale_factor, global.base_height * scale_factor);
surface_resize(application_surface, global.base_width, global.base_height);
display_set_gui_size(global.base_width, global.base_height);

// Criação da câmera
var cam = camera_create_view(0, 0, global.base_width, global.base_height, 0, obj_player, -1, -1, -1, -1);
view_camera[0] = cam;
camera_set_view_size(cam, global.base_width, global.base_height);
view_enabled = true;
view_set_camera(0, cam);

// Parallax
parallax_speed_1 = 0.05;
parallax_speed_2 = 0.1;
parallax_speed_3 = 0.15;

// Configuração de fontes
font_title = font_main; 
font_menu = font_secondary; 

// Estados do jogo
game_state = "transition_in"; // Estados: transition_in, playing, paused
fade_alpha = 1; // Para transição inicial
menu_active = true;
player_controls = false; // Controles desativados inicialmente
//game_state = "menu";

// Menu
menu_options = ["Play", "Options", "Exit"];
selected_option = 0;

audio_play_sound(snd_field, 1, true); // (som, prioridade, loop)