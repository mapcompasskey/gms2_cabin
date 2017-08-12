/// @descr scr_entity_end_step()


//
// Update Position
//
    
/*
// apply movement friction
if (move_friction > 0)
{
    if (abs(velocity_x * move_friction) < move_friction_min)
    {
        velocity_x = 0;
    }
    velocity_x = (velocity_x * move_friction);
}
    
// apply jump bounce
if (jump_bounce > 0)
{
    if (last_velocity_y < jump_bounce_min)
    {
        velocity_y = 0;
    }
    velocity_y = (-last_velocity_y * jump_bounce);
}
*/
    
// apply horizontal restrictions
if (max_velocity_x != 0)
{
    velocity_x = clamp(velocity_x, -max_velocity_x, max_velocity_x);
}
    
// apply vertical restrictions
if (max_velocity_y != 0)
{
    velocity_y = clamp(velocity_y, -max_velocity_y, max_velocity_y);
}
    
// store velocities
last_velocity_x = velocity_x;
last_velocity_y = velocity_y;
    
// new x/y positions
mx = (velocity_x * global.TICK);
my = (velocity_y * global.TICK);
    
// resolve movement collision
script_execute(movement_collision_script);
    
// update position
x += mx;
y += my;

// update object depth
depth = -(floor(y));


//
// Keep Instance inside the Room
//

// *sprite_width can be negative when facing LEFT
if (bbox_right < 0)
{
    x = (room_width - abs(sprite_width));
}
else if (bbox_left > room_width)
{
    x = abs(sprite_width);
}

if (bbox_bottom < 0)
{
    y = room_height - abs(sprite_height);
}
else if (bbox_top > room_height)
{
    y = abs(sprite_height);
}

