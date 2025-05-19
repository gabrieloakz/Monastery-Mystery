// Herda o código criar do pai (entidade)
event_inherited();

// Ajusta a escala proporcionalmente com base no player
scale_factor = 0.65; // Altere este valor conforme necessidade
image_xscale = scale_factor;
image_yscale = scale_factor;

//Dialogo
dialogue_active = false;
current_text_index = 0;

// Defina os textos do diálogo aqui
global.dialogues = [
    "Olá! Bem-vindo ao meu templo. \n Pressione enter para continuar",
    "Estou meditando, mas posso ajudar se precisar.",
    "Siga em frente e agarre na escritura sagrada que ali está"
];