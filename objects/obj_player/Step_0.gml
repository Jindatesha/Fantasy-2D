/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor



#region controls
move_left = keyboard_check(ord("A"));
move_right = keyboard_check(ord("D"));
pressed_jump = keyboard_check_pressed(ord("W"));
var move_down = keyboard_check(ord("S"));


var use_weapon = mouse_check_button_pressed(mb_left);
var use_weapon_special = mouse_check_button(mb_right);

var pick_up_item = keyboard_check_pressed(ord("E"));

var use_utility_item = keyboard_check_pressed(ord("Q"));

var call_inventory = keyboard_check(vk_tab);










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
if can_switch_state == true
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
	if is_inventory_open == false
	{
		is_inventory_open = true;

		
		//set the position for the ui
		var starting_inventory_x = (view_w/2) - (sprite_get_width(spr_ui_healthbar_backing)/2);
		var starting_inventory_y = view_h * 0.1;
			
			

		//create all the items inside the inventory for us to be able to grab and do stuff with
		var hotbar_amount_of_slots = 6;
		var how_many_items_in_inventory_pre = ds_list_size(inventory_list) - hotbar_amount_of_slots;
		//var item_slots_filled = 0;
		for(var i = 0; i < how_many_items_in_inventory_pre; i+=1;)
		{
			//obj_item_in_inventory
			var this_item = ds_list_find_value(inventory_list,i);
			if this_item != -1
			{				
				
				
				//create and place the visual item
				with (instance_create_depth(starting_inventory_x + inventory_slots_pos_array[i,0],starting_inventory_y + inventory_slots_pos_array[i,1],depth - 1,obj_item_in_inventory))
				{
					//create an enum sprite list for weapons and for equipment					
					my_item_number = ds_list_find_value(other.inventory_list,i);					
					
					// based on item number; what class and sprite_index are you?										
					sprite_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.SPRITE_INDEX,my_item_number);		
					image_index = scr_item_number_to_sprite_or_image_index(my_item_number,1);
					my_item_class = ds_grid_get(global.item_database_grid,THIS_ITEMS.ITEM_CLASS,my_item_number);					
					
	
					image_speed = 0;
					
					current_inventory_slot = i;
					slot_placement_x = obj_player.inventory_slots_pos_array[i,0];
					slot_placement_y = obj_player.inventory_slots_pos_array[i,1];
					
				}
								
			}
			
			
			
			//create and place a collision box for an invisible check to see if an item can be moved here
			with (instance_create_depth(starting_inventory_x + inventory_slots_pos_array[i,0],starting_inventory_y + inventory_slots_pos_array[i,1],depth - 2,obj_check_inventory_slot))
			{
				current_inventory_slot = i;
				//class
				slot_placement_x = obj_player.inventory_slots_pos_array[i,0];
				slot_placement_y = obj_player.inventory_slots_pos_array[i,1];
				
				
				
				
				
				/*
				0 = wep 1
				1 = wep 2

				2 = glove
				3 = ring
				4 = boots

				5 = helmet
				6 = torso
				7 = legs

				8 -> ?? = left -> right then down one row
				ie:
				8,9,10
				11,12,13
				*/
				switch(i)
				{
					default:
					case 0: 
						my_slot_class = ITEM_CLASS.HELMET;
					break;
					
					case 1: 
						my_slot_class = ITEM_CLASS.TORSO;
					break;
					
					case 2: 
						my_slot_class = ITEM_CLASS.PANTS;
					break;
					
					case 3: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 4: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 5: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 6: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 7: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 8: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 9: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 10: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 11: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 12: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 13: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 14: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 15: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 16: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 17: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 18: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 19: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
					case 20: 
						my_slot_class = ITEM_CLASS.ANYTHING;
					break;
					
				
				}
					
			}
		}
			
		
	}
		
		
}
else
{
	if is_inventory_open == true
	{
		is_inventory_open = false;
		
		
		
		//get rid of all the objects that we can grab
		with (obj_item_in_inventory)
		{
			//if we are not a hotbar item
			if current_inventory_slot < 15
			{
				if are_we_being_held_by_cursor == false
				{			
					instance_destroy();
				}
			}
		}
		
		//get rid of all the slot location objects
		with (obj_check_inventory_slot)
		{
			if current_inventory_slot < 15
			{
				instance_destroy();
			}
		}
	
	}
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
	var number_of_equipment_slots = 3;
	
	if hit_count > 0
	{
		//see where the nearest empty slot is...if not present then cant pickup
		var current_total_slots = ds_list_size(inventory_list);
		for(var i = 0; i < current_total_slots; i += 1;)
		{
			//check to see if this slot is empty (-1)
			if ds_list_find_value(inventory_list,i) == -1
			{
				#region if we are talking about putting it in one of the equipment slots...
				if i < number_of_equipment_slots
				{
					//make sure the item to be picked up is an equipment piece
					if item_to_be_picked_up.my_item_number >= HELMETS_LIST.BASIC
					{
						var can_equip_item_on_floor = false;
						
						//is this item class the same as the class of the slot we want to place it in?
						switch(i)
						{
							case 0:
								//helmet
								if item_to_be_picked_up.my_item_number < HELMETS_LIST.LAST_IN_LIST
								{
									can_equip_item_on_floor = true;
								}
								else
								{
									continue;
								}
							break;
							
							
							case 1:
								//torso
								if item_to_be_picked_up.my_item_number >= TORSO_LIST.BASIC and item_to_be_picked_up.my_item_number < TORSO_LIST.LAST_IN_LIST
								{
									can_equip_item_on_floor = true;
								}
								else
								{
									continue;
								}
							break;
							
							case 2:
								//pants
								if item_to_be_picked_up.my_item_number >= PANTS_LIST.BASIC and item_to_be_picked_up.my_item_number < PANTS_LIST.LAST_IN_LIST
								{
									
									can_equip_item_on_floor = true;
									
								}
								else
								{
									continue;
								}
							break;
							
						}
						
						
						if can_equip_item_on_floor == true
						{
							
							//place the item on floor into our inventory
							ds_list_replace(inventory_list,i,item_to_be_picked_up.my_item_number);
							
							//destroy that item on the floor so we cant keep picking it up
							with (item_to_be_picked_up)
							{		
								//destroy item so it cant be picked up again
								instance_destroy();
							}
							
							scr_refresh_player_inventory_items();
						}
						
						//found the item slot to place it in, no need to check other inventory slots
						break;
						
					}
					else
					{
						//so we are noticing that an equipment slot is empty but the item we are trying to pick up is NOT an equipment piece
						continue;// so cant place in here...sorry charlie...go through the loop again
					}
				}
				#endregion
				
				//place the item on floor into our inventory
				ds_list_replace(inventory_list,i,item_to_be_picked_up.my_item_number);
			
			
				//destroy that item on the floor so we cant keep picking it up
				with (item_to_be_picked_up)
				{		
					//destroy item so it cant be picked up again
					instance_destroy();
				}			
				
				
				scr_refresh_player_inventory_items();
				
				//we found an empty slot to put our new item in...leave this loop
				break; 
			}
		
		}

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




#region STATE MACHINE
if (abs(v_speed) or abs(h_speed)) > 0 
{
	current_state = STATE.WALK;
}


if is_attacking == true
{
	current_state = STATE.ATTACK;
	
	//im assuming this is the last potential state
	if last_current_state == current_state and floor(image_index) == image_number - 1
	{
		image_index = image_number - 1;
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







scr_movement_and_collision();










