//real ads                                              
//GoogleMobileAds_Init("ca-app-pub-1065246169906153/5031566493");
                                              
                                               
                                              
//test ads
//GoogleMobileAds_Init("ca-app-pub-3940256099942544/1033173712");


randomize();

//for init cloud loading
global.load = false;
has_logged_in = false;
file_name = "save_data.sav";

//turn it on before release
if(file_exists(file_name))   
{
    global.save_data = ds_map_secure_load(file_name);

    //if the save file is not a ds_map (essentially corrupt)/ create a new one
    if !ds_exists(global.save_data,ds_type_map)
    {
        global.save_data = ds_map_create();
    }

}
else
{
	global.save_data = ds_map_create();
}  



//set up the variables we want to save throughout sessions
scr_initialize_dsmap(); 




//create the ds_list of possible in app goods
//script_iap_items_list();


//to local save file in case offline
//ds_map_secure_save(global.save_data,file_name);



/// Initialise Google Play Games

// Google Play Games
//if achievement_available() then achievement_login();
//if achievement_login_status() show_message_async("Google Play Games login OK");



//init variables
save_check_file = 0;
cloud_check_file = 0;

//var to save game every second
save_tick = 0;

