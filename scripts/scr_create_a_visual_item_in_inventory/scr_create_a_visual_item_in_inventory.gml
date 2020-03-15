
/// @param inventory_position


var inventory_position = argument[0];

//obj_player.starting_inventory_x + obj_player.inventory_slots_pos_array[inventory_position,0],obj_player.starting_inventory_y + obj_player.inventory_slots_pos_array[inventory_position,1]
//create and place the visual item in inventory
with (instance_create_depth(100,100,depth - 1,obj_item_in_inventory))
{
	//create an enum sprite list for weapons and for equipment					
	my_item_number = ds_list_find_value(obj_player.inventory_list,inventory_position);					
					
	// based on item number; what class and sprite_index are you?										
	sprite_index = ds_grid_get(global.item_database_grid,THIS_ITEMS.SPRITE_INDEX,my_item_number);	
	//var item_number = ds_grid_get(global.item_database_grid,THIS_ITEMS.ITEM_NUMBER,my_item_number);
	image_index = scr_item_number_to_sprite_or_image_index(my_item_number,1);
	my_item_class = ds_grid_get(global.item_database_grid,THIS_ITEMS.ITEM_CLASS,my_item_number);					
					
	
	image_speed = 0;
					
	current_inventory_slot = inventory_position;
	slot_placement_x = obj_player.inventory_slots_pos_array[inventory_position,0];
	slot_placement_y = obj_player.inventory_slots_pos_array[inventory_position,1];
					
}









