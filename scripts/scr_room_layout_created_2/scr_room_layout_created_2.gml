/// @descr scr_room_layout_create()


/*
Loop through each layer in the room and check whether the layer's name starts with a keyword.
Build a list of object data and store the information into a global ds_map that can be used to rebuild the layers.
*/

// layer keywords
var instances_layer_string = "Instances";
var tiles_layer_string = "Tiles";

var layer_name;
var layer_string_pos;
var elements;
var element_id;

var i1, i2;
var offset_x = 0;
var offset_y = 0;

var name_of_room = room_get_name(room);

// get all the layers in this room
var layers = layer_get_all();


//
// Get Instances
//

/*
If the layer's name starts with the instances keyword, iterate over the layer looking for objects.
Capture information about each instance into a ds_map, convert it to a string using ds_map_write, and then add it to a ds_list of instances on that layer.
Convert the ds_list of instances into a string using ds_list_write and then add it to a global ds_map.

Search for a "chunk size" object that is used to determine the offset position for each instance on layer.
The instance_map will be converted to a string using ds_map_write(), which can be converted back to a ds_map using ds_map_read().

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

    instance_create_layer(inst_x, inst_y, global.INSTANCES_LAYER_ID, asset_get_index(inst_object_name));

*/

// the object that sets the instance offset for a layer
var chunk_size_object_name = "obj_chunk_size";

var layout_instances_map = ds_map_create();

var instances_list = ds_list_create();
var instances_list_idx = 0;
var instances_list_string;

var instance_map = ds_map_create();
var instance_map_string;

var inst;
var inst_object_name;
var inst_x, inst_y;

if (array_length_1d(layers))
{
    // iterate through each layer in the room
    for (i1 = 0; i1 < array_length_1d(layers); i1++)
    {
        // get the layer's name
        layer_name = layer_get_name(layers[i1]);
        //show_debug_message("\n-----\n");
        //show_debug_message("Layer: " + string(layer_name));
        
        // check if the name starts with the instances layer string
        layer_string_pos = string_pos(instances_layer_string, layer_name);
        if (layer_string_pos == 1)
        {
            // create a new ds_list for the instances on this layer
            instances_list = ds_list_create();
            instances_list_idx = 0;
            
            // get all the elements on this layer
            elements = layer_get_all_elements(layers[i1]);
            //show_debug_message("# of elements: " + string(array_length_1d(elements)));
            
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
                    //show_debug_message(string(inst) + ", " + string(inst_object_name) + ", " + string(inst_x) + " " + string(inst_y));
                    
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
                    
                    // convert the instance map data to a string and add it to the list
                    instances_list[| instances_list_idx] = ds_map_write(instance_map);
                    instances_list_idx++
                    
                    // destroy the map data
                    ds_map_destroy(instance_map);
                    
                }
            }
            
            // if the instance list isn't empty
            if (ds_list_size(instances_list))
            {
                // loop through all the instances and offset their x and y positions
                for (i2 = 0; i2 < ds_list_size(instances_list); i2++)
                {
                    // get the instance data string
                    instance_map_string = instances_list[| i2];
                    
                    // read the map data structure from a string
                    instance_map = ds_map_create();
                    ds_map_read(instance_map, instance_map_string);
                    
                    inst_x = instance_map[? "x"];
                    inst_y = instance_map[? "y"];
                    
                    instance_map[? "x"] = (inst_x - offset_x);
                    instance_map[? "y"] = (inst_y - offset_y);
                    
                    // convert the instance map data to a string and add it back to the list
                    instances_list[| i2] =  ds_map_write(instance_map);
                    
                    // destroy the map data
                    ds_map_destroy(instance_map);
                }
                
                // convert the instance list to a string
                instances_list_string = ds_list_write(instances_list);
                
                // add the instances string to the instances layer map
                switch (layer_name)
                {
                    case "Instances_Tower_02":
                        layout_instances_map[? "tower_2"] = instances_list_string;
                        break;
                                
                    case "Instances_Tower_01":
                        layout_instances_map[? "tower_1"] = instances_list_string;
                        break;
                                
                    case "Instances_Cabin_01":
                        layout_instances_map[? "cabin_1"] = instances_list_string;
                        break;
                                
                    case "Instances_Trees_05":
                        layout_instances_map[? "5"] = instances_list_string;
                        break;
                                
                    case "Instances_Trees_04":
                        layout_instances_map[? "4"] = instances_list_string;
                        break;
                                
                    case "Instances_Trees_03":
                        layout_instances_map[? "3"] = instances_list_string;
                        break;
                                
                    case "Instances_Trees_02":
                        layout_instances_map[? "2"] = instances_list_string;
                        break;
                                
                    case "Instances_Trees_01":
                        layout_instances_map[? "1"] = instances_list_string;
                        break;
                                
                    case "Instances_Trees_00":
                        layout_instances_map[? "0"] = instances_list_string;
                        break;
                }
                
            }
            
            // destroy the instance list
            ds_list_destroy(instances_list);
            
        }
        
    }
    
}

