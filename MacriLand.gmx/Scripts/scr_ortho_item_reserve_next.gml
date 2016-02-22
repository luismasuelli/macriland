if (ortho_can_move) {
  var orientation_ = "";
  if (next_orientation != "") {
    orientation_ = next_orientation;
  } else {
    orientation_ = orientation;
  }
  var tx = global.delta_x[? orientation_] + round(x / global.ortho_side);
  var ty = global.delta_y[? orientation_] + round(y / global.ortho_side);
  return scr_ortho_map_occupy(tx, ty);
} else {
  return false;
}
