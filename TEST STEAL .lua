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
local desiredSpeed = 200

-- Устанавливаем скорость
local function setSpeed()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = desiredSpeed
    end
end

-- Поддержка скорости
task.spawn(function()
    while true do
        if autoMove then
            setSpeed()
        end
        task.wait(0.05)
    end
end)

-- Перемещение к точке (ускорено)
local function moveToPoint(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    humanoid:MoveTo(pos)

    local reached = false
    local conn
    conn = humanoid.MoveToFinished:Connect(function(success)
        reached = success
        conn:Disconnect()
    end)

    local timeout = 0
    while not reached and timeout < 3 do -- быстрее: максимум 3 секунды на точку
        task.wait(0.01) -- 🔥 очень быстрый цикл
        timeout += 0.01
    end
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "AutoMoveFast"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 170, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Авто движение: OFF"

toggleBtn.MouseButton1Click:Connect(function()
    autoMove = not autoMove
    toggleBtn.Text = autoMove and "Авто движение: ON" or "Авто движение: OFF"

    if autoMove then
        setSpeed()
    else
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end)

-- Максимально быстрый цикл
task.spawn(function()
    while true do
        if autoMove then
            for _, pos in ipairs(points) do
                if not autoMove then break end
                moveToPoint(pos)
                task.wait(0.01) -- 🔁 почти моментальный переход к следующей точке
            end
        else
            task.wait(0.1)
        end
    end
end)
