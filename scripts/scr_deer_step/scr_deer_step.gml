/// @descr scr_deer_step()

event_inherited();


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
// Check if Hurting
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
// Check if Walking
//
if ( ! dying)
{
    walking = false;
    running = false;
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
        if (key_run)
        {
            running = true;
            velocity_x *= running_multiplier;
            velocity_y *= running_multiplier;
        }
        
        // reduce speed for diagonal movement
        if (velocity_x != 0 && velocity_y != 0)
        {
            velocity_x *= 0.70710678118 // sin of 45 degrees
            velocity_y *= 0.70710678118 // cos of 45 degrees
        }
        
    }
}

/*
//
// Track Proximity to Player
//

if (global.PLAYER != noone)
{
    if (instance_exists(global.PLAYER))
    {
        if (distance_to_object(global.PLAYER) > 200)
        {
            dying = true;
            instance_destroy();
        }
    }
}
*/


//
// Update Sprite
//
if (running)
{
    if (sprite_index != sprite_running)
    {
        sprite_index = sprite_running;
        image_index = 0;
        image_speed = sprite_running_speed;
    }
}
else if (walking)
{
    if (sprite_index != sprite_walking)
    {
        sprite_index = sprite_walking;
        image_index = 0;
        image_speed = sprite_walking_speed;
    }
}
else
{
    if (sprite_index != sprite_idle)
    {
        sprite_index = sprite_idle;
        image_index = 0;
        image_speed = sprite_idle_speed;
    }
}
