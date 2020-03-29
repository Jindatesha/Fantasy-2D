/// @description Insert description here
// You can write your code in this editor




//Inherit the parent event
event_inherited();





//if we are within range of the player...
if has_been_aggroed == false
{
	move_left = 0;
	move_right = 0;

			
	if distance_to_object(obj_player) <= my_range
	{
		has_been_aggroed = true;
	}
}



//if has been aggroed then indefinitely follow and attack the player!
if has_been_aggroed == true
{
	//start walking over to the player...to attack
	var x_dif = obj_player.x - x;	
	move_speed = min(abs(x_dif),my_speed);
	var move_dir = sign(x_dif);
	switch(move_dir) 
	{		
		case -1:
			move_left = 1;
			move_right = 0;
		break;
		
		case 0:
			move_left = 0;
			move_right = 0;
		break;
		
		case 1:
			move_left = 0;
			move_right = 1;
		break;
	}
	
	
	
	
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
	move_speed = 0;
	
			
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
		location_to_attack_x = x + lengthdir_x(min(my_attack_length,max((my_attack_length/2),abs(obj_player.x - x))),direction); 
		location_to_attack_y = y + lengthdir_y(min(my_attack_length,max((my_attack_length/2),abs(obj_player.y - y))),direction); 
		 
	}






	if has_ended_attack_wind_up == true and sprite_index == sprite_state_array[STATE.ATTACK]
	{
		
		//move to attack collider location
		if has_launched_attack == false
		{
			has_launched_attack = true;
			var number_of_attack_frames = sprite_get_number(sprite_state_array[STATE.ATTACK]);
			var horizontal_diff = (location_to_attack_x - x);		
			var grav = 1.3;
			var time_to_get_horizontal_diff = min(my_max_attack_projectile_speed,floor(abs(horizontal_diff/my_max_attack_projectile_speed))) * sign(horizontal_diff);
			h_speed_projectile += time_to_get_horizontal_diff;//projectile based
			var vertical_diff = (location_to_attack_y - y);
			v_speed_additional += min(my_max_attack_projectile_speed, abs(vertical_diff) + (time_to_get_horizontal_diff * grav)) * sign(vertical_diff);
			
			//lerp(x, x + hspeed, room_speed);
		}
		
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
			
				
			sprite_index = sprite_state_array[STATE.RUN];
			
			//can now launch attack again! 
			has_launched_attack = false;
				
		}
	}
	

}



