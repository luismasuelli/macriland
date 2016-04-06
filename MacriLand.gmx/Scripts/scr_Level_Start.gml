global.left_moving = false;
global.right_moving = false;
audio_stop_sound(snd_Die_Left);
audio_stop_sound(snd_Die_Right);
audio_stop_sound(snd_Die_K);
instance_create(0, 0, obj_Death_K);
instance_create(0, 0, obj_Death_Left);
instance_create(0, 0, obj_Death_Right);
