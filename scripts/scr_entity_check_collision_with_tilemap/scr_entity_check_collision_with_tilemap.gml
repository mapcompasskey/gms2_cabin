/// @descr scr_entity_check_collision_with_tilemap()


//
// Test Movement Collision Against Tilemap
//

// check for the tilemap layer
if (tilemap == noone)
{
    return;
}

entity_hit_tilemap_x = false;
entity_hit_tilemap_y = false;

var steps = 0;
var step_size = 0;
var steps_2 = 0;
var step_size_2 = 0;
                
var wd = (bbox_right - bbox_left);
var hg = (bbox_bottom - bbox_top);

var offset_x = 0;
var offset_y = 0;
var target_x = 0;
var target_y = 0;
var result_x = 0;
var result_y = 0;

var collision = false;
var tile_1 = 0;
var tile_at_point = 0;


//
// Vertical Collision Test
//
if (my != 0)
{
    // if moving more than the height of the sprite or the size of a tile,
    // check the path, using the smallest value, for any collisions
    steps = 1;
    if (abs(my) > min(hg, TILE_SIZE))
    {
        steps = ceil(abs(my) / min(hg, TILE_SIZE));
    }
    step_size = (my / steps);
    
    // if the sprite is wider than a tile,
    // check in increments along its width
    steps_2 = 1;
    if (wd > TILE_SIZE)
    {
        steps_2 = ceil(wd / TILE_SIZE);
    }
    step_size_2 = (wd / steps_2);
    
    for (var i = 1; i <= steps; i++)
    {
        collision = false;
        tile_1 = TILE_SOLID;
        
        // if moving up
        if (my < 0)
        {
            offset_y = sprite_bbox_top;
        }
        // else, if moving down
        else
        {
            offset_y = sprite_bbox_bottom;
        }
        
        // get top or bottom position
        target_y = (y + offset_y + (step_size * i));
        
        // check left edge and mid points
        if ( ! collision)
        {
            for (var j = 0; j < steps_2; j++)
            {
                target_x = (x + sprite_bbox_left + (step_size_2 * j));
                tile_at_point = tilemap_get_at_pixel(tilemap, target_x, target_y) & tile_index_mask;
                if (tile_at_point == tile_1)
                {
                    collision = true;
                    j = steps_2;
                }
            }
        }
        
        // check right edge
        if ( ! collision)
        {
            target_x = (x + sprite_bbox_right);
            tile_at_point = tilemap_get_at_pixel(tilemap, target_x, target_y) & tile_index_mask;
            if (tile_at_point == tile_1)
            {
                collision = true;
            }
        }
        
        if (collision)
        {
            collision = false;
            
            // if moving up
            if (my < 0)
            {
                // check the result won't push the instance down
                result_y = ((target_y + TILE_SIZE) & ~NOT_TILE_SIZE);
                if (result_y <= (y + offset_y))
                {
                    collision = true;
                }
            }
            // else, if moving down
            else
            {
                // check the result won't push the instance up
                result_y = (target_y & ~NOT_TILE_SIZE);
                if (result_y >= (y + offset_y))
                {
                    collision = true;
                    result_y = (result_y - (result_y - (y + offset_y)));
                }
            }
            
            if (collision)
            {
                my = (result_y - offset_y - y);
                velocity_y = 0;
                entity_hit_tilemap_y = true;
                break;
            }
        }
        
    }
    
}


//
// Horizontal Collision Test
//
if (mx != 0)
{
    // if moving more than the width of the sprite or the size of a tile,
    // check the path, using the smallest value, for any collisions
    steps = 1;
    if (abs(mx) > min(wd, TILE_SIZE))
    {
        steps = ceil(abs(mx) / min(wd, TILE_SIZE));
    }
    step_size = (mx / steps);
    
    // if the sprite is taller than a tile,
    // check in increments along its height
    steps_2 = 1;
    if (hg > TILE_SIZE)
    {
        steps_2 = ceil(hg / TILE_SIZE);
    }
    step_size_2 = (hg / steps_2);
    
    for (var i = 1; i <= steps; i++)
    {
        collision = false;
        tile_1 = TILE_SOLID;
        
        // if moving right
        if (mx > 0)
        {
            offset_x = sprite_bbox_right;
        }
        // else, if moving left
        else
        {
            offset_x = sprite_bbox_left;
        }
        
        // get left or right position
        target_x = (x + offset_x + (step_size * i));
        
        // check bottom edge and mid points
        if ( ! collision)
        {
            for (var j = 0; j < steps_2; j++)
            {
                target_y = (y + sprite_bbox_bottom + my - (step_size_2 * j));
                tile_at_point = tilemap_get_at_pixel(tilemap, target_x, target_y) & tile_index_mask;
                if (tile_at_point == tile_1)
                {
                    collision = true;
                    j = steps_2;
                }
            }
        }
        
        // check top edge
        if ( ! collision)
        {
            target_y = (y + sprite_bbox_top + my);
            tile_at_point = tilemap_get_at_pixel(tilemap, target_x, target_y) & tile_index_mask;
            if (tile_at_point == tile_1)
            {
                collision = true;
            }
        }
        
        if (collision)
        {
            collision = false;
            
            // if moving right
            if (mx > 0)
            {
                // check the result won't push the instance to the left
                result_x = (target_x & ~NOT_TILE_SIZE);
                if (result_x >= (x + offset_x))
                {
                    collision = true;
                    result_x = (result_x - (result_x - (x + offset_x)));
                }
            }
            // else, if moving left
            else
            {
                // check the result won't push the instance to the right
                result_x = ((target_x + TILE_SIZE) & ~NOT_TILE_SIZE);
                if (result_x <= (x + offset_x))
                {
                    collision = true;
                }
            }
            
            if (collision)
            {
                mx = (result_x - offset_x - x);
                velocity_x = 0;
                entity_hit_tilemap_x = true;
                break;
            }
        }
        
    }
    
}
