/// @descr scr_room_cabin_created()


//
// Set the Background Color
//

var layer_id = layer_get_id(ROOM_LAYER_BACKGROUND);
var layer_background_id = layer_background_get_id(layer_id);
layer_background_blend(layer_background_id, global.ROOM_BG_COLOR);


//
// Create the Camera
//

instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_room_camera);


//
// Create the HUD
//

instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_hud);

