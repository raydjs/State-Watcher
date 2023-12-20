# State-Watcher
This module gives the table sort of like an event to display the Value that's been changed.

The Module is inspired off **__ReplicaService__** just without the Networking System which I'll be working on Soon.

Anyways, let's get straight-forward on how to use the State-Watcher

# Classes
Currently there is only 2 Class

 * `State.create(anyTable: table) -> table`
   * The create function constructs a table that's already been applied with methods to trigger the values.
     
 * `State.extension -> {inject}`
   * The extension is a table that consist only 1 sub-class which is `inject` the given argument must be created from `State.create` in which it will give you a Table
    * State.extension.inject(State.create)
  
# Methods
The methods currently is
* `inject:Watch(path, callback)`
* `inject:Destroy()`

# Usage

```lua
local myTable = kiroState.create {
	["Combat"] = {
		isActive = false,
	},

	["PlayerInfo"] = {
		isRagdolled = false,
		isRunning = false,
		Health = 100,
		Name = "kiro",
	},
}

local inject = kiroState.extension.inject(myTable)

inject:Watch({ "Combat", "isActive" }, function(value: boolean)
	print(value)
end)

inject:Watch({ "PlayerInfo", "isRagdolled" }, function(value: boolean)
	print(value)
end)

inject:Watch({ "PlayerInfo", "isRunning" }, function(value: boolean)
	print(value)
end)

inject:Watch({ "PlayerInfo", "Health" }, function(value: number)
	print(value)
end)

inject:Watch({ "PlayerInfo", "Name" }, function(value: string)
	print(value)
end)

myTable.Combat.isActive = true
myTable.Combat.isActive = false
myTable.PlayerInfo.isRagdolled = true
myTable.PlayerInfo.isRagdolled = false
myTable.PlayerInfo.isRunning = true
myTable.PlayerInfo.isRunning = false
myTable.PlayerInfo.Health -= 10
myTable.PlayerInfo.Name = "kiro legend"
```



