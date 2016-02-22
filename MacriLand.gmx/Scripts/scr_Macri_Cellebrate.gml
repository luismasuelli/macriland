// Solamente disminuimos las variables.
// Lo demas ocurrira en otros lados.
with (obj_MacriL) {
  ortho_can_move = false;
  ortho_should_move = false;
  ortho_moving = false;
  state = "cellebrating";
  speed = 0;
  sprite_index = spr_MacriL_Cellebrate;
  image_speed = 0.25;
}
with (obj_MacriR) {
  ortho_can_move = false;
  ortho_should_move = false;
  ortho_moving = false;
  state = "cellebrating";
  speed = 0;
  sprite_index = spr_MacriR_Cellebrate;
  image_speed = 0.25;
}
audio_play_sound(snd_Applause, 8, false);
