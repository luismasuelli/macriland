var w, h;
w = ds_grid_width(global.room_grid);
h = ds_grid_height(global.room_grid);
var i, j;
for(i = 0; i < w; i += 1) {
  for(j = 0; j < h; j += 1) {
    global.room_grid[# i, j] = false;
  }
}
