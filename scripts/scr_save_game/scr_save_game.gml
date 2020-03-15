//save game
with (obj_save_controller)
{
	//to local save file in case offline
	ds_map_secure_save(global.save_data,file_name);

	//to the cloud for online storage
	//save_check_file = cloud_file_save("save_data.sav", "Just for testing");
    
	//show_message_async("save_check = "+string(save_check_file));

}
