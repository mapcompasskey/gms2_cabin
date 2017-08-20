/// @descr scr_world_step()


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

// find the player's current position within the chunks grid
player_cell_x = (global.PLAYER.x - chunks_offset_x) div CHUNK_WIDTH;
player_cell_y = (global.PLAYER.y - chunks_offset_y) div CHUNK_HEIGHT;

// exit if the player is still in the same cell
if (player_cell_x == prev_player_cell_x && player_cell_y == prev_player_cell_y)
{
    exit;
}

// update changes to player's position
prev_player_cell_x = player_cell_x;
prev_player_cell_y = player_cell_y;


//
// Set Temporary Variables
//

// *local variables can pass between instances
var temp_player_cell_x = player_cell_x;
var temp_player_cell_y = player_cell_y;
var temp_chunk_radius = chunk_radius;
var temp_chunks_grid_1 = chunks_grid_1;
var temp_chunks_grid_2 = chunks_grid_2;


//
// Create Chunks
//

var cell_x, cell_y;

// minimum distance (in cells) to test
var cell_min_x = max(player_cell_x - chunk_radius, 0);
var cell_min_y = max(player_cell_y - chunk_radius, 0);

// maximum distance (in cells) to test
var cell_max_x = min(player_cell_x + chunk_radius, chunks_grid_width - 1);
var cell_max_y = min(player_cell_y + chunk_radius, chunks_grid_height - 1);

var inst, inst_x, inst_y;

// check if the player is close to an empty cell
for (cell_x = cell_min_x; cell_x <= cell_max_x; cell_x++)
{
    for (cell_y = cell_min_y; cell_y <= cell_max_y; cell_y++)
    {
        // if this cell is empty
        if (ds_grid_get(chunks_grid_1, cell_x, cell_y) == noone)
        {
            // add a new chunk object
            inst_x = (cell_x * CHUNK_WIDTH) + chunks_offset_x;
            inst_y = (cell_y * CHUNK_HEIGHT) + chunks_offset_y;
            inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, obj_chunk);
            
            with (inst)
            {
                // set its position within the chunks grid
                chunks_grid_x = cell_x;
                chunks_grid_y = cell_y;
                
                // check if the chunk already existed
                if (ds_grid_get(temp_chunks_grid_2, cell_x, cell_y) != noone)
                {
                    // update the layout list to load
                    layout_index = ds_grid_get(temp_chunks_grid_2, cell_x, cell_y);
                }
            }
            
            // update the chunks grid with the new instance's id
            ds_grid_set(chunks_grid_1, cell_x, cell_y, inst);
        }
        
    }
}


//
// Destroy Chunks
//

// iterate over every chunk object
with (obj_chunk)
{
    // if this chunk is too far from the player
    if (abs(temp_player_cell_x - chunks_grid_x) > temp_chunk_radius || abs(temp_player_cell_y - chunks_grid_y) > temp_chunk_radius)
    {
        // clear the chunk instance from this grid position
        ds_grid_set(temp_chunks_grid_1, chunks_grid_x, chunks_grid_y, noone);
        
        // store the layout index the chunk was using
        ds_grid_set(temp_chunks_grid_2, chunks_grid_x, chunks_grid_y, layout_index);
        
        // remove the chunk (it will remove all the objects it created)
        instance_destroy();
    }
}


//
// Resize the Grid
//

var resize_grid = false;

// get the source grid's size
var source_grid_width = ds_grid_width(chunks_grid_1);
var source_grid_height = ds_grid_height(chunks_grid_1);

// set the destination grid's size
var new_grid_width = source_grid_width;
var new_grid_height = source_grid_height;

// the grid region to copy and paste
var source_region_x2 = 0;
var source_region_y2 = 0;
var new_region_x = 0;
var new_region_y = 0;

// the amount to offset each chunk's cell position in the grid
var temp_chunks_grid_x = 0;
var temp_chunks_grid_y = 0;

