/// @description Insert description here
// You can write your code in this editor



//create a random item to be picked up
if instance_exists(obj_player)
{
	with(instance_create_depth(obj_player.x,obj_player.y - 30,obj_player.depth,obj_item_on_floor))
	{
		var what_item_number_to_use = irandom_range(MATERIAL_LIST.BASIC,MATERIAL_LIST.LAST_IN_LIST - 1);
		sprite_index = scr_item_number_to_sprite_or_image_index(what_item_number_to_use,0);
		image_index = scr_item_number_to_sprite_or_image_index(what_item_number_to_use,1);
		my_item_number = what_item_number_to_use;
	}
}


