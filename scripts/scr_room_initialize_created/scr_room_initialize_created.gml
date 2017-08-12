/// @descr scr_room_initialize_created()

// add the Game Start object
instance_create_layer(0, 0, ROOM_LAYER_CONTROLLERS, obj_game);

// goto the next Room
room_goto_next();
