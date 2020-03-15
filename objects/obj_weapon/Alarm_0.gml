/// @description Insert description here
// You can write your code in this editor




//reset can_attack (use)
can_attack = true;
has_already_attacked = false;
chain_attack_window = max_chain_attack_window;
obj_player.can_control_player = true;
attack_count = 0;
check_to_see_if_player_attacks_again_within_window = false;

//go back to basic attack
sprite_index = ds_grid_get(global.weapons_grid,(WEAPON_ATTRIBUTE.BASIC_ATTACK_1),my_item_number);
image_speed = 0;
image_index = 0;

