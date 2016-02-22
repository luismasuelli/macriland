// Execute when: Before Step.
//   (On Step, we will check these positions and allow, or not, to move).
// The object will occupy as many cells as needed by its bounding-box.
if (solidness == 'occupies' || solidness == 'both') {
    var ox = floor(bbox_left / global.ortho_side);
    var oy = floor(bbox_top / global.ortho_side);
    var ox_limit = floor(bbox_right / global.ortho_side);
    var oy_limit = floor(bbox_bottom / global.ortho_side);
    var i, j;
    for(i = ox; i <= ox_limit; i += 1) {
      for(j = oy; j <= oy_limit; j += 1) {
        scr_ortho_map_occupy(i, j);
      }
    }
}
var w = ds_grid_width(global.room_grid);
var h = ds_grid_height(global.room_grid);
depth = -((w * y + x) + ortho_level * w * h);

