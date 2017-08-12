/// @descr scr_update_hud_players_health()


//
// Update the Player's Health in the HUD
//
if (instance_exists(global.HUD))
{
    if (instance_exists(global.PLAYER))
    {
        // local variables
        var temp_current_health = 0;
        var temp_max_health = 0;
        
        with (global.PLAYER)
        {
            temp_current_health = current_health;
            temp_max_health = max_health;
        }
        
        with (global.HUD)
        {
            player_health = temp_current_health;
            player_max_health = temp_max_health;
            player_health_updated = true;
        }
        
    }
}
