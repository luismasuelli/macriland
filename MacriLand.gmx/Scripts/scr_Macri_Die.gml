// Asignamos el estado de muerto y la animacion a usar.
// Asignamos tambien el tipo de muerte ocurrida:
// - protest (piquete)
// - takedown (cacerolazo)
// - political (golpe K)

var death_type = argument0;
if (death_type == "protest") {
  with(obj_Death_Left) {
    visible = true;
  }
  audio_play_sound(snd_Die_Left, 10, false);
} else if (death_type == "takedown") {
  with(obj_Death_Right) {
    visible = true;
  }
  audio_play_sound(snd_Die_Right, 10, false);
} else if (death_type == "political") {
  with(obj_Death_K) {
    visible = true;
  }
  audio_play_sound(snd_Die_K, 10, false);
}

with (obj_MacriL) {
  ortho_can_move = false;
  ortho_should_move = false;
  ortho_moving = false;
  state = "dead";
  speed = 0;
  sprite_index = spr_MacriL_Die;
  image_speed = 0.25;
}
with (obj_MacriR) {
  ortho_can_move = false;
  ortho_should_move = false;
  ortho_moving = false;
  state = "dead";
  speed = 0;
  sprite_index = spr_MacriR_Die;
  image_speed = 0.25;
}