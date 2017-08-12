/// @descr scr_world_create()

// the distance (in grids) to load and unload chunks around the player
load_radius = 0;

// get the size of the world grid
grid_width = room_width div CHUNK_WIDTH;
grid_height = room_height div CHUNK_HEIGHT;

// create a grid and fill it with "noone"
chunks_grid = ds_grid_create(grid_width, grid_height);
ds_grid_set_region(chunks_grid, 0, 0, grid_width, grid_height, noone);

chunks_grid_2 = ds_grid_create(grid_width, grid_height);
ds_grid_set_region(chunks_grid_2, 0, 0, grid_width, grid_height, noone);

// the players current position on the world grid
player_chunk_x = 0;
player_chunk_y = 0;
prev_player_chunk_x = -1;
prev_player_chunk_y = -1;

// update globals
global.WORLD = id;

// update the HUD's world grid size
scr_update_hud_world_grid();
