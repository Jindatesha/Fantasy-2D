/// @description scr_draw_3_slice_stretched();

/// @param sprite
/// @param total_width
/// @param starting_x
/// @param starting_y

var slice_sprite = argument[0];
var slice_total_width = argument[1];
var slice_segment_width = sprite_get_width(slice_sprite)/3;
var slice_segment_height = sprite_get_height(slice_sprite);

var starting_x = argument[2];
var starting_y = argument[3];

//left corner
draw_sprite_part(slice_sprite,0,0,0,slice_segment_width,slice_segment_height,starting_x,starting_y);

//middle
draw_sprite_part_ext(slice_sprite,0,slice_segment_width,0,slice_segment_width,slice_segment_height,starting_x + slice_segment_width ,starting_y,((slice_total_width - (slice_segment_width * 2))/slice_segment_width) ,1,c_white,1);

//right corner
draw_sprite_part(slice_sprite,0,slice_segment_width * 2,0,slice_segment_width,slice_segment_height,starting_x + (slice_total_width - slice_segment_width) ,starting_y);















