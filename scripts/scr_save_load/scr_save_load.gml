/// @function scr_save_game()
/// @description Saves the current game state to a file
function scr_save_game() {
    // Create a buffer to store our save data
    var save_buffer = buffer_create(1024, buffer_fixed, 1);
    
    // Write a header to identify our save file
    buffer_write(save_buffer, buffer_string, "GAME_SAVE");
    
    // Save player position
    if (instance_exists(obj_player)) {
        var player = instance_find(obj_player, 0);
        buffer_write(save_buffer, buffer_f32, player.x);
        buffer_write(save_buffer, buffer_f32, player.y);
    }
    
    // Save current room
    buffer_write(save_buffer, buffer_s16, room);
    
    // Save any other game state variables here
    // Example: score, health, inventory, etc.
    
    // Save the buffer to a file
    var save_file = file_text_open_write("savegame.sav");
    if (save_file != -1) {
        var save_string = buffer_base64_encode(save_buffer, 0, buffer_tell(save_buffer));
        file_text_write_string(save_file, save_string);
        file_text_close(save_file);
        show_message("Game saved successfully!");
    } else {
        show_message("Error: Could not save game!");
    }
    
    // Clean up
    buffer_delete(save_buffer);
}

/// @function scr_load_game()
/// @description Loads the game state from a file
function scr_load_game() {
    if (!file_exists("savegame.sav")) {
        show_message("No save file found!");
        return false;
    }
    
    var save_file = file_text_open_read("savegame.sav");
    if (save_file == -1) {
        show_message("Error: Could not open save file!");
        return false;
    }
    
    var save_string = file_text_read_string(save_file);
    file_text_close(save_file);
    
    // Create a buffer from the saved data
    var load_buffer = buffer_create(1024, buffer_fixed, 1);
    buffer_base64_decode(load_buffer, 0, save_string);
    
    // Verify the save file header
    var header = buffer_read(load_buffer, buffer_string);
    if (header != "GAME_SAVE") {
        show_message("Error: Invalid save file!");
        buffer_delete(load_buffer);
        return false;
    }
    
    // Load player position
    if (instance_exists(obj_player)) {
        var player = instance_find(obj_player, 0);
        player.x = buffer_read(load_buffer, buffer_f32);
        player.y = buffer_read(load_buffer, buffer_f32);
    }
    
    // Load current room
    var saved_room = buffer_read(load_buffer, buffer_s16);
    if (room != saved_room) {
        room_goto(saved_room);
    }
    
    // Load any other game state variables here
    // Example: score, health, inventory, etc.
    
    // Clean up
    buffer_delete(load_buffer);
    show_message("Game loaded successfully!");
    return true;
} 