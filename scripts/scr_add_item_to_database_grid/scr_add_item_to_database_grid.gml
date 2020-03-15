//scr_add_item_to_database_grid
/// @description This script allows us to have a single line for adding all our grids variables for a single item
//item# = height

//stats for these items
/// @param is_sword
/// @param is_pickaxe
/// @param is_axe
/// @param damage
/// @param harvest_damage
/// @param object
/// @param intbackidleleft
/// @param intbackidleright
/// @param intuseright


var i = 0;
var number_of_variables_these_items_have = ds_grid_width(global.item_grid);

//add +1 to our row
ds_grid_resize(global.item_grid,ds_grid_width(global.item_grid),ds_grid_height(global.item_grid) + 1);

repeat(number_of_variables_these_items_have)
{
	ds_grid_add(global.item_grid,i,ds_grid_height(global.item_grid) - 1,argument[i]);
	i += 1;
}




