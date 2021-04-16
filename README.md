# [entity.lua](https://gamesense.pub/forums/viewtopic.php?id=27529)
This library allows you to take an object oriented approach to managing entities along with using a bunch of new functions.

## Usage
```lua
local entity = require 'gamesense/entity'

client.set_event_callback('paint', function()
    local local_player = entity.get_local_player()

    if not local_player:is_alive() then
        return
    end

    local health = local_player:get_prop('m_iHealth')

    renderer.text(20, 20, 255, 255, 255, 255, '+', 0, string.format('Health: %d', health))
end)
```

## Functions
### .new
**syntax:** `entity.new(entindex)`

Creates and returns a new entity object from the specified `entindex`.
##
### .get_local_player
**syntax:** `entity.get_local_player()`

Returns the entity object for the local player, or `nil` on failure.
##
### .get_all
**syntax:** `entity.get_all(classname)`

`classname` - Optional string that specifies the class name of entities that will be added to the list, for example `'CCSPlayer'`.

Returns an array of entity objects. Pass no arguments for all entities.
##
### .get_players
**syntax:** `entity.get_players(enemies_only)`

`enemies_only` - Optional boolean. If `true` then you and the players on your team will not be added to the list.

Returns an array of player entity objects. Dormant and dead players will not be added to the list.
##
### .get_game_rules
**syntax:** `entity.get_game_rules()`

Returns entity object of `CCSGameRulesProxy` instance, or `nil` if none exists.
##
### .get_player_resource
**syntax:** `entity.get_player_resource()`

Returns entity object of `CCSPlayerResource` instance, or `nil` if none exists.

## Methods
### :get_entindex
**syntax:** `ent:get_entindex()`

`ent` - Entity object.

Returns the `entindex` of the entity object.
##
### :get_classname
**syntax:** `ent:get_classname()`

`ent` - Entity object.

Returns the name of the entity's class, or `nil` on failure.
##
### :set_prop
**syntax:** `ent:set_prop(propname, value, array_index)`

`ent` - Entity object.

`propname` - Name of the networked property.

`value` - The property will be set to this value. For vectors or angles, separate the components by commas.

`array_index` - Optional. If `propname` is an array, the value at this array index will be set. Alternatively, an entity object could be used instead.
##
### :get_prop
**syntax:** `ent:get_prop(propname, value, array_index)`

`ent` - Entity object.

`propname` - Name of the networked property.

`array_index` - Optional. If `propname` is an array, the value at this array index will be returned. Alternatively, an entity object could be used instead.

Returns the value of the property, or `nil` on failure. For vectors or angles, this returns three values.
##
### :is_enemy
**syntax:** `ent:is_enemy()`

`ent` - Player entity object.

Returns `true` if the entity is on the other team.
##
### :is_alive
**syntax:** `ent:is_alive()`

`ent` - Player entity object.

Returns `true` if the player is not dead.
##
### :is_dormant
**syntax:** `ent:is_dormant()`

`ent` - Player entity object.

Returns `true` if the player is dormant.
##
### :get_player_name
**syntax:** `ent:get_player_name()`

`ent` - Player entity object.

Returns the player's name, or the string `'unknown'` on failure.
##
### :get_player_weapon
**syntax:** `ent:get_player_weapon()`

`ent` - Player entity object.

Returns the entity object of the player's active weapon, or `nil` if the player is not alive, dormant, etc.
##
### :hitbox_position
**syntax:** `ent:hitbox_position(hitbox)`

`ent` - Player entity object.

`hitbox` - Either a string of the hitbox name, or an integer index of the hitbox.

Returns world coordinates `x`, `y`, `z`, or `nil` on failure.
##
### :get_steam64
**syntax:** `ent:get_steam64()`

`ent` - Player entity object.

Returns `steamID3`, or `nil` on failure.
##
### :get_bounding_box
**syntax:** `ent:get_bounding_box()`

