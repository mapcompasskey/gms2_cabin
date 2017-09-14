/// @descr scr_room_layout_create()

/*
If a "layout" room is loaded, loop through each layer and build a ds_list of all the instances and their properties.
Record information about each instance into a ds_map that can be used later to recreate it.
Search for a "chunk_size" object that is used to set the boundary of the chunk and record its x/y position.
The x/y position will be used to offset the positions of all the instances.

Place the "rm_layout_N" room first to run this script.
Each instance on a layer will be converted to a string using ds_map_write(), which can be converted back to a ds_map using ds_map_read().
Then each list of instances will be output to the debug window and needs to be copied directly into a GML script.
That script can be called during runtime to randomly select the a list of instances to add to the scene.

INSTANCE MAP:
    instance_map[? "object_name"]
    instance_map[? "x"]
    instance_map[? "y"]

Door instances will contain additional properties:
    instance_map[? "image_xscale"]
    instance_map[? "image_Yscale"]
    instance_map[? "door_id"]


CREATE AN INSTANCE:
Use the object_name to find the object_index when the game loads, then use that index to create the instance.
Game Maker assigns the object_index when the game is compiled and will change during development as new objects are added.

    instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, asset_get_index(inst_object_name));


EXAMPLE GML OUTPUT:
    
    var inst_list = ds_list_create();
    switch (irandom(1))
    {
        // rm_layout_1 - Layer_02
        case 0:
            ds_list_add(inst_list, "9201000003000000010000000100000078000000000000000000004440010000000B0000006F626A6563745F6E616D65010000000A0000006F626A5F747265655F33010000000100000079000000000000000000005040"); // obj_tree_3
            ds_list_add(inst_list, "9201000003000000010000000100000078000000000000000000004C40010000000B0000006F626A6563745F6E616D65010000000A0000006F626A5F747265655F33010000000100000079000000000000000000005240"); // obj_tree_3
            break;
            
        // rm_layout_1 - Layer_01
        case 1:
            ds_list_add(inst_list, "9201000003000000010000000100000078000000000000000000004C40010000000B0000006F626A6563745F6E616D65010000000A0000006F626A5F747265655F31010000000100000079000000000000000000004040"); // obj_tree_1
            ds_list_add(inst_list, "9201000003000000010000000100000078000000000000000000003840010000000B0000006F626A6563745F6E616D65010000000A0000006F626A5F747265655F31010000000100000079000000000000000000004440"); // obj_tree_1
            ds_list_add(inst_list, "9201000003000000010000000100000078000000000000000000005040010000000B0000006F626A6563745F6E616D65010000000A0000006F626A5F747265655F32010000000100000079000000000000000000005040"); // obj_tree_2
            break;
    }
    return inst_list;
    // remember to destroy the list after it is used
*/

// record layers whose name is prepended
var instances_layer_string = "Instances";

// the object that sets the x/y offset
var chunk_size_object_name = "obj_chunk_size";

var layer_name;
var layer_string_pos;
var elements;
var element_id;

var inst;
var inst_object_name;
var inst_x, inst_y;

var i1, i2;
var offset_x = 0;
var offset_y = 0;

var layer_list = ds_list_create();
var layer_size;
var layer_list_idx;
var instance_list = ds_list_create();
var instance_list_idx;
var instance_map = ds_map_create();
var instance_map_string; // ds_map_write()

