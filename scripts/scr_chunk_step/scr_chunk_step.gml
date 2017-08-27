/// @descr scr_chunk_step()

if (create_instances)
{
    var i;
    var inst_list;
    var inst_size;
    var inst_string;
    var inst_object_name;
    var inst_x, inst_y;
    var inst_map;
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
                inst_map = ds_map_create();
                ds_map_read(inst_map, inst_string);
                if (ds_exists(inst_map, ds_type_map))
                {
                    // get the object's properties
                    inst_object_name = inst_map[? "object_name"];
                    inst_x = inst_map[? "x"];
                    inst_y = inst_map[? "y"];
                    
                    // offset the x/y position
                    inst_x = inst_x + x;
                    inst_y = inst_y + y;
                    
                    // create the instance
                    inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, asset_get_index(inst_object_name));
                    
                    // if the object is a door
                    if (inst_object_name == "obj_door")
                    {
                        inst.image_xscale = inst_map[? "image_xscale"];
                        inst.image_yscale = inst_map[? "image_yscale"];
                        inst.door_name = inst_map[? "door_name"];
                    }
                    
                    // update instance depth
                    inst.depth = -(floor(inst.y));
                    
                    // capture the instance id
                    instance_list[i] = inst;
                }
                
                // clean up the ds_map
                ds_map_destroy(inst_map);
                
            }
        
        }
    
    }
    
    // clean up the ds_list
    ds_list_destroy(inst_list);
    
    // change state
    create_instances = false;
}
