/// @description Insert description here
// You can write your code in this editor
//draw_set_font(font_damage_numbers);

draw_text_color(x,y,string(display_amount),my_color,my_color,my_color,my_color,my_alpha);

my_alpha -= 1/(room_speed * 2);

if my_alpha <= 0
{
	instance_destroy();
}

