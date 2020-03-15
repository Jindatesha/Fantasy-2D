

//normal movement
current_state = STATE.WALK;
sprite_state_array[STATE.IDLE] = spr_player_blank;
sprite_state_array[STATE.WALK] = spr_player_blank;
sprite_state_array[STATE.DODGE_ROLL] = spr_player_blank;
sprite_state_array[STATE.ATTACK] = spr_player_blank;
can_switch_state = true;



//starting stats
my_stats_array[PLAYER_STATS.HEALTH] = 10;
my_stats_array[PLAYER_STATS.STRENGTH] = 10;
my_stats_array[PLAYER_STATS.ATTACK_SPEED] = 10;
my_stats_array[PLAYER_STATS.CRIT_CHANCE] = 5;

image_speed = 0.4;

//how fast the player can normally move
move_speed = 10;
max_speed = 40;
jump_height = 40;
mouse_dir = 0;
total_grav= 0;
max_grav = 40;
h_speed = 0;
v_speed = 0;
can_jump = false;

current_additional_v_speed_from_jump_height = 0;
max_pressed_jump_leeyway_time = 4;//frames
pressed_jump_leeway = 0;
pressed_jump = 0;
v_jump_amount = 0;
total_possible_jumps = 2;
current_jumped_times = 0;

max_coyote_time = room_speed * 0.15;
coyote_time = 0;

can_control_player = true;

starting_depth = DEPTH.PLAYER
depth = starting_depth;

h_speed_additional = 0;
v_speed_additional = 0;

//our players collision mask
mask_index = spr_player_collision_mask;




//current weapon
my_weapon_id = scr_create_and_equip_weapon(WEAPON_TYPE.SWORD); // -1 is none




switch_hand_degree_margin = 20;
weapon_hand = 1;//1 = right hand  -1 = left hand
hand_dir = 0; //degree in which the arms will "bend" until the weapon is swapped to the other hand



attack_thrust_amount = 60;
attack_thrust_total_frames = room_speed * 0.13;
attack_thrust_current_frame = 0;


//starting stats
starting_hp = my_stats_array[PLAYER_STATS.HEALTH];

my_max_hp = my_stats_array[PLAYER_STATS.HEALTH];
my_hp = my_max_hp;
hp_lossed = 0;
show_health_reduction_timer = 0;
show_health_max_reduction_time = room_speed * 0.6;





starting_inventory_x = 0;
starting_inventory_y = 0;
inventory_on = -1;//-1 is off by default (1 = on)


inventory_list = ds_list_create();






//do we have this levels key? for draw hud
has_key = false;


is_inventory_open = false;
//just in case you are testing stuff...we can check if there are already nodes placed or stuff in our inventory
//recalc your stats
event_user(0);

//only here...reset current hp
my_hp = my_max_hp;



//how long the special attack takes
special_attack_time_till_player_can_move = 0.2 * room_speed;
is_special_attack_on_cooldown = false;
max_special_attack_cooldown_time = 5 * room_speed; 
special_attack_cooldown_timer = max_special_attack_cooldown_time;

selected_hotbar_slot = 0;

hotbar_item_array[0] = -1;



player_name = "Jindatesha";




