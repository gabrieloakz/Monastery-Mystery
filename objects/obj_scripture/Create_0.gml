// obj_scripture Create Event
/// @description Create - Sistema melhorado

persistent = true; // Torna a escritura persistente se o seu estado precisar de ser mantido entre salas.

// ID único do puzzle desta escritura
puzzle_id = "scripture_intro"; // Muda este valor para cada escritura diferente

// Estados visuais da escritura
is_discovered = false;     // Se o jogador já encontrou esta escritura
is_solved = false;         // Se o puzzle já foi resolvido
is_interactable = true;    // Se pode ser clicada
is_expanding = false;      // Controla a animação de expansão

// Efeitos visuais
hover_scale = 1.0;         // Escala quando o mouse passa por cima
target_scale = 1.0;        // Escala alvo
scale_speed = 0.1;         // Velocidade da animação de escala
glow_alpha = 0;            // Transparência do brilho
glow_direction = 1;        // Direção da animação de brilho

// Variáveis para expansão full-screen
expand_progress = 0;       // Progresso da animação de expansão (0-1)
expand_speed = 0.05;       // Velocidade da expansão
final_scale = 1;           // Será calculado no Step Event
original_scale = 0.6;      // Escala inicial do objeto

// Ajusta o tamanho base do sprite
image_xscale = 0.6;
image_yscale = 0.6;

// Garante que o puzzle_controller existe e é persistente
// e que a nossa variável 'puzzle_controller' aponta para ele.
// Se obj_puzzle_controller já foi criado (e é persistente), instance_find vai encontrá-lo.
// Se não, ele será criado aqui. Isso garante que sempre temos uma referência válida.
puzzle_controller = instance_find(obj_puzzle_controller, 0);
if (puzzle_controller == noone) {
    puzzle_controller = instance_create_depth(0, 0, -1000, obj_puzzle_controller);
    puzzle_controller.persistent = true; // Garante que o recém-criado também é persistente
}

// Marca como descoberta se o jogador chegou perto
detection_radius = 64; // Pixeis de distância para descobrir a escritura

// Som de interação (definir se tiveres recursos de áudio)
// interaction_sound = snd_page_turn;