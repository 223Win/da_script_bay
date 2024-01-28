
-- loadstring(game:HttpGet('https://raw.githubusercontent.com/223Win/da_script_bay/main/MILITARY_TYCOON/AutoFarmDefeatethegigachad.lua'))()

if game.PlaceId ~= 7180042682 then return end

-- writefile('militarytycoonautoelitemissions.lua',game:HttpGet('https://raw.githubusercontent.com/223Win/da_script_bay/main/MILITARY_TYCOON/AutoFarmDefeatethegigachad.lua'))

local PlayerMax = 1
local BossAlive = true
local PlayerConnectionAdd = game.Players.PlayerAdded
local PlayerConnectionRem = game.Players.PlayerRemoving
local FastMode = false

warn('Version: 1.2')

-- AntiKick test

function Rejoin()
	local JobId = game.JobId 
	local PlaceId = game.PlaceId
	game.Players.LocalPlayer:Kick("\nRejoining...")
	wait(20)
	game:GetService("TeleportService"):Teleport(PlaceId, game.Players.LocalPlayer,{'AUTO_REJOIN_ELITE','ELITE_MILITARY_MAIN','ID:%%#@'})
end

function HookKick()
	game.Players.PlayerRemoving:Connect(function(plr)
		if plr.UserId == game.Players.LocalPlayer.UserId then
			Rejoin()
		end
	end)
	game.Players.LocalPlayer.PlayerScripts.Destroying:Connect(function()
		Rejoin()
	end)
end

HookKick()

function CheckFastMode()
	if #game:GetService("Players"):GetPlayers() == 1 then
		FastMode = true
	else
		FastMode = false
	end
end


PlayerConnectionAdd:Connect(CheckFastMode)
PlayerConnectionRem:Connect(CheckFastMode)

--make sure this dont enable infront of people :skull: --

if game:GetService("TeleportService"):GetLocalPlayerTeleportData() == nil or  table.concat(game:GetService("TeleportService"):GetLocalPlayerTeleportData(),'/') ~= table.concat({'AUTO_REJOIN_ELITE','ELITE_MILITARY_MAIN','ID:%%#@'},'/') then
	local StartVal = nil
	local Call_OBJ = Instance.new('BindableFunction')
	game:GetService("StarterGui"):SetCore('SendNotification',{
		Title = 'Execute Script',
		Text = 'Would you like to execute the grinder?',
		Duration = 1e9,
		Button1 = 'Yes',
		Button2 = 'No',
		Callback = Call_OBJ
	})

	Call_OBJ.OnInvoke = function(value)
		if value == 'Yes' then
			StartVal = true
		else
			StartVal = false
		end
	end
	repeat wait() until StartVal ~= nil

	if StartVal == false then
		return
	else
		warn("Starting Main Script")
	end
end

-- Checks to make sure Player isnt in the main menu

function CheckIfInCountryMenu():boolean
	return game.Players.LocalPlayer.PlayerGui.MainMenu.SelectMenu.Visible
end

function Pick_Country()
	local selectmenu = game.Players.LocalPlayer.PlayerGui.MainMenu.SelectMenu
	local flagframe = selectmenu.FlagFrame
	local selectionframe = flagframe.FlagSelectionFrame
	local List = selectionframe.List

	local args = {
		[1] = List:FindFirstChildOfClass('TextButton').Name
	}

	game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.TycoonService.RF.Select:InvokeServer(unpack(args))

end

function GetEliteMissionMenu(MissionId:number)
	local Player = game.Players.LocalPlayer
	local PlayerGUI = Player.PlayerGui
	local EliteMissionMain = PlayerGUI.EliteMissionsMenu
	local EliteMissionGUI = EliteMissionMain.Menu.Missions:FindFirstChildOfClass('ScrollingFrame'):FindFirstChild(tostring(MissionId))
	return EliteMissionGUI
end

function CheckIfMissionIsOnCooldown(MissionId:number):boolean
	local mission = GetEliteMissionMenu(MissionId)
	local OnCooldown:boolean = mission:FindFirstChildOfClass('Frame').Visible
	return OnCooldown
end

function GetCooldownTypeAndTime(MissionId:number)

	local CooldownChecks = {
		'ON COOLDOWN',
		'IN PROGRESS'
	}

	local mission = GetEliteMissionMenu(MissionId)
	local cooldownframe = mission:FindFirstChildOfClass('Frame')
	if cooldownframe.Visible then
		return true
	end
	local TimerLabel:TextLabel = cooldownframe.TimeLabel
	for i,v in pairs(CooldownChecks) do
		if #TimerLabel.Text:split(v) > 1 then
			if i == 1 then
				return TimerLabel.Text:split('ON COOLDOWN (')[2]:split(')')[1]
			else
				return false
			end
		end
	end
end
local GetBoss = function()
	local Boss = game:FindFirstChild('BossHelicopter',true)
	return Boss
end

coroutine.wrap(function()
	while true do
		task.wait()
		BossAlive = (GetBoss().Parent.Parent.Parent.Name ~= 'ReplicatedStorage')
	end
end)()

-- check to make sure you aint in the main menu

if CheckIfInCountryMenu() == true then
	Pick_Country()
end
CheckFastMode()

warn('WAITING FOR GAME TO LOAD')
wait(5)
repeat wait() until game:IsLoaded() == true
warn("Game loaded checks completed; begining grinder")

