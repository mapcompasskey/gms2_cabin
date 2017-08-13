/// @descr scr_hud_create()


// the amount to scale text and images
scale_factor = 1;
scale_text = 1;
scale_sprites = 1;
scale_factor_updated = false;

// the application size
var a = application_get_position();
application_width = a[2] - a[0];
application_height = a[3] - a[1];

// the player's health
player_health = 0;
player_max_health = 0;
player_health_updated = false;
player_health_text = "";

// player health marker
health_marker_sprite = spr_player_health_marker;

// track the marker subimages to draw
health_marker_subimages = ds_list_create();

// player health marker image data
// array(padding, width, height)
health_marker_data[0] = 2;
health_marker_data[1] = sprite_get_width(health_marker_sprite);
health_marker_data[2] = sprite_get_height(health_marker_sprite);

// player health marker drawing values
// array(padding, width, height)
health_marker_draw[0] = 0;
health_marker_draw[1] = 0;
health_marker_draw[2] = 0;

// the world grid
world_grid_width = 0;
world_grid_height = 0;
world_player_cell_x = 0;
world_player_cell_y = 0;
world_grid_updated = false;
world_grid_text = "";

// update globals
global.HUD = id;

// get the players health
scr_update_hud_players_health();

// get the world grid size
scr_update_hud_world_grid();
