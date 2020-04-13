///scr_camera_zoom
///@param zooming
///@param start_zooming_value
///@param end_zooming_value
///@param total_zooming_frames
///@param tween_zooming_type

///@param panning
///@param start_panning_value_x
///@param end_panning_value_x
///@param start_panning_value_y
///@param end_panning_value_y
///@param total_panning_frames
///@param tween_panning_type

///@param at_start_camera_follow
///@param at_end_camera_follow



with(obj_camera)
{
	/*
	change_zoom_amount = true;
	zoom_init = zoom_amount;
	zoom_end = argument[0];
	time_to_get_there = argument[1];
	zoom_difference = (zoom_end - zoom_init);
	*/
	zoom_in_or_pan = true;
	
	zooming = argument[0];
	current_zooming_frame = 0;
	start_zooming_value = argument[1];
	end_zooming_value = argument[2];
	total_zooming_frames = argument[3];
	tween_zooming_type = argument[4];
	
	panning = argument[5];
	current_panning_frame = 0;
	start_panning_value_x = argument[6];
	end_panning_value_x = argument[7];
	start_panning_value_y = argument[8];
	end_panning_value_y = argument[9];
	total_panning_frames = argument[10];
	tween_panning_type = argument[11];

	follow_target = argument[12];
	at_end_camera_follow = argument[13];

}






















