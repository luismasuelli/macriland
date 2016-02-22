var orientation_ = argument0;
if (ds_list_find_index(global.orientations, orientation_) != -1 && !ortho_moving) {
  orientation = orientation_;
} else {
  next_orientation = orientation_;
};
