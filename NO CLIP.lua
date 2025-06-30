local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local noclipEnabled = false
local speedBoost = 2.3 -- множитель скорости
local defaultWalkSpeed = 16

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NoclipGui"
screenGui.Parent = game.CoreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 60)
toggleBtn.Text = "Noclip + Boost: OFF"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Parent = screenGui

toggleBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    toggleBtn.Text = noclipEnabled and "Noclip + Boost: ON" or "Noclip + Boost: OFF"

    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = noclipEnabled and defaultWalkSpeed * speedBoost or defaultWalkSpeed
        end
    end
end)

-- Функция для отключения коллизий
local function noclip()
    local character = player.Character
    if character and noclipEnabled then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

RunService.Stepped:Connect(noclip)
