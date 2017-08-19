/// @descr scr_world_step()


// exit if there is no player
if (global.PLAYER == noone)
{
    exit;
}

if ( ! instance_exists(global.PLAYER))
{
    exit;
}

// find which cell the player is currently in
player_cell_x = (global.PLAYER.x - player_offset_x) div CHUNK_WIDTH;
player_cell_y = (global.PLAYER.y - player_offset_y) div CHUNK_HEIGHT;

// exit if the player is still in the same cell
if (player_cell_x == prev_player_cell_x && player_cell_y == prev_player_cell_y)
{
    exit;
}

// update changes to player's position
prev_player_cell_x = player_cell_x;
prev_player_cell_y = player_cell_y;

// temporary variables that can pass into other instances
var temp_player_cell_x = player_cell_x;
var temp_player_cell_y = player_cell_y;

var temp_player_offset_x = player_offset_x;
var temp_player_offset_y = player_offset_y;

var temp_cell_radius = cell_radius;

var temp_chunks_grid_1 = chunks_grid_1;
var temp_chunks_grid_2 = chunks_grid_2;


//
// Create Close Chunks
//

var cell_x, cell_y;

// minimum distance (in cells) to test
var cell_min_x = max(player_cell_x - cell_radius, 0);
var cell_min_y = max(player_cell_y - cell_radius, 0);

// maximum distance (in cells) to test
var cell_max_x = min(player_cell_x + cell_radius, grid_width - 1);
var cell_max_y = min(player_cell_y + cell_radius, grid_height - 1);

var inst, inst_x, inst_y;

// check if the player is close to an empty cell
for (cell_x = cell_min_x; cell_x <= cell_max_x; cell_x++)
{
    for (cell_y = cell_min_y; cell_y <= cell_max_y; cell_y++)
    {
        // if this grid is empty
        if (ds_grid_get(chunks_grid_1, cell_x, cell_y) == noone)
        {
            // add a chunk object
            inst_x = (cell_x * CHUNK_WIDTH) + player_offset_x;
            inst_y = (cell_y * CHUNK_HEIGHT) + player_offset_y;
            inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, obj_chunk);
            
            // check if the chunk already existed
            if (ds_grid_get(chunks_grid_2, cell_x, cell_y) != noone)
            {
                with (inst)
                {
                    // set the specific layout list to load
                    layout_index = ds_grid_get(temp_chunks_grid_2, cell_x, cell_y);
                }
            }
            
            // update the grid with its instance id
            ds_grid_set(chunks_grid_1, cell_x, cell_y, inst);
        }
        
    }
}


/**/
//
// Destroy Distant Chunks
//

// iterate over every chunk object
with (obj_chunk)
{
    var cell_x = (x - temp_player_offset_x) div CHUNK_WIDTH;
    var cell_y = (y - temp_player_offset_y) div CHUNK_HEIGHT;
    
    // if this chunk is too far from the player
    if (abs(temp_player_cell_x - cell_x) > temp_cell_radius || abs(temp_player_cell_y - cell_y) > temp_cell_radius)
    {
        // clear the chunk instance from this grid position
        ds_grid_set(temp_chunks_grid_1, cell_x, cell_y, noone);
        
        // store the layout index the chunk was using
        ds_grid_set(temp_chunks_grid_2, cell_x, cell_y, layout_index);
        
        instance_destroy();
    }
    
}
/**/


//
// If the Player is Close to the Grid's Edge
//

var resize_grid = false;

// get the source grid size
var source_grid_width = ds_grid_width(chunks_grid_1);
var source_grid_height = ds_grid_height(chunks_grid_1);

// set the destination grid's size
var new_grid_width = source_grid_width;
var new_grid_height = source_grid_height;

// grid region to copy and paste
var source_region_x2 = 0;
var source_region_y2 = 0;
var new_region_x = 0;
var new_region_y = 0;

// position to move everything
var temp_offset_x = 0;
var temp_offset_y = 0;
//var temp_offset_cell_x = 0;
//var temp_offset_cell_y = 0;

// if close to the grid's right edge
if ((player_cell_x + cell_radius) >= (grid_width - 1))
//if ((player_cell_x + cell_radius) >= (ds_grid_width(chunks_grid_1) - 1))
{
    // increase the width of the new grid
    new_grid_width += grid_add_width;
    
    // grid region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    
    // amount to reposition everything
    temp_offset_x = -(global.PLAYER.x - (room_width / 2));
    
    // set resize grid state
    resize_grid = true;
}


//
// If Resizing the Grid
//
if (resize_grid)
{
    // create new grid
    var new_grid_1 = ds_grid_create(new_grid_width, new_grid_height);
    ds_grid_clear(new_grid_1, noone);
    
    // create new grid
    var new_grid_2 = ds_grid_create(new_grid_width, new_grid_height);
    ds_grid_clear(new_grid_2, noone);
    
    // copy the source grid into the new grid
    ds_grid_set_grid_region(new_grid_1, chunks_grid_1, 0, 0, source_region_x2, source_region_y2, new_region_x, new_region_y);
    ds_grid_set_grid_region(new_grid_2, chunks_grid_2, 0, 0, source_region_x2, source_region_y2, new_region_x, new_region_y);
    
    // destroy the source grids
    ds_grid_destroy(chunks_grid_1);
    ds_grid_destroy(chunks_grid_2);
    
    // replace the source grids
    chunks_grid_1 = new_grid_1;
    chunks_grid_2 = new_grid_2;
    
    // reposition everything
    with (all)
    {
        //x = x + temp_offset_x;
        //y = y + temp_offset_y;
        
        if (object_get_name(object_index) != "obj_cross")
        {
            x = x + temp_offset_x;
            y = y + temp_offset_y;
        }
    }
    
    // reposition the camera
    with (global.PLAYER)
    {
        scr_camera_update(x, y, true);
    }
    
    // update the player's offset
    player_offset_x += temp_offset_x;
    player_offset_y += temp_offset_y;
    
    // update grid size
    grid_width = ds_grid_width(chunks_grid_1);
    grid_height = ds_grid_height(chunks_grid_1);
    
}


//
// Update the HUD
//
scr_update_hud_world_grid();

