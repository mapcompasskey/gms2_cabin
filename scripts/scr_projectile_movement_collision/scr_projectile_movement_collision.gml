/// @descr scr_projectile_movement_collision()


//
// Default Projectile Movement Collision Tests
//

// test collisions
scr_projectile_check_collision_with_tilemap();

// if the projectile was moving
if (last_velocity_x != 0 || last_velocity_y != 0)
{
    // if the projectile is inside the tilemap
    if (projectile_inside_tilemap)
    {
        dying = true;
    }
    
    // if the entity struck the tilemap
    if (projectile_hit_tilemap_x || projectile_hit_tilemap_y)
    {
        dying = true;
    }
}
