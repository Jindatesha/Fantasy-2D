/// @description this applies a knock back in a given direction (like when hitting an enemy)
/// @param damage this is how much damage was dealt
/// @param direction the direction in which we are moving ourselves

var damage_amount = argument[0];
var damage_numbers_direction = argument[1];
var has_crit = argument[2];

//see what our health is like to determine the dmg number color
var hp_percentage =  my_hp/my_max_hp; 

with (instance_create_depth(x,y,-100,obj_ui_damage_numbers))
{
	display_amount = damage_amount;
	direction = damage_numbers_direction;
	speed = irandom_range(1,4);	
	
	if has_crit == true
	{
		my_color = c_yellow;
	}
	
	
	/*
	if hp_percentage <= 1		my_color = c_green;
	if hp_percentage <= 0.74	my_color = c_orange;
	if hp_percentage <= 0.25	my_color = c_red;
	*/
	
}






