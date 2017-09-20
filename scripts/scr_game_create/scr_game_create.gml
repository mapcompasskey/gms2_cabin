/// @descr scr_game_create()


// this object must be persistent
if ( ! persistent)
{
    persistent = true;
}


//
// Set Constants
//

#macro RIGHT 1
#macro LEFT -1
#macro UP -1
#macro DOWN 1

#macro DEGREES_RIGHT 0
#macro DEGREES_LEFT 180
#macro DEGREES_UP 90
#macro DEGREES_DOWN 270

#macro TILE_SIZE 8
#macro NOT_TILE_SIZE 7
#macro TILE_SOLID 1

#macro CHUNK_WIDTH 80
#macro CHUNK_HEIGHT 80

// room layer names
#macro ROOM_LAYER_CONTROLLERS "Controllers"
#macro ROOM_LAYER_INSTANCES "Instances"
#macro ROOM_LAYER_GROUND "Ground"
#macro ROOM_LAYER_TILEMAP "Tilemap"
#macro ROOM_LAYER_BACKGROUND "Background"
//#macro ROOM_LAYER_COLLISION_MAP "CollisionMap"


//
// Set Globals
//

// whether to load and output the layout room data
global.OUTPUT_LAYOUT_DATA = false;

// dynamic resources
// *need to be destroyed when no longer required
global.WORLD_CAMERA_RESOURCE = noone;
global.WORLD_CAMERA_2_RESOURCE = noone;
global.ROOM_CAMERA_RESOURCE = noone;

global.WORLD_CHUNK_LAYOUTS_GRID = noone;
global.WORLD_CHUNK_INSTANCES_GRID = noone;

// instances
global.HUD = noone;
global.PLAYER = noone;
global.WORLD = noone;
global.PLAYER_CAMERA = noone;

// parameters
global.TICK = 0;
global.PREVIOUS_DOOR_CODE = noone;
global.PREVIOUS_ROOM_NAME = noone;
global.CURRENT_DOOR_CODE = "world_02";
global.CURRENT_ROOM_NAME = "rm_world_1";
global.PLAYER_WORLD_CELL_X = noone;
global.PLAYER_WORLD_CELL_Y = noone;

// game size and scaling
global.VIEW_SCALE = 3;
global.WINDOW_WIDTH = window_get_width();
global.WINDOW_HEIGHT = window_get_height();
global.WORLD_BG_COLOR = make_color_rgb(255, 255, 255); // white
global.ROOM_BG_COLOR = make_color_rgb(0, 0, 0); // black

// room layer ids (and depth)
// there's a performance when using the layer name instead of the layer id
// get the ids for each layer when the room is created
global.CONTROLLERS_LAYER_ID = noone;
global.INSTANCES_LAYER_ID = noone;
global.GROUND_LAYER_ID = noone;
global.TILEMAP_LAYER_ID = noone;
global.BACKGROUND_LAYER_ID = noone;
global.BACKGROUND_LAYER_DEPTH = 0;


//
// Set Instance Variables
//

aspect_ratio = 1;

