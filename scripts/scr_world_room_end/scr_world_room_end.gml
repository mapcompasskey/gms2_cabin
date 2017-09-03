/// @descr scr_world_room_end()


// destroy the grid
global.WORLD_CHUNK_INSTANCES_GRID = noone;
ds_grid_destroy(chunk_instances_grid);

// update globals
global.WORLD = noone;
