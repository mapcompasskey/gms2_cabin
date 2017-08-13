/// @descr scr_world_create()

// the distance (in cells) to load and unload chunks around the player
load_radius = 0;

// the pixel size of the grid
grid_pixel_width = room_width;
grid_pixel_height = room_height;

// get the size of the grid
grid_width = grid_pixel_width div CHUNK_WIDTH;
grid_height = grid_pixel_height div CHUNK_WIDTH;

// create a grid and fill it with "noone"
chunks_grid = ds_grid_create(grid_width, grid_height);
ds_grid_clear(chunks_grid, noone);

chunks_grid_2 = ds_grid_create(grid_width, grid_height);
ds_grid_clear(chunks_grid_2, noone);

// the players current position on the world grid
player_cell_x = 0;
player_cell_y = 0;
prev_player_cell_x = -1;
prev_player_cell_y = -1;

// update globals
global.WORLD = id;

// update the HUD's world grid size
scr_update_hud_world_grid();
