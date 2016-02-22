#define scr_ortho_item_initialize
ortho_can_move = argument0;
ortho_should_move = false;
ortho_moving = false;
orientation = "down";
next_orientation = "";
x_start = scr_ortho_map_snapped(x);
y_start = scr_ortho_map_snapped(y);
scr_ortho_item_set_speed(1);
scr_ortho_item_set_as_element();
#define scr_ortho_item_set_speed
if (ortho_can_move) {
  ortho_speed = argument0;
}
#define scr_ortho_item_set_as_element
ortho_level = 2;
#define scr_ortho_item_set_as_ceiling_decal
ortho_level = 2;
#define scr_ortho_item_set_as_dropped
ortho_level = 1;
#define scr_ortho_item_set_as_decal
ortho_level = 0;
#define scr_ortho_item_set_stand_sprites
stand_sprites = ds_map_create();
ds_map_add(stand_sprites, "left", argument0);
ds_map_add(stand_sprites, "up", argument1);
ds_map_add(stand_sprites, "right", argument2);
ds_map_add(stand_sprites, "down", argument3);
#define scr_ortho_item_set_moving_sprites
if (ortho_can_move) {
  moving_sprites = ds_map_create();
  ds_map_add(moving_sprites, "left", argument0);
  ds_map_add(moving_sprites, "up", argument1);
  ds_map_add(moving_sprites, "right", argument2);
  ds_map_add(moving_sprites, "down", argument3);
}

