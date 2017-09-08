/// @descr scr_room_camera_end_step()


// if the camera can't move
if ( ! can_move_x && ! can_move_y)
{
    exit;
}

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

// restrict camera x
if (camera_max_x > 0)
{
    cx = clamp(cx, camera_min_x, camera_max_x);
}

// restrict camera y
if (camera_max_y > 0)
{
    cy = clamp(cy, camera_min_y, camera_max_y);
}

// if can't move horizontally
if ( ! can_move_x)
{
    cx = camera_x;
}

// if can't move vertically
if ( ! can_move_y)
{
    cy = camera_y;
}

// update camera position
camera_set_view_pos(camera, cx, cy);

// save the current position
previous_camera_x = camera_x;
previous_camera_y = camera_y;

// update the current position
camera_x = cx;
camera_y = cy;

