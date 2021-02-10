local entity = require 'entity'

client.set_event_callback('net_update_end', function()
    local local_player = entity.get_local_player()

    local anim_state = local_player:get_anim_state()
    if anim_state.hit_in_ground_animation then
        local_player:set_prop('m_flPoseParameter', 0.5, 12)
    end
end)
