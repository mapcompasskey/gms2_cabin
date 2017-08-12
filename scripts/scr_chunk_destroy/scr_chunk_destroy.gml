/// @descr scr_chunk_destroy()

if (is_array(instance_list))
{
    var inst;
    
    // destroy all the instances created by this chunk
    for (var i = 0; i < array_length_1d(instance_list); i++)
    {
        inst = instance_list[i];
        with (inst)
        {
            instance_destroy();
        }
    }
}
