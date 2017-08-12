/// @descr scr_player_create()

event_inherited();

// movement
speed_x = 10;
speed_y = 10;

attack_multiplier = 0.5;
running_multiplier = 5;

knockback_x = 50;
knockback_y = 50;

max_velocity_x = 200;
max_velocity_y = 200;

// object collision
max_health = 10;
current_health = 10;

// states
attacking = false;

// timers
attack_cooldown_time = 0.5;
attack_cooldown_timer = 0;

// drawing
sprite_idle = spr_player_idle;
sprite_idle_speed = 0.1;

sprite_walking = spr_player_walking;
sprite_walking_speed = 0.3;

sprite_running = spr_player_running;
sprite_running_speed = 0.6;

mask_index = spr_player_mask;
sprite_index = sprite_idle;
image_speed = sprite_idle_speed;

sprite_bbox_left = sprite_get_bbox_left(mask_index) - sprite_get_xoffset(mask_index);
sprite_bbox_right = sprite_get_bbox_right(mask_index) - sprite_get_xoffset(mask_index);
sprite_bbox_bottom = sprite_get_bbox_bottom(mask_index) - sprite_get_yoffset(mask_index);
sprite_bbox_top = sprite_get_bbox_top(mask_index) - sprite_get_yoffset(mask_index);

// inputs
key_attack_pressed = false;
key_attack_released = false;

// update globals
global.PLAYER = id;

// update the HUD
scr_update_hud_players_health();
