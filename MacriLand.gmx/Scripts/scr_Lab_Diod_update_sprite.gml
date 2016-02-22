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
