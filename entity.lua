local ffi = require 'ffi'
local csgo_weapons = require 'gamesense/csgo_weapons'

local entity_get_local_player, entity_is_enemy, entity_get_bounding_box, entity_get_all, entity_set_prop, entity_is_alive, entity_get_steam64, entity_get_classname, entity_get_player_resource, entity_get_esp_data, entity_is_dormant, entity_get_player_name, entity_get_game_rules, entity_get_origin, entity_hitbox_position, entity_get_player_weapon, entity_get_players, entity_get_prop = entity.get_local_player, entity.is_enemy, entity.get_bounding_box, entity.get_all, entity.set_prop, entity.is_alive, entity.get_steam64, entity.get_classname, entity.get_player_resource, entity.get_esp_data, entity.is_dormant, entity.get_player_name, entity.get_game_rules, entity.get_origin, entity.hitbox_position, entity.get_player_weapon, entity.get_players, entity.get_prop
local client_userid_to_entindex, client_draw_hitboxes, client_scale_damage, client_trace_line, client_trace_bullet = client.userid_to_entindex, client.draw_hitboxes, client.scale_damage, client.trace_line, client.trace_bullet
local materialsystem_get_model_materials = materialsystem.get_model_materials
local plist_set, plist_get = plist_set, plist.get
local ffi_cast = ffi.cast

local animation_layer_t = ffi.typeof([[
	struct {										char pad_0x0000[0x18];
		uint32_t	sequence;
		float		prev_cycle;
		float		weight;
		float		weight_delta_rate;
		float		playback_rate;
		float		cycle;
		void		*entity;						char pad_0x0038[0x4];
	} **
]])

local animation_state_t = ffi.typeof([[
	struct {										char pad_0x0000[0x18];
		float		anim_update_timer;				char pad_0x001C[0xC];
		float		started_moving_time;
		float		last_move_time;					char pad_0x0030[0x10];
		float		last_lby_time;					char pad_0x0044[0x8];
		float		run_amount;						char pad_0x0050[0x10];
		void*		entity;
		void*		active_weapon;
		void*		last_active_weapon;
		float		last_client_side_animation_update_time;
		int			last_client_side_animation_update_framecount;
		float		eye_timer;
		float		eye_angles_y;
		float		eye_angles_x;
		float		goal_feet_yaw;
		float		current_feet_yaw;
		float		torso_yaw;
		float		last_move_yaw;
		float		lean_amount; char pad2[4];
		float		feet_cycle;
		float		feet_yaw_rate; char pad3[4];
		float		duck_amount;
		float		landing_duck_amount; char pad4[4];
		float		current_origin[3];
		float		last_origin[3];
		float		velocity_x;
		float		velocity_y; char pad5[4];
		float		unknown_float1; char pad6[8];
		float		unknown_float2;
		float		unknown_float3;
		float		unknown;
		float		m_velocity;
		float		jump_fall_velocity;
		float		clamped_velocity;
		float		feet_speed_forwards_or_sideways;
		float		feet_speed_unknown_forwards_or_sideways;
		float		last_time_started_moving;
		float		last_time_stopped_moving;
		bool		on_ground;
		bool		hit_in_ground_animation; char pad7[4];
		float		time_since_in_air;
		float		last_origin_z;
		float		head_from_ground_distance_standing;
		float		stop_to_full_running_fraction;		char		pad8[4];
		float		magic_fraction;						char		pad9[60];
		float		world_force;						char		pad10[458];
		float		min_yaw;
		float		max_yaw;
	} **
]])

local native_GetClientNetworkable = vtable_bind('client.dll', 'VClientEntityList003', 0, 'void*(__thiscall*)(void*, int)')
local native_GetClientEntity = vtable_bind('client.dll', 'VClientEntityList003', 3, 'void*(__thiscall*)(void*, int)')
local native_GetStudioModel = vtable_bind('engine.dll', 'VModelInfoClient004', 32, 'void*(__thiscall*)(void*, const void*)')

local native_GetIClientUnknown = vtable_thunk(0, 'void*(__thiscall*)(void*)')
local native_GetClientRenderable = vtable_thunk(5, 'void*(__thiscall*)(void*)')
local native_GetBaseEntity = vtable_thunk(7, 'void*(__thiscall*)(void*)')
local native_GetModel = vtable_thunk(8, 'const void*(__thiscall*)(void*)')

local GetSequenceActivity_sig = client.find_signature('client_panorama.dll','\x55\x8B\xEC\x53\x8B\x5D\x08\x56\x8B\xF1\x83') or error('Invalid GetSequenceActivity signature')
local native_GetSequenceActivity = ffi.cast('int(__fastcall*)(void*, void*, int)', GetSequenceActivity_sig)

local class_ptr = ffi.typeof('void***')
local char_ptr = ffi.typeof('char*')

local entity = {}

local M = {
	__index = entity,
	__metatable = false
}

local function get_model(this)
	local pNet = ffi_cast(class_ptr, native_GetClientNetworkable(this[0]))
	local pUnk = ffi_cast(class_ptr, native_GetIClientUnknown(pNet))
	local pRen = ffi_cast(class_ptr, native_GetClientRenderable(pUnk))

	return native_GetModel(pRen)
end

M.__tostring = function(this)
	return ('%d'):format(this[0])
end

M.__eq = function(operand_a, operand_b)
	if type(operand_a) == 'table' then
		operand_a = operand_a[0]
	end

	if type(operand_b) == 'table' then
		operand_b = operand_b[0]
	end

	return operand_a == operand_b
