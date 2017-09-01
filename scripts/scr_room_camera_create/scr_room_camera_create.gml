/// @descr scr_room_camera_create()

view_enabled = true;
view_index = 0;
var window_width = global.WINDOW_WIDTH;
var window_height = global.WINDOW_HEIGHT;

// camera size
camera_width = (window_width / global.VIEW_SCALE);
camera_height = (window_height / global.VIEW_SCALE);

// create the camera
var border_x = (camera_width / 2);
var border_y = (camera_height / 2);
camera = camera_create_view(0, 0, camera_width, camera_height, 0, -1, -1, -1, border_x, border_y);

// set the camera to a view port
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

// camera boundaries
camera_min_x = 0;
camera_min_y = 0;
camera_max_x = (room_width - camera_width);
camera_max_y = (room_height - camera_height);

// movement variables
target_x = 0;
target_y = 0;
snap_to_target = true;

// update globals
global.ROOM_CAMERA = id;
global.PLAYER_CAMERA = id;
