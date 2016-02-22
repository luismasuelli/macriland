if (ortho_can_move) {
  if (ortho_moving) {
    event_user(1); // Notify the item is moving.
    var dx, dy;
    dx = abs(x - x_start);
    dy = abs(y - y_start);
    // If another step traversed ...
    if (dx >= global.ortho_side || dy >= global.ortho_side) {
      event_user(2); //Event: step reached.
      if (ortho_should_move && scr_ortho_item_can_advance()) {
        scr_ortho_item_reserve_next();
        if (next_orientation != "") {
          orientation = next_orientation;
        }
        x_start = scr_ortho_map_snapped(x);
        y_start = scr_ortho_map_snapped(y);
        event_user(3); //Event: continues step.
      } else {
        ortho_moving = false;
        vspeed = 0;
        hspeed = 0;
        event_user(4); //Event: does not continue step.
      }
    }
    ortho_should_move = false;
    next_orientation = "";
  } else {
    event_user(5); //Event: the item is not moving.
    if (ortho_should_move && scr_ortho_item_can_advance()) {
      scr_ortho_item_reserve_next();
      ortho_moving = true;
      x_start = scr_ortho_map_snapped(x);
      y_start = scr_ortho_map_snapped(y);
      event_user(6); //Event: the item starts moving.
    } else {
      ortho_should_move = false;
    }
  }
}