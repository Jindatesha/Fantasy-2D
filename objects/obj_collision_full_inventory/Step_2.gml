/// @description Insert description here
// You can write your code in this editor



var view_to_gui_ratio = view_w/gui_w;
x = view_x + ((gui_w - sprite_get_width(spr_ui_backpack_backing) - 20) * view_to_gui_ratio);
y = view_y + (((gui_h * 0.5) - (sprite_get_height(spr_ui_backpack_backing)/2)) * view_to_gui_ratio);


image_xscale = obj_camera.zoom_amount;
image_yscale = obj_camera.zoom_amount;






