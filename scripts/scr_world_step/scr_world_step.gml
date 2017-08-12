/// @descr scr_world_step()


// exit if there is no player
if (global.PLAYER == noone)
{
    exit;
}

// find which chunk the player is currently in
player_chunk_x = global.PLAYER.x div CHUNK_WIDTH;
player_chunk_y = global.PLAYER.y div CHUNK_HEIGHT;

// exit if the player is still in the same chunk
if (player_chunk_x == prev_player_chunk_x && player_chunk_y == prev_player_chunk_y)
{
    exit;
}

// track changes to player's position
prev_player_chunk_x = player_chunk_x;
prev_player_chunk_y = player_chunk_y;


// temporary variables that can pass into other instances
var temp_player_chunk_x = player_chunk_x;
var temp_player_chunk_y = player_chunk_y;
var temp_load_radius = load_radius;
var temp_chunks_grid = chunks_grid;
var temp_chunks_grid_2 = chunks_grid_2;


//
// Create Close Chunks
//

var i, j;

// minimum distance (in chunks) to test
var chunk_min_x = max(player_chunk_x - load_radius, 0);
var chunk_min_y = max(player_chunk_y - load_radius, 0);

// maximum distance (in chunks) to test
var chunk_max_x = min(player_chunk_x + load_radius, grid_width - 1);
var chunk_max_y = min(player_chunk_y + load_radius, grid_height - 1);

var inst_x, inst_y;
var inst;

// check if the player is close to an empty chunk
for (i = chunk_min_x; i <= chunk_max_x; i++)
{
    for (j = chunk_min_y; j <= chunk_max_y; j++)
    {
    
        // if this grid is empty
        if (ds_grid_get(chunks_grid, i, j) == noone)
        {
            // add a chunk object
            inst_x = i * CHUNK_WIDTH;
            inst_y = j * CHUNK_HEIGHT;
            inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, obj_chunk);
            
            // check if the chunk already existed
            if (ds_grid_get(chunks_grid_2, i, j) != noone)
            {
                with (inst)
                {
                    // set the specific layout list to load
                    layout_index = ds_grid_get(temp_chunks_grid_2, i, j);
                }
            }
            
            // update the grid with its instance id
            ds_grid_set(chunks_grid, i, j, inst);
        }
        
    }
}


//
// Destroy Distant Chunks
//

// iterate over every chunk object
with (obj_chunk)
{
    var chunk_x = x div CHUNK_WIDTH;
    var chunk_y = y div CHUNK_HEIGHT;
    
    // if this chunk is too far from the player
    if (abs(temp_player_chunk_x - chunk_x) > temp_load_radius || abs(temp_player_chunk_y - chunk_y) > temp_load_radius)
    {
        // clear the chunk instance from this grid position
        ds_grid_set(temp_chunks_grid, chunk_x, chunk_y, noone);
        
        // store the layout index the chunk was using
        ds_grid_set(temp_chunks_grid_2, chunk_x, chunk_y, layout_index);
        
        instance_destroy();
    }
    
}


//
// If the Player is Close to the Room's Edge
//

var room_chunk_width = room_width div CHUNK_WIDTH;
var room_chunk_height = room_height div CHUNK_HEIGHT;

scr_output(string(room_chunk_width), string(room_chunk_height));
if (player_chunk_x > (room_chunk_width - 1))
{
    scr_output("right edge");
}
else if (player_chunk_x < 1)
{
    scr_output("left edge");
}


// update the HUD's world grid size
scr_update_hud_world_grid();
