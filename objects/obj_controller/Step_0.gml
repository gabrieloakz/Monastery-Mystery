// Transição inicial (fade in)
if (game_state == "transition_in") {
    fade_alpha -= 0.02; // Velocidade do fade (ajuste conforme necessário)
    
    // Quando a transição terminar
    if (fade_alpha <= 0) {
        game_state = "menu"; // Muda para o estado de menu
        fade_alpha = 0; // Garante que o fade esteja completo
    }
}

// Estado de menu
if (game_state == "menu") {
    menu_active = true; // Mantém o menu ativo
    player_controls = false; // Trava o player
}


// Movimento da câmera suave
if (instance_exists(obj_player) && game_state == "playing") {
    var player_x = obj_player.x;
    var player_y = obj_player.y;
    
    var camera_width = camera_get_view_width(view_camera[0]);
    var camera_height = camera_get_view_height(view_camera[0]);
    
    // Cálculo da posição alvo (ajustado para posicionar o player à esquerda)
    var target_camera_x = clamp(player_x - camera_width/10, 0, room_width - camera_width);
    var target_camera_y = clamp(player_y - camera_height/2, 0, room_height - camera_height);
    
    // Suavização com lerp
    var smooth_factor = 0.1;
    var new_camera_x = lerp(camera_get_view_x(view_camera[0]), target_camera_x, smooth_factor);
    var new_camera_y = lerp(camera_get_view_y(view_camera[0]), target_camera_y, smooth_factor);
    
    camera_set_view_pos(view_camera[0], new_camera_x, new_camera_y);
    
    // Parallax
    layer_x("bg_1", new_camera_x * -parallax_speed_1);
    layer_x("bg_2", new_camera_x * -parallax_speed_2);
    layer_x("bg_3", new_camera_x * -parallax_speed_3);
}

if (menu_active && fade_alpha == 0) {
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);
    
    var start_y = 80;
    var spacing = 30;
    
    // Resetar seleção
    selected_option = -1;
    
    // Loop apenas para Play e Exit (ignora Options)
    for (var i = 0; i < array_length(menu_options); i++) {
        // Pula a opção "Options" (índice 1)
        if (i == 1) continue;
        
        var option_y = start_y + (i * spacing);
        var text = menu_options[i];
        var text_width = string_width(text);
        var text_height = string_height(text);
        
        // Verifica se o mouse está sobre Play ou Exit
        if (point_in_rectangle(mx, my, 
            display_get_gui_width()/2 - text_width/2, 
            option_y - text_height/2, 
            display_get_gui_width()/2 + text_width/2, 
            option_y + text_height/2)) {
            
            selected_option = i; // Destaca apenas Play (0) e Exit (2)
        }
    }
    
    // Clique do mouse
    if (mouse_check_button_pressed(mb_left)) {
        for (var i = 0; i < array_length(menu_options); i++) {
            // Pula "Options"
            if (i == 1) continue;
            
            var option_y = start_y + (i * spacing);
            var text = menu_options[i];
            var text_width = string_width(text);
            var text_height = string_height(text);
            
            if (point_in_rectangle(mx, my, 
                display_get_gui_width()/2 - text_width/2, 
                option_y - text_height/2, 
                display_get_gui_width()/2 + text_width/2, 
                option_y + text_height/2)) {
                
                switch (i) {
                    case 0: // Play
                        game_state = "playing";
                        menu_active = false;
                        player_controls = true;
                        break;
                        
                    case 2: // Exit
                        game_end();
                        break;
                }
            }
        }
    }
}

// Pausa o jogo com ESC
if (keyboard_check_pressed(vk_escape)) {
    if (game_state == "playing") {
        game_state = "paused";
        menu_active = true;
        player_controls = false;
    } else if (game_state == "paused") {
        game_state = "playing";
        menu_active = false;
        player_controls = true;
    }
}

// Verifica input para mutar/desmutar o áudio (funciona em qualquer estado do jogo)
check_mute_input();