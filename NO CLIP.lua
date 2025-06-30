local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local noclipEnabled = true
local speedBoost = 2.3
local defaultWalkSpeed = 16

-- Устанавливаем скорость при старте
local function setWalkSpeed(enable)
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = enable and defaultWalkSpeed * speedBoost or defaultWalkSpeed
    end
end

setWalkSpeed(true)

-- Постоянно отключаем коллизии, чтобы ноклип работал
RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)
