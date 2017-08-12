/// @descr scr_enemy_create()

event_inherited();

// movement
speed_x = 20;
speed_y = 20;

knockback_x = 50;
knockback_y = 50;

max_velocity_x = 100;
max_velocity_y = 100;

starting_x = x;
starting_y = y;

// object collision
max_health = 4;
current_health = 4;

// collision
movement_collision_script = scr_npc_movement_collision;

// drawing
idle_sprite_x = spr_enemy_x;
idle_sprite_y_down = spr_enemy_y_down;
idle_sprite_y_up = spr_enemy_y_up;
idle_sprite = idle_sprite_x;

sprite_bbox_left = sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);

// inputs
key_right = true;

// timers
action_time = random_range(2, 4); // 2 - 4 seconds
action_timer = action_time;

dead_time = 1;
dead_timer = 0;
