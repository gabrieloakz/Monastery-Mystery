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
