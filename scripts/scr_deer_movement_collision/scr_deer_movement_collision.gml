/// @descr scr_deer_movement_collision()


/** /
//
// Test Collisions
//

scr_entity_check_collision_with_solid();

// if the entity was moving
if (last_velocity_x != 0)
{
    // if the entity struck a solid object
    if (entity_hit_solid_x)
    {
        // turn around
        key_left = !key_left;
        key_right = !key_right;
    }
}

// if the entity was moving
if (last_velocity_y != 0)
{    
    // if the entity struck a solid object
    if (entity_hit_solid_x)
    {
        // turn around
        key_up = !key_up;
        key_down = !key_down;
    }
}
/**/
