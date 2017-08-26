/// @descr scr_world_create()

// the distance (in cells) to load and unload chunks around the player
chunk_radius = 4;

// get the size of the chunks grid
chunks_grid_width = 4;//room_width div CHUNK_WIDTH;
chunks_grid_height = 4;//room_height div CHUNK_HEIGHT;

if (chunks_grid_width < (chunk_radius * 2))
{
    chunks_grid_width = (chunk_radius * 2);
}

if (chunks_grid_height < (chunk_radius * 2))
{
    chunks_grid_height = (chunk_radius * 2);
}

// the amount to extend the chunks grid
chunks_grid_add_width = ceil(chunks_grid_width / 2);
chunks_grid_add_height = ceil(chunks_grid_height / 2);

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

// set the starting chunks
// [empty, empty, empty]
// [empty, cabin, empty]
// [empty, empty, empty]
var grid_center_x = ceil(chunks_grid_width / 2);
var grid_center_y = ceil(chunks_grid_height / 2);

ds_grid_set(chunks_grid_2, (grid_center_x - 1), (grid_center_y - 1), "empty");
ds_grid_set(chunks_grid_2, (grid_center_x - 1), grid_center_y, "empty");
ds_grid_set(chunks_grid_2, (grid_center_x - 1), (grid_center_y + 1), "empty");

ds_grid_set(chunks_grid_2, grid_center_x, (grid_center_y - 1), "empty");
ds_grid_set(chunks_grid_2, grid_center_x, grid_center_y, "cabin");
ds_grid_set(chunks_grid_2, grid_center_x, (grid_center_y + 1), "empty");

ds_grid_set(chunks_grid_2, (grid_center_x + 1), (grid_center_y - 1), "empty");
ds_grid_set(chunks_grid_2, (grid_center_x + 1), grid_center_y, "empty");
ds_grid_set(chunks_grid_2, (grid_center_x + 1), (grid_center_y + 1), "empty");

// the players position in the chunks grid
player_cell_x = 0;
player_cell_y = 0;
prev_player_cell_x = -1;
prev_player_cell_y = -1;

// update globals
global.WORLD = id;

// update the HUD's world grid size
scr_update_hud_world_grid();
