/// @descr scr_instance_sorter_create()


//
// Sort and Draw Instances by Depth
//

// *requires each object having a custom Draw Event to prevent its draw_self() from being called
// *objects are drawn when this instance is drawn - so if this instance is added beneath the Background layer, the objects its drawing will all be drawn below the Background layer

// get the total number of instances to sort
var count = 0;
count += instance_number(obj_entity);
count += instance_number(obj_solid);

// if there are no instances to sort
if (count < 1)
{
    exit;
}

// if the grid needs resized
if (count != instance_depth_grid_height)
{
    ds_grid_resize(instance_depth_grid, 2, count);
    instance_depth_grid_height = count;
}

// empty the grid
ds_grid_clear(instance_depth_grid, noone);

// local variables to pass between instances
var i = 0;
var depth_grid = instance_depth_grid;

// get all the entities
with (obj_entity)
{
    depth_grid[# 0, i] = id;
    depth_grid[# 1, i] = y;
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




