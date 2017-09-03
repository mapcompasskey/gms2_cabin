/// @descr scr_chunk_destroy()

if (is_array(instances_array))
{
    var inst;
    
    // destroy all the instances created by this chunk
    for (var i = 0; i < array_length_1d(instances_array); i++)
    {
        inst = instances_array[i];
        with (inst)
        {
            instance_destroy();
        }
    }
}
