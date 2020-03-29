/// @description Insert description here
// You can write your code in this editor








//die...
if my_hp <= 0
{
	
	//drop some mats
	var chosen_item = irandom_range(0,100);
	var has_found_items_to_drop = false;
	var item_number = 0;
	var monster_list = ds_list_find_value(global.monster_drop_list,my_monster_type);
	
	do
	{
		chosen_item -= ds_list_find_value(monster_list,item_number);
		
		if chosen_item <= 0
		{
			has_found_items_to_drop = true;
		}
		else
		{
			item_number += 2;
		}
	}
	until (has_found_items_to_drop == true);
	
	
	
	var item_drop_list = ds_list_find_value(monster_list,item_number + 1);
	//now that we know the items we wish to drop...drop them
	for(var i = 0; i < ds_list_size(item_drop_list); i += 1;)
	{
		var what_item_number_to_use = ds_list_find_value(item_drop_list,i);
		if what_item_number_to_use != -1
		{		
			with (instance_create_depth(x + (30 * i),y + (30 * i),depth,obj_item_on_floor))
			{
				sprite_index = scr_item_number_to_sprite_or_image_index(what_item_number_to_use,0);
				image_index = scr_item_number_to_sprite_or_image_index(what_item_number_to_use,1);
				my_item_number = what_item_number_to_use;
			}

		}
	}
	
	
	
	
	
	
	//add it to the obj_spawners list with these variables..to be respawned in later
	with (obj_enemy_spawner)
	{
		
		ds_list_add(spawner_enemy_list,other.object_index);
		ds_list_add(spawner_enemy_list,current_room_number);
		ds_list_add(spawner_enemy_list,other.my_respawn_rate);
	}
	
	
	
	

	
	
	
	
	
	
	//get rid of this instance
	instance_destroy();
	
	
	
	
}









scr_movement_and_collision();



