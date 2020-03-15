
//if this IS the clouds save file...
if ds_map_find_value(async_load, "id") == cloud_check_file
{
	//and we were able to successfully check the status*
    if ds_map_find_value(async_load, "status") >= 0
    {
        // Saving a file
        var data = ds_map_find_value(async_load, "description");
        //show_message_async(data);
            
            
        //take the save file and open it so we can re-write some variables 
        var file = file_text_open_write("save_data.sav");                      
            
        //write in these variables
        file_text_write_string(file, data);
        //close it back up
        file_text_close(file);
            
        //double check for any newly added variables
        scr_initialize_dsmap();
            
        //save the new file
        ds_map_secure_save(global.save_data,"save_data.sav");
            
        //reload our save file
        global.save_data = ds_map_secure_load("save_data.sav");
            
    }
	else
	{
		show_message_async("Cloud Services not available.");
	}
      
    
}

//the above code will (if the player has logged in to their account and has access to it (cloud)) 
//then open that save, add any variables that could be missing (from if dev updates game and adds variables to save)
// lastly it saves that file to our local/offline version and re-opens the newly saved local copy to update vars


//im scared tho that what if their internet doesnt work till AFTER they have been playing and they unlock
///some achievement...but then they log in behind the scenes...and lose that progress