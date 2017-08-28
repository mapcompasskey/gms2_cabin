/// @descr scr_door_step()

if (initialize_door)
{
    // set the door's properties
    switch (door_id)
    {
        // rm_world_1 - Enter Cabin Door
        case "0001":
            door_code = "01";
            exit_room_name = "rm_cabin";
            exit_door_code = "01";
            break;
            
        // rm_cabin - Exit Cabin Door
        case "0002":
            door_code = "01";
            exit_room_name = "rm_world_1";
            exit_door_code = "01";
            break;
    }
    
    // if the player doesn't exist
    if (global.PLAYER == noone || ! instance_exists(global.PLAYER))
    {
        if (global.CURRENT_ROOM_NAME == room_get_name(room))
        {
            if (global.CURRENT_DOOR_CODE == door_code)
            {
                // the door's image offset is top center
                var offset_y = sprite_height + TILE_SIZE;
                
                // if the door is upside down
                if (image_angle == 180)
                {
                    offset_y = -(offset_y);
                }
                
                // create the player at the door
                var pos_x = x;
                var pos_y = y + offset_y;
                instance_create_layer(pos_x, pos_y, ROOM_LAYER_INSTANCES, obj_player);
                
                // temporary disable the door
                //can_use_door = false;
            }
        }
    }
    
    initialize_door = false;
}
