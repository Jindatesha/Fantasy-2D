/// @description Insert description here
// You can write your code in this editor


//macros
#macro view view_camera[0]
#macro view_x camera_get_view_x(view)
#macro view_y camera_get_view_y(view)
#macro view_w camera_get_view_width(view)
#macro view_h camera_get_view_height(view)
#macro gui_w display_get_gui_width()
#macro gui_h display_get_gui_height()
#macro view_ratio surface_get_width(application_surface)/view_w



//set up the games resolution
scr_resolution();




global.screen_shake_duration = 0;
has_set_original_view_before_screenshake = false;
original_view_before_screenshake_x = 0;
original_view_before_screenshake_y = 0;




follow_object_id = -1;

follow_target = true;

#region zooming and panning
zoom_in_or_pan = false;	
zooming = false;
current_zooming_frame = 0;
start_zooming_value = 0;
end_zooming_value = 0;
total_zooming_frames = 0;
tween_zooming_type = 0;
zoom_amount = 1.0;//% of zoom out (higher number = farther zoomed out) (1= 100% ~ 1920x1080  ... 0.5 = 960x540)


panning = false;
current_panning_frame = 0;
start_panning_value_x = 0;
end_panning_value_x = 0;
start_panning_value_y = 0;
end_panning_value_y = 0;
total_panning_frames = 0;
tween_panning_type = 0;
pan_length = 0;

at_end_camera_follow = -1;


#endregion
