/// @descr scr_room_cabin_created()


//
// Set the Background Color
//

var layer_id = layer_get_id(ROOM_LAYER_BACKGROUND);
var layer_background_id = layer_background_get_id(layer_id);
layer_background_blend(layer_background_id, global.BG_COLOR);


//
// Create the Camera
//

// destroy the previous camera
if (global.CAMERA_0 != noone)
{
    scr_output("camera_destroy", camera_destroy(global.CAMERA_0));
    global.CAMERA_0 = noone;
}

// build a camera
var camera_width = (global.WINDOW_WIDTH / global.VIEW_SCALE);
var camera_height = (global.WINDOW_HEIGHT / global.VIEW_SCALE);
var camera_border_x = (camera_width / 2);
var camera_border_y = (camera_height / 2);
var camera = camera_create_view(0, 0, camera_width, camera_height, 0, -1, -1, -1, camera_border_x, camera_border_y);

// set the camera to a view
view_enabled = true;
view_set_camera(0, camera);
view_set_wport(0, camera_width);
view_set_hport(0, camera_height);
view_set_visible(0, true);

// update globals
global.CAMERA_0 = camera;


//
// Create the HUD
//

instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_hud);

