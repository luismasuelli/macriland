if (ortho_can_move) {
  moving_sprites = ds_map_create();
  ds_map_add(moving_sprites, "left", argument0);
  ds_map_add(moving_sprites, "up", argument1);
  ds_map_add(moving_sprites, "right", argument2);
  ds_map_add(moving_sprites, "down", argument3);
}
