/// @descr scr_player_end_step()


//
// Check if Being Attacked
//
if ( ! dying && ! hurting && ! recovering)
{
    if (can_be_damaged)
    {
        // if being damaged
        if (damage_from != noone)
        {
            if (instance_exists(damage_from))
            {
                // get values from attacker
                with (damage_from)
                {
                    var attacker_damage = damage;
                    var attacker_x = x;
                }
                
                // update states
                hurting = true;
                recovering = true;
                recover_timer = 0;
                can_be_damaged = false;
                
                /*
                // apply vertical knockback
                velocity_x = knockback_x;
                if (x < attacker_x)
                {
                    velocity_x = -knockback_x;
                }
                
                // apply vertical knockback
                velocity_y = -knockback_y;
                */
                
                // reduce health
                current_health = (current_health - attacker_damage);
                if (current_health < 0)
                {
                    //dying = true;
                    current_health = max_health;
                }
                
                // update the HUD
                scr_update_hud_players_health();
            }
        }
        
    }
}
    
// reset collision referrence
damage_from = noone;


//
// Update Position
//
if ( ! dying)
{
    event_inherited();
}


//
// Update Camera
//

// move towards the player
scr_camera_update(x, y, false);
//scr_camera_update(x, (y + sprite_bbox_top), false);
