/// @descr scr_npc_create()

event_inherited();

// movement
speed_x = 10;
speed_y = 10;
max_velocity_x = (speed_x * 2);
max_velocity_y = (speed_y * 2);

// collision
movement_collision_script = scr_npc_movement_collision;

// drawing
idle_sprite_x = spr_npc_x;
idle_sprite_y_down = spr_npc_y_down;
idle_sprite_y_up = spr_npc_y_up;
idle_sprite = idle_sprite_x;

sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);

// inputs
key_right = true;

// timers
action_time = random_range(2, 4) // 2 - 4 seconds
action_timer = action_time;
