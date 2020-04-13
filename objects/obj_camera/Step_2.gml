


var x_to,y_to;

//if we can move in the direction of the mouse
if follow_object_id != -1
{
	//change our direction towards mouse
	x_to = follow_object_id.x;
	y_to = follow_object_id.y;
}
else
{
	x_to = obj_player.x;
	y_to = obj_player.y;
}


if follow_target == true
{
	x += ceil((x_to - x) * 0.15);
	y += ceil((y_to - y) * 0.15);
}


//so that way the camera doesnt leave outside the room
//var locked_x = round(clamp(x - (view_w/2),0,room_width - view_w));
//var locked_y = round(clamp(y - (view_h/2),0,room_height - view_h));







#region if player attacked...screenshake
if global.screen_shake_duration != 0
{
	global.screen_shake_duration -= 1;
	
	has_set_original_view_before_screenshake = true;
	var screenshake_amount = random_range(-10,10);
	
	original_view_before_screenshake_x += lengthdir_x(screenshake_amount,obj_player.mouse_dir);
	original_view_before_screenshake_y += lengthdir_y(screenshake_amount,obj_player.mouse_dir);
	
	camera_set_view_pos(view,round(view_x + lengthdir_x(screenshake_amount,obj_player.mouse_dir)),round(view_y + lengthdir_y(screenshake_amount,obj_player.mouse_dir)));
}
else
{	
	if has_set_original_view_before_screenshake == true
	{
		has_set_original_view_before_screenshake = false;
		camera_set_view_pos(view,round(view_x + original_view_before_screenshake_x),round(view_y + original_view_before_screenshake_y));
		original_view_before_screenshake_x = 0;
		original_view_before_screenshake_y = 0;
	}
}
#endregion








//for zooming in/out
if zoom_in_or_pan == true
{
	
	if zooming == true
	{
		//handle zooming
		current_zooming_frame += 1;
		zoom_amount = scr_tween(current_zooming_frame,total_zooming_frames,start_zooming_value,end_zooming_value,tween_zooming_type);
		
		if current_zooming_frame == total_zooming_frames 
		{
			zoom_in_or_pan = false;
			
			if at_end_camera_follow != -1
			{
				follow_target = at_end_camera_follow;
				at_end_camera_follow = -1;
			}
		}
	}
	
	if panning == true
	{
		//handle panning
		current_panning_frame += 1;
		var players_x = obj_player.x;
		var players_y = obj_player.y;
		x = scr_tween(current_panning_frame,total_panning_frames,start_panning_value_x,end_panning_value_x,tween_panning_type);
		y = scr_tween(current_panning_frame,total_panning_frames,start_panning_value_y,end_panning_value_y,tween_panning_type);
		
		if current_panning_frame == total_panning_frames 
		{
			zoom_in_or_pan = false;
			
			if at_end_camera_follow != -1
			{
				follow_target = at_end_camera_follow;
				at_end_camera_follow = -1;
			}
		}
	}
}



camera_set_view_size(view,ideal_screen_width * zoom_amount,ideal_screen_height * zoom_amount);

var locked_x = round(x - (view_w/2));
var locked_y = round(y - (view_h/2));


//update camera
camera_set_view_pos(view,locked_x,locked_y);

