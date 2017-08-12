/// @descr scr_entity_create()

// movement
mx = 0;
my = 0;

speed_x = 100;
speed_y = 100;

knockback_x = 100;
knockback_y = 200;

velocity_x = 0;
velocity_y = 0;

last_velocity_x = 0;
last_velocity_y = 0;

max_velocity_x = (speed_x * 2);
max_velocity_y = (speed_y * 2);

move_friction = 0;     // 0.9 - reduce by 10% every step
move_friction_min = 0; // 1   - if less than 1
jump_bounce = 0;       // 0.4 - reduce by 60% every bounce
jump_bounce_min = 0;   // 1   - if less than 1

// object collision
damage = 1;
max_health = 1;
current_health = 1;

can_be_damaged = true;
damage_from = noone;

// movement collision
entity_hit_solid_x = false;
entity_hit_solid_y = false;

entity_hit_tilemap_x = false;
entity_hit_tilemap_y = false;

movement_collision_script = scr_entity_movement_collision;

// collision tile map
//var collision_layer_id = layer_get_id(ROOM_LAYER_COLLISION_MAP);
tilemap = noone;//layer_tilemap_get_id(collision_layer_id);

// states
dying = false;
hurting = false;
recovering = false;
walking = false;
running = false;

// drawing
facing_x = RIGHT;
facing_y = DOWN;

//image_speed = 0;
//sprite_index = noone;
//mask_index = noone;

sprite_bbox_left = 0; // sprite_get_bbox_left(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_right = 0; // sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index);
sprite_bbox_bottom = 0; // sprite_get_bbox_bottom(sprite_index) - sprite_get_yoffset(sprite_index);
sprite_bbox_top = 0; // sprite_get_bbox_top(sprite_index) - sprite_get_yoffset(sprite_index);

// inputs
key_left = false;
key_right = false;
key_up = false;
key_down = false;

// timers
recover_time = 0.5;
recover_timer = 0;
