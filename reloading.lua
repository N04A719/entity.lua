local entity = require 'gamesense/entity'

local ANIMATION_LAYER_AIMMATRIX = 0
local ANIMATION_LAYER_WEAPON_ACTION = 1
local ANIMATION_LAYER_WEAPON_ACTION_RECROUCH = 2
local ANIMATION_LAYER_ADJUST = 3
local ANIMATION_LAYER_MOVEMENT_JUMP_OR_FALL = 4
local ANIMATION_LAYER_MOVEMENT_LAND_OR_CLIMB = 5
local ANIMATION_LAYER_MOVEMENT_MOVE = 6
local ANIMATION_LAYER_MOVEMENT_STRAFECHANGE = 7
local ANIMATION_LAYER_WHOLE_BODY = 8
local ANIMATION_LAYER_FLASHED = 9
local ANIMATION_LAYER_FLINCH = 10
local ANIMATION_LAYER_ALIVELOOP = 11
local ANIMATION_LAYER_LEAN = 12
local ANIMATION_LAYER_COUNT = 13

client.set_event_callback('setup_command', function()
    local local_player = entity.get_local_player()

    local anim_layer = local_player:get_anim_overlay(ANIMATION_LAYER_WEAPON_ACTION)
    if not anim_layer.entity then
        return 
    end
    
    local activity = local_player:get_sequence_activity(anim_layer.sequence)
    if activity == 967 and anim_layer.weight ~= 0 then
        local cycle = anim_layer.cycle

        print(string.format('Reloading: %d%%', cycle * 100))
    end
end)
