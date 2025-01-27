// obj_manuscrito - Evento Mouse Left Pressed
show_message("Manuscrito: \nvar espada_visivel = false;\n\nAlterar valor da variável?");

if (espada_visivel == false) 
{
    espada_visivel = true;
    show_message("A espada apareceu! Alteraste o valor da variável.");
} else 
{
    show_message("A espada já está visível.");
}
