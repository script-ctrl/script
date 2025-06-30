local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local remoteName = "INTERACT_REMOTE_EVENT"
local remote = ReplicatedStorage:FindFirstChild(remoteName, true)

local function getClosestPart()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end

    local minDist = math.huge
    local nearest = nil

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Part") then
            local dist = (character.HumanoidRootPart.Position - obj.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = obj
            end
        end
    end
    return nearest
end

task.spawn(function()
    while true do
        local closest = getClosestPart()
        if closest and remote then
            pcall(function()
                remote:FireServer(closest)
            end)
        end
        task.wait(0.2)
    end
end)
