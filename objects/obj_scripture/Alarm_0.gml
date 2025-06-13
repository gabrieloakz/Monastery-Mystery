// obj_scripture Alarm 0 Event
/// @description Reativa a interação da escritura

// 1. Tenta obter a referência válida mais recente para o obj_puzzle_controller.
//    Isso é uma salvaguarda essencial caso a referência armazenada na variável 'puzzle_controller'
//    da instância do obj_scripture tenha ficado inválida (ex: objeto destruído e recriado).
var _current_puzzle_controller = instance_find(obj_puzzle_controller, 0);

// 2. Agora, com uma referência potencialmente válida (ou 'noone'), verifica se ela existe
//    E se a função 'is_puzzle_active' está presente nessa instância.
if (instance_exists(_current_puzzle_controller) && variable_instance_exists(_current_puzzle_controller, "is_puzzle_active")) {
    show_debug_message("DEBUG: Alarm 0 - _current_puzzle_controller ID: " + string(_current_puzzle_controller) + " | instance_exists(): " + string(instance_exists(_current_puzzle_controller)) + " | has_is_puzzle_active: " + string(variable_instance_exists(_current_puzzle_controller, "is_puzzle_active")));
    
    // Tenta chamar a função. Se falhar, captura o erro e reativa a interação.
    try {
        if (!_current_puzzle_controller.is_puzzle_active()) {
            is_interactable = true; // Reativa a interação se o puzzle NÃO estiver ativo.
        }
    } catch (_error_message) {
        // Capturou o erro ao tentar chamar is_puzzle_active.
        // Isso significa que _current_puzzle_controller não é o que esperávamos,
        // ou está em um estado inválido. O GameMaker pode retornar um ID válido para
        // uma instância que ainda não está totalmente inicializada ou está sendo destruída.
        is_interactable = true; // Reativa a interação como salvaguarda.
        show_debug_message("ERRO CATCH: Falha ao chamar is_puzzle_active() em Alarm 0: " + _error_message);
        show_debug_message("DEBUG: _current_puzzle_controller ID no erro: " + string(_current_puzzle_controller));
    }
} else {
    // Se, por algum motivo, o obj_puzzle_controller não for encontrado
    // ou não tiver a função 'is_puzzle_active', reativamos a interação.
    is_interactable = true;
    show_debug_message("DEBUG: obj_puzzle_controller não encontrado ou função is_puzzle_active ausente em Alarm 0 de obj_scripture. Reativando interação da escritura.");
    // Adicionalmente, se chegarmos aqui e a instância *existir* mas não tiver a função, é um alerta grave.
    if (instance_exists(_current_puzzle_controller)) {
        show_debug_message("ALERTA GRAVE: obj_puzzle_controller existe, mas NÃO tem is_puzzle_active()! ID: " + string(_current_puzzle_controller));
    }
}

// Nota: Não precisamos de atribuir _current_puzzle_controller de volta à variável
// 'puzzle_controller' da instância, pois essa variável é corretamente atualizada
// no evento Create e no evento Step do obj_scripture. O importante aqui é
// garantir que o código do Alarm 0 usa uma referência válida para a sua lógica.