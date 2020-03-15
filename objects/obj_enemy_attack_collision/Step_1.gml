/// @description Insert description here
// You can write your code in this editor
var hit_list = ds_list_create();
var hit_count = instance_place_list(x,y,obj_player,hit_list,true);
var i = 0;
			
repeat(hit_count)
{
	with (ds_list_find_value(hit_list,i))
	{
		my_hp -= other.my_damage;
		show_health_reduction_timer = show_health_max_reduction_time;
		hp_lossed = other.my_damage;
	}
				
	i += 1;
}
	
ds_list_destroy(hit_list);

instance_destroy();


