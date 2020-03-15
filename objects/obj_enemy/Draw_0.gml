/// @description Insert description here
// You can write your code in this editor
draw_self();


#region draw health

if show_health_timer > 0
{
	show_health_timer -= 1;
	
	//draw health backing
	draw_sprite(spr_enemy_health_backing,0,x - (sprite_get_width(spr_enemy_health_backing)/2),y + (sprite_get_height(sprite_index)/2) + 8);



	//draw health lossed amount
	draw_sprite_part(spr_enemy_lossed_health_bar,0,0,0,(sprite_get_width(spr_enemy_lossed_health_bar) * (hp_lossed/my_max_hp)) * (show_health_timer/show_health_max_time),sprite_get_height(spr_enemy_health_bar),x - (sprite_get_width(spr_enemy_health_backing)/2) + sprite_get_width(spr_enemy_health_bar) * (my_hp/my_max_hp),y + (sprite_get_height(sprite_index)/2) + 8);




	//draw health bar
	draw_sprite_part(spr_enemy_health_bar,0,0,0,sprite_get_width(spr_enemy_health_bar) * (my_hp/my_max_hp),sprite_get_height(spr_enemy_health_bar),x - (sprite_get_width(spr_enemy_health_backing)/2),y + (sprite_get_height(sprite_index)/2) + 8);


}

#endregion


