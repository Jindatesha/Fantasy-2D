//scr_tween

///@param current_frame
///@param total_frames
///@param start_value
///@param end_value
///@param tween_type

var current_frame = argument[0];//t
var total_frames = argument[1];//d
var start_value = argument[2];//b
var end_value = argument[3];//c


var change_in_value = end_value - start_value;
var tween_type = argument[4];



enum TWEEN_TYPE
{
	LINEAR,
	CUBIC_OUT
}



switch(tween_type)
{
	case TWEEN_TYPE.LINEAR:
		return ((change_in_value*current_frame)/total_frames) + start_value;
	break;
	
	case TWEEN_TYPE.CUBIC_OUT:
		current_frame = current_frame/total_frames;
		current_frame -= 1;
		return change_in_value*(current_frame*current_frame*current_frame + 1) + start_value;
	break;
}
















