/// @descr scr_room_initialize_created()


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

/*
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
layer_depth(global.CONTROLLERS_LAYER_ID, (dpth - 100));
*/


//
// Add the Game Controller
//

// *doesn't matter what layer its on - it'll be reassigned when the room changes
//instance_create_layer(0, 0, global.CONTROLLERS_LAYER_ID, obj_game);
instance_create_layer(0, 0, global.BACKGROUND_LAYER_ID, obj_game);


//
// Goto the Next Room
//

room_goto_next();
