/// @descr scr_world_camera_2_create()

view_index = 1;
view_enabled = true;
var window_width = (global.WINDOW_WIDTH / 2);
var window_height = global.WINDOW_HEIGHT;

// create the camera
var camera_width = room_width;
var camera_height = room_height;
camera = camera_create_view(0, 0, camera_width, camera_height, 0, -1, -1, -1, 0, 0);

// set the camera to a view port
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
global.WORLD_CAMERA_2 = camera;
