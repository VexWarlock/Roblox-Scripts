local Perlin={}


local PerlinBlock=script.PerlinBlock
local PerlinTerrain=workspace.PerlinTerrain
local Colors={
	[0.8] = Color3.fromRGB(255, 255, 255),		--Mountain Crests
	[0.75] = Color3.fromRGB(66, 66, 66), 			--Dark Rock
	[0.7] = Color3.fromRGB(88, 88, 88),				--Rock
	[0.5] = Color3.fromRGB(44, 93, 40), 			--Dark Grass
	[0.3] = Color3.fromRGB(52, 111, 48), 			--Grass
	[0.25] = Color3.fromRGB(110, 168, 255), 		--Foamy Edges
	[0.10] = Color3.fromRGB(70, 130, 214), 			--Ocean
	[0] = Color3.fromRGB(48, 89, 149), 				--Deep Ocean
}


local MAP_SIZE=100


local function GetColor(y : number) : Color3
	local closetKey= -1
	-- Loop through colors and find the one that it is greater than but also less than the next one.
	for key,color in pairs(Colors) do
		if y>=key then
			if key>closetKey then
				closetKey=key
			end
		end
	end

	return Colors[closetKey]
end


function Perlin.Generate(Scale: number,Frequency: number,Amplitude: number,Seed: number)
	for _,object in pairs(PerlinTerrain:GetChildren()) do
		object:Destroy()
	end
	
	local random=Random.new(Seed)
	local xOffset=random:NextNumber(-100000,100000)
	local yOffset=random:NextNumber(-100000,100000)

	for x=0,MAP_SIZE do
		for z=0,MAP_SIZE do
			local sampleX=x/Scale*Frequency+xOffset
			local sampleZ=z/Scale*Frequency+yOffset
			
			local basey=math.clamp((math.noise(sampleX, sampleZ) + 0.5),0,1)
			local y=basey*Amplitude

			local clone=PerlinBlock:Clone()
			clone.CFrame=CFrame.new(x,y,z)
			clone.Parent=PerlinTerrain
		end
		task.wait()
	end
end


return Perlin
