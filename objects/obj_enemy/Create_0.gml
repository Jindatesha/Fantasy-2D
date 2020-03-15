/// @description Insert description here
// You can write your code in this editor

current_state = STATE.WALK;

sprite_state_array[STATE.WALK] = spr_enemy_slime_move_side;
//sprite_state_array[STATE.DODGE_ROLL] = spr_player_move_dodge_roll_side;




move_speed = 10;
max_speed = 40;
jump_height = 30;
mouse_dir = 0;
total_grav= 0;
max_grav = 5;
h_speed = 0;
v_speed = 0;
can_jump = false;




my_max_hp = 40;
my_hp = my_max_hp;
my_speed = 1.7;
show_health_timer = 0;
my_range = 400;
show_health_max_time = room_speed * 0.6;
hp_lossed = 0;
my_damage = 15;

depth = DEPTH.ENEMY;

mask_index = spr_enemy_slime_collision;

my_respawn_rate = room_speed * 2;


can_attack = true;

my_attack_reload_time = room_speed * 2;

can_move = true;
can_switch_state = true;



is_attacking = false;

has_done_hit_collisions = false;
my_attack_collision_image = spr_enemy_slime_attack_collision;
my_attack_range = sprite_get_width(my_attack_collision_image) * 0.8;

my_monster_type = MONSTER.SLIME;

h_speed = 0;
v_speed = 0;

has_been_aggroed = false;//if true: follow the player and attack indefinitely 


