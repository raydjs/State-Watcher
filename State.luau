local kiroState = {
	extension = {},
}

-- ================== [ PRIVATE FUNCTION ] =================================== --
local function createRecursion(listeners, target, path)
	return setmetatable({}, {
		__index = function(_, index)
			local value = target[index]
			if type(value) == "table" then
				return createRecursion(listeners, value, path .. "." .. index)
			else
				return value
			end
		end,
		__newindex = function(_, index, value)
			local oldValue = target[index]
			if oldValue ~= value then
				for _, listener in (listeners[path .. "." .. index] or {}) do
					listener(value)
				end
				target[index] = value -- // Set real [[ Value ]
			end
		end,
	})
end
-- ========================================================================= --

-- ======== [ APPLY METHODS TO ORIGIN TABLE & NESTED TABLE ] =============== --
function kiroState.create(tableToWatch)
	return setmetatable({
		listeners = {},
	}, {
		__index = function(origin_table, index)
			if type(tableToWatch[index]) == "table" then -- // Reference the Stair-case 
				return createRecursion(origin_table.listeners, tableToWatch[index], index)
			else
				return tableToWatch[index]
			end
		end,
		__newindex = function(origin_table, index, value)
			if tableToWatch[index] ~= value then -- // Check if the Value we're looking for Exist
				for _, listener in (origin_table.listeners[index] or {}) do
					listener(value)
				end
			end
			tableToWatch[index] = value -- // Set real [[ Value ]
		end,
	})
end
-- ======== [ APPLY METHODS TO ORIGIN TABLE & NESTED TABLE ] =============== --

-- // Extension to apply & detect changes
function kiroState.extension.inject(tableToWatch: {})
	return setmetatable({ listeners = tableToWatch.listeners }, { __index = kiroState.extension })
end

function kiroState.extension:Watch(path, callback)
	local fullPath = table.concat(path, ".")
	self.listeners[fullPath] = self.listeners[fullPath] or {}
	return table.insert(self.listeners[fullPath], callback)
end

function kiroState.extension:Destroy(path)
	local fullPath = table.concat(path, ".")
	self.listeners[fullPath] = self.listeners[fullPath] or {}

	return table.remove(self.listeners, table.find(self.listeners, fullPath))
end


return kiroState
