
///update character stats


/*


//gather stats now from our equipment
var equipment_total_gained_hp = 0;
var i = 2; //2 because weapon slots wont provide stats
repeat(6)
{
	
	var this_equipment_slot_item_number = ds_list_find_value(inventory_list,i);
	
	if this_equipment_slot_item_number != -1
	{
		equipment_total_gained_hp += ds_grid_get(global.item_database_grid,EQUIPMENT_STATS.HP,this_equipment_slot_item_number);
		
		//equipment_total_gained_hp += 
	}
	
	i += 1;
}


// set stats for player
my_max_hp = starting_hp + equipment_total_gained_hp;

my_hp = clamp(my_hp,0,my_max_hp);







