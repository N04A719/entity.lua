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
**syntax:** entity.new(entindex)

Creates and returns a new entity object from the specified entindex.

```
.get_local_player
```
**syntax:** entity.get_local_player()

Returns the entity object for the local player, or nil on failure.

```
.get_all
```
**syntax:** entity.get_all(classname)

`classname` - Optional string that specifies the class name of entities that will be added to the list, for example `"CCSPlayer"`

Returns an array of entity objects. Pass no arguments for all entities.
