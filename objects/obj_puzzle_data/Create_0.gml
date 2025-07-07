// obj_puzzle_data Create Event
/// @description Inicializa base de dados de puzzles

// Sistema de armazenamento de puzzles
puzzles = ds_map_create();

// Puzzle 1: Introdução a variáveis
var puzzle1 = ds_map_create();
ds_map_add(puzzle1, "title", "As Primeiras Palavras");
ds_map_add(puzzle1, "description", "Complete o código para declarar uma variável:");
ds_map_add(puzzle1, "code_template", "var nome_local = \"_____\";\nshow_debug_message(nome_local);");
ds_map_add(puzzle1, "blanks", "Mosteiro"); // Respostas corretas separadas por vírgula
ds_map_add(puzzle1, "hint", "Pense no nome que daria a este lugar sagrado...");
ds_map_add(puzzle1, "reward_type", "unlock_door");
ds_map_add(puzzle1, "reward_target", "door_biblioteca");
ds_map_add(puzzle1, "difficulty", 1);
ds_map_add(puzzles, "scripture_intro", puzzle1);

// Puzzle 2: Condicionais básicas
var puzzle2 = ds_map_create();
ds_map_add(puzzle2, "title", "O Guardião da Sabedoria");
ds_map_add(puzzle2, "description", "Corrija a condição para abrir o baú:");
ds_map_add(puzzle2, "code_template", "var chave_encontrada = true;\nif (chave_encontrada ___ true) {\n    abrir_bau();\n} else {\n    mostrar_mensagem(\"Precisa da chave...\");\n}");
ds_map_add(puzzle2, "blanks", "=="); 
ds_map_add(puzzle2, "hint", "Que operador compara dois valores para ver se são iguais?");
ds_map_add(puzzle2, "reward_type", "give_item");
ds_map_add(puzzle2, "reward_target", "chave_dourada");
ds_map_add(puzzle2, "difficulty", 2);
ds_map_add(puzzles, "scripture_conditionals", puzzle2);

// Puzzle 3: Loops simples
var puzzle3 = ds_map_create();
ds_map_add(puzzle3, "title", "Os Sinos do Mosteiro");
ds_map_add(puzzle3, "description", "Complete o loop para tocar os sinos 5 vezes:");
ds_map_add(puzzle3, "code_template", "for (var i = 0; i __ 5; i++) {\n    tocar_sino();\n    aguardar(1000);\n}");
ds_map_add(puzzle3, "blanks", "<");
ds_map_add(puzzle3, "hint", "Quantas vezes o sino deve tocar? Use o operador correto...");
ds_map_add(puzzle3, "reward_type", "activate_mechanism");
ds_map_add(puzzle3, "reward_target", "sino_torre");
ds_map_add(puzzle3, "difficulty", 3);
ds_map_add(puzzles, "scripture_loops", puzzle3);

// Função auxiliar para obter puzzle por ID
function get_puzzle_data(puzzle_id) {
    if (ds_map_exists(puzzles, puzzle_id)) {
        return ds_map_find_value(puzzles, puzzle_id);
    }
    return noone;
}

// Função para verificar se resposta está correta
function check_puzzle_answer(puzzle_id, player_answer) {
    var puzzle_data = get_puzzle_data(puzzle_id);
    if (puzzle_data == noone) return false;
    
    var correct_answers = ds_map_find_value(puzzle_data, "blanks");
    var answers_array = string_split(correct_answers, ",");
    
    // Remove espaços em branco da resposta do jogador
    player_answer = string_replace_all(player_answer, " ", "");
    
    // Verifica se a resposta está na lista de respostas corretas
    for (var i = 0; i < array_length(answers_array); i++) {
        var clean_answer = string_replace_all(answers_array[i], " ", "");
        if (string_lower(player_answer) == string_lower(clean_answer)) {
            return true;
        }
    }
    return false;
}