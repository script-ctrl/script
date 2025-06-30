local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local noclipEnabled = false
local speedBoost = 2.3
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

local function setWalkSpeed(enable)
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = enable and defaultWalkSpeed * speedBoost or defaultWalkSpeed
    end
end

local function noclip()
    local char = player.Character
    if not char then return end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

toggleBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    toggleBtn.Text = noclipEnabled and "Noclip + Boost: ON" or "Noclip + Boost: OFF"
    setWalkSpeed(noclipEnabled)
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        noclip()
    end
end)

-- Перезапуск настроек при спавне персонажа
player.CharacterAdded:Connect(function(char)
    wait(1) -- подождать загрузку персонажа
    if noclipEnabled then
        noclip()
        setWalkSpeed(true)
    end
end)

-- Переключение ноклипа по клавише N
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.N then
        noclipEnabled = not noclipEnabled
        toggleBtn.Text = noclipEnabled and "Noclip + Boost: ON" or "Noclip + Boost: OFF"
        setWalkSpeed(noclipEnabled)
    end
end)
