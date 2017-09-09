/// @descr scr_world_step()


//
// Setup the World
//

if (initialize_world)
{
    // If the world doesn't exist, prefill the world chunk's grid
    
    // [empty, empty, empty]
    // [empty, cabin, empty]
    // [empty, empty, empty]
    
    var grid_center_x = floor(chunks_grid_width / 2);
    var grid_center_y = floor(chunks_grid_height / 2);
    
    ds_grid_set(chunk_layouts_grid, (grid_center_x - 1), (grid_center_y - 1), "empty");
    ds_grid_set(chunk_layouts_grid, (grid_center_x - 1), grid_center_y, "empty");
    ds_grid_set(chunk_layouts_grid, (grid_center_x - 1), (grid_center_y + 1), "empty");
    
    ds_grid_set(chunk_layouts_grid, grid_center_x, (grid_center_y - 1), "empty");
    ds_grid_set(chunk_layouts_grid, grid_center_x, grid_center_y, "cabin");
    ds_grid_set(chunk_layouts_grid, grid_center_x, (grid_center_y + 1), "empty");
    
    ds_grid_set(chunk_layouts_grid, (grid_center_x + 1), (grid_center_y - 1), "empty");
    ds_grid_set(chunk_layouts_grid, (grid_center_x + 1), grid_center_y, "empty");
    ds_grid_set(chunk_layouts_grid, (grid_center_x + 1), (grid_center_y + 1), "empty");
    
    // update the offset so the cabin is centered in the room
    var chunks_grid_pixel_width = (grid_center_x * CHUNK_WIDTH);
    var chunks_grid_pixel_height = (grid_center_y * CHUNK_HEIGHT);
    chunks_offset_x = (room_width / 2) - chunks_grid_pixel_width;
    chunks_offset_y = (room_height / 2) - chunks_grid_pixel_height;
    
    // target the center of the chunks grid
    scr_world_update_chunks(grid_center_x, grid_center_y);
    
    // update state
    initialize_world = false;
    
    
    
    /**/
    // add a two chunk tall tower to the right edge of the world
    var tower_x = (chunks_grid_width - 1);
    var tower_y = floor(chunks_grid_height / 2);
    ds_grid_set(chunk_layouts_grid, tower_x, (tower_y - 2), "tower_2");
    ds_grid_set(chunk_layouts_grid, tower_x, (tower_y - 1), "tower_1");
    /**/
    
    
}

else if (reinitialize_world)
{
    // reset the player's current grid position
    player_cell_x = global.PLAYER_WORLD_CELL_X;
    player_cell_y = global.PLAYER_WORLD_CELL_Y;
    
    // update the offset so the player is centered in the room
    chunks_offset_x = (room_width / 2) - (player_cell_x * CHUNK_WIDTH);
    chunks_offset_y = (room_height / 2) - (player_cell_y * CHUNK_HEIGHT);
    
    // target where the player last was in this room
    scr_world_update_chunks(player_cell_x, player_cell_y);
    
    // update state
    reinitialize_world = false;
    
}


//
// Check the Player
//

scr_world_check_player();


//
// Check Entities
//

scr_world_check_entities();

