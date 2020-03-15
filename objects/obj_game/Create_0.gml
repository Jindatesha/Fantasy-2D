/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor

//game run speed
game_set_speed(60, gamespeed_fps);

//we dont need 3D text buffering...this sets it for the rest of the game
surface_depth_disable(true);

//debug overlay (FPS    (texture swaps) (vertex batches))
show_debug_overlay(true);



updated_fps = 0;
time_to_update_fps = 0;
average_fps_list = ds_list_create();


//colors
#macro c_ui_yellow make_color_rgb(228,178,42)
#macro c_ui_blue make_color_rgb(174,234,162)
#macro c_ui_purple make_color_hsv(201,59,223) //purple nurple for shop, selected item border



//font
//draw_set_color(c_ui_yellow);
draw_set_color(c_black);
draw_set_font(font_sea_gardens);


//sound globals
global.sound_effects_volume = 1;
global.music_volume = 1;







//settings menu and to make sure that other menus arent interactable while these are open
global.is_settings_menu_open = false;

global.freeze_character = false;
//this object is for the particle system (created only once and used throughout the game (persistent))
//instance_create_depth(view_w /2,view_h * 0.35,depth + 2,obj_target_bits);

global.player_has_attacked = false;

global.transition_fade_alpha = 1;

global.can_move_towards_mouse = true;

//state the player or enemy is in...and will determine their sprite index
enum STATE
{
	IDLE,
	WALK,
	DODGE_ROLL,
	ATTACK,
	ATTACK_WIND,
	ATTACK_SPECIAL,
	LAST
}


enum PLAYER_STATS
{
	HEALTH,
	STRENGTH,
	ATTACK_SPEED,
	CRIT_CHANCE
}


enum DEPTH
{
	CURSOR = -30,
	BELOW_CURSOR = -14,
	SMALLEST = -9,
	PLAYER = 0,
	ENEMY,
	ITEM_ON_FLOOR,
	FLOOR 
	
}



enum WEAPON_ATTRIBUTE
{
	BASIC_ATTACK_1,
	BASIC_ATTACK_2,
	BASIC_ATTACK_3,
	IMAGE_SPEED,
	BASE_DAMAGE,
	COLLISION_SPRITE,
	COLLISION_NUMBER,
	BASIC_ATTACK_COOLDOWN,
	MAX_WEAPON_DAMAGE_SCALE

}



enum MONSTER
{
	SLIME
}


enum WEAPON_TYPE
{
	SWORD = 0
}



// WEAPONS
global.weapons_grid = ds_grid_create(9,0);



//wood sword
scr_add_weapon_to_database_grid(spr_weapon_sword_basic,spr_weapon_sword_basic,spr_weapon_sword_basic,1.45,10,spr_weapon_sword_basic,4,0,1.2);




 







