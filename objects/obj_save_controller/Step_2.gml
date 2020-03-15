/// @description Insert description here
// You can write your code in this editor

//save once a second...
save_tick += 1;
if save_tick >= room_speed
{
	save_tick = 0;
	scr_save_game();
}










