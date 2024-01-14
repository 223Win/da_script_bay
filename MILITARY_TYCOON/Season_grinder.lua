--!nocheck


-- Raid the vault in a way so you can get the maximum amount of points



warn("Loaded Season Grinder")

task.wait(5)



local TS = game:GetService("TweenService")
local Player = game.Players.LocalPlayer

function Teleport(Speed,...)
	local VectorParams = {...}
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

local fp = fireproximityprompt
assert(fp,'does not have env functions')




local MainClaimPos = Vector3.new(228.2662811279297, -61.3765869140625, -77.86969757080078)

local Bank:Folder = workspace.Bank
local bankmission = Bank.BankMission
local bankmodel = workspace.BankModel

local GRE:Part = Bank.Claim 

local MoneyFolder = bankmission.Money

local Moneys = {}
local Vaults = {}
local Gems = {}

for i,v in pairs(MoneyFolder:GetChildren()) do
	task.wait()
	if v.Name == 'MoneyPallet' then
		table.insert(Moneys,v.Main)
	elseif v.Name == 'GemBag' then
		table.insert(Gems,v.Main)
	end
end
task.wait()
for i,v:Instance in pairs(bankmodel:GetChildren()) do
	task.wait()
	for i,v in pairs(v:GetChildren()) do
		task.wait()
		if v.Enabled:FindFirstChild('HackAttachment') then
			table.insert(Vaults,v.Enabled)
		end
	end
end
task.wait()
GRE.Position = MainClaimPos

function Claim(Main:Part)
	Teleport(1,Main.Position.X,Main.Position.Y,Main.Position.Z)
	fp(Main.HackAttachment.ProximityPrompt)
	task.wait(4.3)
	Teleport(1,MainClaimPos.X,MainClaimPos.Y,MainClaimPos.Z)
	
end

task.wait()

for i,v:Part in pairs(Moneys) do
	task.wait(0.3)
	repeat 
		Claim(v) 
	until v.Parent == nil
end

task.wait()

for i,v in pairs(Gems) do
	task.wait(0.3)
	Claim(v)
end

task.wait()

for i,v in pairs(Vaults) do
	task.wait(0.3)
	Claim(v)
end
