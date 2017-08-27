/// @descr scr_world_create()

// the distance (in cells) to load and unload chunks around the player
chunk_radius = 4;

// get the size of the chunks grid
//chunks_grid_width = room_width div CHUNK_WIDTH;
//chunks_grid_height = room_height div CHUNK_HEIGHT;
chunks_grid_width = 4;
chunks_grid_height = 4;

if (chunks_grid_width < (chunk_radius * 2))
{
    chunks_grid_width = (chunk_radius * 2) + 1;
}

if (chunks_grid_height < (chunk_radius * 2))
{
    chunks_grid_height = (chunk_radius * 2) + 1;
}

// the amount to extend the chunks grid
chunks_grid_add_width = floor(chunks_grid_width / 2);
chunks_grid_add_height = floor(chunks_grid_height / 2);

// the pixel size of the grid
var chunks_grid_pixel_width = chunks_grid_width * CHUNK_WIDTH;
var chunks_grid_pixel_height = chunks_grid_height * CHUNK_HEIGHT;

// position to offset the chunks relative to (0, 0) in the room
chunks_offset_x = 0;
chunks_offset_y = 0;

// start the chunks relative to the room's center
chunks_offset_x = (room_width / 2) - (chunks_grid_pixel_width / 2);
chunks_offset_y = (room_height / 2) - (chunks_grid_pixel_height / 2);

// create the grid to store each chunk's id
chunks_grid_1 = ds_grid_create(chunks_grid_width, chunks_grid_height);
ds_grid_clear(chunks_grid_1, noone);

// create the grid to store each chunk's layout index
chunks_grid_2 = ds_grid_create(chunks_grid_width, chunks_grid_height);
ds_grid_clear(chunks_grid_2, noone);

// the players position in the chunks grid
player_cell_x = 0;
player_cell_y = 0;
prev_player_cell_x = -1;
prev_player_cell_y = -1;

// the world needs setup
initialize_world = true;

// update globals
global.WORLD = id;

// update the HUD's world grid size
scr_update_hud_world_grid();
