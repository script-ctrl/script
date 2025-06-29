local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

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
screenGui.Name = "FastMoveGui"

-- Функция перемещения с ускорением
local function fastWalkTo(pos)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local oldSpeed = humanoid.WalkSpeed
    humanoid.WalkSpeed = 100 -- ускоряем

    humanoid:MoveTo(pos)
    humanoid.MoveToFinished:Wait(10)

    humanoid.WalkSpeed = oldSpeed -- возвращаем назад
end

-- Кнопки
for i, tp in ipairs(points) do
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Size = UDim2.new(0, 130, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.SourceSansBold
    button.Text = tp.name

    button.MouseButton1Click:Connect(function()
        fastWalkTo(tp.pos)
    end)
end
