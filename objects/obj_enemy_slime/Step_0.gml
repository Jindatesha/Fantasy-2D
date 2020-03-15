/// @description Insert description here
// You can write your code in this editor




//Inherit the parent event
event_inherited();




//if we are within range of the player...
if has_been_aggroed == false and distance_to_object(obj_player) <= my_range
{
	has_been_aggroed = true;
}



//if has been aggroed then indefinitely follow and attack the player!
if has_been_aggroed == true
{
	//start walking over to the player...to attack
	var x_dif = obj_player.x - x;
	//var y_dif = obj_player.y - y;
	h_speed = min(abs(x_dif),my_speed) * sign(x_dif);
	//v_speed = min(abs(y_dif),my_speed) * sign(y_dif);
	
	
	
	if distance_to_object(obj_player) <= my_attack_range and is_attacking == false
	{
		is_attacking = true;
		time_till_attack = my_attack_wind_up_time;
		can_move = false;
		can_switch_state = false;
		sprite_index = sprite_state_array[STATE.ATTACK_WIND];
		image_index = 0;
		image_speed = 0;
	}
	
	
}



if is_attacking == true
{
	//we dont want to be able to move while attacking (wind up)	
	h_speed = 0;
	v_speed = 0;
			
	//count down till attack comenses..(can be affected by player attacking us to stun*)
	time_till_attack -= 1;
		
	
	//break time_till attack original into equal fractions of the sprites image number
	//and if it gets less than the next segment (+1 to image number)

	//attack wind up is now over
	if time_till_attack <= 0 and has_ended_attack_wind_up == false
	{
		has_ended_attack_wind_up = true;
		sprite_index = sprite_state_array[STATE.ATTACK];
		image_speed = 1;//whatever the normal play speed is		
		alarm[0] = my_attack_reload_time;
		
		//set attack location
		direction = point_direction(x,y,obj_player.x,obj_player.y);
		location_to_attack_x = x + lengthdir_x(min(my_attack_length,abs(obj_player.x - x)),direction); 
		location_to_attack_y = y + lengthdir_y(min(my_attack_length,abs(obj_player.y - y)),direction); 
		 
	}






	if has_ended_attack_wind_up == true and sprite_index == sprite_state_array[STATE.ATTACK]
	{
		
		//move to attack collider location
		
		var number_of_attack_frames = sprite_get_number(sprite_state_array[STATE.ATTACK]);
		h_speed = (location_to_attack_x - x)/number_of_attack_frames;
		v_speed = (location_to_attack_y - y)/number_of_attack_frames;
		
		
		//during punch part where collider should check for player
		if floor(image_index) == image_number - 1
		{			
				
	
			
			
			with instance_create_depth(location_to_attack_x,location_to_attack_y,depth,obj_enemy_attack_collision)
			{
				my_damage = other.my_damage;
				sprite_index = other.my_attack_collision_image;
				direction = other.direction;
				image_angle = direction;				
			}
			
				
			sprite_index = sprite_state_array[STATE.WALK];
			
				
		}
	}
	

}






#region horizontal/vertical movement & collision

//horizontal
if place_meeting(x + h_speed, y,obj_solid)
{
	while !place_meeting(x + sign(h_speed), y,obj_solid)
	{
		x += sign(h_speed);			
	}
	
	h_speed = 0;
}
else
{
	x += h_speed;	
}



//vertical movement
if place_meeting(x, y + v_speed,obj_solid)
{
	while !place_meeting(x, y + sign(v_speed),obj_solid)
	{
		y += sign(v_speed);
	}
	
	v_speed = 0;
}
else
{
	y += v_speed;
}


#endregion


