/// @descr scr_game_draw()


//
// Draw Instances by Depth
//

// *requires each object having a custom Draw Event to prevent draw_self() from being called

if (ds_exists(instance_depth_grid, ds_type_grid))
{
    var i = 0;
    
    // local variable to pass into instances
    var depth_grid = instance_depth_grid;
    
    // get the total number of instances to sort
    var count = 0;
    count += instance_number(obj_entity);
    count += instance_number(obj_door);
    count += instance_number(obj_solid);
    
    // if there are no instances to sort
    if (count < 1)
    {
        exit;
    }
    
    // if the grid needs resized
    if (count != instance_depth_grid_height)
    {
        ds_grid_resize(depth_grid, 2, count);
        instance_depth_grid_height = count;
    }
    
    // empty the grid
    ds_grid_clear(depth_grid, noone);
    
    // get all the entities
    with (obj_entity)
    {
        depth_grid[# 0, i] = id;
        depth_grid[# 1, i] = y;
        i++;
    }
    
    // get all the doors
    with (obj_door)
    {
        var pos_y = y;
        if (image_angle == 0)
        {
            pos_y += sprite_height;
        }
        
        depth_grid[# 0, i] = id;
        depth_grid[# 1, i] = pos_y;
        i++;
    }
    
    // get all the solids
    with (obj_solid)
    {
        depth_grid[# 0, i] = id;
        depth_grid[# 1, i] = y;
        i++;
    }
    
    // sort the grid by the "y position" of each instances
    ds_grid_sort(depth_grid, 1, true);
    
    // loop through the grid and draw each instance
    for (var i = 0; i < count; i++)
    {
        var inst = depth_grid[# 0, i];
        with (inst)
        {
            draw_self();
        }
    }
    
}
