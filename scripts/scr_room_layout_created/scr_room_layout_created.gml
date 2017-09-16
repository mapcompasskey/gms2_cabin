/// @descr scr_room_layout_create()


// if not getting and outputting the layout room data
if ( ! global.OUTPUT_LAYOUT_DATA)
{
    // goto the next Room
    room_goto_next();
}


/*
Loop through each layer in the room and check whether the layer's name starts with a keyword.
Build a list of object data and output the information as code that be copied and pasted directly into a GML script for rebuilding the layers.
*/

/*
INSTANCES:

If the layer's name starts with the instances keyword, iterate over the layer looking for objects.
Capture information about each instance into a ds_map and add it to a ds_list of instances on that layer.
Add that layer list to a ds_list of all the instance layers in the room.

Search for a "chunk size" object that is used to determine the offset position for each instance on layer.
The instance_map will be converted to a string using ds_map_write(), which can be converted back to a ds_map using ds_map_read().

INSTANCE LAYER LIST/MAP:
    Layers - instances_layer_list
    
        Layer 1 - instance_list
            Object 1 - instance_map
            
        Layer 2 - instance_list
            Object 1 - instance_map
            Object 2 - instance_map
            Object 2 - instance_map
            
        Layer 3 - instance_list
            Object 1 - instance_map
            Object 3 - instance_map


INSTANCE PROPERTIES:
    instance_map[? "object_name"]
    instance_map[? "x"]
    instance_map[? "y"]

ADDITIONAL DOOR PROPERTIES:
    instance_map[? "image_xscale"]
    instance_map[? "image_Yscale"]
    instance_map[? "door_id"]


RECREATING AN INSTANCE:
Use the object_name to find the object_index when the game loads, then use that index to create the instance.
Game Maker assigns the object_index when the game is compiled and will change during development as new objects are added.

    instance_create_layer(inst_x, inst_y, ROOM_LAYER_INSTANCES, asset_get_index(inst_object_name));


EXAMPLE GML OUTPUT:
    
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

*/

/*
TILES:

If the layer's name starts with the tiles keyword, iterate over the layer's tilemap looking for tiles.
Capture information about each tile into a ds_map and add it to a ds_list of tiles on that layer.
Add that layer list to a ds_list of all the tile layers in the room.

The tilemap layer will cover the entire room, so while iterating over tiles, its looking for the first non-zero tile to use as the x and y offset.
Only non-zero tiles are recorded.
So make sure the tilemap contains tiles only in the desired area.
*I can set the layer's offset x and y - so that might be a more reliable solution

TILE LAYER LIST/MAP:
    Layers - tiles_layer_list
    
        Layer 1 - tile_list
            Tile 1 - tile_map
            Tile 2 - tile_map
            Tile 1 - tile_map
            Tile 3 - tile_map
            
        Layer 2 - tile_list
            Tile 1 - tile_map
            Tile 2 - tile_map
            Tile 3 - tile_map


TILE PROPERTIES:
    tile_map[? "tile_index"]
    tile_map[? "x"]
    tile_map[? "y"]


EXAMPLE GML OUTPUT:

    // rm_layout_1 - Tiles_Trees_01
    case 1:
        ds_list_add(tile_list, "9201000003000000010000000A00000074696C655F696E646578000000000000000000000040010000000100000078000000000000000000000000010000000100000079000000000000000000000000"); // tile: 2
        ds_list_add(tile_list, "9201000003000000010000000A00000074696C655F696E64657800000000000000000000084001000000010000007800000000000000000000000001000000010000007900000000000000000000F03F"); // tile: 3
        break;
        
    // rm_layout_1 - Tiles_Trees_00
    case 0:
        ds_list_add(tile_list, "9201000003000000010000000A00000074696C655F696E64657800000000000000000000F03F010000000100000078000000000000000000000000010000000100000079000000000000000000000000"); // tile: 1
        ds_list_add(tile_list, "9201000003000000010000000A00000074696C655F696E64657800000000000000000000F03F01000000010000007800000000000000000000000001000000010000007900000000000000000000F03F"); // tile: 1
        ds_list_add(tile_list, "9201000003000000010000000A00000074696C655F696E64657800000000000000000000F03F010000000100000078000000000000000000000000010000000100000079000000000000000000000040"); // tile: 1
        break;
                      
*/

// layer keywords
var instances_layer_string = "Instances";
var tiles_layer_string = "Tiles";

// the object that sets the instance offset for a layer
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

