/// @descr scr_room_world_created()


//
// Clear the Application Surface
//

// with multiple camera - the previous scene is visible
surface_set_target(application_surface);
//draw_clear(global.WORLD_BG_COLOR);
draw_clear(c_black);
surface_reset_target();


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
layer_depth(global.GROUND_LAYER_ID, (dpth - 100));
layer_depth(global.INSTANCES_LAYER_ID, (dpth - 200));
layer_depth(global.CONTROLLERS_LAYER_ID, (dpth - 300));


//
// Set the Background Color
//

var layer_background_id = layer_background_get_id(global.BACKGROUND_LAYER_ID);
layer_background_blend(layer_background_id, global.WORLD_BG_COLOR);


//
// Create the Cameras
//

instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_world_camera);
instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_world_camera_2);


//
// Create the HUD
//

instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_hud);


//
// Create the World controller
//

instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_world);


//
// Create the Instance Sorter
//

instance_create_layer(0, 0, global.INSTANCES_LAYER_ID, obj_instance_sorter);


//
// Misc
//

/*
// add deer
var pos_x, pos_y;
for (var i = 0; i < 100; i++)
{
    pos_x = (room_width / 2) + random(200) - 100;
    pos_y = (room_height / 2) + random(200) - 100;
    instance_create_layer(pos_x, pos_y, global.INSTANCES_LAYER_ID, obj_deer);
}
*/

// add cross to center of the room
instance_create_layer(room_width/2, room_height/2, global.INSTANCES_LAYER_ID, obj_cross);

