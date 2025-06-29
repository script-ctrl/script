local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- Точки для перемещения
local points = {
    {name = "TP 1", pos = Vector3.new(-348, -6.6, 221)},
    {name = "TP 2", pos = Vector3.new(-348, -6.6, 112)},
    {name = "TP 3", pos = Vector3.new(-348, -6.6, 6)},
    {name = "TP 4", pos = Vector3.new(-348, -6.6, -100)},
    {name = "TP 5", pos = Vector3.new(-471, -6.6, 221)},
    {name = "TP 6", pos = Vector3.new(-471, -6.6, 112)},
    {name = "TP 7", pos = Vector3.new(-471, -6.6, 6)},
    {name = "TP 8", pos = Vector3.new(-471, -6.6, -100)},
}

-- Создание GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "SafeTPGui"

-- Функция плавного перемещения
local function fakeWalk(targetPos)
    local steps = 30 -- количество шагов
    local startPos = hrp.Position
    for i = 1, steps do
        local alpha = i / steps
        local newPos = startPos:Lerp(targetPos, alpha)
        local cf = CFrame.new(newPos)
        char:PivotTo(cf)
        task.wait(0.05) -- скорость перемещения
    end
end

-- Кнопки телепорта
for i, tp in ipairs(points) do
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Size = UDim2.new(0, 120, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.SourceSansBold
    button.Text = tp.name

    button.MouseButton1Click:Connect(function()
        local character = player.Character or player.CharacterAdded:Wait()
        fakeWalk(tp.pos)
    end)
end
