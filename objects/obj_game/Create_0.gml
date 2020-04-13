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


global.game_speed = 1;

global.world_time = 0;//0 -> 1  ( 1=100% of day)


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
	RUN,
	BACK_PEDDLE,
	DODGE_ROLL,
	ATTACK,
	CROUCH,
	LEDGE_INITIAL,
	LEDGE_IDLE,
	LEDGE_TO_KNEE,
	KNEE_TO_STAND,
	IN_AIR_UP,
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
	PLAYER = -8,
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

//what room are we in?
enum ROOM_NUMBER
{
	NO_ENEMY_ZONE = -1,
	SLIME_ZONE = 0
}

enum MONSTER
{
	SLIME
}


enum ITEM_CLASS
{
	ANYTHING,
	MATERIAL,
	WEAPON,
	PANTS,
	TORSO,
	HELMET
	
	
}

enum WEAPON_TYPE
{
	SWORD = 0
}

enum WEAPON_LIST
{
	//first one is fists
	BASIC = MATERIAL_LIST.LAST_IN_LIST,
	IRON_SWORD,
	LAST_IN_LIST
}


// WEAPONS
global.weapons_grid = ds_grid_create(9,0);



//wood sword
scr_add_weapon_to_database_grid(spr_weapon_sword_basic_1,spr_weapon_sword_basic_2,spr_weapon_sword_basic_3,1.45,10,spr_weapon_sword_basic_1,4,0.3,1.2);




 



#region MONSTER-ITEM DROP TABLE 

//material list
enum MATERIAL_LIST
{
	//NOTHING = -1, (in a sprite, these are sub images)
	BASIC = 0,//slime
	ICE_BLOCK,
	GOLD_GEM,
	PURPLE_GEM,
	LAST_IN_LIST
	
}


#region potential drops for slime
	slime_list_1 = ds_list_create();
	ds_list_add(slime_list_1,-1);

	slime_list_2 = ds_list_create();
	ds_list_add(slime_list_2,MATERIAL_LIST.BASIC);

	slime_list_3 = ds_list_create();
	ds_list_add(slime_list_3,MATERIAL_LIST.ICE_BLOCK);
	
	//% and a list of what that drop entails 
	slime_drop_list = ds_list_create();
	ds_list_add(slime_drop_list,30,slime_list_1,45,slime_list_2,25,slime_list_3);
#endregion






global.monster_drop_list = ds_list_create(); 
ds_list_add(global.monster_drop_list,slime_drop_list);

#endregion


#region ALL items data-base...what item number

enum THIS_ITEMS
{
	SPRITE_INDEX,
	IMAGE_INDEX,
	ITEM_CLASS,
	SLOT_WIDTH,
	SLOT_HEIGHT
	
	
}



global.item_database_grid = ds_grid_create(5,0);

//materials
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.BASIC,ITEM_CLASS.MATERIAL);//item # 0 = slime
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.ICE_BLOCK,ITEM_CLASS.MATERIAL);
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.GOLD_GEM,ITEM_CLASS.MATERIAL);
scr_add_item_to_database_grid(spr_all_materials,MATERIAL_LIST.PURPLE_GEM,ITEM_CLASS.MATERIAL);
#endregion






#region craftable items recipe info
	global.item_forge_grid = ds_grid_create(13,0);
	
	//fill grid info

	//weapons
	scr_add_item_to_forge_grid(WEAPON_LIST.BASIC,"Wood Sword",MATERIAL_LIST.BASIC,2,MATERIAL_LIST.ICE_BLOCK,1);
#endregion





//what item are we dragging for our inventory stuff
global.item_in_hand = -1;
