/// @description This script allows us to have a single line for adding all our grids variables for a single item
/// @param item#
/// @param item_desription

/// @param materials_item#
/// @param that_materials_count

var item_to_create_item_number = argument[0];
var item_to_create_description = argument[1];


var material_slot = 2;

var material_required_item_number_array = array_create(0,0);
var that_materials_count_array = array_create(0,0);


//if we have an argument for this material slot...plug it in...otherwise set them to -1 and 0
repeat(6)
{
	if argument_count >= (material_slot + 2)
	{
		material_required_item_number_array[material_slot] = argument[material_slot];
		that_materials_count_array[material_slot] = argument[material_slot + 1];
	}
	else
	{
		material_required_item_number_array[material_slot] = -1;
		that_materials_count_array[material_slot] = 0;
	}
	
	material_slot += 2;
}


//resize our grid in order to make room for this item
ds_grid_resize(global.item_forge_grid,ds_grid_width(global.item_forge_grid),ds_grid_height(global.item_forge_grid) + 1);

//add the variables to the designated grid spaces
ds_grid_add(global.item_forge_grid,0, ds_grid_height(global.item_forge_grid) - 1,item_to_create_item_number);
ds_grid_add(global.item_forge_grid,1, ds_grid_height(global.item_forge_grid) - 1,item_to_create_description);


material_slot = 2;

repeat(6)
{
	ds_grid_add(global.item_forge_grid,material_slot, ds_grid_height(global.item_forge_grid) - 1,material_required_item_number_array[material_slot]);
	ds_grid_add(global.item_forge_grid,material_slot + 1, ds_grid_height(global.item_forge_grid) - 1,that_materials_count_array[material_slot]);
	material_slot += 2;
}










