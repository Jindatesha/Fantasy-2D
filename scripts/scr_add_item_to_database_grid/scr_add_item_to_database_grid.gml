/// @description This script allows us to have a single line for adding all our grids variables for a single item
//item# = height

/// @param sprite_index
/// @param image_index
/// @param item_class

/// @param item_set_bonus

//stats for this item
/// @param HP

/*
dmg
atk speed,
weight = affects atk speed and movement speed while weilding this
etc...
*/


var i = 0;
var number_of_variables_these_items_have = 5;

//add +1 to our row
ds_grid_resize(global.item_database_grid,number_of_variables_these_items_have,ds_grid_height(global.item_database_grid) + 1);



repeat(number_of_variables_these_items_have)
{
	//first set it as blank...
	ds_grid_add(global.item_database_grid,i,ds_grid_height(global.item_database_grid) - 1,0);
	
	//if we have an argument for this position in the grid...set it as such
	if argument_count > i
	{
		//so it looks cleaner when calling script...if this is for the image_index
		if i == 1
		{
			#region find the proper image_index to use
				var how_much_to_subtract_by = 0;
				var this_sprite_index = ds_grid_get(global.item_database_grid,0,ds_grid_height(global.item_database_grid) - 1);
				switch(this_sprite_index)
				{
					case spr_all_materials:
					how_much_to_subtract_by = 0;
					break;
	/*
					case spr_all_weapons:
					how_much_to_subtract_by = WEAPON_LIST.BASIC;
					break;
	
					case spr_all_helmets:
					how_much_to_subtract_by = HELMETS_LIST.BASIC;
					break;
	
					case spr_all_torsos:
					how_much_to_subtract_by = TORSO_LIST.BASIC;
					break;
	
					case spr_all_pants:
					how_much_to_subtract_by = PANTS_LIST.BASIC;
					break;
					*/
				}
			#endregion
			ds_grid_set(global.item_database_grid,i,ds_grid_height(global.item_database_grid) - 1,argument[i] - how_much_to_subtract_by);
		}
		else
		{
			ds_grid_set(global.item_database_grid,i,ds_grid_height(global.item_database_grid) - 1,argument[i]);
		}
	}
	
	i += 1;
}







