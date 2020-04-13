/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor



#region controls
move_left = keyboard_check(ord("A"));
move_right = keyboard_check(ord("D"));
pressed_jump = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_space);
var crouch = keyboard_check(ord("S"));


var use_weapon = mouse_check_button_pressed(mb_left);
var use_weapon_special = mouse_check_button(mb_right);

var pick_up_item = keyboard_check_pressed(ord("E"));

var use_utility_item = keyboard_check_pressed(ord("Q"));

var call_inventory = keyboard_check_pressed(vk_tab);



if use_weapon_special > 0 
{
	var debug = true;
}





#region Jumping
	//now can no longer jump...so if u walk off cliff u cant jump
	
	if pressed_jump > 0
	{
		pressed_jump_leeway = max_pressed_jump_leeyway_time;
	}


	if pressed_jump_leeway > 0 and can_jump == true
	{
		pressed_jump_leeway = 0;
		current_jumped_times += 1;
		total_grav = 0;	
		v_speed_additional = 0;
		current_additional_v_speed_from_jump_height = -jump_height;	
		coyote_time = 0;
	}

	if current_jumped_times >= total_possible_jumps
	{
		can_jump = false;
	}
	pressed_jump_leeway -= 1;
#endregion

#endregion


#region hotbar
	var olde_hotbar_selection = selected_hotbar_slot;
	var how_many_hotbar_slots = array_length_1d(hotbar_item_array) - 1;
	
	/*
	if mouse_wheel_up()
	{
		selected_hotbar_slot += 1;
		if (selected_hotbar_slot - 15) > how_many_hotbar_slots selected_hotbar_slot = 15;
		
		//if you had a weapon/tool equipped...un-equip it and delete the weapon object
		if my_weapon != -1
		{
			with(my_weapon)
			{
				instance_destroy();
			}
			
			my_weapon = -1;
		}

	}
	*/
	
	
	//first ... did we change the hotbar selection?
	if olde_hotbar_selection != selected_hotbar_slot
	{
		
		var inventory_item_number = ds_list_find_value(inventory_list,selected_hotbar_slot);
		
		//check to see if the newly selected hotbar item is a weapon/tool
		if inventory_item_number >= WEAPON_LIST.BASIC and inventory_item_number < WEAPON_LIST.LAST_IN_LIST or (inventory_item_number >= TOOLS_LIST.BASIC and inventory_item_number < TOOLS_LIST.LAST_IN_LIST)
		{
			//since it is...create the item and equip it to the player
		
			scr_create_and_equip_weapon(id,inventory_item_number);
 
		}
	
	}
#endregion

#region switching hands for holding weapon and image scale based on mouse_dir


//mouse direction
if can_flip_image_dir == true
{

		
	mouse_dir = point_direction(x,y,mouse_x,mouse_y);
	
		//switch hands and all sprites
		
		
		switch(weapon_hand)
		{
			//left hand
			case -1:
			

				if mouse_dir < (90 - switch_hand_degree_margin) or mouse_dir > (270 + switch_hand_degree_margin)
				{
					//switch hands
					image_xscale = 1;
					weapon_hand = 1;
					hand_dir = mouse_dir;
					
					//also mirror the weapon in hand if we have one
					if my_weapon != -1
					{
						with(my_weapon)
						{
							flip_weapon = true;
							flip_direction = 1;
						}
					}
					
				}
				else
				{
					hand_dir = clamp(mouse_dir,135,225);
				}
				
			break;
			
			//right hand
			case 1:
			
				
				
				//if we are passed our threshold...switch hands
				if  mouse_dir > (90 + switch_hand_degree_margin) and mouse_dir < (270 - switch_hand_degree_margin)
				{
					image_xscale = -1;
					weapon_hand = -1;
					hand_dir = mouse_dir;
					
					//also mirror the weapon in hand if we have one
					if my_weapon != -1
					{
						with(my_weapon)
						{
							flip_weapon = true;
							flip_direction = -1;
						}
					}
					
					
				}
				else
				{
					if mouse_dir < (45 + switch_hand_degree_margin)
					{
						hand_dir = clamp(mouse_dir,0,45);
					}
					else
					{
						hand_dir = clamp(mouse_dir,225,360);
					}
				}
				
			break;
		}
	
	
}

#endregion



#region idle
		if can_switch_state == true 
		{
			 //what state am I in?
			current_state = STATE.IDLE;
		}
	#endregion




