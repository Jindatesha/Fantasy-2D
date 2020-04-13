///scr_refresh_player_inventory_items

//this script will delete all the obj_items from the players inventory and recreate 
//them all in order to not have to refresh* them every step and repeating of code


//set the position for the ui
var starting_inventory_x = (gui_w/2) - (sprite_get_width(spr_ui_hud_health_bar_backing)/2);
var starting_inventory_y = gui_h * 0.1;

if instance_exists(obj_player)
{
	
	if obj_cursor.item_in_hand != -1 
	{
		with(obj_cursor)
		{
			//empty our hand
			item_in_hand = -1;
	
			sprite_index = spr_cursor;
			mask_index = spr_cursor;
		}
	}
	
	
	//remove all object items in our inventory (will be re-created)
	with(obj_item_in_inventory)
	{
		instance_destroy();
	}
	
	
	
	
	with(obj_player)
	{
		
		
		//remove the obj_weapon  (will be re-added if need be)
		if my_weapon != -1
		{
			with(my_weapon)
			{
				instance_destroy();
			}
			
			my_weapon = -1;
		}
		
		
		
		//create all the items inside the inventory for us to be able to grab and do stuff with
		var how_many_items_in_inventory = ds_list_size(inventory_list);
		//var item_slots_filled = 0;
		for(var i = 0; i < how_many_items_in_inventory; i+=1;)
		{
			//obj_item_in_inventory
			var this_item = ds_list_find_value(inventory_list,i);
			
			//make sure there is an item in this slot
			if this_item != -1
			{			
				//are we apart of the main inventory
				if i < 15
				{
					//if so...is the menu up?	
					if obj_player.is_inventory_open == true
					{
						scr_create_a_visual_item_in_inventory(i);
					}
				}
				else
				{
					scr_create_a_visual_item_in_inventory(i);
				}
				
				
				
				
				
				var inventory_item_number = ds_list_find_value(obj_player.inventory_list,obj_player.selected_hotbar_slot);
				//if this item is going inside the hotbar active item slot and item is a weapon/tool
				if i == obj_player.selected_hotbar_slot and inventory_item_number >= WEAPON_LIST.BASIC and inventory_item_number < WEAPON_LIST.LAST_IN_LIST
				{
					//since it is...create the item and equip it to the player		
					scr_create_and_equip_weapon(obj_player,inventory_item_number);					
				}
		
				
				
				
			}
								
		}
	
	}
}











