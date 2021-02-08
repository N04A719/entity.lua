# entity.lua (v1.0)
The entity object/wrapper library allows you to take an object oriented approach to managing entities.

## Usage
```lua
local entity = require 'entity'

client.set_event_callback('paint', function()
    local local_player = entity.get_local_player()
    local health = local_player:get_prop('m_iHealth')

    renderer.text(20, 20, 255, 255, 255, 255, '+', 0, string.format('Health: %d', health))
end)
```

## Functions
```
.new
```
**syntax:** `entity.new(entindex)`

Creates and returns a new entity object from the specified entindex.

```
.get_local_player
```
**syntax:** `entity.get_local_player()`

Returns the entity object for the local player, or nil on failure.

```
.get_all
```
**syntax:** `entity.get_all(classname)`

`classname` - Optional string that specifies the class name of entities that will be added to the list, for example `"CCSPlayer"`

Returns an array of entity objects. Pass no arguments for all entities.

```
.get_players
```
**syntax:** `entity.get_players(enemies_only)`

`enemies_only` - Optional boolean. If `true` then you and the players on your team will not be added to the list.

Returns an array of player entity objects. Dormant and dead players will not be added to the list.

```
.get_game_rules
```
**syntax:** `entity.get_game_rules()`

Returns entity object of CCSGameRulesProxy instance, or nil if none exists.

```
.get_player_resource
```
**syntax:** `entity.get_player_resource()`

Returns entity object of CCSPlayerResource instance, or nil if none exists.

## Methods
```
:get_classname
```
**syntax:** `ent:get_classname()`

`ent` - Entity object.

Returns the name of the entity's class, or nil on failure.

```
:set_prop
```
**syntax:** `ent:set_prop(propname, value, array_index)`

`ent` - Entity object.

`propname` - Name of the networked property.

`value` - The property will be set to this value. For vectors or angles, separate the components by commas.

`array_index` - Optional. If `propname` is an array, the value at this array index will be set.

```
:get_prop
```
**syntax:** `ent:get_prop(propname, value, array_index)`

`ent` - Entity object.
`propname` - Name of the networked property.
`array_index` - Optional. If `propname` is an array, the value at this array index will be returned.

Returns the value of the property, or nil on failure. For vectors or angles, this returns three values.

```
:is_enemy
```
**syntax:** `ent:is_enemy()`

`ent` - Entity object.

Returns true if the entity is on the other team.
