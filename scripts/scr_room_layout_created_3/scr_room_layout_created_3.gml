/// @descr scr_room_layout_create()


var layer_string = "Layer";
var corner_object_name = "obj_layout_corner";


/*
    If a "layout" room is loaded, loop through each layer and build a ds_list of all the instances
    and their properties. Record the object name of the instance and its x and y positions. There
    should also be four "corner" instances that are used to set the boundary and offset the x/y points.
    
    Place the "rm_layout_N" room after "rm_initialize" to run this file. Each instance on a layer will
    be converted to a string using ds_list_write() which can be converted back to a list using ds_list_read().
    Then each list of instances will be output to the debug window into a GML script that can be copied and
    pasted into the script that will randomly select the chunk to load.
    
    
    INSTANCE LIST:
        inst[| 0]   object_index
        inst[| 1]   object_name
        inst[| 2]   x
        inst[| 3]   y
    
    
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
*/
if (1 == 1)
{
    var layer_name;
    var layer_string_pos;
    var elements;
    var element_id;
    var inst;
    var inst_object_index;
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
                        inst_object_index = inst.object_index;
                        inst_object_name = object_get_name(inst_object_index);
                        inst_x = inst.x;
                        inst_y = inst.y;
                        show_debug_message(string(inst) + ", " + string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                        
                        // if a corner object (used to mark the chunk's boundaries)
                        if (inst_object_name == corner_object_name)
                        {
                            // if not rotated, its the top-left corner
                            if (inst.image_angle == 0)
                            {
                                // capture its x and y position
                                offset_x = inst_x;
                                offset_y = inst_y;
                            }
                        }
                        // else, regular game instance
                        else
                        {
                            // capture the instance data into a ds_list
                            list2 = ds_list_create();
                            list2[| 0] = inst_object_index;
                            list2[| 1] = inst_object_name;
                            list2[| 2] = inst_x;
                            list2[| 3] = inst_y;
                            
                            // add the instance data to the instance list
                            list1[| list1_idx] = list2;
                            ds_list_mark_as_list(list1, list1_idx);
                            list1_idx++
                        }
                
                    }
                }
        
                // if the instance list isn't empty
                if (ds_list_size(list1))
                {
                    // loop through all the instances and offset their x and y positions
                    for (i2 = 0; i2 < ds_list_size(list1); i2++)
                    {
                        list2 = list1[| i2];
                        
                        inst_x = list2[| 2];
                        inst_y = list2[| 3];
                        
                        list2[| 2] = (inst_x - offset_x);
                        list2[| 3] = (inst_y - offset_y);
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
            
            show_debug_message("\n-----\n");
            show_debug_message("END GML OUTPUT");
        }
        
        show_debug_message("\n-----\n");
        
        // free up all the memory
        ds_list_destroy(list1);
    }
}


/*
    An example of the GML that is generated and a test case that randomly selects and iterates through the instances on that layer.
*/
if (1 == 1)
{
    var i;
    var inst;
    var inst_string;
    var inst_object_index;
    var inst_object_name;
    var inst_x, inst_y;
    
    var inst_list = ds_list_create();
    switch (irandom(1))
    {
        case 0:
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000004C40000000000000000000006240");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000006240000000000000000000006440");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000005A40000000000000000000006540");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000005240000000000000000000006440");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000006540000000000000000000006240");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000005440000000000000000000005240");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000006240000000000000000000005240");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000005E40000000000000000000006540");
            break;
            
        case 1:
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000006640000000000000000000005E40");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000004040000000000000000000006640");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002640010000000A0000006F626A5F747265655F33000000000000000000005640000000000000000000006540");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002640010000000A0000006F626A5F747265655F33000000000000000000006540000000000000000000004C40");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000006040000000000000000000005840");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000005040000000000000000000006040");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000005440000000000000000000004440");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000004440000000000000000000004040");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000005440000000000000000000005440");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002440010000000A0000006F626A5F747265655F32000000000000000000004C40000000000000000000004C40");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002240010000000A0000006F626A5F747265655F31000000000000000000006240000000000000000000006440");
            ds_list_add(inst_list, "2E01000004000000000000000000000000002640010000000A0000006F626A5F747265655F33000000000000000000004440000000000000000000005840");
            break;
    }
    
    show_debug_message("\n-----\n");
    
    if (ds_list_size(inst_list))
    {
        for (i = 0; i < ds_list_size(inst_list); i++)
        {
            inst_string = inst_list[| i];
            if (inst_string != "")
            {
                inst = ds_list_create();
                ds_list_read(inst, inst_string);
                if (ds_list_size(inst) == 4)
                {
                    inst_object_index = inst[| 0];
                    inst_object_name = inst[| 1];
                    inst_x = inst[| 2];
                    inst_y = inst[| 3];
                    show_debug_message(string(inst_object_name) + " " + string(inst_x) + " " + string(inst_y));
                }
            }
            
        }
    }
    
    show_debug_message("\n-----\n");
    
    // clean up list
    ds_list_destroy(inst_list);
    
}

