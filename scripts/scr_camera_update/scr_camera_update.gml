/// @descr scr_camera_update(target_x, target_y, snap_to)
/// @param {number} target_x The x position to move the camera to.
/// @param {number} target_y The y position to move the camera to.
/// @param {bool} snap_to Whether to instantly move to the target or to transition towards it.

if (view_camera[0])
{
    // get arguments
    var target_x = argument0;
    var target_y = argument1;
    var snap_to = argument2;
    var camera_x = 0;
    var camera_y = 0;
    
    // get the target view size
    var view_wd = camera_get_view_width(view_camera[0]);
    var view_hg = camera_get_view_height(view_camera[0]);
    
    // get half the target view size to find its center
    var view_wd_half = view_wd * 0.5;
    var view_hg_half = view_hg * 0.5;
    
    // if the camera should transition towards the target
    if ( ! snap_to)
    {
        // get the view's position
        var view_x = camera_get_view_x(view_camera[0]);
        var view_y = camera_get_view_y(view_camera[0]);
        
        // find the distance between the view and the target
        var distance_min = 1;
        var distance_max = point_distance(0, 0, view_wd_half, view_hg_half);
        var target_distance = point_distance(view_x, view_y, (target_x - view_wd_half), (target_y - view_hg_half));
        
        // if the distance is outside the bounds
        if (target_distance < distance_min || target_distance > distance_max)
        {
            snap_to = true;
        }
        else
        {
            // the interpolation rate
            var rate = 0.5;
            
            // interpolate the view position to the new, relative position
            camera_x = lerp(view_x, target_x - view_wd_half, rate);
            camera_y = lerp(view_y, target_y - view_hg_half, rate);
        }
    }
    
    // if the camera should instantly move to the target
    if (snap_to)
    {
        camera_x = target_x - view_wd_half;
        camera_y = target_y - view_hg_half;
    }
    
    //camera_x = round(camera_x);
    //camera_y = round(camera_y);
    
    // bind the values within range
    camera_x = clamp(camera_x, 0, room_width - view_wd);
    camera_y = clamp(camera_y, 0, room_height - view_hg);
    
    // update the view position
    camera_set_view_pos(view_camera[0], camera_x, camera_y);
}
