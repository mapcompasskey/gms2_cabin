/// @descr scr_camera_update(target_x, target_y, snap_to_target)
/// @param {number} target_x The x position to move the camera to.
/// @param {number} target_y The y position to move the camera to.
/// @param {bool} snap_to_target Whether to instantly move to the target or to transition towards it.

// get arguments
var temp_target_x = argument0;
var temp_target_y = argument1;
var temp_snap_to_target = argument2;

if (global.PLAYER_CAMERA_INSTANCE != noone)
{
    with (global.PLAYER_CAMERA_INSTANCE)
    {
        target_x = temp_target_x;
        target_y = temp_target_y;
        snap_to_target = temp_snap_to_target;
    }
}