`ent` - Player entity object.

Returns `x1`, `y1`, `x2`, `y2`, `alpha_multiplier`. The contents of `x1`, `y1`, `x2`, `y2` must be ignored when `alpha_multiplier` is zero, which indicates that the bounding box is invalid and should not be drawn.
##
### :get_origin
**syntax:** `ent:get_origin()`

`ent` - Entity object.

Returns `x`, `y`, `z` world coordinates of the entity's origin, or `nil` if the entity is dormant and dormant ESP information is not available.
##
### :get_esp_data
**syntax:** `ent:get_esp_data()`

`ent` - Player entity object.

Returns a table containing `alpha`, `health`, and `weapon_id`, or `nil` on failure.
##
### :get_client_networkable
**syntax:** `ent:get_client_networkable()`

`ent` - Entity object.

Returns the `IClientNetworkable` of the entity object.
##
### :get_client_entity
**syntax:** `ent:get_client_entity()`

`ent` - Entity object.

Returns the `IClientEntity` of the entity object.

##
### :get_sequence_activity
**syntax:** `ent:get_sequence_activity(sequence)`

`ent` - Player entity object.

`sequence` - Animation layer sequence.

Returns the current activity from the sequence, or `-1` if no activity was found.
##
### :get_anim_overlay
**syntax:** `ent:get_anim_overlay(layer)`

`ent` - Player entity object.

`layer` - Animation layer index.

Returns the animation layer of the player.
##
### :get_anim_state
**syntax:** `ent:get_anim_state()`

`ent` - Player entity object.

Returns the animation state of the player.

## Animation layer
```lua
m_nSequence
m_flPrevCycle
m_flWeight
m_flCycle
m_pOwner
```

## Weapon info
```lua
consoleName
iMaxClip1
MaxClip2
iDefaultClip1
iDefaultClip2
iPrimaryReserveAmmoMax
iSecondaryReserveAmmoMax
szWorldModel
szViewModel
szDroppedModel
szHudName
szWeaponName
bIsMeleeWeapon
flWeaponWeight
iWeaponType
iWeaponPrice
iKillAward
flCycleTime
flCycleTimeAlt
bFullAuto
iDamage
flArmorRatio
iBullets
flPenetration
flWeaponRange
flRangeModifier
flThrowVelocity
bHasSilencer
szBulletType
flMaxSpeed
flMaxSpeedAlt
iRecoilSeed
```

## Animation state
```lua
m_bForceWeaponUpdate
m_pBaseEntity
m_pActiveWeapon
m_pLastActiveWeapon
m_flLastClientSideAnimationUpdateTime
m_iLastClientSideAnimationUpdateFramecount
m_flAnimUpdateDelta
m_flEyeYaw
m_flPitch
m_flGoalFeetYaw
m_flCurrentFeetYaw
m_flCurrentTorsoYaw
m_flUnknownVelocityLean
m_flLeanAmount
m_flFeetCycle
m_flFeetYawRate
m_fDuckAmount
m_fLandingDuckAdditiveSomething
m_vOriginX
m_vOriginY
m_vOriginZ
m_vLastOriginX
m_vLastOriginY
m_vLastOriginZ
m_vVelocityX
m_vVelocityY
m_flUnknownFloat1
m_flUnknownFloat2
m_flUnknownFloat3
m_flUnknown
m_flSpeed2D
m_flUpVelocity
m_flSpeedNormalized
m_flFeetSpeedForwardsOrSideWays
m_flFeetSpeedUnknownForwardOrSideways
m_flTimeSinceStartedMoving
m_flTimeSinceStoppedMoving
m_bOnGround
m_bInHitGroundAnimation
m_flTimeSinceInAir
m_flLastOriginZ
m_flHeadHeightOrOffsetFromHittingGroundAnimation
m_flStopToFullRunningFraction
m_flMagicFraction
m_flWorldForce
m_flMinYaw
m_flMaxYaw
```
