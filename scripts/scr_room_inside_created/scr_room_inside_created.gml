/// @descr scr_room_inside_created()


//
// Get the Layer IDs
//

// starting layer depth
// *minimum and maximum layer depths are -16000 to 16000 
var dpth = 1000;
global.BACKGROUND_LAYER_DEPTH = dpth;

// get/create the background layer
if (layer_get_id(ROOM_LAYER_BACKGROUND))
{
    global.BACKGROUND_LAYER_ID = layer_get_id(ROOM_LAYER_BACKGROUND);
}
else
{
    global.BACKGROUND_LAYER_ID = layer_create(dpth, ROOM_LAYER_BACKGROUND);
}

// get/create the tilemap layer
if (layer_get_id(ROOM_LAYER_TILEMAP))
{
    global.TILEMAP_LAYER_ID = layer_get_id(ROOM_LAYER_TILEMAP);
}
else
{
    global.TILEMAP_LAYER_ID = layer_create(dpth, ROOM_LAYER_TILEMAP);
}

// get/create the ground layer
if (layer_get_id(ROOM_LAYER_GROUND))
{
    global.GROUND_LAYER_ID = layer_get_id(ROOM_LAYER_GROUND);
}
else
{
    global.GROUND_LAYER_ID = layer_create(dpth, ROOM_LAYER_GROUND);
}

// get/create the instances layer
if (layer_get_id(ROOM_LAYER_INSTANCES))
{
    global.INSTANCES_LAYER_ID = layer_get_id(ROOM_LAYER_INSTANCES);
}
else
{
    global.INSTANCES_LAYER_ID = layer_create(dpth, ROOM_LAYER_INSTANCES);
}

// get/create the controllers layer
if (layer_get_id(ROOM_LAYER_CONTROLLERS))
{
    global.CONTROLLERS_LAYER_ID = layer_get_id(ROOM_LAYER_CONTROLLERS);
}
else
{
    global.CONTROLLERS_LAYER_ID = layer_create(dpth, ROOM_LAYER_CONTROLLERS);
}

// order the depth of each layer
layer_depth(global.BACKGROUND_LAYER_ID, dpth);
layer_depth(global.TILEMAP_LAYER_ID, (dpth - 100))
layer_depth(global.GROUND_LAYER_ID, (dpth - 200));
layer_depth(global.INSTANCES_LAYER_ID, (dpth - 300));
layer_depth(global.CONTROLLERS_LAYER_ID, (dpth - 400));


//
// Set the Background Color
//

var layer_background_id = layer_background_get_id(global.BACKGROUND_LAYER_ID);
layer_background_blend(layer_background_id, global.ROOM_BG_COLOR);


//
// Create the Camera
//

instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_room_camera);


//
// Create the HUD
//

instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_hud);


//
// Create the Instance Sorter
//

instance_create_layer(0, 0, global.INSTANCES_LAYER_ID, obj_instance_sorter);

