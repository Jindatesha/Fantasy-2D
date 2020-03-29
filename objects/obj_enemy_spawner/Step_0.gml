


//list has 2 slots:(enemy id, remaining spawn timer)

var i = 0;
repeat(ds_list_size(spawner_enemy_list)/3)
{
	//count this enemy's timer down by one
	var this_enemys_timer = ds_list_find_value(spawner_enemy_list, i + 2);
	ds_list_set(spawner_enemy_list,i + 2,this_enemys_timer - 1);
	
	//if timer is up... 
	if this_enemys_timer <= 0
	{
		//activating the object
		var this_enemys_type = ds_list_find_value(spawner_enemy_list, i);
		
		var this_enemys_room_id = ds_list_find_value(spawner_enemy_list, i + 1);
		
		//add this enemy back to the rooms list...where it will be spawned either now...or when that room is next active/entered
		ds_list_add(enemy_spawn_room_list[this_enemys_room_id],this_enemys_type);
		
		
		
		//remove this from our list
		ds_list_delete(spawner_enemy_list,i);
		ds_list_delete(spawner_enemy_list,i);
		ds_list_delete(spawner_enemy_list,i);
		
	}
	else
	{
		i += 3;
	}
	
}



//if we have any enemies waiting to be spawned in our current rooms list....spawn them
if current_room_number != ROOM_NUMBER.NO_ENEMY_ZONE
{
	//check if that list is empty
	var size_of_current_room_list = ds_list_size(enemy_spawn_room_list[current_room_number]);
	if size_of_current_room_list > 0
	{
		//for all the enemies in this list...spawn them
		var current_room_list_position = 0;
		repeat(size_of_current_room_list)
		{
			var this_enemy_type = ds_list_find_value(enemy_spawn_room_list[current_room_number],current_room_list_position);
		
			//random_location ...take into account our sprite (prevent us from getting stuck in walls)
			with (instance_create_depth(x,y,depth,this_enemy_type))
			{
		
				do
				{
					x = irandom_range(0 + sprite_width,room_width - sprite_width);
					y = irandom_range(0 + sprite_width,room_height - sprite_width);
				}
				until(!place_meeting(x,y,obj_solid) and (point_distance(x,y,obj_player.x,obj_player.y) > 200) and (place_meeting(x,y,obj_spawn_area)))
			}
		
		
			//remove this enemy to be spawned from our room list
			ds_list_delete(enemy_spawn_room_list[current_room_number],current_room_list_position);
		
		
		}
	}

}

