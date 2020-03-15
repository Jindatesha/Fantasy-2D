/// @description This script allows us to have a single line for adding all our grids variables for a single item
//item# = height

//stats for this item
/// @param spr_basic_attack_1
/// @param spr_basic_attack_2
/// @param spr_basic_attack_3
/// @param attack_image_speed
/// @param base_damage
/// @param collision_sprite_index
/// @param collision_image_number this is what image in the attack animation to spawn the collision check sprite
/// @param basic_attack_CD first attack and no combo OR after all three combo...till attack resets
/// @param damage_variance minimum is 1... and a crit is 1.5x our max hit




var i = 0;
var number_of_variables_these_items_have = ds_grid_width(global.weapons_grid);

//add +1 to our row
ds_grid_resize(global.weapons_grid,ds_grid_width(global.weapons_grid),ds_grid_height(global.weapons_grid) + 1);

repeat(number_of_variables_these_items_have)
{
	ds_grid_add(global.weapons_grid,i,ds_grid_height(global.weapons_grid) - 1,argument[i]);
	i += 1;
}








