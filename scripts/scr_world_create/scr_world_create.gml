/// @descr scr_world_create()


// the distance (in cells) to load and unload chunks around the player
chunk_radius = 4;

// set the initialize size of the chunks grid
//chunks_grid_width = room_width div CHUNK_WIDTH;
//chunks_grid_height = room_height div CHUNK_HEIGHT;
chunks_grid_width = 4;
chunks_grid_height = 4;

// increase the initialize if its less than the radius
if (chunks_grid_width < (chunk_radius * 2))
{
    chunks_grid_width = (chunk_radius * 2) + 1;
}

if (chunks_grid_height < (chunk_radius * 2))
{
    chunks_grid_height = (chunk_radius * 2) + 1;
}

// set the amount to extend the chunks grid
chunks_grid_add_width = floor(chunks_grid_width / 2);
chunks_grid_add_height = floor(chunks_grid_height / 2);

// set the offset position relative to (0, 0) in the room
chunks_offset_x = 0;
chunks_offset_y = 0;

// the players position in the chunks grid
player_cell_x = 0;
player_cell_y = 0;
prev_player_cell_x = -1;
prev_player_cell_y = -1;

// does the world needs setup
initialize_world = true;
reinitialize_world = false;

// if the chunk layouts grid already exist
if (global.WORLD_CHUNK_LAYOUTS_GRID != noone)
{
    if (ds_exists(global.WORLD_CHUNK_LAYOUTS_GRID, ds_type_grid))
    {
        // get the grid that stores each chunk's layout index
        chunk_layouts_grid = global.WORLD_CHUNK_LAYOUTS_GRID;
        
        // get the size of the chunks grid
        chunks_grid_width = ds_grid_width(chunk_layouts_grid);
        chunks_grid_height = ds_grid_height(chunk_layouts_grid);
                
        // create the grid to store each chunk's instance id
        chunk_instances_grid = ds_grid_create(chunks_grid_width, chunks_grid_height);
        ds_grid_clear(chunk_instances_grid, noone);
        
        // the pixel size of the grid
        var chunks_grid_pixel_width = chunks_grid_width * CHUNK_WIDTH;
        var chunks_grid_pixel_height = chunks_grid_height * CHUNK_HEIGHT;
        
        // if the grid width is less than the room's width
        if (chunks_grid_pixel_width < room_width)
        {
            // center the x offset
            chunks_offset_x = (room_width / 2) - (chunks_grid_pixel_width / 2);
        }
        
        // if the grid height is less than the room's height
        if (chunks_grid_pixel_height < room_height)
        {
            // center the y offset
            chunks_offset_y = (room_height / 2) - (chunks_grid_pixel_height / 2);
        }
        
        // update states
        initialize_world = false;
        reinitialize_world = true;
    }
}

// if the world needs to be setup
if (initialize_world)
{
    // the pixel size of the grid
    var chunks_grid_pixel_width = chunks_grid_width * CHUNK_WIDTH;
    var chunks_grid_pixel_height = chunks_grid_height * CHUNK_HEIGHT;
    
    // set the offset position relative to the room's center
    chunks_offset_x = (room_width / 2) - (chunks_grid_pixel_width / 2);
    chunks_offset_y = (room_height / 2) - (chunks_grid_pixel_height / 2);
    
    // create the grid to store each chunk's layout index
    chunk_layouts_grid = ds_grid_create(chunks_grid_width, chunks_grid_height);
    ds_grid_clear(chunk_layouts_grid, noone);
    
    // create the grid to store each chunk's instance id
    chunk_instances_grid = ds_grid_create(chunks_grid_width, chunks_grid_height);
    ds_grid_clear(chunk_instances_grid, noone);
}

// update globals
global.WORLD = id;
global.WORLD_CHUNK_LAYOUTS_GRID = chunk_layouts_grid;
global.WORLD_CHUNK_INSTANCES_GRID = chunk_instances_grid;
    
// update the HUD's world grid size
scr_update_hud_world_grid();
