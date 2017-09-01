/// @descr scr_world_camera_end_step()

// save the current position
previous_camera_x = camera_x;
previous_camera_y = camera_y;

// move to the target position
camera_x = (target_x - camera_half_width);
camera_y = (target_y - camera_half_height);

// if the camera should transition towards the target
if ( ! snap_to_target)
{
    // find the distance between the camera and the target
    var distance_min = 1;
    var distance_max = point_distance(0, 0, camera_half_width, camera_half_height);
    var target_distance = point_distance(previous_camera_x, previous_camera_y, (target_x - camera_half_width), (target_y - camera_half_height));
    
    // if the distance is within bounds
    if (target_distance > distance_min && target_distance < distance_max)
    {
        // the interpolation rate
        var rate = 0.5;
        
        // interpolate the camera position to the new, relative position
        camera_x = lerp(previous_camera_x, target_x - camera_half_width, rate);
        camera_y = lerp(previous_camera_y, target_y - camera_half_height, rate);
    }
}

//camera_x = round(camera_x);
//camera_y = round(camera_y);

// update the view position
camera_set_view_pos(camera, camera_x, camera_y);
