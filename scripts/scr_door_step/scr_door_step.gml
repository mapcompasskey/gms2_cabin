/// @descr scr_door_step()


//
// Set the Door's Properties
//

if (initialize_door)
{
    // the "door_id" is set in the obj_door's Creation Code in the Room Editor
    switch (door_id)
    {
        // rm_layout_1 - Layer_Cabin_01
        case "0001":
            door_code = "world_01";
            exit_room_name = "rm_room_1";
            exit_door_code = "rm_room_1_01";
            break;
            
        // rm_layout_1 - Layer_Cabin_02
        case "0002":
            door_code = "world_02";
            exit_room_name = "rm_room_1";
            exit_door_code = "rm_room_1_01";
            break;
            
        // rm_layout_1 - Layer_Tower_01
        case "0003":
            door_code = "world_03";
            exit_room_name = "rm_room_2";
            exit_door_code = "rm_room_2_01";
            break;
            
        // rm_room_1
        case "rm_room_1_01":
            door_code = "rm_room_1_01";
            exit_room_name = "rm_world_1";
            exit_door_code = "world_02";
            break;
            
        // rm_room_2
        case "rm_room_2_01":
            door_code = "rm_room_2_01";
            exit_room_name = "rm_world_1";
            exit_door_code = "world_03";
            break;
            
        // door_id is unknown
        default:
            exit;
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
    
    can_use_door = true;
    initialize_door = false;
}
