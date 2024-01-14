local _old = game
local gameProxy = setmetatable({}, {
	__index = function(_, key)
		if key == "HttpGet" then
			return function(self, ...)
				warn(...)
				return _old:HttpGet(...)
			end
		else
			local originalValue = _old[key]

			if type(originalValue) == "function" then
				return function(_, ...)
					return originalValue(_old, ...)  
				end
			else
				return originalValue
			end
		end
	end,
	__newindex = function(_, key, value)
		_old[key] = value
	end,
})

game,Game = gameProxy,gameProxy
game:GetService('StarterGui'):SetCore("DevConsoleVisible",true)

-- paste your goofy loadstring(httpget) functions here and do a key system it will give you all of the links they use to load --
