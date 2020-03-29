

//normal movement
current_state = STATE.IDLE;
sprite_state_array[STATE.IDLE] = spr_player_idle;
sprite_state_array[STATE.RUN] = spr_player_run;
sprite_state_array[STATE.DODGE_ROLL] = spr_player_idle;
sprite_state_array[STATE.ATTACK] = spr_player_attack_sword_basic;
sprite_state_array[STATE.CROUCH] = spr_player_crouch;
sprite_state_array[STATE.IN_AIR_UP] = spr_player_in_air_up;
sprite_state_array[STATE.BACK_PEDDLE] = spr_player_back_peddle;
sprite_state_array[STATE.LEDGE_INITIAL] = spr_player_ledge_hang_initial;
sprite_state_array[STATE.LEDGE_IDLE] = spr_player_ledge_hang_idle;
sprite_state_array[STATE.LEDGE_TO_KNEE] = spr_player_ledge_hang_to_kneel;
sprite_state_array[STATE.KNEE_TO_STAND] = spr_player_kneel_to_stand;
can_switch_state = true;
last_current_state = current_state;
is_attacking = false;

//starting stats
my_stats_array[PLAYER_STATS.HEALTH] = 10;
my_stats_array[PLAYER_STATS.STRENGTH] = 10;
my_stats_array[PLAYER_STATS.ATTACK_SPEED] = 10;
my_stats_array[PLAYER_STATS.CRIT_CHANCE] = 5;

image_speed = 1;


//where the arm socket/origin is
arm_socket_x = 0;
arm_socket_y = 0;

//how fast the player can normally move
h_speed_projectile = 0;
move_speed = 10;
max_speed = 40;
jump_height = 25;
mouse_dir = 0;
total_grav= 0;
max_grav = 40;
h_speed = 0;
v_speed = 0;
can_jump = false;
is_on_floor = false;
move_left = 0;
move_right = 0;
reduce_speed = 0;
is_crouching = false;
can_air_juggle = true;

current_additional_v_speed_from_jump_height = 0;
max_pressed_jump_leeyway_time = 4;//frames
pressed_jump_leeway = 0;
pressed_jump = 0;

total_possible_jumps = 1;
current_jumped_times = 0;

//ledge grabbing stuff
hanging_on_ledge = false;
can_flip_image_dir = true;
max_time_taken_to_get_up_from_ledge = room_speed * 0.6;
current_time_taken_to_get_up_from_ledge = 0;
getting_up_from_ledge = false;
has_finished_initial_ledge_grab = false;
can_now_climb_up_with_that_directional_button = false;
ledge_collision_list = ds_list_create();

can_get_hit = true;

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



attack_thrust_amount = 6;
attack_thrust_total_frames = room_speed * 0.13;
attack_thrust_current_frame = 0;
has_added_attack_thrust = false;

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
ds_list_add(inventory_list,-1,-1,-1,-1);





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




