/// @description Insert description here
// You can write your code in this editor


//macros
#macro view view_camera[0]

//set up the games resolution
scr_resolution();



#macro view_x camera_get_view_x(view)
#macro view_y camera_get_view_y(view)
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)
#macro view_ratio surface_get_width(application_surface)/view_w


global.screen_shake_duration = 0;
has_set_original_view_before_screenshake = false;
original_view_before_screenshake_x = 0;
original_view_before_screenshake_y = 0;











