/// @descr scr_room_world_created()


//
// Set the Background Color
//

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

// destroy the previous camera
if (global.CAMERA_0 != noone)
{
    scr_output("camera_destroy", camera_destroy(global.CAMERA_0));
    global.CAMERA_0 = noone;
}

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

// update globals
global.CAMERA_0 = camera_0;


//
// Create the Room Camera on View 1
//

// destroy the previous camera
if (global.CAMERA_1 != noone)
{
    scr_output("camera_destroy", camera_destroy(global.CAMERA_1));
    global.CAMERA_1 = noone;
}

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

// update globals
global.CAMERA_1 = camera_1;


//
// Create the HUD
//
instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_hud);


//
// Create the World controller
//
instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_world);


/*
// add deer
var pos_x, pos_y;
for (var i = 0; i < 100; i++)
{
    pos_x = (room_width / 2) + random(200) - 100;
    pos_y = (room_height / 2) + random(200) - 100;
    instance_create_layer(pos_x, pos_y, ROOM_LAYER_INSTANCES, obj_deer);
}
*/

// add cross to center of the room
instance_create_layer(room_width/2, room_height/2, ROOM_LAYER_INSTANCES, obj_cross);

