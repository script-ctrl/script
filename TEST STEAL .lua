local Players = game:GetService("Players")
local player = Players.LocalPlayer

local points = {
    Vector3.new(-348, -6.6, 221),
    Vector3.new(-348, -6.6, 112),
    Vector3.new(-348, -6.6, 6),
    Vector3.new(-348, -6.6, -100),
    Vector3.new(-471, -6.6, 221),
    Vector3.new(-471, -6.6, 112),
    Vector3.new(-471, -6.6, 6),
    Vector3.new(-471, -6.6, -100),
}

local autoMove = false

local function moveToPoint(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local oldSpeed = humanoid.WalkSpeed
    humanoid.WalkSpeed = 300 -- Очень высокая скорость!

    local reached = false
    humanoid:MoveTo(pos)

    local connection
    connection = humanoid.MoveToFinished:Connect(function(success)
        reached = success
        connection:Disconnect()
    end)

    local timer = 0
    while not reached and timer < 10 do -- Уменьшаем максимум ожидания
        task.wait(0.05) -- Меньше задержка для более быстрой проверки
        timer = timer + 0.05
    end

    humanoid.WalkSpeed = oldSpeed
    return reached
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "AutoMoveGui"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 150, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Авто движение: OFF"

toggleBtn.MouseButton1Click:Connect(function()
    autoMove = not autoMove
    toggleBtn.Text = autoMove and "Авто движение: ON" or "Авто движение: OFF"
end)

-- Автоцикл движения
task.spawn(function()
    while true do
        if autoMove then
            for _, pos in ipairs(points) do
                if not autoMove then break end
                moveToPoint(pos)
                task.wait(0.1) -- Очень маленькая пауза между точками
            end
        else
            task.wait(0.2)
        end
    end
end)
