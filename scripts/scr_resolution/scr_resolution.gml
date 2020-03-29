
//get the phones dimensions
this_screens_width = display_get_width();
this_screens_height = display_get_height();

//if we are testing on computer set the dimensions manually

if os_type == os_windows
{
	this_screens_width = 1280;
	this_screens_height = 720;
}



//set the size of the game window
window_set_size( this_screens_width, this_screens_height);



//these are our target device dimensions

ideal_screen_width = 1920;
ideal_screen_height = 1080;



//determine the preferred aspect ratio so we can keep it
aspect_ratio = ideal_screen_width/ideal_screen_height;



//work out the adjusted height and width for our device
if(this_screens_width >= this_screens_height)
{
	final_display_height = round(min(ideal_screen_height,this_screens_height));
	final_display_width = round(final_display_height * aspect_ratio);
}
else
{
	final_display_width = round(min(ideal_screen_width,this_screens_width));
	final_display_height = round(final_display_width / aspect_ratio);
}


//resize the application surface to our adjusted values
surface_resize(application_surface,final_display_width,final_display_height);

//set the size of our GUI (in case we have any it will scale correctly)
display_set_gui_size(ideal_screen_width,ideal_screen_height);



//how much the camera sees
camera_set_view_size(view,ideal_screen_width,ideal_screen_height);

var locked_x = round(x - (view_w/2));
var locked_y = round(y - (view_h/2));



camera_set_view_pos(view,locked_x,locked_y);


alarm[0] = 1;
