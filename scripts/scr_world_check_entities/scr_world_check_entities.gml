/// @descr scr_world_check_entities()


//
// Check Entities
//

// *local variables can pass between instances
var temp_player_id = global.PLAYER.id;
var temp_chunks_grid_1 = chunks_grid_1;
var temp_chunks_grid_width = chunks_grid_width;
var temp_chunks_grid_height = chunks_grid_height;
var temp_chunks_offset_x = chunks_offset_x;
var temp_chunks_offset_y = chunks_offset_y;

with (obj_entity)
{
    // if not the player
    if (id != temp_player_id)
    {
        var entity_offset_x = (x - temp_chunks_offset_x);
        var entity_offset_y = (y - temp_chunks_offset_y);
        
        // if the entities offset is negative
        if (entity_offset_x < 0 || entity_offset_y < 0)
        {
            instance_destroy();
        }
        else
        {
            // find the entiity's current position within the chunks grid
            var entity_cell_x = entity_offset_x div CHUNK_WIDTH;
            var entity_cell_y = entity_offset_y div CHUNK_HEIGHT;
            
            // if the entity is beyond the limits of the chunks grid
            if (entity_cell_x > temp_chunks_grid_width || entity_cell_y > temp_chunks_grid_height)
            {
                instance_destroy();
            }
            else
            {
                // if this entity is in an empty cell
                if (ds_grid_get(temp_chunks_grid_1, entity_cell_x, entity_cell_y) == noone)
                {
                    instance_destroy();
                }
                
            }
            
        }
        
    }
    
}

