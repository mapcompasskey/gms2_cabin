/// @descr scr_hud_step()


//
// Update Scale Factor
//
// The obj_game tracks if the game's aspect ratio changes and updates the obj_hud's scale_factor.
//
if (scale_factor_updated)
{
    // update text and image scaling
    scale_text = max(1, floor(scale_factor * 0.4));
    scale_sprites = max(1, floor(scale_factor * 0.75));
    
    // update health marker draw settings
    // array(padding, width, height)
    health_marker_draw[0] = (health_marker_data[0] * scale_sprites);
    health_marker_draw[1] = (health_marker_data[1] * scale_sprites);
    health_marker_draw[2] = (health_marker_data[2] * scale_sprites);
    
    scale_factor_updated = false;
}


//
// If the Player's Health has Changed
//
if (player_health_updated)
{
    // update the player's health text
    var perc = round(player_health / player_max_health * 100);
    player_health_text = string(perc) + "%, " + string(player_health) + " / " + string(player_max_health);
    
    // update the marker subimages list
    health_marker_subimages = ds_list_create();
    
    var subimage = 0;
    var lgnth = ceil(player_max_health / 2);
    for (var i = 1; i <= lgnth; i++)
    {
        subimage = 0;
        if (player_health >= (i * 2))
        {
            subimage = 2;
        }
        else if (player_health >= (i * 2 - 1))
        {
            subimage = 1;
        }
        
        ds_list_add(health_marker_subimages, subimage);
    }
    
    player_health_updated = false;
}


//
// If the World Grid Size has Changed
//
if (world_grid_updated)
{
    // update the world grid text
    world_grid_text = string(world_grid_width) + " x " + string(world_grid_height);
    world_grid_text += string("\n" + string(world_player_cell_x) + " x " + string(world_player_cell_y));
    
    world_grid_updated = false;
}

