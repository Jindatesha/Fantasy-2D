



if !achievement_login_status()
{
	//achievement_login();
	
	//now set our cloud saved file 
	cloud_check_file = cloud_synchronise();
		
		//show_message_async("cloud_check_file = "+string(cloud_check_file));  
}

