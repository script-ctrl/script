-- Показывает координаты игрока в левом верхнем углу экрана
-- Совместим с Fluxus и другими Executors

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local CoordLabel = Instance.new("TextLabel")

CoordLabel.Size = UDim2.new(0, 300, 0, 25)
CoordLabel.Position = UDim2.new(0, 10, 0, 10)
CoordLabel.BackgroundTransparency = 1
CoordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CoordLabel.TextStrokeTransparency = 0.7
CoordLabel.Font = Enum.Font.SourceSans
CoordLabel.TextSize = 18
CoordLabel.TextXAlignment = Enum.TextXAlignment.Left
CoordLabel.Text = "Coords: -"
CoordLabel.Parent = ScreenGui

-- Обновление координат каждый кадр
RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local pos = char.HumanoidRootPart.Position
        CoordLabel.Text = string.format("Coords: X=%.1f Y=%.1f Z=%.1f", pos.X, pos.Y, pos.Z)
    else
        CoordLabel.Text = "Coords: -"
    end
end)

print("Отображение координат запущено.")

