/// @descr scr_room_stage_created()


//
// Create the Camera
//

/*
// enable the use of views
view_enabled = true;

// make view 0 visible
view_set_visible(0, true);

// set the port bounds of view 0
view_set_wport(0, global.VIEW_WIDTH);
view_set_hport(0, global.VIEW_HEIGHT);

// set the background layer's background color
var layer_id = layer_get_id(ROOM_LAYER_BACKGROUND);
var layer_background_id = layer_background_get_id(layer_id);
layer_background_blend(layer_background_id, global.BG_COLOR);

// build a camera
var camera_width = view_get_wport(0);
var camera_height = view_get_hport(0);
var camera_border_x = (camera_width / 2);
var camera_border_y = (camera_height / 2);
var camera = camera_create_view(0, 0, camera_width, camera_height, 0, -1, -1, -1, camera_border_x, camera_border_y);

// assign the camera to view 0
view_set_camera(0, camera);

// set target 
//camera_set_view_target(camera, obj_player);
*/

/*
// basic camera set up
camera_set_view_pos(view_camera[0], 0, 0);
camera_set_view_size(view_camera[0], camera_width, camera_height);
camera_set_view_target(view_camera[0], obj_player);
camera_set_view_speed(view_camera[0], -1, -1);
camera_set_view_border(view_camera[0], camera_border_x, camera_border_y);
*/


// set the background layer's background color
var layer_id = layer_get_id(ROOM_LAYER_BACKGROUND);
var layer_background_id = layer_background_get_id(layer_id);
layer_background_blend(layer_background_id, global.BG_COLOR);


//
// Multiple Cameras
//

/*
    Create two cameras placed next to each in the game window.
    The first is the player camera that is zoomed in on and follows the player.
    The second camera displays the entire room, scaled down to proportionally fill the view.
*/

view_enabled = true;
var camera_width = (global.WINDOW_WIDTH / 2);
var camera_height = global.WINDOW_HEIGHT;


//
// Create the Player Camera on View 0
//

// create the camera
var camera_0_width = (camera_width / global.VIEW_SCALE);
var camera_0_height = (camera_height / global.VIEW_SCALE);
var camera_0_border_x = (camera_0_width / 2);
var camera_0_border_y = (camera_0_height / 2);
var camera_0 = camera_create_view(0, 0, camera_0_width, camera_0_height, 0, -1, -1, -1, camera_0_border_x, camera_0_border_y);

// set the camera to a view
var view_0_width = camera_width;
var view_0_height = camera_height;
view_set_camera(0, camera_0);
view_set_wport(0, view_0_width);
view_set_hport(0, view_0_height);
view_set_xport(1, 0);
view_set_yport(1, 0);
view_set_visible(0, true);


//
// Create the Room Camera on View 1
//

// create the camera
var camera_1_width = room_width;
var camera_1_height = room_height;
var camera_1 = camera_create_view(0, 0, camera_1_width, camera_1_height, 0, -1, -1, -1, 0, 0);

// scale the view to fit the camera
var camera_1_size_rate = 1;
if (camera_1_width > camera_1_height)
{
    camera_1_size_rate = camera_width / camera_1_width;
}
else
{
    camera_1_size_rate = camera_height / camera_1_height;
}
var view_1_width = camera_1_width * camera_1_size_rate;
var view_1_height = camera_1_height * camera_1_size_rate;

// x and y positions (with offsets)
var view_1_x = camera_width + ((camera_width - view_1_width) / 2);
var view_1_y = 0 + ((camera_height - view_1_height) / 2);

// set the camera to a view
view_set_camera(1, camera_1);
view_set_wport(1, view_1_width);
view_set_hport(1, view_1_height);
view_set_xport(1, view_1_x);
view_set_yport(1, view_1_y);
view_set_visible(1, true);


//
// Create the HUD
//
instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_hud);


//
// Create the World controller
//
//instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_world);
instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_world_2);


//
// Create the Player
//
if (global.PLAYER == noone)
{
    var player_x = room_width / 2;
    var player_y = room_height / 2;
    instance_create_layer(player_x, player_y, ROOM_LAYER_INSTANCES, obj_player);
}

