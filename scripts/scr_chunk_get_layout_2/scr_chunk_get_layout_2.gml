/// @descr scr_chunk_get_layout(index)
/// @param {any} index List of instances to return (optional)
/// @returns {real} ds_map


// choose a random layout
var idx = irandom(5); // 0 - 5

// if requesting a specific layout
if (argument_count == 1)
{
    idx = argument[0];
}

// create a ds_map to return
var rtn = ds_map_create();

// get the list of instances
var inst_list = ds_list_create();
if (global.LAYOUT_INSTANCES_MAP != noone)
{
    var str = ds_map_find_value(global.LAYOUT_INSTANCES_MAP, string(idx));
    if ( ! is_undefined(str))
    {
        ds_list_read(inst_list, str);
    }
    else
    {
        var str = ds_map_find_value(global.LAYOUT_INSTANCES_MAP, "default");
        if ( ! is_undefined(str))
        {
            ds_list_read(inst_list, str);
        }    
    }
}
ds_map_add_list(rtn, "instances", inst_list);

// get the list of tiles
var tile_list = ds_list_create();
if (global.LAYOUT_TILES_MAP != noone)
{
    var str = ds_map_find_value(global.LAYOUT_TILES_MAP, string(idx));
    if ( ! is_undefined(str))
    {
        ds_list_read(tile_list, str);
    }
    else
    {
        var str = ds_map_find_value(global.LAYOUT_TILES_MAP, "default");
        if ( ! is_undefined(str))
        {
            ds_list_read(tile_list, str);
        }
    }
}
ds_map_add_list(rtn, "tiles", tile_list);


// capture the layout index
rtn[? "idx"] = idx;

return rtn;