var name_of_room = room_get_name(room);
var layer_name_list = ds_list_create();

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
        layer_string_pos = string_pos(instances_layer_string, layer_name);
        if (layer_string_pos == 1)
        {
            // create a new ds_list for the instances on this layer
            instance_list = ds_list_create();
            instance_list_idx = 0;
            
            // get all the elements on this layer
            elements = layer_get_all_elements(layers[i1]);
            show_debug_message("# of elements: " + string(array_length_1d(elements)));
            
            // loop through the elements, capturing the information and saving it to a ds_map
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
                    
                    // capture the instance data into a ds_map
                    instance_map = ds_map_create();
                    instance_map[? "object_name"] = inst_object_name;
                    instance_map[? "x"] = inst_x;
                    instance_map[? "y"] = inst_y;
                    
                    // if the object is a door
                    if (inst_object_name == "obj_door")
                    {
                        instance_map[? "image_xscale"] = inst.image_xscale;
                        instance_map[? "image_yscale"] = inst.image_yscale;
                        instance_map[? "door_id"] = inst.door_id;
                    }
                    
                    // add the instance map to the list
                    instance_list[| instance_list_idx] = instance_map;
                    ds_list_mark_as_map(instance_list, instance_list_idx);
                    instance_list_idx++
                }
            }
            
            // if the instance list isn't empty
            if (ds_list_size(instance_list))
            {
                // loop through all the instances and offset their x and y positions
                for (i2 = 0; i2 < ds_list_size(instance_list); i2++)
                {
                    instance_map = instance_list[| i2];
                    
                    inst_x = instance_map[? "x"];
                    inst_y = instance_map[? "y"];
                    
                    instance_map[? "x"] = (inst_x - offset_x);
                    instance_map[? "y"] = (inst_y - offset_y);
                }
                
                // add the instance list to the layer list
                layer_list[| layer_list_idx] = instance_list;
                ds_list_mark_as_list(layer_list, layer_list_idx);
                
                // add the layer name to the layer name list at the same index
                layer_name_list[| layer_list_idx] = layer_name;
                
                // increment the layer list index
                layer_list_idx++;
            }
            
            // else, destroy the empty list
            else
            {
                ds_list_destroy(instance_list);
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
            instance_list = layer_list[| i1];
            if ( ! is_undefined(instance_list))
            {
                if (ds_exists(instance_list, ds_type_list))
                {
                    if (ds_list_size(instance_list))
                    {
                        // output layer name
                        show_debug_message("    // " + string(name_of_room) + " - " + string(layer_name_list[| i1]));
                        
                        // output case declaration
                        //show_debug_message("    case " + string(i1) + ":");
                        switch (layer_name_list[| i1])
                        {
                            case "Instances_Tower_02":
                                show_debug_message("    case \"tower_2\":");
                                break;
                                
                            case "Instances_Tower_01":
                                show_debug_message("    case \"tower_1\":");
                                break;
                                
                            case "Instances_Cabin_01":
                                show_debug_message("    case \"cabin_1\":");
                                break;
                                
                            case "Instances_Trees_05":
                                show_debug_message("    case 5:");
                                break;
                                
                            case "Instances_Trees_04":
                                show_debug_message("    case 4:");
                                break;
                                
                            case "Instances_Trees_03":
                                show_debug_message("    case 3:");
                                break;
                                
                            case "Instances_Trees_02":
                                show_debug_message("    case 2:");
                                break;
                                
                            case "Instances_Trees_01":
                                show_debug_message("    case 1:");
                                break;
                                
                            case "Instances_Trees_00":
                                show_debug_message("    case 0:");
                                break;
                                
                            default:
                                show_debug_message("    case \"unknown\":");
                        }
                        
                        // encode and output each instance list as a string that can be decoded back into a ds_map
                        for (i2 = 0; i2 < ds_list_size(instance_list); i2++)
                        {
                            instance_map = instance_list[| i2];
                            if ( ! is_undefined(instance_map))
                            {
                                if (ds_exists(instance_map, ds_type_map))
                                {
                                    instance_map_string = ds_map_write(instance_map);
                                    inst_object_name = instance_map[? "object_name"];
                                    show_debug_message("        ds_list_add(inst_list, \"" + string(instance_map_string) + "\"); // " + string(inst_object_name));
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
    ds_list_destroy(layer_name_list);
    ds_list_destroy(layer_list);
    ds_list_destroy(instance_list);
    ds_map_destroy(instance_map);
}

