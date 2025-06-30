local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local noclip = false

-- Включение и выключение ноуклипа по кнопке F
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.F then
        noclip = true
    end
end)
UserInputService.InputEnded:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.F then
        noclip = false
    end
end)

RunService.Heartbeat:Connect(function()
    local character = player.Character
    if character then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = noclip and false or true
            end
        end
    end
end)
