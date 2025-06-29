local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Точки
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

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "StepTPGui"

-- ⬇️ Функция пошагового телепорта
local function stepTeleport(targetPos)
    local currentPos = hrp.Position
    local distance = (targetPos - currentPos).Magnitude
    local stepSize = 6 -- шаг в студиях
    local direction = (targetPos - currentPos).Unit

    local steps = math.floor(distance / stepSize)

    for i = 1, steps do
        local nextPos = currentPos + direction * (i * stepSize)
        char:PivotTo(CFrame.new(nextPos))
        task.wait(0.03)
    end

    -- Финальный прыжок до цели
    char:PivotTo(CFrame.new(targetPos))
end

-- Создание кнопок
for i, tp in ipairs(points) do
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Size = UDim2.new(0, 130, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.SourceSansBold
    button.Text = tp.name

    button.MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        stepTeleport(tp.pos)
    end)
end
