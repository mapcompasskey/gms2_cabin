/// @descr scr_door_step()

if (initialize_door)
{
    // set the door's properties
    switch (door_id)
    {
        // rm_world_1 - Cabin Door
        case "0001":
            door_code = "01";
            exit_room_name = "rm_cabin";
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
                // create the player at the door
                var pos_x = x;
                var pos_y = y + sprite_height + TILE_SIZE;
                instance_create_layer(pos_x, pos_y, ROOM_LAYER_INSTANCES, obj_player);
                
                // temporary disable the door
                can_use_door = false;
            }
        }
    }
    
    initialize_door = false;
}
