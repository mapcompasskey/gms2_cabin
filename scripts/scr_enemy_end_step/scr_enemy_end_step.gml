/// @descr scr_enemy_end_step()


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
                with (damage_from)
                {
                    var other_damage = damage;
                    var other_x = x;
                }
                
                // update states
                hurting = true;
                recovering = true;
                recover_timer = 0;
                can_be_damaged = false;
                
                /*
                // apply vertical knockback
                velocity_x = knockback_x;
                if (x < other_x)
                {
                    velocity_x = -knockback_x;
                }
                
                // apply vertical knockback
                velocity_y = -knockback_y;
                */
                
                // reduce health
                current_health = (current_health - other_damage);
                if (current_health <= 0)
                {
                    dying = true;
                    
                    // reset variables
                    velocity_x = 0;
                    velocity_y = 0;
                    current_health = max_health;
                }
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

