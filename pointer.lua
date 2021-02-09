local entity = require 'entity'
local ffi = require 'ffi'

local get_inaccuracy = vtable_thunk(482, "float(__thiscall*)(void*)")
local get_spread = vtable_thunk(452, "float(__thiscall*)(void*)")

client.set_event_callback('setup_command', function()
    local local_player = entity.get_local_player()
    local weapon = local_player:get_player_weapon()
    
    local weapon_ptr = ffi.cast('void***', weapon:get_client_entity())

    print(string.format('inaccuracy: %f, spread: %f', get_inaccuracy(weapon_ptr), get_spread(weapon_ptr)))
end)
