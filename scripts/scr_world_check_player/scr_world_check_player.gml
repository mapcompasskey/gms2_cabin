/// @descr scr_world_check_player()


//
// Get Player's Position
//

// exit if there is no player
if (global.PLAYER == noone)
{
    exit;
}

if ( ! instance_exists(global.PLAYER))
{
    exit;
}

// get the player's current position
var player_x = global.PLAYER.x;
var player_y = global.PLAYER.y;

// find the player's current position within the chunks grid
player_cell_x = (player_x - chunks_offset_x) div CHUNK_WIDTH;
player_cell_y = (player_y - chunks_offset_y) div CHUNK_HEIGHT;

// exit if the player is still in the same cell
if (player_cell_x == prev_player_cell_x && player_cell_y == prev_player_cell_y)
{
    exit;
}

// update changes to player's position
prev_player_cell_x = player_cell_x;
prev_player_cell_y = player_cell_y;
global.PLAYER_WORLD_CELL_X = player_cell_x;
global.PLAYER_WORLD_CELL_Y = player_cell_y;


//
// Update World Chunkd
//

scr_world_update_chunks(player_cell_x, player_cell_y);


/** /
//
// Reposition Everything
//

var reposition = false;
var reposition_offset_x = 0;
var reposition_offset_y = 0;

// if the player has reached a horizontal boundary
if (player_x >= room_width || player_x <= 0)
{
    reposition_offset_x = (room_width / 2) - player_x;
    reposition_offset_x = (reposition_offset_x div CHUNK_WIDTH) * CHUNK_WIDTH;
    reposition = true;
}

// if the player has reached a vertical boundary
if (player_y >= room_height || player_y <= 0)
{
    reposition_offset_y = (room_height / 2) - player_y;
    reposition_offset_y = (reposition_offset_y  div CHUNK_HEIGHT) * CHUNK_HEIGHT;
    reposition = true;
}

if (reposition)
{
    // reposition everything
    with (all)
    {
        //x += reposition_offset_x;
        //y += reposition_offset_y;
        
        if (object_get_name(object_index) != "obj_cross")
        {
            x += reposition_offset_x;
            y += reposition_offset_y;
        }
    }
    
    // reposition the camera
    with (global.PLAYER)
    {
        scr_camera_update(x, y, true);
    }
    
    // update the chunk's offset position
    chunks_offset_x += reposition_offset_x;
    chunks_offset_y += reposition_offset_y;
}
/**/
