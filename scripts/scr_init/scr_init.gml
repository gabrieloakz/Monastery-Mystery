// Ao iniciar o jogo defini-se a constante da gravidade
#macro gravity .3

// Inicializa o sistema de áudio
global.audio_muted = false; // Estado inicial: não mutado

// Função para alternar mute/unmute
function toggle_audio() {
    global.audio_muted = !global.audio_muted;
    
    // Define o volume master como 0 (mute) ou 1 (unmute)
    var new_volume = global.audio_muted ? 0 : 1;
    audio_master_gain(new_volume);
    
    // Opcional: Mostrar feedback visual
    var status = global.audio_muted ? "MUDO" : "SOM LIGADO";
    show_debug_message("Audio: " + status);
}

// Função para verificar input de mute (chamar no Step Event do controlador)
function check_mute_input() {
    if (keyboard_check_pressed(ord("M"))) { // Tecla M para mutar/desmutar
        toggle_audio();
    }
}