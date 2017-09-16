/// @descr scr_chunk_destroy()


// destroy all the instances created by this chunk
if (is_array(instances_array))
{
    var inst;
    
    for (var i = 0; i < array_length_1d(instances_array); i++)
    {
        inst = instances_array[i];
        with (inst)
        {
            instance_destroy();
        }
    }
}

// destroy the tilemap
if (tilemap_id != noone)
{
    layer_tilemap_destroy(tilemap_id);
    tilemap_id = noone;
}

// destroy the tilemap layer
if (tilemap_layer_id != noone)
{
    layer_destroy(tilemap_layer_id);
    layertilemap_layer_id_id = noone;
}
