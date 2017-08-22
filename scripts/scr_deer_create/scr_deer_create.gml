/// @descr scr_deer_create()

event_inherited();

// movement
speed_x = 10;
speed_y = 10;

running_multiplier = 5;

knockback_x = 50;
knockback_y = 50;

max_velocity_x = 200;
max_velocity_y = 200;

// object collision
max_health = 10;
current_health = 10;

// states
//eating = false;

// collision
movement_collision_script = scr_deer_movement_collision;

// drawing
sprite_idle = spr_deer_idle;
sprite_idle_speed = 0.1;

sprite_walking = spr_deer_walking;
sprite_walking_speed = 0.3;

sprite_running = spr_deer_running;
sprite_running_speed = 0.6;

mask_index = spr_deer_mask;
sprite_index = sprite_idle;
image_speed = sprite_idle_speed;

sprite_bbox_left = sprite_get_bbox_left(mask_index) - sprite_get_xoffset(mask_index);
sprite_bbox_right = sprite_get_bbox_right(mask_index) - sprite_get_xoffset(mask_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(mask_index) - sprite_get_yoffset(mask_index);
sprite_bbox_top = sprite_get_bbox_top(mask_index) - sprite_get_yoffset(mask_index);

// inputs
key_run = false;

// timers
action_time = random_range(2, 4) // 2 - 4 seconds
action_timer = action_time;
