/// @descr scr_world_camera_2_create()


// get window size
var window_width = (global.WINDOW_WIDTH / 2);
var window_height = global.WINDOW_HEIGHT;

// camera size
camera_width = room_width;
camera_height = room_height;

// if the camera already exist
if (global.WORLD_CAMERA_2_RESOURCE == noone)
{
    // create the camera
    camera = camera_create();
}
else
{
    // get the camera
    camera = global.WORLD_CAMERA_2_RESOURCE;
}

// update camera properties
camera_set_view_pos(camera, 0, 0);
camera_set_view_size(camera, camera_width, camera_height);
camera_set_view_angle(camera, 0);
camera_set_view_speed(camera, -1, -1);
camera_set_view_target(camera, -1);
camera_set_view_border(camera, 0, 0);

// set the camera to a view port
view_enabled = true;
view_index = 1;
view_set_camera(view_index, camera);
view_set_visible(view_index, true);

// set the size of the view port
var camera_size_rate = 1;
if (camera_width > camera_height)
{
    camera_size_rate = window_width / camera_width;
}
else
{
    camera_size_rate = window_height / camera_height;
}
var view_width = camera_width * camera_size_rate;
var view_height = camera_height * camera_size_rate;
view_set_wport(view_index, view_width);
view_set_hport(view_index, view_height);

// set the view ports position (with offsets)
var view_x = window_width + ((window_width - view_width) / 2);
var view_y = 0 + ((window_height - view_height) / 2);
view_set_xport(view_index, view_x);
view_set_yport(view_index, view_y);

// update globals
global.WORLD_CAMERA_2_RESOURCE = camera;
