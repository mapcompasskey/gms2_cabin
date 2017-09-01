/// @descr scr_room_camera_end_step()


var camera_x = target_x - (camera_width * 0.5);
var camera_y = target_y - (camera_height * 0.5);

//camera_x = round(camera_x);
//camera_y = round(camera_y);

// restrict camera position
camera_x = clamp(camera_x, camera_min_x, camera_max_x);
camera_y = clamp(camera_y, camera_min_y, camera_max_y);

// update camera position
camera_set_view_pos(camera, camera_x, camera_y);
