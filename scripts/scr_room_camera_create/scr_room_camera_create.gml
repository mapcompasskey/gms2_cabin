/// @descr scr_room_camera_create()


// get window size
var window_width = global.WINDOW_WIDTH;
var window_height = global.WINDOW_HEIGHT;

// camera size
camera_width = (window_width / global.VIEW_SCALE);
camera_height = (window_height / global.VIEW_SCALE);
camera_half_width = (camera_width / 2)
camera_half_height = (camera_height / 2);

// target/view boundaries
var border_x = (camera_width / 2);
var border_y = (camera_height / 2);

// if the camera already exist
if (global.ROOM_CAMERA_RESOURCE == noone)
{
    // create the camera
    camera = camera_create();
}
else
{
    // get the camera
    camera = global.ROOM_CAMERA_RESOURCE;
}

// update camera properties
camera_set_view_pos(camera, 0, 0);
camera_set_view_size(camera, camera_width, camera_height);
camera_set_view_angle(camera, 0);
camera_set_view_speed(camera, -1, -1);
camera_set_view_target(camera, -1);
camera_set_view_border(camera, border_x, border_y);

// set the camera to a view port
view_enabled = true;
view_index = 0;
view_set_camera(view_index, camera);
view_set_visible(view_index, true);

// set the size of the view port
var view_width = window_width;
var view_height = window_height;
view_set_wport(view_index, view_width);
view_set_hport(view_index, view_height);

// set the view ports position
view_set_xport(view_index, 0);
view_set_yport(view_index, 0);

// movement variables
camera_x = 0;
camera_y = 0;
previous_camera_x = 0;
previous_camera_y = 0;
target_x = 0;
target_y = 0;
snap_to_target = true;

// camera boundaries
camera_min_x = 0;
camera_min_y = 0;
camera_max_x = (room_width - camera_width);
camera_max_y = (room_height - camera_height);

// update globals
global.PLAYER_CAMERA = id;
global.ROOM_CAMERA_RESOURCE = camera;
