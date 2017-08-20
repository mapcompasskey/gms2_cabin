/// @descr scr_world_create()

// the distance (in cells) to load and unload chunks around the player
cell_radius = 0;

// get the size of the grid
//grid_width = room_width div CHUNK_WIDTH;
//grid_height = room_height div CHUNK_HEIGHT;
grid_width = 4;
grid_height = 4;
grid_add_width = ceil(grid_width / 2);
grid_add_height = ceil(grid_height / 2);

// the pixel size of the grid
grid_pixel_width = CHUNK_WIDTH * grid_width;
grid_pixel_height = CHUNK_HEIGHT * grid_height;

// the offset of the grid inside the room (starts centered)
grid_offset_x = (room_width / 2) - (grid_pixel_width / 2);
grid_offset_y = (room_height / 2) - (grid_pixel_height / 2);

// create a grid and fill it with "noone"
chunks_grid_1 = ds_grid_create(grid_width, grid_height);
ds_grid_clear(chunks_grid_1, noone);

// create a grid and fill it with "noone"
chunks_grid_2 = ds_grid_create(grid_width, grid_height);
ds_grid_clear(chunks_grid_2, noone);

// the players position on the world grid
player_cell_x = 0;
player_cell_y = 0;
prev_player_cell_x = -1;
prev_player_cell_y = -1;

// player's boundary
player_reset_x = (room_width / 2);
player_reset_y = (room_height / 2);
player_min_x = player_reset_x - (grid_pixel_width / 2);
player_min_y = player_reset_y - (grid_pixel_height / 2);
player_max_x = player_reset_x + (grid_pixel_width / 2);
player_max_y = player_reset_y + (grid_pixel_height / 2);

// update globals
global.WORLD = id;

// update the HUD's world grid size
scr_update_hud_world_grid();
