/// @descr scr_player_step()

event_inherited();


//
// Update Inputs
//
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_up = keyboard_check(vk_up);
key_down = keyboard_check(vk_down);
key_attack_pressed = keyboard_check(ord("Z"));
key_attack_released = keyboard_check_released(ord("Z"));


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
// Check if Attacking
//
if ( ! dying)
{
    if (attacking)
    {
        attack_cooldown_timer += global.TICK;
        if (attack_cooldown_timer >= attack_cooldown_time)
        {
            attacking = false;
        }
    }
    else
    {
        if (key_attack_pressed)
        {
            attacking = true;
            attack_cooldown_timer = 0;
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
        //if (keyboard_check(vk_shift))
        //{
            running = true;
            velocity_x *= running_multiplier;
            velocity_y *= running_multiplier;
        //}
        
        // reduce speed for diagonal movement
        if (velocity_x != 0 && velocity_y != 0)
        {
            velocity_x *= 0.70710678118 // sin of 45 degrees
            velocity_y *= 0.70710678118 // cos of 45 degrees
        }
    
        // reduce movement speed if attacking
        if (attacking)
        {
            velocity_x *= attack_multiplier;
            velocity_y *= attack_multiplier;
        }
    }
}


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
