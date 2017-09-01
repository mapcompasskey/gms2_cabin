/// @descr scr_world_camera_end_step()


var camera_x = target_x - (camera_width * 0.5);
var camera_y = target_y - (camera_height * 0.5);

//camera_x = round(camera_x);
//camera_y = round(camera_y);

// update the view position
camera_set_view_pos(camera, camera_x, camera_y);
