local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local noclip = false

-- Создаём GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local button = Instance.new("TextButton")
button.Parent = screenGui
button.Size = UDim2.new(0, 160, 0, 40)
button.Position = UDim2.new(0, 20, 1, -60) -- Левый нижний угол
button.AnchorPoint = Vector2.new(0, 1)
button.Text = "Включить ноуклип"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
button.TextColor3 = Color3.fromRGB(255, 255, 255)

button.MouseButton1Click:Connect(function()
    noclip = not noclip
    button.Text = noclip and "Выключить ноуклип" or "Включить ноуклип"
end)

RunService.Heartbeat:Connect(function()
    local character = player.Character
    if character then
        for _, v in pairs(character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = not noclip and true or false
            end
        end
    end
end)
