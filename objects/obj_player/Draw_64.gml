/// @description Insert description here
// You can write your code in this editor




//draw hud


var player_count = 0;
var player_number = 0;

if player_number == 0
{
	var starting_player_hud_x = round((view_w * player_count) + (view_w * 0.042));
	var starting_player_hud_y = round((view_h * 0.83));
}

draw_set_halign(fa_left);

//full hud backing
draw_sprite(spr_ui_hud_backing,0,starting_player_hud_x,starting_player_hud_y);



//day and night cycle circle?
var hud_clock_pos_x = starting_player_hud_x + 55;
var hud_clock_pos_y = starting_player_hud_y + 55;
draw_sprite_ext(spr_ui_hud_day_and_night_cycle,0,hud_clock_pos_x,hud_clock_pos_y,1,1,global.world_time * 360,c_white,1);
//cycle time stamp clock hand
draw_sprite(spr_ui_hud_day_and_night_cycle_stamp,0,hud_clock_pos_x,hud_clock_pos_y);


#region weapon icons
	//backing
	

#endregion

#region draw_health 
	var starting_health_bar_x = starting_player_hud_x + 110;
	var starting_health_bar_y = starting_player_hud_y + 25;
	var percentage_of_players_health = my_hp/my_max_hp;
	var percentage_of_players_missing_health = 1 - percentage_of_players_health;
	var width_of_health_bar = sprite_get_width(spr_player_health_green_bar);
	var height_of_health_bar = sprite_get_height(spr_player_health_green_bar);

	//backing
	draw_sprite(spr_ui_hud_health_bar_backing,0,starting_health_bar_x,starting_health_bar_y);
	
	//players_health
	draw_sprite_part(spr_ui_hud_health_bar,0,percentage_of_players_missing_health * width_of_health_bar,0,percentage_of_players_health * width_of_health_bar,height_of_health_bar,starting_health_bar_x,starting_health_bar_y);


#endregion	
	
	
//exp bar
draw_sprite(spr_ui_hud_exp_bar,0,starting_player_hud_x + 110,starting_player_hud_y + 49);
	
	
#region weapon icons
	
	//secondary      ...this one first for order/depth
		//backing
		draw_sprite_ext(spr_ui_hud_weapon_icon_backing,0,starting_player_hud_x + 84,starting_player_hud_y + 96,0.6667,0.6667,0,c_white,1);
		//icon
		draw_sprite_ext(spr_ui_hud_weapon_icons,1,starting_player_hud_x + 84,starting_player_hud_y + 96,0.6667,0.6667,0,c_white,1);
	
	
	//primary
		//backing
		draw_sprite(spr_ui_hud_weapon_icon_backing,0,hud_clock_pos_x,hud_clock_pos_y);
		//icon
		draw_sprite(spr_ui_hud_weapon_icons,0,hud_clock_pos_x,hud_clock_pos_y);
	


#endregion
	
	
	
#region ability 0 (weapon special attack)

var ability_0_pos_x = starting_player_hud_x + 120;
var ability_0_pos_y = starting_player_hud_y + 70;

var space_in_between_abilities = 12;
var width_of_ability_backing = sprite_get_width(spr_ui_hud_weapon_ability_backing);

var ability_1_pos_x = ability_0_pos_x + width_of_ability_backing + space_in_between_abilities;
var ability_1_pos_y = ability_0_pos_y;


//ability#0 backing
draw_sprite(spr_ui_hud_weapon_ability_backing,0,ability_0_pos_x,ability_0_pos_y);

//ability#1 backing
draw_sprite(spr_ui_hud_weapon_ability_backing,0,ability_1_pos_x,ability_1_pos_y);
/*

cooldown_counter_aray[0] = 1 -  (special_attack_cooldown_timer/max_special_attack_cooldown_time);




//backing
draw_sprite_part_ext(spr_ui_ability_backing,1,0,0,sprite_get_width(spr_ui_ability_backing),sprite_get_height(spr_ui_ability_backing) * cooldown_counter_aray[0],ability_0_pos_x,ability_0_pos_y + sprite_get_height(spr_ui_ability_backing),1,-1,c_white,1);

//ability image

var is_ability_0_on_cooldown = 0;
if special_attack_cooldown_timer > 0
{
	//if the ability is on cd then change to grayscale version
	is_ability_0_on_cooldown = 1;
}


//sprite
var diff = (sprite_get_width(spr_ui_ability_backing) - sprite_get_width(ability_slot[0]))/2;
draw_sprite(ability_slot[0],is_ability_0_on_cooldown,ability_0_pos_x + diff,ability_0_pos_y + diff);


var ability_0_seconds_left = round(special_attack_cooldown_timer/room_speed);
if ability_0_seconds_left == 0
{
	ability_0_seconds_left = round((special_attack_cooldown_timer/room_speed) * 10);
	ability_0_seconds_left = "0." + string(ability_0_seconds_left);
}

var ability_0_text_pos_x = ability_0_pos_x + diff + (sprite_get_width(ability_slot[0])/2);
var ability_0_text_pos_y = ability_0_pos_y + diff + (sprite_get_height(ability_slot[0])/2);

if ability_0_seconds_left != "0.0"
{
	draw_text(ability_0_text_pos_x,ability_0_text_pos_y,string(ability_0_seconds_left));
}
*/
#endregion


#region hotbar
/*
var hot_bar_starting_x = starting_health_bar_x;
var hot_bar_starting_y = starting_health_bar_y + height_of_health_bar + 10;




var hot_bar_total_slots = array_length_1d(hotbar_item_array);
for(var i = 0; i < hot_bar_total_slots; i += 1;)
{
	//backing
	var space_between_hotbar_slots = 10;
	var x_loc_for_this_hotbar_slot = hot_bar_starting_x + (sprite_get_width(spr_ui_hotbar_backing) * i) + (space_between_hotbar_slots * i);
	draw_sprite(spr_ui_hotbar_backing,0,x_loc_for_this_hotbar_slot,hot_bar_starting_y);
	
	//draw the selected item slot...
	if i == (selected_hotbar_slot - 15)
	{
		draw_sprite(spr_ui_hotbar_selection_box,0,x_loc_for_this_hotbar_slot,hot_bar_starting_y);
	}
}

*/

#endregion



#region spell cast
/*
if is_casting_spell[0] or is_casting_spell[1] or is_casting_spell[2]
{
	switch(which_spell)
	{
		case 0:
			//draw the base of the arrow
			var max_distance = sprite_get_width(spr_ability_dash_arrow_tail);
			var distance_to_mouse = point_distance(x,y,mouse_x,mouse_y);
			distance_to_mouse = clamp(distance_to_mouse,0,max_distance);
			var dir_of_mouse = point_direction(x,y,mouse_x,mouse_y);
			
			draw_sprite_ext(spr_ability_dash_arrow_tail,0,x,y,1,1,dir_of_mouse,c_white,1);
			//draw the arrow head
			draw_sprite_ext(spr_ability_dash_arrow_head,0,x + lengthdir_x(length_of_dash,dir_of_mouse),y + lengthdir_y(length_of_dash,dir_of_mouse),1,1,dir_of_mouse,c_white,1);
			
			
			
		break;
		
		//utility item : dummy
		case 1:
		
		break;
		
		
		//utility item: grappling hook
		case 2:
		
		break;
	}
}
*/
#endregion








