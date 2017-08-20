/// @descr scr_chunk_step()

if (create_instances)
{
    var i;
    var inst_list;
    var inst_size;
    var inst_string;
    var inst_object_name;
    var inst_x, inst_y;
    var inst_data;
    var inst;
    
    // the array to store the value returned by the "get instances" script
    // [0] = int, [1] = ds_list
    var layout_arr = array_create(2);
    
    // if the layout index is not set
    if (layout_index == noone)
    {
        // get a random list of instances
        layout_arr = scr_chunk_get_instances();
        layout_index  = layout_arr[0];
    }
    
    else
    {
        // get a specific list of instances
        layout_arr = scr_chunk_get_instances(layout_index);
    }
    
    // get the list of instances
    inst_list = layout_arr[1];
    inst_size = ds_list_size(inst_list);

    if (inst_size)
    {
        // create the array and fill it with noone
        instance_list = array_create(inst_size, noone);
    
        for (i = 0; i < inst_size; i++)
        {
            // get the instance data (as a string)
            inst_string = inst_list[| i];
            if (inst_string != "")
            {
                // convert the string to a ds_list
                inst_data = ds_list_create();
                ds_list_read(inst_data, inst_string);
                if (ds_list_size(inst_data) == 3)
                {
                    // get the object's properties
                    inst_object_name = inst_data[| 0];
                    inst_x = inst_data[| 1];
                    inst_y = inst_data[| 2];
                
                    // offset the x/y position
                    inst_x = inst_x + x;
                    inst_y = inst_y + y;
                
                    // create the instance
                    inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, asset_get_index(inst_object_name));
                    
                    // update instance depth
                    inst.depth = -(floor(inst.y));
                    
                    // capture the instance id
                    instance_list[i] = inst;
                }
            }
        
        }
    
    }
    
    ds_list_destroy(inst_list);
    
    create_instances = false;
}
