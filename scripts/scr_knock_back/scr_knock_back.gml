/// @description this applies a knock back in a given direction (like when hitting an enemy)
/// @param amount this is how much in pixels we move ourselves
/// @param direction the direction in which we are moving ourselves

var knock_back_amount = argument[0];
var knock_back_direction = argument[1];

x += lengthdir_x(knock_back_amount,knock_back_direction);
y += lengthdir_y(knock_back_amount,knock_back_direction);





