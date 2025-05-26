// obj_scripture Alarm 0 Event
/// @description Reativa a interação da escritura

// Reativa a interação se o puzzle não estiver mais ativo
if (!puzzle_controller.is_puzzle_active()) {
    is_interactable = true;
}