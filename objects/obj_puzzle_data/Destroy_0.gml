// obj_puzzle_data Destroy Event
/// @description Limpa a memória dos data structures

// Destroi cada puzzle individualmente
var key = ds_map_find_first(puzzles);
while (!is_undefined(key)) {
    var puzzle_data = ds_map_find_value(puzzles, key);
    if (ds_exists(puzzle_data, ds_type_map)) {
        ds_map_destroy(puzzle_data);
    }
    key = ds_map_find_next(puzzles, key);
}

// Destroi o mapa principal
ds_map_destroy(puzzles);