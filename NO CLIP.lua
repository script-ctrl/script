local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local noclipEnabled = false

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoclipGui"
screenGui.Parent = game.CoreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 60)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.Text = "Noclip: OFF"
toggleBtn.Parent = screenGui

toggleBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    toggleBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Massless = true
                    part.Velocity = Vector3.new(0, 5, 0)
                end
            end
        end
    end
end)

-- Автоматическое повторное включение при респавне
player.CharacterAdded:Connect(function()
    if noclipEnabled then
        wait(1)
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Massless = true
                end
            end
        end
    end
end)
