/// @descr scr_world_camera_end_step()


// get the target position
var cx = (target_x - camera_half_width);
var cy = (target_y - camera_half_height);

// if the target hasn't moved
if (cx == camera_x && cy == camera_y)
{
    exit;
}

// if the camera should transition towards the target
if ( ! snap_to_target)
{
    // find the distance between the camera and the target
    var distance_min = 1;
    var distance_max = point_distance(0, 0, camera_half_width, camera_half_height);
    var target_distance = point_distance(camera_x, camera_y, cx, cy);
    
    // if the distance is within bounds
    if (target_distance > distance_min && target_distance < distance_max)
    {
        // the interpolation rate
        var rate = 0.5;
        
        // interpolate the camera position to the target
        cx = lerp(camera_x, cx, rate);
        cy = lerp(camera_y, cy, rate);
    }
}

//camera_x = round(camera_x);
//camera_y = round(camera_y);

// update the view position
camera_set_view_pos(camera, cx, cy);

// save the current position
previous_camera_x = camera_x;
previous_camera_y = camera_y;

// update the current position
camera_x = cx;
camera_y = cy;

