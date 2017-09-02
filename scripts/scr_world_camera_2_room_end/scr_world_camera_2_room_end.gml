/// @descr scr_world_camera_2_room_end()


// unassign the camera from the view
// *the camera must be unassigned from the view or there are issues trying to reuse it in another room
view_set_camera(view_index, noone);
