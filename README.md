# State-Watcher
This module gives the table sort of like an event to display the Value that's been changed.
The Module is inspired off **__ReplicaService__** just without the Networking System which I'll be working on Soon.

The State-Watcher doesn't have any specific Paradigm to follow, all it does is apply Methods to the table you created and display the changes :)

The Module itself doesn't have `setter() or getter()` to set each values or get the values, you just basically concatenate them 

But the only thing that it's not allowed to do is constructing an empty list, let's say you'd like to create a Playerlist or a leaderboard and then you proceed to add a new Key 
It would not trigger that changes. Which I'll look forward soon.

Anyways, let's get straight-forward on how to use the State-Watcher

# Classes
Currently there is only 2 Class

 * `State.create(anyTable: table) -> table`
   * The create function constructs a table that's already been applied with methods to trigger the values.
     
 * `State.extension -> {inject}`
   * The extension is a table that consist only 1 sub-class which is `inject` the given argument must be created from `State.create` in which it will give you a Table
    * State.extension.inject(State.create)
  
# Methods
The existant methods are:
* `inject:Watch(path, callback)`
 * This will apply a method to attach to the value you want to watch.
* `inject:Destroy()`
 * This method is optional if you want to destroy the `:Watch()` method

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

inject:Destroy({ "PlayerInfo", "Name" })
inject:Destroy({ "PlayerInfo", "Health" })
inject:Destroy({ "PlayerInfo", "isRunning" })
inject:Destroy({ "PlayerInfo", "isRagdolled" })
```



