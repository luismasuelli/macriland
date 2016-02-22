ortho_can_move = argument0;
ortho_should_move = false;
ortho_moving = false;
orientation = "down";
next_orientation = "";
solidness = "both"; //none, occupies, checks, both
x_start = scr_ortho_map_snapped(x);
y_start = scr_ortho_map_snapped(y);
scr_ortho_item_set_speed(1);
scr_ortho_item_set_as_element();
