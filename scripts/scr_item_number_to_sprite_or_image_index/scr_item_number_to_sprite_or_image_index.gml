

/// @param item_number
/// @param sprite_or_image_index




var item_number = argument[0];
var which_index_to_return = argument[1];//sprite index = 0 & image_index = 1



if item_number < MATERIAL_LIST.LAST_IN_LIST
{
	if which_index_to_return == 0 return spr_all_materials;
	else return item_number;
}
else
if item_number < WEAPON_LIST.LAST_IN_LIST
{
	if which_index_to_return == 0 return spr_all_weapons;
	else return (item_number - WEAPON_LIST.BASIC);
}
else
if item_number < HELMETS_LIST.LAST_IN_LIST
{
	if which_index_to_return == 0 return spr_all_helmets;
	else return item_number - HELMETS_LIST.BASIC;
}
else
if item_number < TORSO_LIST.LAST_IN_LIST
{
	if which_index_to_return == 0 return spr_all_torsos;
	else return item_number - TORSO_LIST.BASIC;
}
else
if item_number < PANTS_LIST.LAST_IN_LIST
{
	if which_index_to_return == 0 return spr_all_pants;
	else return item_number - PANTS_LIST.BASIC;
}










