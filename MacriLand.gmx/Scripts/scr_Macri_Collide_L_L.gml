if (state == 'active') {
  if (abs(self.x - other.x) < 2 && abs(self.y - other.y) < 2) {
    with (obj_MacriR) {
      if (place_meeting(x, y, obj_RightGoal)) {
        scr_Macri_Cellebrate();
      } else {
        scr_Macri_Die("takedown");
      }
    }
  }
}