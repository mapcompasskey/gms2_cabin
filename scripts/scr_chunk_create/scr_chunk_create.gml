/// @descr scr_chunk_create()

// the index of the layout list
layout_index = irandom(5); // 0 - 5

// the list of instances
instances_array = noone;

// states
initialize_chunk = true;

// position in the world object's chunks grid
chunks_grid_x = noone;
chunks_grid_y = noone;

// the layer and tilemap
tilemap_layer_id = noone;
tilemap_id = noone;