#region attacks/ weapon use & special


#region basic attack
//if use weapon ....... and can attack (combo is 3)
if use_weapon > 0 and my_weapon_id != -1 and my_weapon_id.can_attack == true 
{
	my_weapon_id.launch_attack = true;
	my_weapon_id.has_done_hit_collisions = false;
	global.player_has_attacked = true;
	attack_thrust_current_frame = 0;
	//can_control_player = false;
	
	is_attacking = true;//still
	image_index = 0;//[reset] or transition to next the attack animation

}


if global.player_has_attacked == true
{
	attack_thrust_current_frame += 1;
	
	if has_added_attack_thrust == false
	{
		has_added_attack_thrust = true;
		h_speed_additional += lengthdir_x(attack_thrust_amount,mouse_dir);
		v_speed_additional += lengthdir_y(attack_thrust_amount,mouse_dir);
	}
	
	if attack_thrust_current_frame >= attack_thrust_total_frames
	{
		global.player_has_attacked = false;
		
		attack_thrust_current_frame = 0;
		has_added_attack_thrust = false;
	}
}
#endregion



#region special
/*
special_attack_cooldown_timer -= 1;
special_attack_cooldown_timer = clamp(special_attack_cooldown_timer,0,max_special_attack_cooldown_time);

if special_attack_cooldown_timer <= 0 is_special_attack_on_cooldown = false;


if use_weapon_special and my_weapon.can_attack == true and is_special_attack_on_cooldown == false and has_cast_spell == false
{
	is_casting_spell[0] = true;
	which_spell = 0;
	is_special_attack_on_cooldown = true;	
	//can_control_player = false;
	//can_switch_state = false;
	

	
}



//if a button has been pressed and held for casting a spell...
if is_casting_spell[0] or is_casting_spell[1] or is_casting_spell[2]
{
		
	switch(which_spell)
	{
		//special attack
		default:
		case 0:
			//which special attack will depend what weapon you have
			
			if use_weapon_special == 0 and has_cast_spell == false
			{		
				current_state = STATE.ATTACK;
				has_cast_spell = true;
				can_control_player = false;
				can_switch_state = false;
				is_casting_spell[0] = false;
				special_attack_cooldown_timer = max_special_attack_cooldown_time;



				alarm[0] = special_attack_time_till_player_can_move;
				alarm[1] = max_special_attack_cooldown_time;
				//warp to location (in direction of mouse)
				var dir_of_mouse = point_direction(x,y,mouse_x,mouse_y);
				
				
				//before we actually move...check for collisions to see about who is getting hit
				with (instance_create_depth(x,y,depth,obj_hit_collision))
				{
					image_angle = dir_of_mouse;
					sprite_index = spr_ability_dash_arrow_tail;
					
					var final_damage = other.my_damage * random_range(1,ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.MAX_WEAPON_DAMAGE_SCALE,other.my_weapon.my_weapon_number)) * 4;							
					
					var hit_list = ds_list_create();
					var hit_count = instance_place_list(x,y,obj_enemy,hit_list,true);
					var i = 0;
					repeat(hit_count)
					{
						with (ds_list_find_value(hit_list,i))
						{				
							final_damage = floor(final_damage);
							var crit_number_needed = 97;
							var crit = irandom_range(0,100);
							var has_crit = false;
				
							if crit_number_needed - crit  <= 0
							{
								//then we did crit
								has_crit = true;
								final_damage *= 2; 
								final_damage = floor(final_damage);
							}
				
							my_hp -= final_damage;
							show_health_timer = show_health_max_time;
							hp_lossed = final_damage;			
							scr_damage_numbers(hp_lossed,dir_of_mouse,has_crit);
				
					
						}
				
						i += 1;
					}
	
					ds_list_destroy(hit_list);
	
					instance_destroy();
	
				}
	
						
				
				
				
				h_speed += lengthdir_x(length_of_dash,dir_of_mouse);
				v_speed += lengthdir_y(length_of_dash,dir_of_mouse);
				
				//mask_index = spr_player_collision_mask;
			}

			
			
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



#endregion






#region Inventory


//if we press the inventory button
if call_inventory > 0 
{
	#region OPENING BACKPACK
	if is_inventory_open == false
	{
		is_inventory_open = true;
		
		//for camera
		//create new object for camera to follow for a short while
		scr_camera_new_follow_target(-1,id,gui_w * 0.1,0,false);
		
		//tell camera to zoom in and pan to the new object to follow
		scr_camera_zoom_and_pan(true,obj_camera.zoom_amount,0.75,room_speed * 0.3,TWEEN_TYPE.CUBIC_OUT,true,x,obj_camera_target.x,y,obj_camera_target.y,room_speed * 0.3,TWEEN_TYPE.CUBIC_OUT,false,true);
		
		//create all the items inside the inventory for us to be able to grab and do stuff with
		var inventory_width = ds_grid_width(global.player_inventory_grid);
		var inventory_height = ds_grid_height(global.player_inventory_grid);
		var how_many_items_in_inventory_pre = inventory_width * inventory_height;
		var inv_grid_number_x = 0;
		var inv_grid_number_y = 0;
		var item_slot_spacing = 15;
		var width_of_item_slot = 80;
		var total_space_for_slot = width_of_item_slot + item_slot_spacing;				
		var backpack_collision_width = sprite_get_width(spr_ui_backpack_backing);
		var backpack_collision_height = sprite_get_height(spr_ui_backpack_backing);

		var view_to_gui_ratio = view_w/gui_w;
		var starting_inventory_x = view_x + ((gui_w - sprite_get_width(spr_ui_backpack_backing) - 20) * view_to_gui_ratio);
		var starting_inventory_y = view_y + (((gui_h * 0.5) - (sprite_get_height(spr_ui_backpack_backing)/2)) * view_to_gui_ratio);
		//this is the inventory object_collision
		instance_create_depth(starting_inventory_x,starting_inventory_y,depth,obj_collision_full_inventory);

			
		//items to be in starting slot
		var first_item_slot_adjust_x = 333;
		var first_item_slot_adjust_y = 252;
		starting_inventory_x += first_item_slot_adjust_x;
		starting_inventory_y += first_item_slot_adjust_y;
		
		#region create all of our objects and colliders for the inventory slots
			for(var i = 0; i < how_many_items_in_inventory_pre; i+=1;)
			{
		
				inv_grid_number_x = i mod inventory_width;
				inv_grid_number_y = i div inventory_width;
			
				//obj_item_in_inventory			
				var this_item = ds_grid_get(global.player_inventory_grid,inv_grid_number_x,inv_grid_number_y);
				if this_item != -1
				{							
					//create and place the visual item				
					with (instance_create_depth(starting_inventory_x + (total_space_for_slot * inv_grid_number_x),starting_inventory_y + (total_space_for_slot * inv_grid_number_y),depth - 1,obj_item_in_inventory))
					{
						my_starting_x = first_item_slot_adjust_x + (total_space_for_slot * inv_grid_number_x);
						my_starting_y = first_item_slot_adjust_y + (total_space_for_slot * inv_grid_number_y);
						
						//create an enum sprite list for weapons and for equipment					
						my_item_number = this_item;					
					
						//based on item number; what class and sprite_index are you?										
						sprite_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.SPRITE_INDEX,my_item_number);		
						image_index = scr_item_number_to_sprite_or_image_index(my_item_number,1);
						my_item_class = ds_grid_get(global.item_database_grid,THIS_ITEMS.ITEM_CLASS,my_item_number);
						my_item_width = sprite_get_width(sprite_index) div width_of_item_slot;
						my_item_height = sprite_get_height(sprite_index) div width_of_item_slot;//its a square
						image_speed = 0;
					
						current_inventory_slot = i;
						my_inv_grid_number_x = inv_grid_number_x;
						my_inv_grid_number_y = inv_grid_number_y;
						//slot_placement_x = (total_space_for_slot * inv_grid_number_x);
						//slot_placement_y = (total_space_for_slot * inv_grid_number_y);				
					}								
				}
			
			
			
				//create and place a collision box for an invisible check to see if an item can be moved here
				with (instance_create_depth(starting_inventory_x + (total_space_for_slot * inv_grid_number_x),starting_inventory_y + (total_space_for_slot * inv_grid_number_y),depth - 2,obj_check_inventory_slot))
				{
					current_inventory_slot = i;
					//class
					my_starting_x = first_item_slot_adjust_x + (total_space_for_slot * inv_grid_number_x);
					my_starting_y = first_item_slot_adjust_y + (total_space_for_slot * inv_grid_number_y);	
					
					my_item_class = ITEM_CLASS.ANYTHING;
					
					my_inv_grid_number_x = inv_grid_number_x;
					my_inv_grid_number_y = inv_grid_number_y;
				}
			
			
			}
		#endregion

		
			
	#endregion
	}	
	else
	{
	#region CLOSE BACKPACK

		is_inventory_open = false;
		
		//allow ourselves to able to attack and flip dir
		my_weapon_id.can_attack = true;
		can_flip_image_dir = true;
				
		//get rid of all the objects that we can grab
		with(obj_item_in_inventory)
		{
			if are_we_being_held_by_cursor == false
			{			
				instance_destroy();
			}			
		}
		
		
		//get rid of all the slot location objects
		with(obj_check_inventory_slot)
		{			
			instance_destroy();			
		}
	
		
		//tell camera to zoom in and pan to the new object to follow
		scr_camera_zoom_and_pan(true,obj_camera.zoom_amount,1,room_speed * 0.3,TWEEN_TYPE.CUBIC_OUT,false,x,obj_camera_target.x,y,obj_camera_target.y,room_speed * 1,TWEEN_TYPE.LINEAR,false,true);
		
		
		
		//get rid of that camera follow from opening inv
		instance_destroy(obj_camera.follow_object_id);
		
		obj_camera.follow_target = true;
		obj_camera.follow_object_id = -1;
		
		instance_destroy(obj_collision_full_inventory);
		
		
	}

}

#endregion
	
	
	
	if is_inventory_open == true
	{			
		//stop ourselves from being able to attack and flip dir
		my_weapon_id.can_attack = false;
		can_flip_image_dir = false;
	}

#endregion






#region Item Pickup

	//same button will be for using the forge
	if collision_circle(x,y,300,obj_forge,false,true) 
	{	
		if pick_up_item > 0 and !instance_exists(obj_forge_menu)
		{
			instance_create_depth(x,y,depth,obj_forge_menu)
		}
	}
	else
	{
		if instance_exists(obj_forge_menu)
		{
			with(obj_forge_menu)
			{
				instance_destroy();
			}
		}
	}




	if pick_up_item > 0
	{

		var hit_list = ds_list_create();
		var hit_count = instance_place_list(x,y,obj_item_on_floor,hit_list,true);
		var item_to_be_picked_up = ds_list_find_value(hit_list,0);
			
	
		if hit_count > 0
		{
			scr_check_and_put_item_in_inventory(item_to_be_picked_up);
		}

	
		//no item slots available but still clean up your list			
		ds_list_destroy(hit_list);
	
	}

#endregion



#region Die

//LATER: make sure to save any achievements

//LATER: go into a death animation with a spotlight on you...then a menu comes with stats and was killed by:  ie: enter the gungeon


if my_hp <= 0
{

	//LATER: dont simply restart the whole game...but go back to a certain menu
	game_restart();

}



#endregion



#region ledge-grabbing

//if we are touching the ledge of an 
//obj_solid and in_air and are moving towards that ledge...
//then go into ledge-grab state

var facing_dir = (move_right - move_left);
var normal_run_value = (facing_dir * move_speed);
var colliding_terrain_id = noone;
ds_list_clear(ledge_collision_list);
if hanging_on_ledge == false and getting_up_from_ledge == false and is_on_floor == false 
{
	colliding_terrain_id = instance_position(x + (sprite_get_xoffset(mask_index) * facing_dir) + normal_run_value,y - sprite_get_yoffset(mask_index),obj_solid);

}

if colliding_terrain_id != noone
{
	can_now_climb_up_with_that_directional_button = false;
	has_finished_initial_ledge_grab = false;
	
	with(colliding_terrain_id)
	{
		var ledge_leeway_for_grab = 10;//px away from ledge we can still grab on too...some forgiveness
		
		//if we are on the left edge
		if collision_rectangle(bbox_left, bbox_top, bbox_left - ledge_leeway_for_grab, bbox_top + other.v_speed, other, false, true) and !instance_position(bbox_left, bbox_top - 1,obj_solid)
		{
			with(other)
			{
				//switch hands
				image_xscale = 1;
				weapon_hand = 1;
				hand_dir = mouse_dir;
					
				//also mirror the weapon in hand if we have one
				if my_weapon != -1
				{
					with(my_weapon)
					{
						flip_weapon = true;
						flip_direction = 1;
					}
				}
					
				hanging_on_ledge = true;
				potential_end_up_location_from_ledge_x = other.bbox_left + sprite_get_xoffset(mask_index);
				potential_end_up_location_from_ledge_y = other.bbox_top - sprite_get_height(mask_index) + sprite_get_yoffset(mask_index);
				
				x = other.bbox_left - sprite_get_xoffset(mask_index) - 1;
				y = other.bbox_top + sprite_get_yoffset(mask_index);
				
				ds_list_clear(ledge_collision_list);
			}
		}
		
		
		//or right edge of a solid obj/terrain
		if collision_rectangle(bbox_right, bbox_top, bbox_right + ledge_leeway_for_grab, bbox_top + other.v_speed, other, false, true) and !instance_position(bbox_left, bbox_top - 1,obj_solid)
		{
			with(other)
			{
				//switch hands
				image_xscale = -1;
				weapon_hand = -1;
				hand_dir = mouse_dir;
					
				//also mirror the weapon in hand if we have one
				if my_weapon != -1
				{
					with(my_weapon)
					{
						flip_weapon = true;
						flip_direction = -1;
					}
				}
					
				hanging_on_ledge = true;
				potential_end_up_location_from_ledge_x = other.bbox_right - sprite_get_xoffset(mask_index);
				potential_end_up_location_from_ledge_y = other.bbox_top - sprite_get_height(mask_index) + sprite_get_yoffset(mask_index);
				
				x = other.bbox_right + sprite_get_xoffset(mask_index) + 1;
				y = other.bbox_top + sprite_get_yoffset(mask_index);
				
				ds_list_clear(ledge_collision_list);
			}
		}
		
		
	}
	
}
#endregion




#region STATE MACHINE
if abs(h_speed) > 0 
{
	if image_xscale != sign(h_speed)
	{
		current_state = STATE.BACK_PEDDLE;
	}
	else
	{
		current_state = STATE.RUN;
	}
}



#region crouch
	if crouch > 0
	{
		is_crouching = true;
	}
	else
	{
		is_crouching = false;
	}
	
	if is_crouching == true and is_attacking == false and is_on_floor == true
	{
		current_state = STATE.CROUCH;
		var max_arm_socket_y = 35;
		arm_socket_y += 9;
		arm_socket_y = clamp(arm_socket_y,0,max_arm_socket_y);
		
		//im assuming this is the last potential state
		if last_current_state == current_state and floor(image_index) == image_number - 1
		{
			image_index = image_number - 1;			
		}
	}
	else
	{
		arm_socket_y = 0;
	}
#endregion


if is_attacking == true
{
	initially_launching_attack = true;
	total_grav = 0;
	current_state = STATE.ATTACK;
	
	//im assuming this is the last potential state
	if last_current_state == current_state and floor(image_index) == image_number - 1
	{
		image_index = image_number - 1;
	}
}
else
{
	initially_launching_attack = false;
}


//in air
if is_attacking == false and is_on_floor == false
{
	//check if we are going up or down
	current_state = STATE.IN_AIR_UP;
}


#region on ledge
	if hanging_on_ledge == true
	{
		v_speed_additional = 0;
		current_additional_v_speed_from_jump_height = 0;
		total_grav = 0;
		v_speed = 0;
		h_speed_projectile = 0;
		h_speed_additional = 0;
		h_speed = 0;	
		can_flip_image_dir = false;
	
		mouse_dir = 90
		arm_socket_x = 20 * image_xscale;
		arm_socket_y = -47;
		my_weapon_id.can_attack = false;
		my_weapon_id.draw_weapon = false;

	
		if has_finished_initial_ledge_grab == false
		{
			current_state = STATE.LEDGE_INITIAL;
			
			if last_current_state == STATE.LEDGE_INITIAL and floor(image_index) == image_number - 1
			{
				has_finished_initial_ledge_grab = true;			
			}
		}
		else
		{
			current_state = STATE.LEDGE_IDLE;
		}
		
		
		
		if facing_dir != image_xscale
		{
			can_now_climb_up_with_that_directional_button = true;
		}
		
		
		var pull_self_from_ledge_width_dir_button = false;
		if can_now_climb_up_with_that_directional_button == true and facing_dir == image_xscale
		{
			pull_self_from_ledge_width_dir_button = true;
		}
		
		
		//start to climb up
		if pressed_jump == true or pull_self_from_ledge_width_dir_button == true
		{			
			getting_up_from_ledge = true;	
			current_time_taken_to_get_up_from_ledge = 0;
			hanging_on_ledge = false;
		}
	
		//if pressing down ...no longer ledge grab and fall directly down
		if crouch > 0 
		{
			hanging_on_ledge = false;
		}
	
	
		//if pressing on the opposite side then fall off in that direction
		var facing_dir = (move_right - move_left);
		var normal_run_value = (facing_dir * move_speed);
	
		if facing_dir != 0 and !position_meeting(x + (sprite_get_xoffset(mask_index) * facing_dir) + normal_run_value,y - sprite_get_yoffset(mask_index),obj_solid) 
		{
			hanging_on_ledge = false;
		}
	
	
	
		//if we are no longer hanging due to a button push in here...reset some variables to bring back normal state
		if hanging_on_ledge == false and getting_up_from_ledge == false
		{
			can_flip_image_dir = true;	
			my_weapon_id.can_attack = true;
			my_weapon_id.draw_weapon = true;
		}
	
	}
	
	
	
	
	if getting_up_from_ledge == true
	{
		//after a couple frames make the player invulnerable to damage...
		//I hate getting on a ledge...unable to move and get smacked...potentially falling and infinite loop
		v_speed_additional = 0;
		current_additional_v_speed_from_jump_height = 0;
		total_grav = 0;
		v_speed = 0;
		h_speed_projectile = 0;
		h_speed_additional = 0;
		h_speed = 0;	
		can_flip_image_dir = false;
		
		mouse_dir = 160;
		if image_xscale == 1 mouse_dir = 20;
		var end_hand_pos_x = 34
		arm_socket_x = min(current_time_taken_to_get_up_from_ledge * 2,end_hand_pos_x) * image_xscale;
		arm_socket_y = -80;
	
		my_weapon_id.can_attack = false;
		my_weapon_id.draw_weapon = false;	
		current_state = STATE.LEDGE_TO_KNEE;
		image_speed = room_speed/max_time_taken_to_get_up_from_ledge;
		
		current_time_taken_to_get_up_from_ledge += 1;
		
		var time_till_cant_get_hit = 4;//frames
		
		if current_time_taken_to_get_up_from_ledge < time_till_cant_get_hit
		{
			can_get_hit = false;
		}
		
		if current_time_taken_to_get_up_from_ledge >= max_time_taken_to_get_up_from_ledge
		{
			
			current_state = STATE.KNEE_TO_STAND;			
			getting_up_from_ledge = false;
			
			x = potential_end_up_location_from_ledge_x;
			y = potential_end_up_location_from_ledge_y;
			
			mouse_dir = 190;
			if image_xscale == 1 mouse_dir = 50;
			//if image_xscale == 1 mouse_dir -= 180;
			arm_socket_x = 5 * image_xscale;
			arm_socket_y = 74;
		}
		
		
	}
	
#endregion

if last_current_state == STATE.KNEE_TO_STAND
{
	current_state = STATE.KNEE_TO_STAND;
	
	var current_image_index = floor(image_index);
	
	switch(current_image_index)
	{
		case 0: 
			mouse_dir = 190;
			if image_xscale == 1 mouse_dir = 50;
			arm_socket_x = 5 * image_xscale;
			arm_socket_y = 74;
		break;
		
		case 1: 
			mouse_dir = 140;
			if image_xscale == 1 mouse_dir = 22;
			arm_socket_x = 14 * image_xscale;
			arm_socket_y = 60;
		break;
		
		case 2: 
			mouse_dir = 110;
			//if image_xscale == 1 mouse_dir -= 180;
			arm_socket_x = 25 * image_xscale;
			arm_socket_y = 14;
		break;
	}
	
	
	
	if current_image_index == image_number - 1
	{
		current_state = STATE.IDLE;	
		
		can_get_hit = true;
		can_flip_image_dir = true;
	
		my_weapon_id.can_attack = true;
		my_weapon_id.draw_weapon = true;
		
		arm_socket_x = 0;
		arm_socket_y = 0;
	}

}



//animate our sprites
if current_state != last_current_state
{
	image_index = 0;
}

last_current_state = current_state;


//finally set our sprites image
sprite_index = sprite_state_array[current_state];
#endregion





if hanging_on_ledge == false and getting_up_from_ledge == false and last_current_state != STATE.KNEE_TO_STAND
{
	scr_movement_and_collision();
}







