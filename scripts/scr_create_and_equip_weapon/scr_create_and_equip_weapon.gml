
/// @param who_to_equip_to
/// @param item_number_to_equip


var item_number_to_equip = argument[0];

//give the player their weapon
var id_of_weapon = (instance_create_depth(x,y,DEPTH.PLAYER,obj_weapon));

with(id_of_weapon)
{
	owner = other;
	owner.my_weapon = id;
	my_item_number = item_number_to_equip;
			
			
	sprite_index = ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.BASIC_ATTACK_1,my_item_number);
	my_base_damage = ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.BASE_DAMAGE,my_item_number);
	my_damage_max_potential = ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.MAX_WEAPON_DAMAGE_SCALE,my_item_number);
				
	mask_index = ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.COLLISION_SPRITE,my_item_number);
			
	/*
		my_item_class = ITEM_CLASS.WEAPON;
		my_attack_image_speed = ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.IMAGE_SPEED,my_weapon_number);
		image_number_to_spawn_hit_collider = ds_grid_get(global.weapons_grid,WEAPON_ATTRIBUTE.COLLISION_NUMBER,my_weapon_number);
	
	
		my_rarity = EQUIPMENT_RARITY.COMMON;
		var my_total_points = scr_get_total_points_from_rarity(my_rarity);
	
		var remaining_points = my_total_points;
		var points_for_this_stat = irandom_range(0,remaining_points);
		my_health = points_for_this_stat;
		remaining_points -= points_for_this_stat;
	
		points_for_this_stat = irandom_range(0,remaining_points);
		my_strength = points_for_this_stat;
		remaining_points -= points_for_this_stat;
	
		points_for_this_stat = irandom_range(0,remaining_points);
		my_attack_speed = points_for_this_stat;
		remaining_points -= points_for_this_stat;
	
		//whatever is left put it in the last stat
		my_crit_chance = remaining_points;
	*/
	
	
}


return id_of_weapon;









