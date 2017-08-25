/// @descr scr_room_layout_create()


var layer_string = "Layer";
var chunk_size_object_name = "obj_chunk_size";


/*
    If a "layout" room is loaded, loop through each layer and build a ds_list of all the instances and their properties.
    Record the object name of the instance and its x and y positions.
    Search for a "chunk_size" object that is used to set the boundary of the chunk and record its x/y position.
    The x/y position will be used to offset the positions of all the instances.
    
    Place the "rm_layout_N" room first to run this script.
    Each instance on a layer will be converted to a string using ds_list_write(), which can be converted back to a list using ds_list_read().
    Then each list of instances will be output to the debug window and needs to be copied directly into a GML script.
    That can script can be called during runtime to randomly select the a list of instances to add to the scene.
        
    INSTANCE LIST:
        inst[| 0]   object_name
        inst[| 1]   x
        inst[| 2]   y
    
    
    CREATE AN INSTANCE:
    Use the object_name to find the object_index when the game loads, then use that index to create the instance.
    Game Maker assigns object_index when the game is compiled and will change during development as new objects are added.
    
        instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, asset_get_index(inst_object_name));
    
    
    EXAMPLE GML OUTPUT:
    
        var inst_list = ds_list_create();
        switch (irandom(1))
        {
            case 0:
                ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000004C40000000000000000000006240");
                ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000006240000000000000000000006440");
                break;
            case 1:
                ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000006640000000000000000000005E40");
                ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000004040000000000000000000006640");
                ds_list_add(inst_list, "2E01000004000000000000000000000000002640010000000A0000006F626A5F747265655F33000000000000000000005640000000000000000000006540");
                break;
        }
        return inst_list;
        // remember to destroy the list after it is used
*/
if (1 == 1)
{
    var layer_name;
    var layer_string_pos;
    var elements;
    var element_id;
    var inst;
    var inst_object_name;
    var inst_x, inst_y;
    var i1, i2;
    var offset_x, offset_y;
    var list1, list2;
    var list1_idx, list2_idx;
    var layer_list;
    var layer_size;
    var layer_list_idx;
    
    // get all the layers in this room
    var layers = layer_get_all();
    if (array_length_1d(layers))
    {
        // create the layer list
        layer_list = ds_list_create();
        layer_list_idx = 0;
        
        show_debug_message("\n-----\n");
        show_debug_message("START LAYER SCAN");
        
        // iterate through each layer in the room
        for (i1 = 0; i1 < array_length_1d(layers); i1++)
        {
            // get the layer's name
            layer_name = layer_get_name(layers[i1]);
            show_debug_message("\n-----\n");
            show_debug_message("Layer: " + string(layer_name));
    
            // check if the name starts with the layer string
            layer_string_pos = string_pos(layer_string, layer_name);
            if (layer_string_pos == 1)
            {
                // create a new ds_list for the instances on this layer
                list1 = ds_list_create();
                list1_idx = 0;
        
                // get all the elements on this layer
                elements = layer_get_all_elements(layers[i1]);
                show_debug_message("# of elements: " + string(array_length_1d(elements)));
        
                // loop through the elements, capturing the information and saving it to a ds_list
                for (i2 = 0; i2 < array_length_1d(elements); i2++)
                {
                    element_id = elements[i2];
                    if (layer_get_element_type(element_id) == layerelementtype_instance)
                    {
                        // get the instance and its properties
                        inst = layer_instance_get_instance(element_id);
                        inst_object_name = object_get_name(inst.object_index);
                        inst_x = inst.x;
                        inst_y = inst.y;
                        show_debug_message(string(inst) + ", " + string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                        
                        // if the "chunk size" object
                        if (inst_object_name == chunk_size_object_name)
                        {
                            // capture its x and y position
                            offset_x = inst_x;
                            offset_y = inst_y;
                            
                            // don't record this instance
                            // continue;
                        }
                        
                        // capture the instance data into a ds_list
                        list2 = ds_list_create();
                        list2[| 0] = inst_object_name;
                        list2[| 1] = inst_x;
                        list2[| 2] = inst_y;
                        
                        // add the instance data to the instance list
                        list1[| list1_idx] = list2;
                        ds_list_mark_as_list(list1, list1_idx);
                        list1_idx++
                
                    }
                }
        
                // if the instance list isn't empty
                if (ds_list_size(list1))
                {
                    // loop through all the instances and offset their x and y positions
                    for (i2 = 0; i2 < ds_list_size(list1); i2++)
                    {
                        list2 = list1[| i2];
                        
                        inst_x = list2[| 1];
                        inst_y = list2[| 2];
                        
                        list2[| 1] = (inst_x - offset_x);
                        list2[| 2] = (inst_y - offset_y);
                    }
                    
                    // add the instance list to the layer list
                    layer_list[| layer_list_idx] = list1;
                    ds_list_mark_as_list(layer_list, layer_list_idx);
                    layer_list_idx++;
                }
                
                // else, destroy the empty list
                else
                {
                    ds_list_destroy(list1);
                }
                
            }
            
        }
        
        show_debug_message("\n-----\n");
        show_debug_message("END LAYER SCAN");
        
        // if the layer list is not empty
        layer_size = ds_list_size(layer_list);
        if (layer_size)
        {
            show_debug_message("\n-----\n");
            show_debug_message("START GML OUTPUT");
            show_debug_message("\n-----\n");
            
            // output file open
            show_debug_message("");
            show_debug_message("var inst_list = ds_list_create();");
            show_debug_message("");
            show_debug_message("switch (irandom(" + string(layer_size - 1) + "))");
            show_debug_message("{");
            
            for (i1 = 0; i1 < layer_size; i1++)
            {
                list1 = layer_list[| i1];
                if ( ! is_undefined(list1))
                {
                    if (ds_exists(list1, ds_type_list))
                    {
                        if (ds_list_size(list1))
                        {
                            // output case declaration
                            show_debug_message("    case " + string(i1) + ":");
                            
                            for (i2 = 0; i2 < ds_list_size(list1); i2++)
                            {
                                list2 = list1[| i2];
                                if ( ! is_undefined(list2))
                                {
                                    if (ds_exists(list2, ds_type_list))
                                    {
                                        show_debug_message("        ds_list_add(inst_list, \"" + string(ds_list_write(list2)) + "\");");
                                    }
                                }
                            }
                            
                            show_debug_message("        break;");
                            show_debug_message("");
                        }
                    }
                }
            }
            
            // output file close
            show_debug_message("}");
            show_debug_message("");
            show_debug_message("return inst_list;");
            show_debug_message("// remember to destroy the list after its used");
            
            show_debug_message("\n-----\n");
            show_debug_message("END GML OUTPUT");
        }
        
        show_debug_message("\n-----\n");
        
        // free up all the memory
        ds_list_destroy(list1);
    }
}

