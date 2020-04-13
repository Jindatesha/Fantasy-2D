/// @description Insert description here
// You can write your code in this editor





if global.item_in_hand == -1 and mouse_check_button_pressed(mb_left)
{
	are_we_being_held_by_cursor = true;
	global.item_in_hand = my_item_number;
	old_mouse_x = round(mouse_x);
	old_mouse_y = round(mouse_y);
}



if are_we_being_held_by_cursor == true
{
	mask_index = sprite_index;

	#region have we let go of the item
		if mouse_check_button_released(mb_left)
		{
			are_we_being_held_by_cursor = false;
			global.item_in_hand = -1;//nothing is in ur hand now
			

					
			if !place_meeting(x,y,obj_collision_full_inventory)
			{
				//u are dropping the item OUTSIDE of the inventory
								
				//drop ur item on the floor and clear its slot position from grid
				with (instance_create_depth(obj_player.x,obj_player.y,DEPTH.ITEM_ON_FLOOR,obj_item_on_floor))
				{
					var what_item_number_to_use = other.my_item_number;
					sprite_index = scr_item_number_to_sprite_or_image_index(what_item_number_to_use,0);
					image_index = scr_item_number_to_sprite_or_image_index(what_item_number_to_use,1);
					my_item_number = what_item_number_to_use;
				}
				
				//remove this item from our players backpack
				ds_grid_set(global.player_inventory_grid,my_inv_grid_number_x,my_inv_grid_number_y,-1);
				
				//get rid of the item...
				instance_destroy();
				
			}
			else
			{		
				//check what grid space we are in	
				var collided_slot_list = ds_list_create();
				var collided_slot_list_size = instance_place_list(x,y,obj_check_inventory_slot,collided_slot_list,true);
				
				if collided_slot_list_size > 0
				{
					var collided_slot_id = ds_list_find_value(collided_slot_list,0);
					
					if collided_slot_id.my_item_class == my_item_class or collided_slot_id.my_item_class == ITEM_CLASS.ANYTHING
					{
						//move this item to this slot...if its empty tho then see if the items can be swapped around
						//weve collided with the nearest slot...but are we colliding with another item?
						var item_id_in_collided_slot = instance_place(x,y,obj_item_in_inventory);
						if item_id_in_collided_slot != noone 
						{
							//so there was an item already in the spot...now lets check to see if it can fit in our old position...
							var difference_in_widths = max(item_id_in_collided_slot.my_item_width - my_item_width,0);//higher than zero is all we care about...cuz it can either fit in what will be empty space or exceed that
							var difference_in_heights = max(item_id_in_collided_slot.my_item_height - my_item_height,0);//^same
							
							if difference_in_widths > 0 or difference_in_heights > 0
							{
								//it wont fit in our old slot space...but could it fit in that space + potentially empty space around it?
							}
							else
							{
								//it WILL fit! letsssss  SWAP EM =)
								var my_old_starting_x = my_starting_x;
								var my_old_starting_y = my_starting_y;
								var my_old_inv_grid_number_x = my_inv_grid_number_x;
								var my_old_inv_grid_number_y = my_inv_grid_number_y;
								
								my_starting_x = item_id_in_collided_slot.my_starting_x;
								my_starting_y = item_id_in_collided_slot.my_starting_y;
								
								ds_grid_set(global.player_inventory_grid,my_inv_grid_number_x[],my_inv_grid_number_y,item_id_in_collided_slot.my_item_number);//empty
								my_inv_grid_number_x = item_id_in_collided_slot.my_inv_grid_number_x;
								my_inv_grid_number_y = item_id_in_collided_slot.my_inv_grid_number_y;
								ds_grid_set(global.player_inventory_grid,my_inv_grid_number_x,my_inv_grid_number_y,my_item_number);//new slot
								
							}
							
						}
						else
						{
							//there was nothing taking up the new slot...go ahead and move in!
							my_starting_x = collided_slot_id.my_starting_x;
							my_starting_y = collided_slot_id.my_starting_y;
							ds_grid_set(global.player_inventory_grid,my_inv_grid_number_x,my_inv_grid_number_y,-1);//empty
							my_inv_grid_number_x = collided_slot_id.my_inv_grid_number_x;
							my_inv_grid_number_y = collided_slot_id.my_inv_grid_number_y;
							ds_grid_set(global.player_inventory_grid,my_inv_grid_number_x,my_inv_grid_number_y,my_item_number);//new slot
						}
						
						
					}
				}
				//ELSE: dont worry...it automatically snaps back from its x/y code below
				
			}
		
		}
	#endregion
	
	#region move the item around with the cursor
		x = mouse_x;
		y = mouse_y;
		
	#endregion
		
}
else
{	
	var view_to_gui_ratio = view_w/gui_w;
	x = view_x + ((gui_w - sprite_get_width(spr_ui_backpack_backing) - 20 + my_starting_x) * view_to_gui_ratio);
	y = view_y + (((gui_h * 0.5) - (sprite_get_height(spr_ui_backpack_backing)/2) + my_starting_y) * view_to_gui_ratio);
	mask_index = spr_ui_inventory_slot_backing;
}


image_xscale = obj_camera.zoom_amount;
image_yscale = obj_camera.zoom_amount;