var instances_layer_name_list = ds_list_create();
var instances_layer_list = ds_list_create();
var instances_layer_size = 0;
var instances_layer_list_idx = 0;
var instance_list = ds_list_create();
var instance_list_idx = 0;
var instance_map = ds_map_create();
var instance_map_string; // ds_map_write()

var tiles_layer_name_list = ds_list_create();
var tiles_layer_list = ds_list_create();
var tiles_layer_size = 0;
var tiles_layer_list_idx = 0;
var tile_list = ds_list_create();
var tile_list_idx = 0;
var tile_map = ds_map_create();
var tile_map_string; // ds_map_write();

var name_of_room = room_get_name(room);

// get all the layers in this room
var layers = layer_get_all();
if (array_length_1d(layers))
{
    show_debug_message("\n-----\n");
    show_debug_message("START LAYER SCAN");
    
    // iterate through each layer in the room
    for (i1 = 0; i1 < array_length_1d(layers); i1++)
    {
        // get the layer's name
        layer_name = layer_get_name(layers[i1]);
        show_debug_message("\n-----\n");
        show_debug_message("Layer: " + string(layer_name));
        
        
        //
        // Get Instances
        //
        
        // check if the name starts with the instances layer string
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
                instances_layer_list[| instances_layer_list_idx] = instance_list;
                ds_list_mark_as_list(instances_layer_list, instances_layer_list_idx);
                
                // add the layer name to the layer name list at the same index
                instances_layer_name_list[| instances_layer_list_idx] = layer_name;
                
                // increment the layer list index
                instances_layer_list_idx++;
            }
            
            // else, destroy the empty list
            else
            {
                ds_list_destroy(instance_list);
            }
            
        }
        
        
        //
        // Get Tiles
        //
        
        // check if the name starts with the tiles layer string
        layer_string_pos = string_pos(tiles_layer_string, layer_name);
        if (layer_string_pos == 1)
        {
            // create a new ds_list for the tiles on this layer
            tile_list = ds_list_create();
            tile_list_idx = 0;
            
            // get all the elements on this layer
            elements = layer_get_all_elements(layers[i1]);
            show_debug_message("# of elements: " + string(array_length_1d(elements)));
            
            // there should only be one element in the array
            if (array_length_1d(elements) == 1)
            {
                element_id = elements[0];
                if (layer_get_element_type(element_id) == layerelementtype_tilemap)
                {
                    var tile_width = tilemap_get_width(element_id);
                    var tile_height = tilemap_get_height(element_id);
                    show_debug_message("tilemap: " + string(element_id));
                    show_debug_message(string(tile_width) + ", " + string(tile_height));
                    
                    // *can't get the name of the tile set
                    //var tileset = tilemap_get_tileset(element_id);
                    //show_debug_message("tileset: " + string(tileset) + ", " + string(object_get_name(tileset)));
                    
                    offset_x = -1;
                    offset_y = -1;
                    
                    for (var tile_x = 0; tile_x < tile_width; tile_x++)
                    {
                        for (var tile_y = 0; tile_y < tile_height; tile_y++)
                        {
                            // get the tile data
                            var tile_data = tilemap_get(element_id, tile_x, tile_y);
                            var tile_index = tile_get_index(tile_data);
                            if (tile_index != 0)
                            {
                                // if found the first non-zero tile
                                if (offset_x == -1 && offset_y == -1)
                                {
                                    offset_x = tile_x;
                                    offset_y = tile_y;
                                }
                                
                                var tile_cell_x = (tile_x - offset_x);
                                var tile_cell_y = (tile_y - offset_y);
                                show_debug_message("tile: " + string(tile_cell_x) + ", " + string(tile_cell_y) + ", " + string(tile_index));
                                
                                // capture the tile data into a ds_map
                                tile_map = ds_map_create();
                                tile_map[? "tile_index"] = tile_index;
                                tile_map[? "x"] = tile_cell_x;
                                tile_map[? "y"] = tile_cell_y;
                                
                                // add the tile map to the list
                                tile_list[| tile_list_idx] = tile_map;
                                ds_list_mark_as_map(tile_list, tile_list_idx);
                                tile_list_idx++
                                
                            }
                            
                        }
                    }
                    
                }
            }
            
            // if the tile list isn't empty
            if (ds_list_size(tile_list))
            {
                // add the tile list to the tiles layer list
                tiles_layer_list[| tiles_layer_list_idx] = tile_list;
                ds_list_mark_as_list(tiles_layer_list, tiles_layer_list_idx);
                
                // add the layer name to the tiles layer name list at the same index
                tiles_layer_name_list[| tiles_layer_list_idx] = layer_name;
                
                // increment the tiles layer list index
                tiles_layer_list_idx++;
            }
            
            // else, destroy the empty list
            else
            {
                ds_list_destroy(tile_list);
            }
            
        }
        
    }
    
    show_debug_message("\n-----\n");
    show_debug_message("END LAYER SCAN");
    
    
    //
    // Output Instances Data
    //
    
    // if the instances layer list is not empty
    instances_layer_size = ds_list_size(instances_layer_list);
    if (instances_layer_size)
    {
        // output file start
        show_debug_message("\n-----\n");
        show_debug_message("START GML INSTANCES OUTPUT");
        show_debug_message("\n-----\n");
        
        for (i1 = 0; i1 < instances_layer_size; i1++)
        {
            instance_list = instances_layer_list[| i1];
            if ( ! is_undefined(instance_list))
            {
                if (ds_exists(instance_list, ds_type_list))
                {
                    if (ds_list_size(instance_list))
                    {
                        // output layer name
                        show_debug_message("    // " + string(name_of_room) + " - " + string(instances_layer_name_list[| i1]));
                        
                        // output case declaration
                        switch (instances_layer_name_list[| i1])
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
        show_debug_message("\n-----\n");
        show_debug_message("END GML INSTANCES OUTPUT");
    }
    
    
    //
    // Output Tiles Data
    //
    
    // if the tiles layer list is not empty
    tiles_layer_size = ds_list_size(tiles_layer_list);
    if (tiles_layer_size)
    {
        // output file start
        show_debug_message("\n-----\n");
        show_debug_message("START GML TILES OUTPUT");
        show_debug_message("\n-----\n");
        
        for (i1 = 0; i1 < tiles_layer_size; i1++)
        {
            tile_list = tiles_layer_list[| i1];
            if ( ! is_undefined(tile_list))
            {
                if (ds_exists(tile_list, ds_type_list))
                {
                    if (ds_list_size(tile_list))
                    {
                        // output layer name
                        show_debug_message("    // " + string(name_of_room) + " - " + string(tiles_layer_name_list[| i1]));
                        
                        // output case declaration
                        switch (tiles_layer_name_list[| i1])
                        {
                            case "Tiles_Tower_02":
                                show_debug_message("    case \"tower_2\":");
                                break;
                                
                            case "Tiles_Tower_01":
                                show_debug_message("    case \"tower_1\":");
                                break;
                                
                            case "Tiles_Cabin_01":
                                show_debug_message("    case \"cabin_1\":");
                                break;
                                
                            case "Tiles_Trees_05":
                                show_debug_message("    case 5:");
                                break;
                                
                            case "Tiles_Trees_04":
                                show_debug_message("    case 4:");
                                break;
                                
                            case "Tiles_Trees_03":
                                show_debug_message("    case 3:");
                                break;
                                
                            case "Tiles_Trees_02":
                                show_debug_message("    case 2:");
                                break;
                                
                            case "Tiles_Trees_01":
                                show_debug_message("    case 1:");
                                break;
                                
                            case "Tiles_Trees_00":
                                show_debug_message("    case 0:");
                                break;
                                
                            default:
                                show_debug_message("    case \"unknown\":");
                        }
                        
                        // encode and output each tile list as a string that can be decoded back into a ds_map
                        for (i2 = 0; i2 < ds_list_size(tile_list); i2++)
                        {
                            tile_map = tile_list[| i2];
                            if ( ! is_undefined(tile_map))
                            {
                                if (ds_exists(tile_map, ds_type_map))
                                {
                                    tile_map_string = ds_map_write(tile_map);
                                    tile_index = tile_map[? "tile_index"];
                                    show_debug_message("        ds_list_add(tile_list, \"" + string(tile_map_string) + "\"); // tile: " + string(tile_index));
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
        show_debug_message("\n-----\n");
        show_debug_message("END GML TILES OUTPUT");
    }
    
    show_debug_message("\n-----\n");
    
    // destroy the lists
    ds_list_destroy(instances_layer_name_list);
    ds_list_destroy(instances_layer_list);
    ds_list_destroy(tiles_layer_name_list);    
    ds_list_destroy(tiles_layer_list);
    
}

// close the application
game_end();

