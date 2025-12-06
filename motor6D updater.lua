--Console -> script
local model = workspace:FindFirstChild("StarterCharacter")
if not model then return end

local hrp = model:FindFirstChild("HumanoidRootPart")
if not hrp then return end

local offset = Vector3.new(0, 3, 0) --add the offset of the HumanoidRootPart
local offsetCFrame = CFrame.new(offset)
local invOffset = offsetCFrame:Inverse()


for _, joint in ipairs(model:GetDescendants()) do
    if joint:IsA("Motor6D") then
        if joint.Part0 == hrp then
            joint.C0 = invOffset * joint.C0
        end
        if joint.Part1 == hrp then
            joint.C1 = invOffset * joint.C1
        end
    end
end
