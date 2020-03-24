
///scr_movement_and_collision();


//this goes in the bottom of a step event

#region needed variables in create event:
/*
h_speed_additional = 0;
v_speed_additional = 0;
current_additional_v_speed_from_jump_height = 0;
is_on_floor = false;
total_grav = 0;
h_speed = 0;
v_speed = 0;
reduce_speed = 0;
move_speed = 0;
move_left = 0;
move_right = 0;
total_possible_jumps = 1;
current_jumped_times = 0;
can_jump = true;
max_coyote_time = room_speed * 0.15;
coyote_time = 0;
h_speed_projectile = 0;
*/
#endregion



x = round(x);
y = round(y);

#region friction,gravity, setting h/v_speeds

	//friction 
	var friction_amount = 0.35;
	
	//this is for projectile like stuff (wont add friction unless its on floor)
	if is_on_floor == true 
	{
		if abs(h_speed_projectile) <= friction_amount 
		{
			h_speed_projectile = 0;
		}
		else
		{
			h_speed_projectile -= sign(h_speed_projectile) * friction_amount;
		}
	}
	
	//this is for normal horizontal movement that gets slowly reduced in the air...because GAME FEEL
	if h_speed_projectile == 0
	{
		if abs(h_speed_additional) <= friction_amount 
		{
			h_speed_additional = 0;
		}
		else
		{
			h_speed_additional -= sign(h_speed_additional) * friction_amount;
		}
	}	
	




	//gravity
	var grav = 1.2;

	if current_additional_v_speed_from_jump_height < 0
	{		

		current_additional_v_speed_from_jump_height += grav;
	
	}
	else 
	{
		if v_speed_additional < 0
		{	

			v_speed_additional += grav;
		
		}
		else
		{
			if is_on_floor == false
			{
				total_grav += grav;
			}
		}
	}


	total_grav = clamp(total_grav,0,45);


	v_speed = (total_grav + current_additional_v_speed_from_jump_height + v_speed_additional) * global.game_speed;
	
	var facing_dir = (move_right - move_left);
	//if facing_dir != 0 image_xscale = facing_dir;
	h_speed = ((facing_dir * move_speed) + h_speed_additional + h_speed_projectile) * global.game_speed;

#endregion



#region horizontal/vertical movement & collision





//horizontal
if place_meeting(x + h_speed, y,obj_solid)
{
	while (!place_meeting(x + sign(h_speed), y,obj_solid))
	{
		x += sign(h_speed);			
	}
	h_speed_projectile = 0;
	h_speed_additional = 0;
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
	
	
	//we are on the floor
	if sign(v_speed) >= 0
	{
		is_on_floor = true;
		v_speed_additional = 0;
		current_additional_v_speed_from_jump_height = 0;
		current_jumped_times = 0;
		can_jump = true;
		coyote_time = max_coyote_time;
	}
	
	v_speed = 0;
	total_grav = 0;
	
	
}
else
{
	//in the air
	
	coyote_time -= 1;
	if coyote_time <= 0 and current_jumped_times >= total_possible_jumps
	{
		can_jump = false;
	}
	
	y += v_speed;
	
	
	
	
	if !place_meeting(x, y + v_speed + 1,obj_solid)
	{
		is_on_floor = false;
	}

}


#endregion





