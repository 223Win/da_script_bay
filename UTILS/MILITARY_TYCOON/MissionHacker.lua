local MissionHacker = {}

MissionHacker.Stages = {}
MissionHacker.C4Placements = {}

local Mission = game.Workspace.Mission



function MissionHacker:UPDATE()
	function MissionHacker:GetStages()
		return Mission.Stages:GetChildren()
	end

	function MissionHacker:FetchC4Placements()
		MissionHacker.C4Placements = {}
		for i,v in pairs(MissionHacker.Stages) do
			if v:FindFirstChild('C4DoorNew') and v:FindFirstChild('C4DoorNew'):FindFirstChild('C4') then
				MissionHacker.C4Placements[v.Name] = v:FindFirstChild('C4DoorNew'):FindFirstChild('C4').Position
			end
		end
	end
	
	
	MissionHacker.Stages = MissionHacker:GetStages()
	
	MissionHacker:FetchC4Placements()
end


return MissionHacker
