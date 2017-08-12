/// @descr scr_enemy_step()

event_inherited();


//
// Check if Dead
//
if (dying)
{
    image_alpha = 0.2;
    
    dead_timer += global.TICK;
    if (dead_timer > dead_time)
    {
        dead_timer = 0;    
        dying = false;
        
        // repostion to starting point
        x = starting_x;
        y = starting_y;
    }
}


//
// Update Action
//
if ( ! dying && ! hurting)
{
    action_timer += global.TICK;
    if (action_timer > action_time)
    {
        action_timer = 0;
        action_time = random_range(2, 4);
        
        key_left = false;
        key_right = false;
        key_up = false;
        key_down = false;
        
        var rand = irandom(4);
        switch (rand)
        {
            case 0:
                key_left = true;
                break;
                
            case 1:
                key_right = true;
                break;
                
            case 2:
                key_up = true;
                break;
                
            case 3:
                key_down = true;
                break;
        }
        
    }
}


//
// Check if Hurting or Recovering
//
if ( ! dying)
{
    // if recovering
    if (recovering)
    {
        image_alpha = 0.5;
        
        recover_timer += global.TICK;
        if (recover_timer >= recover_time)
        {
            image_alpha = 1;
            
            // update states
            hurting = false;
            recovering = false;
            recover_timer = 0;
            can_be_damaged = true;
        }
    }
    
}


//
// Check if Attacking
//
if ( ! dying)
{
    // check if colliding with player objects
    if (place_meeting(x, y, obj_player))
    {
        with (obj_player)
        {
            if (place_meeting(x, y, other))
            {
                // if the player can be damaged
                if (can_be_damaged && damage_from == noone)
                {
                    // update player
                    damage_from = other;
                    
                    break;
                }
            }
        }
    }
}


//
// Check if Walking
//
if ( ! dying && ! hurting)
{
    walking = false;
    velocity_x = 0;
    velocity_y = 0;
    
    // if moving horizontally
    if (key_left)
    {
        walking = true;
        facing_x = LEFT;
        velocity_x = (speed_x * facing_x);
    }
    else if (key_right)
    {
        walking = true;
        facing_x = RIGHT;
        velocity_x = (speed_x * facing_x);
    }
    
    // if moving vertically
    if (key_up)
    {
        walking = true;
        facing_y = UP;
        velocity_y = (speed_y * facing_y);
    }
    else if (key_down)
    {
        walking = true;
        facing_y = DOWN;
        velocity_y = (speed_y * facing_y);
    }
    
    if (walking)
    {
        // update sprite
        if (velocity_x != 0)
        {
            if (idle_sprite != idle_sprite_x)
            {
                idle_sprite = idle_sprite_x;
            }
        }
        else if (velocity_y != 0)
        {
            if (sign(velocity_y) == UP && idle_sprite != idle_sprite_y_up)
            {
                idle_sprite = idle_sprite_y_up;
            }
            else if (sign(velocity_y) == DOWN && idle_sprite != idle_sprite_y_down)
            {
                idle_sprite = idle_sprite_y_down;
            }
        }
    
        // reduce speed for diagonal movement
        if (velocity_x != 0 && velocity_y != 0)
        {
            velocity_x *= 0.70710678118 // sin of 45 degrees
            velocity_y *= 0.70710678118 // cos of 45 degrees
        }
    }
}


//
// Update Sprite
//
if (sprite_index != idle_sprite)
{
    sprite_index = idle_sprite;
    image_index = 0;
    //image_speed = idle_speed;
}
