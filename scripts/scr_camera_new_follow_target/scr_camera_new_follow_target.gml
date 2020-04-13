///@param existing_id_or_-1 
///@param this_target_follows_another_id_or_-1
///@param target_to_follow_additional_x
///@param target_to_follow_additional_y
///@param camera_follows_at_start

var target_for_camera_to_follow = argument[0];
var target_follows_another_id = argument[1];
var target_additional_length_x = argument[2];
var target_additional_length_y = argument[3];
var camera_follows_at_start = argument[4];


if target_for_camera_to_follow == -1
{
	if !instance_exists(obj_camera_target)
	{
		//so we dont keep creating a new one per frame
		target_for_camera_to_follow = instance_create_depth(x + target_additional_length_x,y + target_additional_length_y,depth,obj_camera_target);		
	}
	else
	{
		target_for_camera_to_follow = obj_camera_target;//better only be one
	}
}


obj_camera.follow_object_id = target_for_camera_to_follow;
obj_camera.follow_target = camera_follows_at_start;



if target_follows_another_id != -1
{
	//so we want the target to follow another object
	with(target_for_camera_to_follow)
	{
		follow_object_id = target_follows_another_id;
		target_for_camera_to_follow.target_additional_length_x = target_additional_length_x;
		target_for_camera_to_follow.target_additional_length_y = target_additional_length_y;
	}
	
	
}



