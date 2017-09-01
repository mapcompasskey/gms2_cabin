/// @descr scr_room_camera_room_end()

// update globals
global.ROOM_CAMERA = noone;
global.PLAYER_CAMERA = noone;

// destroy the camera
camera_destroy(camera);
