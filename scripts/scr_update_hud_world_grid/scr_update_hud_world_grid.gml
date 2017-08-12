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
        var temp_world_grid_player_x = 0;
        var temp_world_grid_player_y = 0;
        
        with (global.WORLD)
        {
            temp_world_grid_width = grid_width;
            temp_world_grid_height = grid_height;
            temp_world_grid_player_x = player_chunk_x;
            temp_world_grid_player_y = player_chunk_y;
        }
        
        with (global.HUD)
        {
            world_grid_width = temp_world_grid_width;
            world_grid_height = temp_world_grid_height;
            world_grid_player_x = temp_world_grid_player_x + 1;
            world_grid_player_y = temp_world_grid_player_y + 1;
            world_grid_updated = true;
        }
        
    }
}
