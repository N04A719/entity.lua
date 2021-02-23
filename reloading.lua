local entity = require 'gamesense/entity'

client.set_event_callback('setup_command', function()
    local local_player = entity.get_local_player()

    local anim_layer = local_player:get_anim_overlay(1)
    if not anim_layer.entity then
        return 
    end
    
    local activity = local_player:get_sequence_activity(anim_layer.sequence)
    if activity == 967 and anim_layer.weight ~= 0 then
        local cycle = anim_layer.cycle

        print(string.format('Reloading: %d%%', cycle * 100))
    end
end)
