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

local desiredSpeed = 300
local autoMove = false
local speedLoopRunning = false

-- Проверка: brainrot в руках?
local function hasBrainrot()
    local char = player.Character
    if not char then return false end
    return char:FindFirstChild("Brainrot") ~= nil -- замени имя если нужно
end

-- Установка скорости
local function setSpeed()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.WalkSpeed ~= desiredSpeed then
        humanoid.WalkSpeed = desiredSpeed
    end
end

-- Запуск цикла поддержания скорости
local function startSpeedLoop()
    if speedLoopRunning then return end
    speedLoopRunning = true
    task.spawn(function()
        while speedLoopRunning do
            if hasBrainrot() and autoMove then
                setSpeed()
            end
            task.wait(0.025) -- в 2 раза быстрее
        end
    end)
end

local function stopSpeedLoop()
    speedLoopRunning = false
end

-- Движение к точке
local function moveToPoint(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    local reached = false
    humanoid:MoveTo(pos)

    local connection
    connection = humanoid.MoveToFinished:Connect(function(success)
        reached = success
        connection:Disconnect()
    end)

    local timer = 0
    while not reached and timer < 5 do -- уменьшено с 10 до 5 сек
        task.wait(0.025) -- ускорено с 0.05 до 0.025
        timer = timer + 0.025
    end
    return reached
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "StealABrainrotAutoMove"

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
        startSpeedLoop()
    else
        stopSpeedLoop()
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end)

-- Цикл движения
task.spawn(function()
    while true do
        if autoMove then
            for _, pos in ipairs(points) do
                if not autoMove then break end
                moveToPoint(pos)
                task.wait(0.05) -- пауза между точками уменьшена
            end
        else
            task.wait(0.1)
        end
    end
end)
