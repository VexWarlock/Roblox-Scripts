--StarterPlayerScripts -> LocalScript
local UserInputService=game:GetService("UserInputService")


local count,init,final=1,0,0
local timer=5
local delta=0.01
local min_time=0.05
local kicked=false
local intervals={}


local SAMPLE_SIZE=3


UserInputService.InputBegan:Connect(function(input, proc)
	if input.UserInputType~=Enum.UserInputType.MouseButton1 then return end
	if kicked==true then return end

	local now=os.clock()

	if count==1 then
		init=now
		final=now
	else
		final=now
		local current=final-init

		if current>timer then
			count=1
			intervals={}
			init=final
			print("RESETTING THE TIMER...")
			return
		end

		table.insert(intervals, current)
		if #intervals>SAMPLE_SIZE then
			table.remove(intervals,1)
		end

		if #intervals==SAMPLE_SIZE then
			local maxInterval=math.max(table.unpack(intervals))
			local minInterval=math.min(table.unpack(intervals))

			if (maxInterval-minInterval<=delta) or current<min_time then
				print("AUTOCLICKER DETECTED!")
				--kicked=true
				return
			end
		end

		print(current)
		init=final
	end

	count+=1
end)
