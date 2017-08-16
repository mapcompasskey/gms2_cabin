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
player_cell_x = (global.PLAYER.x - grid_offset_x) div CHUNK_WIDTH;
player_cell_y = (global.PLAYER.y - grid_offset_y) div CHUNK_HEIGHT;

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
var temp_grid_offset_x = grid_offset_x;
var temp_grid_offset_y = grid_offset_y;
var temp_load_radius = load_radius;
var temp_chunks_grid = chunks_grid;
var temp_chunks_grid_2 = chunks_grid_2;


//
// Create Close Chunks
//

var i, j;

// minimum distance (in chunks) to test
var chunk_min_x = max(player_cell_x - load_radius, 0);
var chunk_min_y = max(player_cell_y - load_radius, 0);

// maximum distance (in chunks) to test
var chunk_max_x = min(player_cell_x + load_radius, grid_width - 1);
var chunk_max_y = min(player_cell_y + load_radius, grid_height - 1);

var inst_x, inst_y;
var inst;

// check if the player is close to an empty chunk
for (i = chunk_min_x; i <= chunk_max_x; i++)
{
    for (j = chunk_min_y; j <= chunk_max_y; j++)
    {
        var cell_i = (i + player_cell_offset_x);
        var cell_j = (j + player_cell_offset_y);
        
        // if this grid is empty
        //if (ds_grid_get(chunks_grid, i, j) == noone)u
        if (ds_grid_get(chunks_grid, cell_i, cell_j) == noone)
        {
            // add a chunk object
            inst_x = (i * CHUNK_WIDTH) + grid_offset_x;
            inst_y = (j * CHUNK_HEIGHT) + grid_offset_y;
            inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, obj_chunk);
            
            /*
            // check if the chunk already existed
            if (ds_grid_get(chunks_grid_2, i, j) != noone)
            {
                with (inst)
                {
                    // set the specific layout list to load
                    layout_index = ds_grid_get(temp_chunks_grid_2, i, j);
                }
            }
            */
            
            // update the grid with its instance id
            //ds_grid_set(chunks_grid, i, j, inst);
            ds_grid_set(chunks_grid, cell_i, cell_j, inst);
        }
        
    }
}


//
// Destroy Distant Chunks
//
/** /
// iterate over every chunk object
with (obj_chunk)
{
    var chunk_x = (x - temp_grid_offset_x) div CHUNK_WIDTH;
    var chunk_y = (y - temp_grid_offset_y) div CHUNK_HEIGHT;
    
    // if this chunk is too far from the player
    if (abs(temp_player_cell_x - chunk_x) > temp_load_radius || abs(temp_player_cell_y - chunk_y) > temp_load_radius)
    {
        // clear the chunk instance from this grid position
        ds_grid_set(temp_chunks_grid, chunk_x, chunk_y, noone);
        
        // store the layout index the chunk was using
        ds_grid_set(temp_chunks_grid_2, chunk_x, chunk_y, layout_index);
        
        instance_destroy();
    }
    
}
/**/


//
// If the Player is Close to the Room's Edge
//

//var room_chunk_width = room_width div CHUNK_WIDTH;
//var room_chunk_height = room_height div CHUNK_HEIGHT;
/*
if (player_cell_x >= (room_chunk_width - 1))
{
    scr_output("right edge");
    
    // move the player back to the center x position
    // increase the grids by adding half the room size onto the right side
    // track the offset x position to add onto the player's x position when determining the x chunk
    
    // get the source grid size
    var source_grid_width = ds_grid_width(chunks_grid);
    var source_grid_height = ds_grid_width(chunks_grid);
    
    // set the destination grid's size
    var destination_grid_width = source_grid_width;
    var destination_grid_height = source_grid_height;
    
    // increase the width of the new grid
    destination_grid_width += ceil(room_chunk_width / 2);
    
    // create the new grids
    var destination_grid = ds_grid_create(destination_grid_width, destination_grid_height);
    ds_grid_clear(destination_grid, noone);
    
    var destination_grid_2 = ds_grid_create(destination_grid_width, destination_grid_height);
    ds_grid_clear(destination_grid_2, noone);
    
    // copy the source grid into the new grid
    var x1 = 0;
    var y1 = 0;
    var x2 = source_grid_width;
    var y2 = source_grid_height;
    var pos_x = 0;
    var pos_y = 0;
    
    ds_grid_set_grid_region(destination_grid, chunks_grid, x1, y1, x2 ,y2, pos_x, pos_y);
    ds_grid_set_grid_region(destination_grid_2, chunks_grid_2, x1, y1, x2 ,y2, pos_x, pos_y);
    
    scr_output("source", chunks_grid, chunks_grid_2);
    scr_output("destination", destination_grid, destination_grid_2);
    
    // destroy the source grids
    ds_grid_destroy(chunks_grid);
    ds_grid_destroy(chunks_grid_2);
    
    // replace the source grids
    chunks_grid = destination_grid;
    chunks_grid_2 = destination_grid_2;
    
    scr_output("new source", chunks_grid, chunks_grid_2);
    scr_output("widths", source_grid_width, destination_grid_width);
}
else if (player_cell_x <= 0)
{
    scr_output("left edge");
}
*/


