/// @descr scr_enemey_movement_collision()


//
// Enemy Movement Collision Tests
//

// test collisions
scr_entity_check_collision_with_tilemap();

// if the entity was moving
if (last_velocity_x != 0)
{
    // if the entity struck the tilemap or reached an edge
    if (entity_hit_tilemap_x)
    {
        // turn around
        key_left = !key_left;
        key_right = !key_right;
    }
}

// if the entity was moving
if (last_velocity_y != 0)
{    
    // if the entity struck the tilemap or reached an edge
    if (entity_hit_tilemap_y)
    {
        // turn around
        key_up = !key_up;
        key_down = !key_down;
    }
}
