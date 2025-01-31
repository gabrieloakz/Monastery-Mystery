// Declaração de variáveis globais para a resolução base do jogo
global.base_width = 320;  // Largura da câmara base
global.base_height = 180; // Altura da câmara base

// Obtém a largura e altura do ecrã do dispositivo
var screen_width = display_get_width();
var screen_height = display_get_height();

// Calcula o fator de escalonamento para manter a proporção
var scale_factor = min(screen_width / global.base_width, screen_height / global.base_height);

// Ajusta o tamanho da janela com base na escala calculada
window_set_size(global.base_width * scale_factor, global.base_height * scale_factor);

// Redimensiona a surface principal para corresponder à resolução base
surface_resize(application_surface, global.base_width, global.base_height);

// Ativa a manutenção do aspecto no escalonamento
display_set_gui_size(global.base_width, global.base_height);

// Configuração inicial da câmara
var cam = camera_create_view(0, 0, global.base_width, global.base_height, 0, obj_player, -1, -1, -1, -1);
view_camera[0] = cam;

// Define o tamanho da view da câmara
camera_set_view_size(cam, global.base_width, global.base_height);

// Aplica a câmara à viewport 0
view_enabled = true;
view_set_camera(0, cam);

// No Evento Create de obj_music_controller
if (!audio_is_playing(soundtrack)) {
    // Verifica se a música não está tocando, e toca ela em loop
    audio_play_sound(soundtrack, 1, true);  // 1 significa volume máximo e 'true' significa loop
}


