/// @descr scr_room_world_created()


//
// Set the Background Color
//

var layer_id = layer_get_id(ROOM_LAYER_BACKGROUND);
var layer_background_id = layer_background_get_id(layer_id);
layer_background_blend(layer_background_id, global.WORLD_BG_COLOR);


//
// Create the Cameras
//

instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_world_camera);
instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_world_camera_2);


//
// Create the HUD
//

instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_hud);


//
// Create the World controller
//

instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_world);


//
// Misc
//

/*
// add deer
var pos_x, pos_y;
for (var i = 0; i < 100; i++)
{
    pos_x = (room_width / 2) + random(200) - 100;
    pos_y = (room_height / 2) + random(200) - 100;
    instance_create_layer(pos_x, pos_y, ROOM_LAYER_INSTANCES, obj_deer);
}
*/

// add cross to center of the room
instance_create_layer(room_width/2, room_height/2, ROOM_LAYER_INSTANCES, obj_cross);

