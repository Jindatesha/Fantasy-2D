//scr_equip_item
/// @description this changes our objects variables to use the new item we are equipping


//which item are we equipping?
/// @param item_number
var item_to_equip = argument[0];

is_sword = ds_grid_get(global.item_grid,item_to_equip,0);
is_pickaxe = ds_grid_get(global.item_grid,item_to_equip,1); 
is_axe = ds_grid_get(global.item_grid,item_to_equip,2);
damage = ds_grid_get(global.item_grid,item_to_equip,3);
harvest_damage = ds_grid_get(global.item_grid,item_to_equip,4);
object = ds_grid_get(global.item_grid,item_to_equip,5);
intbackidleleft = ds_grid_get(global.item_grid,item_to_equip,6);
intbackidleright = ds_grid_get(global.item_grid,item_to_equip,7);
intuseright = ds_grid_get(global.item_grid,item_to_equip,8);









