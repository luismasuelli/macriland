if (global.next_level < 0) {
  scr_Game_Win();
} else {
  room_goto(global.next_level);
}