//
// If the Player is Close to the Grid's Edge
//

var resize_grid = false;

// get the source grid size
var source_grid_width = ds_grid_width(chunks_grid);
var source_grid_height = ds_grid_height(chunks_grid);

// set the destination grid's size
var new_grid_width = source_grid_width;
var new_grid_height = source_grid_height;

// grid region to copy and paste
var source_region_x1 = 0;
var source_region_y1 = 0;
var source_region_x2 = 0;
var source_region_y2 = 0;
var new_region_x = 0;
var new_region_y = 0;

// position to move everything
var temp_offset_x = 0;
var temp_offset_y = 0;
var temp_offset_cell_x = 0;
var temp_offset_cell_y = 0;

// if close to the grid's right edge
if ((player_cell_x + load_radius) >= (grid_width - 1))
{
    // increase the width of the new grid
    new_grid_width += ceil(grid_width / 2);
    
    // grid region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    
    // amount to reposition everything
    temp_offset_x = -(grid_pixel_width / 2);
    temp_offset_cell_x = new_grid_width - source_grid_width;
    
    // set resize grid state
    resize_grid = true;
}
// else, if close to the grid's left edge
else if (player_cell_x <= load_radius)
{
    // increase the width of the new grid
    new_grid_width += ceil(grid_width / 2);
    
    // grid region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    new_region_x = new_grid_width - source_grid_width;
    
    // amount to reposition everything
    temp_offset_x = (grid_pixel_width / 2);
    
    // set resize grid state
    resize_grid = true;
}

// if close to the grid's bottom edge
if ((player_cell_y + load_radius) >= (grid_height - 1))
{
    // increase the height of the new grid
    new_grid_height += ceil(grid_height / 2);
    
    // grid region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    
    // amount to reposition everything
    temp_offset_y = -(grid_pixel_height / 2);
    temp_offset_cell_y = new_grid_height - source_grid_height;
    
    // set resize grid state
    resize_grid = true;
}
// else, if close to the grid's top edge
else if (player_cell_y <= load_radius)
{
    // increase the height of the new grid
    new_grid_height += ceil(grid_height / 2);
    
    // grid region to copy and paste
    source_region_x2 = source_grid_width;
    source_region_y2 = source_grid_height;
    new_region_y = new_grid_height - source_grid_height;
    
    // amount to reposition everything
    temp_offset_y = (grid_pixel_height / 2);
    
    // set resize grid state
    resize_grid = true;
}


//
// If Resizing the Grid
//
if (resize_grid)
{
    // create the new grids
    var new_grid = ds_grid_create(new_grid_width, new_grid_height);
    ds_grid_clear(new_grid, noone);
    
    var new_grid_2 = ds_grid_create(new_grid_width, new_grid_height);
    ds_grid_clear(new_grid_2, noone);
    
    // copy the source grid into the new grid
    ds_grid_set_grid_region(new_grid, chunks_grid, source_region_x1, source_region_y1, source_region_x2 ,source_region_y2, new_region_x, new_region_y);
    ds_grid_set_grid_region(new_grid_2, chunks_grid_2, source_region_x1, source_region_y1, source_region_x2 , source_region_y2, new_region_x, new_region_y);
    
    scr_output("source", chunks_grid, chunks_grid_2);
    scr_output("new", new_grid, new_grid_2);
    
    // destroy the source grids
    ds_grid_destroy(chunks_grid);
    ds_grid_destroy(chunks_grid_2);
    
    // replace the source grids
    chunks_grid = new_grid;
    chunks_grid_2 = new_grid_2;
    
    // reposition everything
    with (all)
    {
        x = x + temp_offset_x;
        y = y + temp_offset_y;
    }
    
    // reposition the camera
    with (global.PLAYER)
    {
        scr_camera_update(x, y, true);
    }
    
    /*
    // update the player's x cell offset
    if (temp_offset_x < 0)
    {
        player_cell_offset_x += abs(ceil(temp_offset_x / CHUNK_WIDTH));
    }
    
    // update the player's y cell offset
    if (temp_offset_y < 0)
    {
        player_cell_offset_y += abs(ceil(temp_offset_y / CHUNK_HEIGHT));
    }
    */
    
    player_cell_offset_x += temp_offset_cell_x;
    player_cell_offset_y += temp_offset_cell_y;
    
}


//
// Update the HUD
//
scr_update_hud_world_grid();

