local fp = function(ProximityPrompt:ProximityPrompt)
	local old = ProximityPrompt.MaxActivationDistance
	local old_1 = ProximityPrompt.HoldDuration
	task.wait()
	ProximityPrompt.MaxActivationDistance = 500
	ProximityPrompt.HoldDuration = 0
	ProximityPrompt:InputHoldBegin()
	task.wait()
	ProximityPrompt:InputHoldEnd()
	ProximityPrompt.MaxActivationDistance = old
	ProximityPrompt.HoldDuration = old_1
end
warn(fp)
local Bank:Folder = workspace.Bank
local bankmission = Bank.BankMission
local bankmodel = workspace.BankModel


-- Auto Raid the bank at amazing speeds.

assert(fp,'env functions missing')

function Teleport(Speed,...)
	local VectorParams = {...}
	local TS = game:GetService("TweenService")
	local Player = game.Players.LocalPlayer
	local Character = Player.Character
	if Character then
		local info = TweenInfo.new(Speed,Enum.EasingStyle.Linear)
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
			return tween
		end
	end
end



function StartDrill()
	pcall(function()
		fp(workspace.Bank.BankMission.Stages["3"].BankVault.DrillPart.ProximityPrompt)
	end)
end

function EnableElevator()
	pcall(function()
		fp(Workspace.Bank.BankMission.Stages['2'].Elevator.ActivateMain.ProximityPrompt)
	end)
end

function BlowBox(Box:Model)
	local Onshot:BindableEvent = Box.OnShot
	Onshot:Fire()
end

--BlowBox(bankmission.Stages['2'].LaserDoor.Box)

function GrabRandomCash()
	local Money = bankmission.Money
	local Item = Money:GetChildren()[1]
	fp(Item.Main.HackAttachment.ProximityPrompt)
end

function BreachDoor(Stage:number)
	pcall(function()
		local Stages = bankmission.Stages
		local Stage = Stages[Stage]
		local prox = Stage:FindFirstChild('ProximityPrompt',true)
		fp(prox)
	end)
end

function GetPos(pos)
	return pos.X,pos.Y,pos.Z
end

function CheckOnCooldown():boolean
	local s,r = pcall(function()
		if Bank:FindFirstChild("Door"):FindFirstChild('SurfaceGui',true) ~= nil then
			return true
		else
			return false
		end
	end)
	if s == false then
		return false
	else
		return r
	end
end

--warn(CheckOnCooldown())


Teleport(3,GetPos(Workspace.Bank.BankMission.Stages["1"].C4Door.C4.Position))
BreachDoor(1)
Teleport(3,GetPos(Workspace.Bank.BankMission.Stages["2"].Elevator.ActivateMain.Position))
EnableElevator()


wait(3)

warn('Loading Season Grinder')


loadstring(game:HttpGet('https://raw.githubusercontent.com/223Win/da_script_bay/main/MILITARY_TYCOON/Season_grinder.lua'))()

