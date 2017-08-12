/// @descr scr_room_layout_create()


var layer_string = "Layer";
var corner_object_name = "obj_layout_corner";
var ini_filename = "lists.ini";


/*
    If a "layout" room is loaded, loop through each layer and build an array of all the instances
    and their properties. Record the object name of the instance and its x and y positions. There
    should also be four "corner" instances that are used to set the boundary and offset the x/y points.
    
    Place the "rm_layout_N" room after "rm_initialize" to run this file. Each instance will be added to
    the *.ini file under a section created for each layer. The names of the layer sections is added to
    a ds_list that is saved to the *.ini as well. The file can be found in the  AppData directory
    under this projects name: C:\Users\USERNAME\AppData\Local\PROJECT_NAME\"
    
    The "layer_section_1" value is a ds_list containing the section names: "layer02_1" and "layer02_2".
    Then, each section contains a "_size" that can be used to load each value under that section.
    
    *.ini
        [layer_sections]
        layer_section_1="..."
    
        [layer02_1]
        layer01_1_size="1"
        layer02_1_0="..."
        
        [layer01_2]
        layer01_2_size="2"
        layer01_2_0="..."
        layer01_2_1="..."
*/
if (1 == 0)
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
    var list_string;
    var ini_section, ini_key;
    var layers_list;
    var layers_list_idx;

    // get all the layers in this room
    var layers = layer_get_all();
    if (array_length_1d(layers))
    {
        // open the *.ini file
        ini_open(ini_filename);
        
        // create the layers ds_list
        layers_list = ds_list_create();
        layers_list_idx = 0;
        
        for (i1 = 0; i1 < array_length_1d(layers); i1++)
        {
            // get the layer's name
            layer_name = layer_get_name(layers[i1]);
            show_debug_message("\n-----\n");
            show_debug_message("Layer: " + string(layer_name));
            
            ini_section = layer_name;
            ini_section = string_lettersdigits(ini_section);
            ini_section = string_lower(ini_section);
            ini_section = string(ini_section) + "_" + string(i1);
            show_debug_message("Ini Section: " + string(ini_section));
    
            // check if the name starts with the layer string
            layer_string_pos = string_pos(layer_string, layer_name);
            if (layer_string_pos == 1)
            {
                // create a new ds_list for the layer
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
                            // if not rotated (the top-left corner)
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
                            
                            // add the instance data to the layer list
                            list1[| list1_idx] = list2;
                            ds_list_mark_as_list(list1, list1_idx);
                            list1_idx++
                        }
                
                    }
                }
        
                // if the layer list isn't empty
                if (ds_list_size(list1))
                {
                    // loop through all the instances and offset their x and y positions
                    show_debug_message("offset: " + string(offset_x) + ", " + string(offset_y));
                    for (i2 = 0; i2 < ds_list_size(list1); i2++)
                    {
                        list2 = list1[| i2];
                        
                        inst_x = list2[| 2];
                        inst_y = list2[| 3];
                        
                        list2[| 2] = (inst_x - offset_x);
                        list2[| 3] = (inst_y - offset_y);
                        
                        // add instance data to the *.ini file
                        ini_key = string(ini_section) + "_" + string(i2);
                        list_string = ds_list_write(list2);
                        ini_write_string(ini_section, ini_key, list_string);
                    }
                    
                    // add the number of instances to the *.ini file
                    ini_key = string(ini_section) + "_size";
                    list_string = string(ds_list_size(list1));
                    ini_write_string(ini_section, ini_key, list_string);
                    
                    // add the layer's section name to the list
                    layers_list[| layers_list_idx] = ini_section;
                    layers_list_idx++
                }
                
                // else, destroy the empty list
                else
                {
                    ds_list_destroy(list1);
                }
        
            }
    
        }
        
        // add the list of layer sections to the *.ini file
        ini_section = "layer_sections";
        ini_key = "layer_section_1";
        list_string = ds_list_write(layers_list);
        ini_write_string(ini_section, ini_key, list_string);
        
        // close the *.ini file
        ini_close();
        
        // free up all the memory
        ds_list_destroy(list1);
    }
}



/*
    Load the data from an *.ini file.
    The "layer_section_1" is a ds_list of the names of the other sections.
    Load it and loop through the list to find each section. Then load each sections "_size" value to know the number of values in that section.
    
    *.ini
        [layer_sections]
        layer_section_1="..."
    
        [layer02_1]
        layer01_1_size="1"
        layer02_1_0="..."
        
        [layer01_2]
        layer01_2_size="2"
        layer01_2_0="..."
        layer01_2_1="..."
*/
if (1 == 0)
{
    var layers_list;
    var list_string;
    var i1, i2, i3;
    var ini_section, ini_key;
    var section_size;
    var inst;
    var inst_object_index;
    var inst_object_name;
    var inst_x, inst_y;
    
    // open the *.ini file
    ini_open(ini_filename);
    
    list_string = ini_read_string("layer_sections", "layer_section_1", noone);
    if (list_string != noone)
    {
        // create the list of layer sections
        layers_list = ds_list_create();
        ds_list_read(layers_list, list_string);
        if (ds_exists(layers_list, ds_type_list))
        {
            if (ds_list_size(layers_list))
            {
                show_debug_message("\n-----\n");
                show_debug_message("layers_list size: " + string(ds_list_size(layers_list)));
                for (i1 = 0; i1 < ds_list_size(layers_list); i1++)
                {
                    ini_section = ds_list_find_value(layers_list, i1);
                    show_debug_message("\n-----\n");
                    show_debug_message("ini_section: " + string(ini_section));
                    
                    ini_key = string(ini_section) + "_size";
                    section_size = ini_read_string(ini_section, ini_key, "0");
                    section_size = real(section_size);
                    show_debug_message("section_size: " + string(section_size) + "\n");
                    if (section_size > 0)
                    {
                        for (i2 = 0; i2 < section_size; i2++)
                        {
                            ini_key = string(ini_section) + "_" + string(i2);
                            list_string = ini_read_string(ini_section, ini_key, noone);
                            if (list_string != noone)
                            {
                                inst = ds_list_create();
                                ds_list_read(inst, list_string);
                                if (ds_exists(inst, ds_type_list))
                                {
                                    inst_object_index = ds_list_find_value(inst, 0);
                                    inst_object_name = ds_list_find_value(inst, 1);
                                    inst_x = ds_list_find_value(inst, 2);
                                    inst_y = ds_list_find_value(inst, 3);
                                    show_debug_message(string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                                }
                            }
                        }
                    }
                    
                }
            }
        }
    }
    else
    {
        show_debug_message("ini_read_string(layer_section, layer_section_1) is empty");
    }
    
    // close the *.ini file
    ini_close();
    
    show_debug_message("\n-----\n");
}