// store the instances map id in a global
global.LAYOUT_INSTANCES_MAP = layout_instances_map;

/** /
// load instance data
var instance_list_string = global.LAYOUT_INSTANCES_MAP[? "0"];
var instance_list = ds_list_create();
ds_list_read(instance_list, instance_list_string );

scr_output("-----");
scr_output("Reading Instances from \"0\"");
scr_output("Instances Count", ds_list_size(instance_list));

for (var i1 = 0; i1 < ds_list_size(instance_list); i1++)
{
    var instance_map_string = instance_list[| i1];
    
    var instance_map = ds_map_create();
    ds_map_read(instance_map, instance_map_string);
    
    var size = ds_map_size(instance_map);
    var key = ds_map_find_first(instance_map);
    
    scr_output("-----");
    for (var i2 = 0; i2 < size; i2++;)
    {
        scr_output(key, instance_map[? key]);
        key = ds_map_find_next(instance_map, key);
    }
    
    ds_map_destroy(instance_map);
}

ds_list_destroy(instance_list);
/**/

        
//
// Get Tiles
//

/*
TILES:

If the layer's name starts with the tiles keyword, iterate over the layer looking for tiles.
Capture information about each tile into a ds_map, convert it to a string using ds_map_write, and then add it to a ds_list of tiles on that layer.
Convert the ds_list of tiles into a string using ds_list_write and then add it to a global ds_map.

The tilemap layer will cover the entire room, so while iterating over tiles, its looking for the first non-zero tile to use as the x and y offset.
Only non-zero tiles are recorded.
So make sure the tilemap contains tiles only in the desired area.
*I can set the layer's offset x and y - so that might be a more reliable solution

TILE PROPERTIES:
    tile_map[? "tile_index"]
    tile_map[? "x"]
    tile_map[? "y"]

*/

var layout_tiles_map = ds_map_create();

var tiles_list = ds_list_create();
var tiles_list_idx = 0;
var tiles_list_string;

var tile_map = ds_map_create();

var tile_data;
var tile_index;
var tile_x, tile_y;
var tile_cell_x, tile_cell_y;

