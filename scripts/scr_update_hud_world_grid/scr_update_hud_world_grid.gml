/// @descr scr_update_hud_world_grid()


//
// Update the World Grid Size in the HUD
//
if (instance_exists(global.HUD))
{
    if (instance_exists(global.WORLD))
    {
        // local variables
        var temp_world_grid_width = 0;
        var temp_world_grid_height = 0;
        var temp_world_player_cell_x = 0;
        var temp_world_player_cell_y = 0;
        
        with (global.WORLD)
        {
            temp_world_grid_width = chunks_grid_width;
            temp_world_grid_height = chunks_grid_height;
            temp_world_player_cell_x = player_cell_x;
            temp_world_player_cell_y = player_cell_y;
        }
        
        with (global.HUD)
        {
            world_grid_width = temp_world_grid_width;
            world_grid_height = temp_world_grid_height;
            world_player_cell_x = temp_world_player_cell_x + 1;
            world_player_cell_y = temp_world_player_cell_y + 1;
            world_grid_updated = true;
        }
        
    }
}