// if close to the grid's right edge
if ((player_cell_x + chunk_radius) >= (chunks_grid_width - 1))
{
    // increase the width of the new grid
    new_grid_width += chunks_grid_add_width;
    
    // set the region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    
    // upddate resize state
    resize_grid = true;
}

// else, if close to the grid's left edge
else if ((player_cell_x - chunk_radius) <= 0)
{
    // increase the width of the new grid
    new_grid_width += chunks_grid_add_width;
    
    // set the region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    new_region_x = chunks_grid_add_width;
    
    // update the chunk's offset position
    chunks_offset_x -= (chunks_grid_add_width * CHUNK_WIDTH);
    
    // offset each chunk's position in the chunk grid
    temp_chunks_grid_x = chunks_grid_add_width;
    
    // upddate resize state
    resize_grid = true;
}

// if close to the grid's bottom edge
if ((player_cell_y + chunk_radius) >= (chunks_grid_height - 1))
{
    // increase the height of the new grid
    new_grid_height += chunks_grid_add_height;
    
    // set the region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    
    // upddate resize state
    resize_grid = true;
}

// else, if close to the grid's top edge
else if ((player_cell_y - chunk_radius) <= 0)
{
    // increase the height of the new grid
    new_grid_height += chunks_grid_add_height;
    
    // set the region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    new_region_y = chunks_grid_add_height;
    
    // update the chunk's offset position
    chunks_offset_y -= (chunks_grid_add_height * CHUNK_HEIGHT);
    
    // offset each chunk's position in the chunk grid
    temp_chunks_grid_y = chunks_grid_add_height;
    
    // upddate resize state
    resize_grid = true;
}

// if the chunks grid needs resized
if (resize_grid)
{
    // create a new grid
    var new_grid_1 = ds_grid_create(new_grid_width, new_grid_height);
    ds_grid_clear(new_grid_1, noone);
    
    // create a new grid
    var new_grid_2 = ds_grid_create(new_grid_width, new_grid_height);
    ds_grid_clear(new_grid_2, noone);
    
    // copy the source grids into the new grids
    ds_grid_set_grid_region(new_grid_1, chunks_grid_1, 0, 0, source_region_x2, source_region_y2, new_region_x, new_region_y);
    ds_grid_set_grid_region(new_grid_2, chunks_grid_2, 0, 0, source_region_x2, source_region_y2, new_region_x, new_region_y);
    
    // destroy the source grids
    ds_grid_destroy(chunks_grid_1);
    ds_grid_destroy(chunks_grid_2);
    
    // replace the source grids
    chunks_grid_1 = new_grid_1;
    chunks_grid_2 = new_grid_2;
    
    // update the grid's size values
    chunks_grid_width = ds_grid_width(chunks_grid_1);
    chunks_grid_height = ds_grid_height(chunks_grid_1);
    
    // if the chunk's cell positions need updated
    if (temp_chunks_grid_x || temp_chunks_grid_y)
    {
        with (obj_chunk)
        {
            chunks_grid_x += temp_chunks_grid_x;
            chunks_grid_y += temp_chunks_grid_y;
        }
    }
    
}


//
// Reposition Everything
//

var reposition = false;
var reposition_offset_x = 0;
var reposition_offset_y = 0;

// if the player has reached a horizontal boundary
if (global.PLAYER.x >= room_width || global.PLAYER.x <= 0)
{
    reposition_offset_x = (room_width / 2) - global.PLAYER.x;
    reposition_offset_x = (reposition_offset_x div CHUNK_WIDTH) * CHUNK_WIDTH;
    reposition = true;
}

// if the player has reached a vertical boundary
if (global.PLAYER.y >= room_height || global.PLAYER.y <= 0)
{
    reposition_offset_y = (room_height / 2) - global.PLAYER.y;
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


//
// Update the HUD
//

scr_update_hud_world_grid();

