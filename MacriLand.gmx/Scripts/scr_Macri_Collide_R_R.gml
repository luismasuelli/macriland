if (state == 'active') {
  if (abs(self.x - other.x) < 2 && abs(self.y - other.y) < 2) {
    with (obj_MacriL) {
      if (place_meeting(x, y, obj_LeftGoal)) {
        scr_Macri_Cellebrate();
      } else {
        scr_Macri_Die("protest");
      }
    }
  }
}
