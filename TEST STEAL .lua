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

local desiredSpeed = 400
local autoMove = false
local connection -- будет использоваться для слежения за изменением скорости

-- Проверка на brainrot в руках
local function hasBrainrot()
    local char = player.Character
    if not char then return false end
    return char:FindFirstChild("Brainrot") ~= nil -- замени имя при необходимости
end

-- Устанавливаем и следим за скоростью
local function setupSpeedEnforcer()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    -- Ставим нужную скорость
    humanoid.WalkSpeed = desiredSpeed

    -- Удаляем прошлую связь если есть
    if connection then
        connection:Disconnect()
    end

    -- Слушаем любые изменения WalkSpeed
    connection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if autoMove and humanoid.WalkSpeed ~= desiredSpeed and hasBrainrot() then
            humanoid.WalkSpeed = desiredSpeed
        end
    end)
end

-- Движение
local function moveToPoint(pos)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    local reached = false
    humanoid:MoveTo(pos)

    local conn
    conn = humanoid.MoveToFinished:Connect(function(success)
        reached = success
        conn:Disconnect()
    end)

    local timer = 0
    while not reached and timer < 10 do
        task.wait(0.05)
        timer = timer + 0.05
    end
    return reached
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "BrainrotAutoMove"

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
        setupSpeedEnforcer()
    else
        if connection then connection:Disconnect() end
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = 16
            end
        end
    end
end)

-- Автодвижение
task.spawn(function()
    while true do
        if autoMove then
            for _, pos in ipairs(points) do
                if not autoMove then break end
                moveToPoint(pos)
                task.wait(0.1)
            end
        else
            task.wait(0.2)
        end
    end
end)

-- Если персонаж умирает/перерождается — пересоздаём слежку
player.CharacterAdded:Connect(function()
    if autoMove then
        task.wait(1)
        setupSpeedEnforcer()
    end
end)
