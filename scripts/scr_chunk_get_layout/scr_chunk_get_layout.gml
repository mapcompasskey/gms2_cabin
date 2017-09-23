/// @descr scr_chunk_get_layout(index)
/// @param {any} index List of instances and tiles to return
/// @returns {real} ds_map


// get the layout index
var idx = argument[0];

// create the return ds_map
var rtn = ds_map_create();


//
// Get the Instances List String
//

var instances_list_string = "";

if (global.STORE_LAYOUT_DATA)
{
    if (global.LAYOUT_INSTANCES_MAP != noone)
    {
        var str = ds_map_find_value(global.LAYOUT_INSTANCES_MAP, string(idx));
        if ( ! is_undefined(str))
        {
            if (string_length(str) > 1)
            {
                instances_list_string = str;
            }
        }
        
        if (string_length(instances_list_string) < 1)
        {
            var str = ds_map_find_value(global.LAYOUT_INSTANCES_MAP, "default");
            if ( ! is_undefined(str))
            {
                if (string_length(str) > 1)
                {
                    instances_list_string = str;
                }
            }
        }
        
    }
}
else
{
    instances_list_string = scr_chunk_get_layout_instances(string(idx));
}

rtn[? "instances"] = instances_list_string;


//
// Get the Tiles List String
//

var tiles_list_string = "";

if (global.STORE_LAYOUT_DATA)
{
    if (global.LAYOUT_TILES_MAP != noone)
    {
        var str = ds_map_find_value(global.LAYOUT_TILES_MAP, string(idx));
        if ( ! is_undefined(str))
        {
            if (string_length(str) > 1)
            {
                tiles_list_string = str;
            }
        }
        
        if (string_length(tiles_list_string) < 1)
        {
            var str = ds_map_find_value(global.LAYOUT_TILES_MAP, "default");
            if ( ! is_undefined(str))
            {
                if (string_length(str) > 1)
                {
                    tiles_list_string = str;
                }
            }
        }
        
    }
}
else
{
    tiles_list_string = scr_chunk_get_layout_tiles(string(idx));
}

rtn[? "tiles"] = tiles_list_string;


//
// Return the DS Map
//

return rtn;
