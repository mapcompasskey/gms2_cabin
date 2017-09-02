/// @descr scr_room_camera_room_end()


// unassign the camera from the view
// *the camera must be unassigned from the view or there are issues trying to reuse it in another room
view_set_camera(view_index, noone);

// update globals
global.PLAYER_CAMERA = noone;
