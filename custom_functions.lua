local ffi = require 'ffi'
local entity = require 'gamesense/entity'

local native_GetInaccuracy = vtable_thunk(482, 'float(__thiscall*)(void*)')

function entity.get_health(player)
    return player:get_prop('m_iHealth')
end

function entity.get_inaccuracy(weapon)
    local pEnt = ffi.cast('void***', weapon:get_client_entity())

    return native_GetInaccuracy(pEnt)
end

client.set_event_callback('setup_command', function()
    local local_player = entity.get_local_player()
    local health = local_player:get_health()

    local weapon = local_player:get_player_weapon()
    local inaccuracy = weapon:get_inaccuracy()
end)
