/// @descr scr_chunk_step()


//
// Create the Chunk
//

if (initialize_chunk)
{
    var i;
    var inst_list;
    var inst_size;
    var inst_string;
    var inst_object_name;
    var inst_x, inst_y;
    var instance_map;
    var inst;
    
    // check if this chunk's layout already exists
    if (global.WORLD_CHUNK_LAYOUTS_GRID != noone)
    {
        if (ds_exists(global.WORLD_CHUNK_LAYOUTS_GRID, ds_type_grid))
        {
            // get the layout index (default value is "noone")
            layout_index = ds_grid_get(global.WORLD_CHUNK_LAYOUTS_GRID, chunks_grid_x, chunks_grid_y);
        }
    }
    
    // the array to store the value returned by the "get instances" script
    // [0] = int, [1] = ds_list
    var layout_array;
    
    // if the layout index is not set
    if (layout_index == noone)
    {
        // get a random list of instances
        layout_array = scr_chunk_get_instances();
        layout_index  = layout_array[0];
    }
    
    else
    {
        // get a specific list of instances
        layout_array = scr_chunk_get_instances(layout_index);
    }
    
    // get the list of instances
    inst_list = layout_array[1];
    inst_size = ds_list_size(inst_list);
    
    // clean up the array
    layout_array = noone;
    
    if (inst_size)
    {
        // create the array and fill it with noone
        instances_array = array_create(inst_size, noone);
        
        for (i = 0; i < inst_size; i++)
        {
            // get the instance data (as a string)
            inst_string = inst_list[| i];
            if (inst_string != "")
            {
                // convert the string to a ds_list
                instance_map = ds_map_create();
                ds_map_read(instance_map, inst_string);
                if (ds_exists(instance_map, ds_type_map))
                {
                    // get the object's properties
                    inst_object_name = instance_map[? "object_name"];
                    inst_x = instance_map[? "x"];
                    inst_y = instance_map[? "y"];
                    
                    // offset the x/y position
                    inst_x = inst_x + x;
                    inst_y = inst_y + y;
                    
                    // skip if the "chunk size" object
                    if (inst_object_name == "obj_chunk_size")
                    {
                        continue;
                    }
                    
                    // if the object is a door
                    if (inst_object_name == "obj_door")
                    {
                        // add the door
                        inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_GROUND, asset_get_index(inst_object_name));
                        
                        // scale and update its "door_id"
                        inst.image_xscale = instance_map[? "image_xscale"];
                        inst.image_yscale = instance_map[? "image_yscale"];
                        inst.door_id = instance_map[? "door_id"];
                    }
                    
                    // else, if a grass object
                    else if (inst_object_name == "obj_grass_1" || inst_object_name == "obj_grass_2" || inst_object_name == "obj_grass_3")
                    {
                        // add the grass
                        inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_GROUND, asset_get_index(inst_object_name));                    
                    }
                    
                    // else, object is an entity or solid
                    else
                    {
                        // add the instance
                        inst = instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, asset_get_index(inst_object_name));
                    }
                    
                    // capture the instance id
                    instances_array[i] = inst;
                }
                
                // destroy the ds_map
                ds_map_destroy(instance_map);
                
            }
        
        }
    
    }
    
    // destroy the ds_list
    ds_list_destroy(inst_list);
    
    // update this chunk's layout index
    if (global.WORLD_CHUNK_LAYOUTS_GRID != noone)
    {
        if (ds_exists(global.WORLD_CHUNK_LAYOUTS_GRID, ds_type_grid))
        {
            // set the layout index
            ds_grid_set(global.WORLD_CHUNK_LAYOUTS_GRID, chunks_grid_x, chunks_grid_y, layout_index);
        }
    }
    
    /*
    // add deer
    var pos_x, pos_y;
    for (var i = 0; i < 1000; i++)
    {
        pos_x = x + 40 + irandom(40) - 20;
        pos_y = y + 40 + irandom(40) - 20;
        inst = instance_create_layer(pos_x, pos_y, ROOM_LAYER_INSTANCES, obj_deer);
    }
    */
    
    // randomly add a deer
    if (irandom(2) == 2)
    {
        instance_create_layer(x, y, ROOM_LAYER_INSTANCES, obj_deer);
    }
    
    // update state
    initialize_chunk = false;
}
