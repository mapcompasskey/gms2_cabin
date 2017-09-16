/// @descr scr_chunk_step()


//
// Create the Chunk
//

if (initialize_chunk)
{
    var layout_map;
    
    // check if this chunk's layout already exists
    if (global.WORLD_CHUNK_LAYOUTS_GRID != noone)
    {
        if (ds_exists(global.WORLD_CHUNK_LAYOUTS_GRID, ds_type_grid))
        {
            // get the layout index (default value is "noone")
            layout_index = ds_grid_get(global.WORLD_CHUNK_LAYOUTS_GRID, chunks_grid_x, chunks_grid_y);
        }
    }
    
    // if the layout index is not set
    if (layout_index == noone)
    {
        // get a random layout
        layout_map = scr_chunk_get_layout();
    }
    
    else
    {
        // get a specific layout
        layout_map = scr_chunk_get_layout(layout_index);        
    }
    
    if (ds_exists(layout_map, ds_type_map))
    {
        // update the layout index
        layout_index = layout_map[? "idx"];
        
        // get the list of instances
        var inst_list = layout_map[? "instances"];
        if (ds_exists(inst_list, ds_type_list))
        {
            var inst_list_size = ds_list_size(inst_list);
            if (inst_list_size)
            {
                var inst_string;
                var inst_object_name;
                var inst_x, inst_y;
                var instance_map ;
                var inst;
                
                // create the array and fill it with noone
                instances_array = array_create(inst_list_size, noone);
                
                for (var i = 0; i < inst_list_size; i++)
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
                            
                            /*
                            // skip if the "chunk size" object
                            if (inst_object_name == "obj_chunk_size")
                            {
                                continue;
                            }
                            */
                            
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
            
        }
        
        // get the list of tiles
        var  tile_list = layout_map[? "tiles"];
        if (ds_exists(tile_list, ds_type_list))
        {
            var tile_list_size = ds_list_size(tile_list);
            if (tile_list_size)
            {
                var tile_string;
                var tile_index;
                var tile_cell_x, tile_cell_y;
                var tile_map;
                var tile;
                
                // create the tilemap layer and the tilemap
                var background_layer_depth = layer_get_depth(ROOM_LAYER_BACKGROUND);
                tilemap_layer_id = layer_create((background_layer_depth - 10));
                tilemap_id = layer_tilemap_create(tilemap_layer_id, x, y, ts_ground, 10, 10);
                
                for (var i = 0; i < tile_list_size; i++)
                {
                    // get the tile data (as a string)
                    tile_string = tile_list[| i];
                    if (tile_string != "")
                    {
                        // convert the string to a ds_list
                        tile_map = ds_map_create();
                        ds_map_read(tile_map, tile_string);
                        if (ds_exists(tile_map, ds_type_map))
                        {
                            // get the object's properties
                            tile_index = tile_map[? "tile_index"];
                            tile_cell_x = instance_map[? "x"];
                            tile_cell_y = instance_map[? "y"];
                            
                            // add the tile
                            tilemap_set(tilemap_id, tile_index, tile_cell_x, tile_cell_y);
                        }
                        
                        // destroy the ds_map
                        ds_map_destroy(tile_map);
                        
                    }
                    
                }
                
            }
            
        }
        
        // destroy the ds_map (will destroy nested lists)
        ds_map_destroy(layout_map);
        
    }
    
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
