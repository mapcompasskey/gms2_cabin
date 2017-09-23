/// @descr scr_game_step()


//
// Track the Time between Steps
//

// convert the amount of microseconds that have passed since the last step to seconds
var dt = (1/1000000 * delta_time);

// limit TICK to 8fps: (1 / 1,000,000) * (1,000,000 / 8) = 0.125
global.TICK = min(0.125, dt);


//
// If the Game's Asepct Ratio has Changed
//
var a = application_get_position();
var ratio = ((a[2] - a[0]) / view_get_wport(0));
if (ratio != aspect_ratio)
{
    // update GUI scaling in the HUD and the Application size
    if (instance_exists(global.HUD))
    {
        with (global.HUD)
        {
            scale_factor = ratio;
            scale_factor_updated = true;
            
            application_width = a[2] - a[0];
            application_height = a[3] - a[1];
        }
    }
    
    // update aspect ratio
    aspect_ratio = ratio;
}


//
// Restart the Room
//
if (keyboard_check_pressed(ord("R")))
{
    room_restart();
}


//
// Display All the Currnet Room Layers
//
if (keyboard_check_pressed(ord("Q")))
{
    scr_output("----------");
    scr_output("ALL ROOM LAYERS");
    var layer_name, layer_dpth;
    var layers = layer_get_all();
    if (array_length_1d(layers))
    {
        for (var i = 0; i < array_length_1d(layers); i++)
        {
            layer_name = layer_get_name(layers[i]);
            layer_dpth = layer_get_depth(layers[i]);
            scr_output("Layer", layers[i], layer_name, layer_dpth)
        }
    }
    scr_output("----------");
}

