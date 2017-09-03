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
    
    // target the center of the chunks grid
    scr_world_update_chunks(grid_center_x, grid_center_y);
    
    initialize_world = false;
}

else if (reinitialize_world)
{
    // reset the player's current grid position
    player_cell_x = global.PLAYER_WORLD_CELL_X;
    player_cell_y = global.PLAYER_WORLD_CELL_Y;
    
    // target where the player last was in this room
    scr_world_update_chunks(player_cell_x, player_cell_y);
    
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

