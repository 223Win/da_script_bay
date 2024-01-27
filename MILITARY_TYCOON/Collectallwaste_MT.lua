

assert(fireproximityprompt,'Unsupported Env functions')
assert(queueonteleport,'Unsupported Env functions')

local fp = fireproximityprompt
local qot = queueonteleport

function ServerHop()
	local Servers = game:HttpGet('https://games.roblox.com/v1/games/7180042682/servers/0?sortOrder=2&excludeFullGames=true&limit=100')
	local DecodedServers = game:GetService("HttpService"):JSONDecode(Servers)
	local AllServers = {}
	
	for i,v in pairs(DecodedServers.Data) do
		table.insert(AllServers,v.id)
	end
	math.randomseed(math.random(1,231712))
	qot(game:HttpGet('https://raw.githubusercontent.com/223Win/da_script_bay/main/MILITARY_TYCOON/Collectallwaste_MT.lua'))
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,AllServers[math.random(1,#AllServers)],game.Players.LocalPlayer)
end




local WasteFolder = workspace.CurrentEventCollectables


for i,v in pairs(WasteFolder:GetChildren()) do
	task.wait()
	fp(v.Hitbox.ProximityPrompt)
end

task.wait(3)

ServerHop()
