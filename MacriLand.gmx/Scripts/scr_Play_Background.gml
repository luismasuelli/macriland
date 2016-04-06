audio_stop_sound(snd_Final_Loop);
if (!audio_is_playing(snd_Loop)) {
  var instance = audio_play_sound(snd_Loop, 9, true);
  audio_sound_gain(instance, 0.25, 0);
} else {
  show_debug_message("Still playing");
}