#define scr_ortho_item_set_orientation
var orientation_ = argument0;
if (ds_list_find_index(global.orientations, orientation_) != -1 && !ortho_moving) {
  orientation = orientation_;
} else {
  next_orientation = orientation_;
};
#define scr_ortho_item_set_position
x = argument0 * global.ortho_side;
y = argument1 * global.ortho_side;
ortho_moving = false;
ortho_should_move = false;
#define scr_ortho_item_can_advance
if (ortho_can_move) {
  var tx = global.delta_x[? orientation] + round(x / global.ortho_side);
  var ty = global.delta_y[? orientation] + round(y / global.ortho_side);
  return !scr_ortho_map_occupied(tx, ty);
} else {
  return false;
}
#define scr_ortho_item_update_occupiance
// Execute when: Before Step.
//   (On Step, we will check these positions and allow, or not, to move).
// The object will occupy as many cells as needed by its bounding-box.
if (solid) {
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
#define scr_ortho_item_update_sprite
if (ortho_moving) {
  sprite_index = moving_sprites[? orientation];
} else {
  sprite_index = stand_sprites[? orientation];
}
#define scr_ortho_item_update_stand_pos
if (hspeed == 0) {
  x = round(x / global.ortho_side) * global.ortho_side;
}
if (vspeed == 0) {
  y = round(y / global.ortho_side) * global.ortho_side;
}
#define scr_ortho_item_update_movement
if (ortho_can_move) {
  if (ortho_moving) {
    var dx, dy;
    dx = abs(x - x_start);
    dy = abs(y - y_start);
    // If another step traversed ...
    if (dx >= global.ortho_side || dy >= global.ortho_side) {
      if (ortho_should_move && scr_ortho_item_can_advance()) {
        if (next_orientation != "") {
          orientation = next_orientation;
        }
        x_start = scr_ortho_map_snapped(x);
        y_start = scr_ortho_map_snapped(y);
      } else {
        ortho_moving = false;
        vspeed = 0;
        hspeed = 0;
      }
    }
    ortho_should_move = false;
    next_orientation = "";
  } else {
    if (ortho_should_move && scr_ortho_item_can_advance()) {
      ortho_moving = true;
      x_start = scr_ortho_map_snapped(x);
      y_start = scr_ortho_map_snapped(y);
    } else {
      ortho_should_move = false;
    }
  }
}
#define scr_ortho_item_update_speed
if (ortho_moving) {
  hspeed = global.delta_x[? orientation] * ortho_speed;
  vspeed = global.delta_y[? orientation] * ortho_speed;
}
#define scr_ortho_item_movement_do
var orientation_ = argument0;
if (orientation != orientation_) {
  scr_ortho_item_set_orientation(orientation_);
} else {
  ortho_should_move = true;
}
#define scr_ortho_setup
global.ortho_side = 32;
global.orientations = ds_list_create();
ds_list_add(global.orientations, "left");
ds_list_add(global.orientations, "up");
ds_list_add(global.orientations, "right");
ds_list_add(global.orientations, "down");
global.delta_x = ds_map_create();
ds_map_add(global.delta_x, "left", -1);
ds_map_add(global.delta_x, "up", 0);
ds_map_add(global.delta_x, "right", 1);
ds_map_add(global.delta_x, "down", 0);
global.delta_y = ds_map_create();
ds_map_add(global.delta_y, "left", 0);
ds_map_add(global.delta_y, "up", -1);
ds_map_add(global.delta_y, "right", 0);
ds_map_add(global.delta_y, "down", 1);
#define scr_ortho_map_create
scr_ortho_setup();
global.room_grid = ds_grid_create(room_width / global.ortho_side,
                                  room_height / global.ortho_side);
#define scr_ortho_map_clear
var w, h;
w = ds_grid_width(global.room_grid);
h = ds_grid_height(global.room_grid);
var i, j;
for(i = 0; i < w; i += 1) {
  for(j = 0; j < h; j += 1) {
    global.room_grid[# i, j] = false;
  }
}
#define scr_ortho_map_occupy
global.room_grid[# argument0, argument1] = true;
#define scr_ortho_map_occupied
return global.room_grid[# argument0, argument1];
#define scr_ortho_map_destroy
global.room_grid = undefined;
#define scr_ortho_map_snapped
return round(argument0 / global.ortho_side) * global.ortho_side;
#define scr_Lab_WireHole_initialize
scr_ortho_item_initialize(false);
scr_Lab_WireHole_left();
scr_Lab_WireHole_cover();
#define scr_Lab_WireHole_update_sprite
if (covered) {
  sprite_index = spr_Lab_WireHole_Lid;
} else if (left_side) {
  sprite_index = spr_Lab_WireHole_Left;
} else {
  sprite_index = spr_Lab_WireHole_Right;
}
#define scr_Lab_WireHole_cover
covered = 1;
#define scr_Lab_WireHole_uncover
covered = 0;
#define scr_Lab_WireHole_left
left_side = true;
#define scr_Lab_WireHole_right
left_side = false;
#define scr_Lab_Wall_Wire_initialize
scr_ortho_item_initialize(false);
scr_Lab_Wall_Wire_left();
#define scr_Lab_Wall_Wire_update_sprite
if (left_side) {
  sprite_index = spr_Lab_Wall_Wire_Left;
} else {
  sprite_index = spr_Lab_Wall_Wire_Right;
}
#define scr_Lab_Wall_Wire_left
left_side = true;
#define scr_Lab_Wall_Wire_right
left_side = false;
#define scr_Lab_Wall_CPanel_initialize
scr_ortho_item_initialize(false);
scr_Lab_Wall_CPanel_left();
#define scr_Lab_Wall_CPanel_update_sprite
if (left_side) {
  sprite_index = spr_Lab_Wall_CPanel_Left;
} else {
  sprite_index = spr_Lab_Wall_CPanel_Right;
}
#define scr_Lab_Wall_CPanel_left
left_side = true;
#define scr_Lab_Wall_CPanel_right
left_side = false;
#define scr_Lab_Wall_WireLever_initialize
scr_ortho_item_initialize(false);
scr_Lab_Wall_WireLever_left();
scr_Lab_Wall_WireLever_off();
#define scr_Lab_Wall_WireLever_update_sprite
if (left_side) {
  if (turned_on) {
    sprite_index = spr_Lab_Wall_WireLever_Left_On;
  } else {
    sprite_index = spr_Lab_Wall_WireLever_Left_Off;
  }
} else {
  if (turned_on) {
    sprite_index = spr_Lab_Wall_WireLever_Right_On;
  } else {
    sprite_index = spr_Lab_Wall_WireLever_Right_Off;
  }
}
#define scr_Lab_Wall_WireLever_left
left_side = true;
#define scr_Lab_Wall_WireLever_right
left_side = false;
#define scr_Lab_Wall_WireLever_off
turned_on = false;
#define scr_Lab_Wall_WireLever_on
turned_on = true;
#define scr_Lab_Pipe_initialize
scr_ortho_item_initialize(false);
scr_Lab_Pipe_left();
#define scr_Lab_Pipe_update_sprite
if (side == "left") {
  sprite_index = spr_Lab_Pipe_Left;
} else if (side == "right") {
  sprite_index = spr_Lab_Pipe_Right;
} else if (side == "front") {
  sprite_index = spr_Lab_Pipe_Front;
}
#define scr_Lab_Pipe_left
side = "left";
#define scr_Lab_Pipe_front
side = "front";
#define scr_Lab_Pipe_right
side = "right";
#define scr_Lab_ControlDesk_initialize
scr_ortho_item_initialize(false);
scr_Lab_ControlDesk_left();
#define scr_Lab_ControlDesk_update_sprite
if (left_side) {
  sprite_index = spr_Lab_ControlDesk_Left;
} else {
  sprite_index = spr_Lab_ControlDesk_Right;
}
#define scr_Lab_ControlDesk_left
left_side = true;
#define scr_Lab_ControlDesk_right
left_side = false;
#define scr_Lab_Diod_initialize
scr_ortho_item_initialize(false);
scr_Lab_Diod_black();
scr_Lab_Diod_off();
#define scr_Lab_Diod_update_sprite
if (turned_on) {
  if (color == "black") {
    sprite_index = spr_Lab_Diod_Black_Off;
  } else if (color == "cyan") {
    sprite_index = spr_Lab_Diod_Cyan_Off;
  } else if (color == "yellow") {
    sprite_index = spr_Lab_Diod_Yellow_Off;
  } else if (color == "magenta") {
    sprite_index = spr_Lab_Diod_Magenta_Off;
  }
} else {
  if (color == "black") {
    sprite_index = spr_Lab_Diod_Black_On;
  } else if (color == "cyan") {
    sprite_index = spr_Lab_Diod_Cyan_On;
  } else if (color == "yellow") {
    sprite_index = spr_Lab_Diod_Yellow_On;
  } else if (color == "magenta") {
    sprite_index = spr_Lab_Diod_Magenta_On;
  }
}
#define scr_Lab_Diod_black
color = "black";
#define scr_Lab_Diod_cyan
color = "cyan";
#define scr_Lab_Diod_magenta
color = "magenta";
#define scr_Lab_Diod_yellow
color = "yellow";
#define scr_Lab_Diod_on
turned_on = true;
#define scr_Lab_Diod_off
turned_on = false;
#define scr_Lab_Desk_Operary_initialize
scr_ortho_item_initialize(false);
scr_Lab_Desk_Operary_empty();
#define scr_Lab_Desk_Operary_update_sprite
if (state == 'empty') {
  sprite_index = spr_Lab_Desk_Operary_Iron;
} else if (state == 'papers') {
  sprite_index = spr_Lab_Desk_Operary_Iron_Papers;
} else if (state == 'books') {
  sprite_index = spr_Lab_Desk_Operary_Iron_Books;
}
#define scr_Lab_Desk_Operary_empty
state = "empty";
#define scr_Lab_Desk_Operary_papers
state = "papers";
#define scr_Lab_Desk_Operary_books
state = "books";
#define scr_Lab_Desk_PC_initialize
scr_ortho_item_initialize(false);
scr_Lab_Desk_PC_off();
#define scr_Lab_Desk_PC_update_sprite
if (turned_on) {
  sprite_index = spr_Lab_Desk_Operary_Iron_Computer_On;
} else {
  sprite_index = spr_Lab_Desk_Operary_Iron_Computer_Off;
}
#define scr_Lab_Desk_PC_on
turned_on = true;
#define scr_Lab_Desk_PC_off
turned_on = false;
#define scr_Lab_BookCase_initialize
scr_ortho_item_initialize(false);
scr_Lab_BookCase_empty();
#define scr_Lab_BookCase_Iron_update_sprite
if (full) {
  sprite_index = spr_Lab_BookCase_Iron_Full;
} else {
  sprite_index = spr_Lab_BookCase_Iron_Empty;
}
#define scr_Lab_BookCase_Steel_update_sprite
if (full) {
  sprite_index = spr_Lab_BookCase_Steel_Full;
} else {
  sprite_index = spr_Lab_BookCase_Steel_Empty;
}
#define scr_Lab_BookCase_Gold_update_sprite
if (full) {
  sprite_index = spr_Lab_BookCase_Gold_Full;
} else {
  sprite_index = spr_Lab_BookCase_Gold_Empty;
}
#define scr_Lab_BookCase_empty
full = false;
#define scr_Lab_BookCase_full
full = true;
#define scr_Lab_TableL_initialize
scr_ortho_item_initialize(false);
scr_Lab_TableL_empty();
#define scr_Lab_TableL_update_sprite
if (state == "empty") {
  sprite_index = spr_Lab_TableL_Empty;
} else if (state == "blood") {
  sprite_index = spr_Lab_TableL_Blood;
}
#define scr_Lab_TableL_empty
state = "empty";
#define scr_Lab_TableL_bleed
state = "blood";
#define scr_Lab_TableS_initialize
scr_ortho_item_initialize(false);
scr_Lab_TableS_empty();
#define scr_Lab_TableS_update_sprite
if (state == "empty") {
  sprite_index = spr_Lab_TableS_Empty;
} else if (state == "blood") {
  sprite_index = spr_Lab_TableS_Blood;
} else if (state == "tray") {
  sprite_index = spr_Lab_TableS_Tray;
} else if (state == "full-tray") {
  sprite_index = spr_Lab_TableS_Tray_Full;
} else if (state == "blue-dish") {
  sprite_index = spr_Lab_TableS_Dish_Blue;
} else if (state == "red-dish") {
  sprite_index = spr_Lab_TableS_Dish_Red;
} else if (state == "green-dish") {
  sprite_index = spr_Lab_TableS_Dish_Green;
}
#define scr_Lab_TableS_empty
state = "empty";
#define scr_Lab_TableS_bleed
state = "blood";
#define scr_Lab_TableS_tray
state = "tray";
#define scr_Lab_TableS_full_tray
state = "full-tray";
#define scr_Lab_TableS_dish_blue
state = "blue-dish";
#define scr_Lab_TableS_dish_red
state = "red-dish";
#define scr_Lab_TableS_dish_green
state = "green-dish";