end

entity.get_local_player = function()
	return setmetatable(
		{
			[0] = entity_get_local_player()
		},
		M
	)
end

entity.is_enemy = function(ent)
	return entity_is_enemy(ent[0])
end

entity.get_bounding_box = function(ent)
	return entity_get_bounding_box(ent[0])
end

entity.get_all = function(...)
	local ents = entity_get_all(...)
	for i, ent in ipairs(ents) do
		ents[i] = setmetatable(
			{
				[0] = ent
			},
			M
		)
	end
	return ents
end

entity.set_prop = function(this, ...)
	return entity_set_prop(this[0], ...)
end

entity.is_alive = function(this)
	return entity_is_alive(this[0])
end

entity.get_steam64 = function(this)
	return entity_get_steam64(this[0])
end

entity.get_classname = function(this)
	return entity_get_classname(this[0])
end

entity.get_player_resource = function()
	return setmetatable(
		{
			[0] = entity_get_player_resource()
		},
		M
	)
end

entity.get_esp_data = function(this)
	return entity_get_esp_data(this[0])
end

entity.is_dormant = function(this)
	return entity_is_dormant(this[0])
end

entity.get_player_name = function(this)
	return entity_get_player_name(this[0])
end

entity.get_game_rules = function()
	return setmetatable(
		{
			[0] = entity_get_game_rules()
		},
		M
	)
end

entity.get_origin = function(this)
	return entity_get_origin(this[0])
end

entity.hitbox_position = function(this, ...)
	return entity_hitbox_position(this[0], ...)
end

entity.get_player_weapon = function(this)
	return setmetatable(
		{
			[0] = entity_get_player_weapon(this[0])
		},
		M
	)
end

entity.get_players = function(...)
	local ents = entity_get_players(...)
	for i, ent in ipairs(ents) do
		ents[i] = setmetatable(
			{
				[0] = ent
			},
			M
		)
	end
	return ents
end

entity.get_prop = function(this, ...)
	return entity_get_prop(this[0], ...)
end

entity.new_from_userid = function(userid)
	return setmetatable(
		{
			[0] = client_userid_to_entindex(userid)
		},
		M
	)
end

entity.new = function(entindex)
	return setmetatable(
		{
			[0] = entindex
		},
		M
	)
end

entity.draw_hitboxes = function(this, ...)
	return client_draw_hitboxes(this[0], ...)
end

entity.scale_damage = function(this, ...)
	return client_scale_damage(this[0], ...)
end

entity.trace_line = function(this, ...)
	local fraction, entindex = client_trace_line(this[0], ...)

	return fraction, setmetatable(
		{
			[0] = entindex
		},
		M
	)
end

entity.trace_bullet = function(this, ...)
	local entindex, damage = client_trace_bullet(this[0], ...)

	return setmetatable(
		{
			[0] = entindex
		},
		M
	), damage
end

entity.get_model_materials = function(this)
	return materialsystem_get_model_materials(this[0])
end

entity.plist_set = function(this, ...)
	return plist_set(this[0], ...)
end

entity.plist_get = function(this, field)
	return plist_get(this[0], field)
end

entity.get_client_networkable = function(this)
	return native_GetClientNetworkable(this[0])
end

entity.get_client_entity = function(this)
	return native_GetClientEntity(this[0])
end

entity.get_client_unknown = function(this)
	local pNet = ffi_cast(class_ptr, native_GetClientNetworkable(this[0]))
	
	return native_GetIClientUnknown(pNet)
end

entity.get_client_renderable = function(this)
	local pNet = ffi_cast(class_ptr, native_GetClientNetworkable(this[0]))
	local pUnk = ffi_cast(class_ptr, native_GetIClientUnknown(pNet))
	
	return native_GetClientRenderable(pUnk)
end

entity.get_base_entity = function(this)
	local pNet = ffi_cast(class_ptr, native_GetClientNetworkable(this[0]))
	local pUnk = ffi_cast(class_ptr, native_GetIClientUnknown(pNet))
	
	return native_GetBaseEntity(pUnk)
end

entity.get_sequence_activity = function(self, sequence)
	local hdr = native_GetStudioModel(get_model(self))

	if not hdr then
		return -1
	end

	return native_GetSequenceActivity(native_GetClientEntity(self[0]), hdr, sequence)
end

entity.get_anim_overlay = function(this, layer) -- (*(animation_layer_t)((char*)ent_ptr + 0x2980))[layer]
	layer = layer or 1

	local pEnt = ffi_cast(class_ptr, native_GetClientEntity(this[0]))

	return ffi_cast(animation_layer_t, ffi_cast(char_ptr, pEnt) + 0x2980)[0][layer] 
end

entity.get_anim_state = function(this) -- (*(animation_state_t)((char*)ent_ptr + 0x3914))
	local pEnt = ffi.cast(class_ptr, native_GetClientEntity(this[0]))

	return ffi_cast(animation_state_t, ffi_cast(char_ptr, pEnt) + 0x3914)[0]
end

entity.get_weapon_info = function(this)
	local idx = entity_get_prop(this[0], 'm_iItemDefinitionIndex')
	
	return csgo_weapons[idx]
end

entity.get_entindex = function(this)
	return this[0]
end

setmetatable(
	entity,
	{
		__call = function(this, entindex)
			return setmetatable(
				{
					[0] = entindex
				},
				M
			)
		end,
		__metatable = false
	}
)

return entity