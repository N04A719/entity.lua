# [entity.lua](https://gamesense.pub/forums/viewtopic.php?id=27529)
This library allows you to take an object oriented approach to managing entities along with using a bunch of new functions.

## Usage
```lua
local entity = require "gamesense/entity"

client.set_event_callback("setup_command", function()
    -- create a local player entity object
	local local_player = entity.get_local_player()

    -- get a net property using a metamethod straight out of the local player
    local health = local_player:get_prop("m_iHealth")

    -- backwards compatibility
    local health = entity.get_prop(local_player, "m_iHealth")
end)
```

## Functions

##
### entity
**syntax:** `entity(entindex)`
Creates and returns an entity object from the specified entindex.

##
### entity.new
**syntax:** `entity.new(entindex)`
Creates and returns an entity object from the specified entindex.

## Methods
### :get_entindex
**syntax:** `ent:get_entindex()`

`ent` - Entity object.

Returns the `entindex` of the entity object.

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

##
### :get_weapon_info
**syntax:** `ent:get_weapon_info()`

`ent` - Weapon entity object.

Returns the CS:GO weapon data of the weapon.

## Animation layer
```
sequence            -- m_nSequence
prev_cycle          -- m_flPrevCycle
weight              -- m_flWeight
weight_delta_rate   -- m_flWeightDeltaRate
playback_rate       -- m_flPlaybackRate
cycle               -- m_flCycle
entity              -- m_pOwner
```

## Weapon info
```
addon_location
addon_scale
armor_ratio
attack_movespeed_factor
bot_audible_range
bullets
console_name
crosshair_delta_distance
crosshair_min_distance
cycletime
cycletime_alt
damage
eject_brass_effect
flinch_velocity_modifier_large
flinch_velocity_modifier_small
has_burst_mode
has_silencer
heat_effect
heat_per_shot
hide_view_model_zoomed
idle_interval
idx (item definition index)
in_game_price
inaccuracy_alt_sound_threshold
inaccuracy_crouch
inaccuracy_crouch_alt
inaccuracy_fire
inaccuracy_fire_alt
inaccuracy_jump
inaccuracy_jump_alt
inaccuracy_jump_apex
inaccuracy_jump_initial
inaccuracy_ladder
inaccuracy_ladder_alt
inaccuracy_land
inaccuracy_land_alt
inaccuracy_move
inaccuracy_move_alt
inaccuracy_reload
inaccuracy_stand
inaccuracy_stand_alt
is_full_auto
is_melee_weapon
is_revolver
item_class
item_gear_slot_position
item_name
itemflag_exhaustible
kill_award
max_player_speed
max_player_speed_alt
model_dropped
model_player
model_right_handed
model_world
muzzle_flash_effect_1st_person
muzzle_flash_effect_1st_person_alt
muzzle_flash_effect_3rd_person
muzzle_flash_effect_3rd_person_alt
name (localized weapon name, for example: "Glock-18")
penetration
player_animation_extension
primary_ammo
primary_clip_size
primary_default_clip_size
primary_reserve_ammo_max
range
range_modifier
raw (returns the raw CCSWeaponInfo_t struct)
recoil_angle
recoil_angle_alt
recoil_angle_variance
recoil_angle_variance_alt
recoil_magnitude
recoil_magnitude_alt
recoil_magnitude_variance
recoil_magnitude_variance_alt
recoil_seed
recovery_time_crouch
recovery_time_crouch_final
recovery_time_stand
recovery_time_stand_final
recovery_transition_end_bullet
recovery_transition_start_bullet
schema (raw item schema as returned by panorama, for example: https://pastebin.com/gsE9RvHr)
secondary_ammo
secondary_clip_size
secondary_default_clip_size
secondary_reserve_ammo_max
sound_burst
sound_empty
sound_nearlyempty
sound_reload
sound_single_shot
sound_single_shot_accurate
sound_special1
sound_special2
sound_special3
spread
spread_alt
spread_seed
throw_velocity
time_to_idle
tracer_effect
tracer_frequency
tracer_frequency_alt
type (knife, pistol, smg, rifle, shotgun, sniperrifle, machinegun, c4, grenade, stackableitem, fists, breachcharge, bumpmine, tablet, melee, equipment)
unzoom_after_shot
weapon_type_int
weapon_weight
zoom_fov_1
zoom_fov_2
zoom_in_sound
zoom_levels
zoom_out_sound
zoom_time_0
zoom_time_1
zoom_time_2
```

## Animation state
```
anim_update_timer
started_moving_time
last_move_time
last_lby_time
run_amount
entity
active_weapon
last_active_weapon
last_client_side_animation_update_time
last_client_side_animation_update_framecount
eye_timer
eye_angles_y
eye_angles_x
goal_feet_yaw
current_feet_yaw
torso_yaw
last_move_yaw
lean_amount
feet_cycle
feet_yaw_rate
duck_amount
landing_duck_amount
current_origin  -- This is a float[3]; USAGE: local x, y, z = current_origin[0], current_origin[1], current_origin[2]
last_origin     -- This is a float[3]; USAGE: local x, y, z = last_origin[0], last_origin[1], last_origin[2]
velocity_x
velocity_y
move_direction_1
move_direction_2
m_velocity
jump_fall_velocity
clamped_velocity
feet_speed_forwards_or_sideways
feet_speed_unknown_forwards_or_sideways
last_time_started_moving
last_time_stopped_moving
on_ground
hit_in_ground_animation
last_origin_z
head_from_ground_distance_standing
stop_to_full_running_fraction
is_not_moving
last_anim_update_time
moving_direction_x
moving_direction_y
moving_direction_z
started_moving
lean_yaw
poses_speed
ladder_speed
ladder_yaw
some_pose
body_yaw
body_pitch
death_yaw
stand
jump_fall
aim_blend_stand_idle
aim_blend_crouch_idle
strafe_yaw
aim_blend_stand_walk
aim_blend_stand_run
aim_blend_crouch_walk
move_blend_walk
move_blend_run
move_blend_crouch
speed
moving_in_any_direction
acceleration
crouch_height
is_full_crouched
velocity_subtract_x
velocity_subtract_y
velocity_subtract_z
standing_head_height
```
