/// @descr scr_world_camera_room_end()

// update globals
global.WORLD_CAMERA = noone;
global.PLAYER_CAMERA = noone;

// destroy the camera
camera_destroy(camera);
