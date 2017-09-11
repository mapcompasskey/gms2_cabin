/// @descr scr_world_camera_draw()


exit;

// get the total number of instances to sort
var count = 0;
count += instance_number(obj_entity);
count += instance_number(obj_solid);

if (count < 1)
{
    exit;
}

// get camera boundaries
var x1 = floor(camera_get_view_x(camera));
var y1 = floor(camera_get_view_y(camera));
var x2 = ceil(x1 + camera_width);
var y2 = ceil(y1 + camera_height);

x1 -= instance_depth_grid_padding;
y1 -= instance_depth_grid_padding;
x2 += instance_depth_grid_padding;
y2 += instance_depth_grid_padding;
//scr_output(x1, y1, x2, y2);

// local variable to pass between objects
var depth_grid = instance_depth_grid;

// clear all the list inside the gird
for (var i = 0; i < ds_grid_height(depth_grid); i++)
{
    ds_list_clear(depth_grid[# 0, i]);
}

// get all the entities
with (obj_entity)
{
    var pos_y = round(y);
    if (pos_y > y1 && pos_y < y2)
    {
        pos_y = pos_y - y1;
        ds_list_add(depth_grid[# 0, pos_y], id);
    }
}

// get all the solids
with (obj_solid)
{
    var pos_y = round(y);
    if (pos_y > y1 && pos_y < y2)
    {
        pos_y = pos_y - y1;
        ds_list_add(depth_grid[# 0, pos_y], id);
    }
}

var inst_list, inst;
for (var i = 0; i < ds_grid_height(depth_grid); i++)
{
    inst_list = depth_grid[# 0, i];
    if ( ! ds_list_empty(inst_list))
    {
        for (var j = 0; j < ds_list_size(inst_list); j++)
        {
            inst = inst_list[| j];
            with (inst)
            {
                draw_self();
            }
            
        }
    }
    
}

