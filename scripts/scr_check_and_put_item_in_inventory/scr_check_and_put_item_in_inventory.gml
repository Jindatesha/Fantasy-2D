//scr_check_and_put_item_in_inventory()

///@param item_id_to_put_in_backpack



//create all the items inside the inventory for us to be able to grab and do stuff with
var inventory_width = ds_grid_width(global.player_inventory_grid);
var inventory_height = ds_grid_height(global.player_inventory_grid);
var total_inventory_slots = inventory_width * inventory_height;
var inv_grid_number_x = 0;
var inv_grid_number_y = 0;
var item_slot_spacing = 15;
var width_of_item_slot = 80;
var total_space_for_slot = width_of_item_slot + item_slot_spacing;

//set the position for the ui
var backpack_collision_width = sprite_get_width(spr_ui_backpack_backing);
var backpack_collision_height = sprite_get_height(spr_ui_backpack_backing);



var obj_id = argument[0];
var item_to_be_placed = obj_id.my_item_number;





#region make sure collision stuff is up
	//if backpack ui is UP...create and place the visual item
		if obj_player.is_inventory_open == true
		{
			//items to be in starting slot
			var first_item_slot_adjust_x = 333;
			var first_item_slot_adjust_y = 252;
			var starting_inventory_x = obj_collision_full_inventory.x + first_item_slot_adjust_x;
			var starting_inventory_y = obj_collision_full_inventory.y + first_item_slot_adjust_y;
			
		}
		else
		{
			//since they arent up...i cant do collision checks...gunna need to do em up and then delete them
			#region create collision boxes with their respective data
			{
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
			}
			#endregion
		}
#endregion


var item_id_to_be_placed_in_inventory = instance_create_depth(starting_inventory_x + (total_space_for_slot * inv_grid_number_x),starting_inventory_y + (total_space_for_slot * inv_grid_number_y),depth - 1,obj_item_in_inventory);
with (item_id_to_be_placed_in_inventory)
{
	my_starting_x = first_item_slot_adjust_x + (total_space_for_slot * inv_grid_number_x);
	my_starting_y = first_item_slot_adjust_y + (total_space_for_slot * inv_grid_number_y);
	//create an enum sprite list for weapons and for equipment					
	my_item_number = item_to_be_placed;					
					
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
	
	
	
	
	
	
	
var slots_collided_list = ds_list_create();	
ds_list_destroy(slots_collided_list);//******


//check all the slots
for(var i = 0; i < total_inventory_slots; i+=1;)
{
			
	inv_grid_number_x = i mod inventory_width;
	inv_grid_number_y = i div inventory_height;
			
	//check slot		
	var slot_to_check_for_item = ds_grid_get(global.player_inventory_grid,inv_grid_number_x,inv_grid_number_y);
		
										
	if slot_to_check_for_item == -1
	{
		//place our collider check position
		var slot_to_check_id = instance_find(obj_check_inventory_slot,(inv_grid_number_x * inv_grid_number_y));
		item_id_to_be_placed_in_inventory.x = slot_to_check_id.x;
		item_id_to_be_placed_in_inventory.y = slot_to_check_id.y;
		
		
		//check to see if its colliding with any other slots than the one we are on
		instance_place_list(item_id_to_be_placed_in_inventory.x,item_id_to_be_placed_in_inventory.y,obj_check_inventory_slot,slots_collided_list,false);
	
		var how_many_slot_collisions = ds_list_size(slots_collided_list);
		if how_many_slot_collisions > 1
		{
			//since we are colliding with more than one...we are a big boi...need to check to see if those are empty otherwise keep trying till loop runs its course
			
		}
		
		//set it in the BACKPACK inventory
		ds_grid_set(global.player_inventory_grid,inv_grid_number_x,inv_grid_number_y,item_to_be_placed);
		
		//delete the one from the floor
		instance_destroy(obj_id);
		
		break;
		
	}
}	


