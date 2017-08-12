/// @descr scr_room_layout_create()


var layer_string = "Layer";
var corner_object_name = "obj_layout_corner";
var ini_filename = "map.ini";
var text_filename = "text-file.txt";


/*
    If a "layout" room is loaded, loop through each layer and build an array of all the instances
    and their properties. Record the object name of the instance and its x and y positions. There
    should also be four "corner" instances that are used to set the boundary and offset the x/y points.
    
    Place the "rm_layout_N" room after "rm_initialize" to run this file. The data will be collected
    and dumped as a JSON string to a local text file. The file can be found in the  AppData directory
    under this projects name: C:\Users\USERNAME\AppData\Local\PROJECT_NAME\"
    
    map1 = ds_map[
        0 => ds_map[
            0 => ds_map[
                "x" => 56,
                "y" => 144,
                "object_index" => 9
                "object_name" => "obj_tree_1
            ],
            1 => ds_map[
                "x" => 144,
                "y" => 160,
                "object_index" => 10
                "object_name" => "obj_tree_2
            ]
            ...
        ],
        1 => ds_map[
            0 => ds_map[
                "x" => 176,
                "y" => 120,
                "object_index" => 9
                "object_name" => "obj_tree_1
            ],
            1 => ds_map[
                "x" => 32,
                "y" => 176,
                "object_index" => 10
                "object_name" => "obj_tree_2
            ]
            ...
        ]
    ]
            
            
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
    var map1, map2, map3;
    var map1_idx, map2_idx;

    // get all the layers in this room
    var layers = layer_get_all();
    if (array_length_1d(layers))
    {
        map1 = ds_map_create();
        map1_idx = 0;

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
                // create a new ds_map
                map2 = ds_map_create();
                map2_idx = 0;
        
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
                            // capture the instance data into a ds_map
                            map3 = ds_map_create();
                            ds_map_add(map3, "x", inst_x);
                            ds_map_add(map3, "y", inst_y);
                            ds_map_add(map3, "object_index", inst_object_index);
                            ds_map_add(map3, "object_name", inst_object_name);
                    
                            // add the instance data to the instances map
                            ds_map_add_map(map2, map2_idx, map3);
                            map2_idx++;
                        }
                
                    }
                }
        
                // if there is a instances map isn't empty
                if (ds_map_size(map2))
                {
                    // loop through all the instances and offset their x and y positions
                    show_debug_message("offset: " + string(offset_x) + ", " + string(offset_y));
                    for (i2 = 0; i2 < ds_map_size(map2); i2++)
                    {
                        map3 = map2[? i2];
                
                        inst_x = map3[? "x"];
                        inst_y = map3[? "y"];
                
                        map3[? "x"] = (inst_x - offset_x);
                        map3[? "y"] = (inst_y - offset_y);
                    }
            
                    // add the map of instances to the layout map
                    ds_map_add_map(map1, map1_idx, map2);
                    map1_idx++;
                }
                // else, destroy the empty map
                else
                {
                    ds_map_destroy(map2);
                }
        
            }
    
        }
    
        /**/
        // move through the ds_map and display all the contents
        if (ds_map_size(map1))
        {
            show_debug_message("\n-----\n");
            show_debug_message("ds_map_size(map1): " + string(ds_map_size(map1)));
            for (i1 = 0; i1 < ds_map_size(map1); i1++)
            {
                map2 = map1[? i1];
                if ( ! is_undefined(map2))
                {
                    if (ds_exists(map2, ds_type_map))
                    {
                        if (ds_map_size(map2))
                        {
                            show_debug_message(" ");
                            for (i2 = 0; i2 < ds_map_size(map2); i2++)
                            {
                                map3 = map2[? i2];
                                if ( ! is_undefined(map3))
                                {
                                    if (ds_exists(map3, ds_type_map))
                                    {
                                        if (ds_map_size(map3))
                                        {
                                            inst_object_index = ds_map_find_value(map3, "object_index");
                                            inst_object_name = ds_map_find_value(map3, "object_name");
                                            inst_x = ds_map_find_value(map3, "x");
                                            inst_y = ds_map_find_value(map3, "y");
                                            show_debug_message(string(inst_object_name) + ", " + string(inst_object_index) + ", " + string(inst_x) + " " + string(inst_y));
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
                
            }
        }
        /**/
    
        // write the ds_map to an ini file
        // *nested maps only work with JSON
        //ini_open("map.ini");
        //var map_string = ds_map_write(map1);
        //ini_write_string("Layouts", "layout_1", map_string);
        //ini_close();

        // encode the ds_map to a JSON string and save to a file
        var json_string = json_encode(map1);
        var text_file = file_text_open_write(text_filename);
        file_text_write_string(text_file, json_string);
        file_text_close(text_file);

        // free up all the memory
        ds_map_destroy(map1);
    }
}


/*
    Load the ds_map data from an *.ini file.
    Can't load nested ds_maps from an ini file saved using ds_map_write();
    
    DS Maps:
    There are also a couple of complimentary functions for ds_lists: ds_list_mark_as_list, ds_list_mark_as_map
    NOTE: While these functions permit you to add lists and maps within a map, they are useless for anything other than JSON,
    and nested maps and lists will not be read correctly if written to disk or accessed in any other way.
*/
if (1 == 0)
{
    var map1, map2, map3;
    var map_string;
    var inst_object_index;
    var inst_object_name;
    var inst_x, inst_y;
    var i1, i2;
    
    show_debug_message("\n-----\n");
    
    // load the ini file
    map1 = ds_map_create();
    ini_open(ini_filename);
    
    // read the ds_map data
    map_string = ini_read_string("Layouts", "layout_1", "");
    if (map_string != "")
    {
        show_debug_message("ini string: " + string(map_string));
        ds_map_read(map1, map_string);
    }
    else
    {
        show_debug_message("ini string empty");
    }
    
    // close the file
    ini_close();
    
    // move through the ds_map and display all the contents
    if (ds_map_size(map1))
    {
        show_debug_message("ds_map_size(map1): " + string(ds_map_size(map1)));
        for (i1 = 0; i1 < ds_map_size(map1); i1++)
        {
            map2 = map1[? i1];
            if ( ! is_undefined(map2))
            {
                if (ds_exists(map2, ds_type_map))
                {
                    if (ds_map_size(map2))
                    {
                        show_debug_message(" ");
                        for (i2 = 0; i2 < ds_map_size(map2); i2++)
                        {
                            map3 = map2[? i2];
                            if (ds_exists(map3, ds_type_map))
                            {
                                if (ds_map_size(map3))
                                {
                                    inst_object_index = ds_map_find_value(map3, "object_index");
                                    inst_object_name = ds_map_find_value(map3, "object_name");
                                    inst_x = ds_map_find_value(map3, "x");
                                    inst_y = ds_map_find_value(map3, "y");
                                    show_debug_message(string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
    
}


/*
    Load the ds_map data from an *.txt file and output the nested contents.
    The indexes from the original ds_map have been coverted from numbers to strings.
    So the original ds_map data at index 0, map1[? 0], has to be called using a string, map1[? "0"]
*/
if (1 == 0)
{
    var map1, map2, map3;
    var i1, i2;
    var inst_object_index;
    var inst_object_name;
    var inst_x, inst_y;
    
    // open the file and get the JSON string
    var text_file = file_text_open_read(text_filename);
    var json_string = file_text_read_string(text_file);
    file_text_close(text_file);
    
    // covert the JSON string to a ds_map
    map1 = json_decode(json_string);
    
    // move through the ds_map and display all the contents
    if (ds_map_size(map1))
    {
        show_debug_message("ds_map_size(map1): " + string(ds_map_size(map1)));
        for (i1 = 0; i1 < ds_map_size(map1); i1++)
        {
            map2 = map1[? string(i1)];
            if ( ! is_undefined(map2))
            {
                if (ds_exists(map2, ds_type_map))
                {
                    if (ds_map_size(map2))
                    {
                        show_debug_message(" ");
                        for (i2 = 0; i2 < ds_map_size(map2); i2++)
                        {
                            map3 = map2[? string(i2)];
                            if ( ! is_undefined(map3))
                            {
                                if (ds_exists(map3, ds_type_map))
                                {
                                    if (ds_map_size(map3))
                                    {
                                        inst_object_index = ds_map_find_value(map3, "object_index");
                                        inst_object_name = ds_map_find_value(map3, "object_name");
                                        inst_x = ds_map_find_value(map3, "x");
                                        inst_y = ds_map_find_value(map3, "y");
                                        show_debug_message(string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
    
}


/*
    Load the ds_map data from a string and output the nested contents.
    Single quotes aren't a valid string delimiter in GML.
    
    Normally, saving a JSON string in GML would require escaping all the double quotes like the followinig.
        var json_string = "{ \"1\": { \"2\": { \"object_index\": 11.000000....";
    
    However, single quotes can be used if prepended by the @ syntax.
        var json_string = @'{ "1": { "2": { "object_index": 11.000000, ...';
*/
if (1 == 1)
{
    var map1, map2, map3;
    var i1, i2;
    var inst_object_index;
    var inst_object_name;
    var inst_x, inst_y;
    
    // JSON string
    var json_string = @'{ "1": { "2": { "object_index": 11.000000, "x": 88.000000, "y": 168.000000, "object_name": "obj_tree_3" }, "3": { "object_index": 11.000000, "x": 168.000000, "y": 56.000000, "object_name": "obj_tree_3" }, "1": { "object_index": 10.000000, "x": 32.000000, "y": 176.000000, "object_name": "obj_tree_2" }, "11": { "object_index": 11.000000, "x": 40.000000, "y": 96.000000, "object_name": "obj_tree_3" }, "9": { "object_index": 10.000000, "x": 56.000000, "y": 56.000000, "object_name": "obj_tree_2" }, "5": { "object_index": 9.000000, "x": 64.000000, "y": 128.000000, "object_name": "obj_tree_1" }, "4": { "object_index": 10.000000, "x": 128.000000, "y": 96.000000, "object_name": "obj_tree_2" }, "7": { "object_index": 10.000000, "x": 40.000000, "y": 32.000000, "object_name": "obj_tree_2" }, "6": { "object_index": 9.000000, "x": 80.000000, "y": 40.000000, "object_name": "obj_tree_1" }, "0": { "object_index": 9.000000, "x": 176.000000, "y": 120.000000, "object_name": "obj_tree_1" }, "10": { "object_index": 9.000000, "x": 144.000000, "y": 160.000000, "object_name": "obj_tree_1" }, "8": { "object_index": 10.000000, "x": 80.000000, "y": 80.000000, "object_name": "obj_tree_2" } }, "0": { "2": { "object_index": 10.000000, "x": 104.000000, "y": 168.000000, "object_name": "obj_tree_2" }, "3": { "object_index": 9.000000, "x": 72.000000, "y": 160.000000, "object_name": "obj_tree_1" }, "1": { "object_index": 10.000000, "x": 144.000000, "y": 160.000000, "object_name": "obj_tree_2" }, "5": { "object_index": 10.000000, "x": 80.000000, "y": 72.000000, "object_name": "obj_tree_2" }, "4": { "object_index": 10.000000, "x": 168.000000, "y": 144.000000, "object_name": "obj_tree_2" }, "7": { "object_index": 9.000000, "x": 120.000000, "y": 168.000000, "object_name": "obj_tree_1" }, "6": { "object_index": 10.000000, "x": 144.000000, "y": 72.000000, "object_name": "obj_tree_2" }, "0": { "object_index": 9.000000, "x": 56.000000, "y": 144.000000, "object_name": "obj_tree_1" } } }';
    
    // covert the JSON string to a ds_map
    map1 = json_decode(json_string);
    
    // move through the ds_map and display all the contents
    if (ds_map_size(map1))
    {
        show_debug_message("ds_map_size(map1): " + string(ds_map_size(map1)));
        for (i1 = 0; i1 < ds_map_size(map1); i1++)
        {
            map2 = map1[? string(i1)];
            if ( ! is_undefined(map2))
            {
                if (ds_exists(map2, ds_type_map))
                {
                    if (ds_map_size(map2))
                    {
                        show_debug_message(" ");
                        for (i2 = 0; i2 < ds_map_size(map2); i2++)
                        {
                            map3 = map2[? string(i2)];
                            if ( ! is_undefined(map3))
                            {
                                if (ds_exists(map3, ds_type_map))
                                {
                                    if (ds_map_size(map3))
                                    {
                                        inst_object_index = ds_map_find_value(map3, "object_index");
                                        inst_object_name = ds_map_find_value(map3, "object_name");
                                        inst_x = ds_map_find_value(map3, "x");
                                        inst_y = ds_map_find_value(map3, "y");
                                        show_debug_message(string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                                    }
                                }
                            }
                            
                        }
                    }
                }
            }
            
        }
    }
    
}