if (array_length_1d(layers))
{
    // iterate through each layer in the room
    for (i1 = 0; i1 < array_length_1d(layers); i1++)
    {
        // get the layer's name
        layer_name = layer_get_name(layers[i1]);
        //show_debug_message("\n-----\n");
        //show_debug_message("Layer: " + string(layer_name));
        
        // check if the name starts with the tiles layer string
        layer_string_pos = string_pos(tiles_layer_string, layer_name);
        if (layer_string_pos == 1)
        {
            // create a new ds_list for the tiles on this layer
            tiles_list = ds_list_create();
            tiles_list_idx = 0;
            
            // get all the elements on this layer
            elements = layer_get_all_elements(layers[i1]);
            //show_debug_message("# of elements: " + string(array_length_1d(elements)));
            
            // there should only be one element in the array
            if (array_length_1d(elements) == 1)
            {
                element_id = elements[0];
                if (layer_get_element_type(element_id) == layerelementtype_tilemap)
                {
                    var tile_width = tilemap_get_width(element_id);
                    var tile_height = tilemap_get_height(element_id);
                    //show_debug_message("tilemap: " + string(element_id));
                    //show_debug_message(string(tile_width) + ", " + string(tile_height));
                    
                    // *can't get the name of the tile set
                    //var tileset = tilemap_get_tileset(element_id);
                    //show_debug_message("tileset: " + string(tileset) + ", " + string(object_get_name(tileset)));
                    
                    offset_x = -1;
                    offset_y = -1;
                    
                    for (tile_x = 0; tile_x < tile_width; tile_x++)
                    {
                        for (tile_y = 0; tile_y < tile_height; tile_y++)
                        {
                            // get the tile data
                            tile_data = tilemap_get(element_id, tile_x, tile_y);
                            tile_index = tile_get_index(tile_data);
                            if (tile_index != 0)
                            {
                                // if found the first non-zero tile
                                if (offset_x == -1 && offset_y == -1)
                                {
                                    offset_x = tile_x;
                                    offset_y = tile_y;
                                }
                                
                                tile_cell_x = (tile_x - offset_x);
                                tile_cell_y = (tile_y - offset_y);
                                //show_debug_message("tile: " + string(tile_cell_x) + ", " + string(tile_cell_y) + ", " + string(tile_index));
                                
                                // capture the tile data into a ds_map
                                tile_map = ds_map_create();
                                tile_map[? "tile_index"] = tile_index;
                                tile_map[? "x"] = tile_cell_x;
                                tile_map[? "y"] = tile_cell_y;
                                
                                // convert the tile map data to a string and add it to the list
                                tiles_list[| tiles_list_idx] = ds_map_write(tile_map);
                                tiles_list_idx++
                                
                                // destroy the map data
                                ds_map_destroy(tile_map);
                                
                            }
                            
                        }
                    }
                    
                }
            }
            
            // if the tile list isn't empty
            if (ds_list_size(tiles_list))
            {
                // convert the tiles list to a string
                tiles_list_string = ds_list_write(tiles_list);
                
                // add the tile list to the tiles layer map
                switch (layer_name)
                {
                    case "Tiles_Tower_02":
                        layout_tiles_map[? "tower_2"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Tower_01":
                        layout_tiles_map[? "tower_1"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Cabin_01":
                        layout_tiles_map[? "cabin_1"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Trees_05":
                        layout_tiles_map[? "5"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Trees_04":
                        layout_tiles_map[? "4"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Trees_03":
                        layout_tiles_map[? "3"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Trees_02":
                        layout_tiles_map[? "2"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Trees_01":
                        layout_tiles_map[? "1"] = tiles_list_string;
                        break;
                                
                    case "Tiles_Trees_00":
                        layout_tiles_map[? "0"] = tiles_list_string;
                        break;
                }
                
            }
            
            // destroy the list
            ds_list_destroy(tiles_list);
            
        }
        
    }
    
}

// store the tiles map id in a global
global.LAYOUT_TILES_MAP = layout_tiles_map;

/** /
// load tile data
var tile_list_string = global.LAYOUT_TILES_MAP[? "0"];
var tile_list = ds_list_create();
ds_list_read(tile_list, tile_list_string);

scr_output("-----");
scr_output("Reading Tiles from \"0\"");
scr_output("Tiles Count", ds_list_size(tile_list));

for (var i1 = 0; i1 < ds_list_size(tile_list); i1++)
{
    var tile_map_string = tile_list[| i1];
    
    var tile_map = ds_map_create();
    ds_map_read(tile_map, tile_map_string);
    
    var size = ds_map_size(tile_map);
    var key = ds_map_find_first(tile_map);
    
    scr_output("-----");
    for (var i2 = 0; i2 < size; i2++;)
    {
        scr_output(key, tile_map[? key]);
        key = ds_map_find_next(tile_map, key);
    }
    
    ds_map_destroy(tile_map);
}

ds_list_destroy(tile_list);
/**/


// goto the next room
room_goto_next();

