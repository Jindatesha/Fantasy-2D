/// @description Insert description here
// You can write your code in this editor

//initialize
current_room_number = ROOM_NUMBER.NO_ENEMY_ZONE;


//create a list of enemies to spawn for each of our rooms
rooms_that_spawn_enemies = 1;
var i = 0;
repeat(rooms_that_spawn_enemies)
{
	enemy_spawn_room_list[i] = ds_list_create();
	i += 1;
}



//what enemies are in those lists?

//room 0 = slime_zone
ds_list_add(enemy_spawn_room_list[ROOM_NUMBER.SLIME_ZONE],MONSTER_TYPE.SLIME,MONSTER_TYPE.SLIME,MONSTER_TYPE.SLIME);





spawner_enemy_list = ds_list_create();









