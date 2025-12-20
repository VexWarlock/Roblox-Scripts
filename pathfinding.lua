--Rig -> Script
local PFS=game:GetService("PathfindingService")


local human=script.Parent:WaitForChild("Humanoid")
local torso=script.Parent.PrimaryPart
local finish=workspace.Finish
local agentparams={
	AgentRadius=3,         --limita inferioara e 0.5 (chiar daca o poti seta si mai mica,se considera 0.5)
	AgentHeight=1,         --limita inferioara e 1
	AgentCanJump=true,     --daca character-ul poate sa sara sau nu
	AgentCanClimb=true,    --daca character-ul poate sa se catere sau nu
	WaypointSpacing=0.1,   --distanta dintre waypoints (o distanta mai mica duce la un path mai smooth)
	Costs={ 
		Plastic=1,
		Neon=10
	} --seteaza costul fiecarui material pentru a face ca agentul sa prefere unele materiale pe care sa mearga in favoarea altora (costul default e 1 si prioritatea e invers proportionala cu costul)
}


--cream un path si il legam intre start si finish,tinand cont de faptul ca daca e o diferenta de 5 intre inaltimile lor nu se va crea path-ul
local path=PFS:CreatePath(agentparams)

repeat
	local success,errormsg=pcall(function()
		path:ComputeAsync(torso.Position,finish.Position)
	end)
	task.wait(0.1)
until success and not errormsg

--luam waypoints-urile path-ului
local waypoints=path:GetWaypoints()

--facem path-ul vizibil(doar pentru testing)
for position,waypoint in pairs(waypoints) do
	local part=Instance.new("Part",workspace)	part.Position=waypoint.Position part.CanCollide=false part.CanTouch=false	part.CanQuery=false	part.Anchored=true	part.Size=Vector3.new(1,1,1) part.Shape=Enum.PartType.Ball part.Color=Color3.fromRGB(255,0,0) part.Material=Enum.Material.Neon part.Transparency=0.5
end

--iteram printre waypoints,de la primul la ultimul
for position,waypoint in pairs(waypoints)  do
	
--miscam torso-ul character-ului de la punctul precedent la cel curent
	human:MoveTo(waypoint.Position)

--facem character-ul sa sara cand e nevoie 
	if waypoint.Action==Enum.PathWaypointAction.Jump then
		human:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	
--asteptam ca character-ul sa ajunga la waypoint
	human.MoveToFinished:Wait()
end