function Complete_Mission()
	repeat wait() until CheckIfMissionIsOnCooldown(3) == false
	local args = {
		[1] = 3,
		[2] = "Hard"
	}	

	game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.MissionService.RF.Join:InvokeServer(unpack(args))

	-- Elite Mission Main Script

	repeat wait() until CheckIfMissionIsOnCooldown(3) == true
	wait(5)
	warn('Starting Elite Mission')

	local fp = fireproximityprompt
	local GetMission = function()
		local CurrentMission = workspace.Mission
		return CurrentMission
	end
	local CheckForExplosiveSniper = function()
		local Char = game.Players.LocalPlayer.Character
		local Backpack = game.Players.LocalPlayer.Backpack
		local ID = "Explosive Sniper"
		local ID_Exists = (Char:FindFirstChild(ID) ~= nil or Backpack:FindFirstChild(ID) ~= nil)

		return ID_Exists
	end
	local GetRPG = function()
		fp(workspace.EliteMission3.Build.Model.weapon_crate_lid.ProximityPrompt)
	end

	local GetRPGPos = function():Vector3
		return workspace.EliteMission3.Build.Model.weapon_crate_lid.Position
	end


	local BreachDoor = function(Stage:number)
		local Mission = GetMission()
		local Stages = Mission.Stages
		local Door = Stages[tostring(Stage)].C4DoorNew
		local prox = Door.C4.ProximityPrompt
		fp(prox)
	end

	local GetDoorPosition = function(Stage:number):Vector3
		local Mission = GetMission()
		local Stages = Mission.Stages
		local Door:Instance = Stages[tostring(Stage)].C4DoorNew
		local FirstDoorPart = Door:FindFirstChild('Door')

		if FirstDoorPart == nil then
			return game.Players.LocalPlayer.Character.HumanoidRootPart.Position
		end

		return FirstDoorPart:FindFirstChild("Door").Position
	end
	local tp = function (...)

		local VectorParams = {...}
		if type(VectorParams[1]) == 'vector' then
			local VEC = VectorParams[1]
			VectorParams[1] = VEC.X
			VectorParams[2] = VEC.Y
			VectorParams[3] = VEC.Z
		end
		local TS = game:GetService("TweenService")
		local Player = game.Players.LocalPlayer
		local Character = Player.Character
		if Character then
			local info = TweenInfo.new(3,Enum.EasingStyle.Linear)
			local goal = {CFrame = CFrame.new(VectorParams[1],VectorParams[2],VectorParams[3])}
			local error,tween = pcall(function()
				return TS:Create(Character.HumanoidRootPart,info,goal)
			end)
			if error == true then
				Character.Torso.Anchored = false
				tween:Play()
				tween.Completed:Wait()
				Character.Torso.Anchored = true
			else	
				error(tween,5)
			end
		end
	end


	local SniperExists = CheckForExplosiveSniper()

	warn('Running Main Script')


	tp(GetDoorPosition(1))
	BreachDoor(1)
	tp(GetDoorPosition(2))
	BreachDoor(2)
	tp(GetDoorPosition(3))
	BreachDoor(3)
	tp(GetRPGPos())
	GetRPG()
	tp(workspace.EliteMission3.Build.ArmoredTrain.PWagon4.Big_suitcase.Position)
	game.Players.LocalPlayer.Character.Torso.Anchored = false



	local Health = GetBoss().VehicleHealth.Value
	local Body:MeshPart = GetBoss().Body
	local BodyParts = GetBoss().VehicleParts

	local function EquipRPG()
		local RPG:Tool = game.Players.LocalPlayer.Backpack:FindFirstChild("RPG")
		if RPG then
			RPG.Parent = game.Players.LocalPlayer.Character
		else
			warn('NO RPG')
		end
	end

	local function EquipSniper()
		local SNIPER:Tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Explosive Sniper")
		if SNIPER then
			SNIPER.Parent = game.Players.LocalPlayer.Character
		else
			warn("Cannot find Sniper in Inventory Most likely equipped")
		end
	end

	local function Main_Equip()
		if SniperExists then
			EquipSniper()
		else
			EquipRPG()
		end
	end


	local function Attack()
		if SniperExists then
			local SniperPos = Vector3.new(-2051.103759765625, 306.8470153808594, 7218.2216796875)
			local Target = GetBoss().Body.Position
			local args = {
				[1] = {SniperPos},
				[2] = {Target},
				[3] = {GetBoss().Body},
				[4] = {Target},
				[5] = {Vector3.new(-0.9868752956390381, 0, 0.1614837646484375)},
				[6] = {Enum.Material.Plastic}
			}
			game:GetService("ReplicatedStorage").Events.ShootEvent:FireServer(unpack(args))
			game:GetService("ReplicatedStorage").Events.ReloadEvent:FireServer()
			wait(3.55)
		else
			local Target = GetBoss().Body.Position
			local args = {
				[1] = CFrame.new(Target.X,Target.Y,Target.Z) * CFrame.Angles(-0, 0, -0)
			}

			game:GetService("ReplicatedStorage").Events.RPG:FireServer(unpack(args))
			game:GetService("ReplicatedStorage").Events.RPGReload:FireServer()
			wait(3.1)
		end
	end
	Main_Equip()
	repeat wait() until BossAlive == true
	repeat Attack() until BossAlive == false

	tp(GetDoorPosition(5))
	BreachDoor(5)
	tp(GetDoorPosition(6))
	BreachDoor(6)
	tp(workspace.EliteMission3.Build.ArmoredTrain.PWagon4.Big_suitcase.Position)
	game.Players.LocalPlayer.Character.Torso.Anchored = false
	wait(20)
end

while true do
	warn("Fast Mode Status: ",FastMode)
	if FastMode == true then
		Complete_Mission()
		wait(5)
		warn("rejoining")
		Rejoin()
	else
		Complete_Mission()
	end
end
