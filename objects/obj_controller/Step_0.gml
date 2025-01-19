// Posição do personagem (obj_player)
var camera_x = obj_player.x;  // Aqui você pega a posição X do personagem (obj_player)

// Velocidades do parallax para diferentes camadas de fundo
var parallax_speed_1 = 0.5;   // Velocidade para o fundo mais próximo
var parallax_speed_2 = 0.3;   // Velocidade para o fundo intermediário
var parallax_speed_3 = 0.1;   // Velocidade para o fundo mais distante

// Calcula as posições dos fundos com base na posição do obj_player
background_x[0] = -camera_x * parallax_speed_1;  // Camada 1 (mais próxima)
background_x[1] = -camera_x * parallax_speed_2;  // Camada 2 (intermediária)
background_x[2] = -camera_x * parallax_speed_3;  // Camada 3 (mais distante)
