local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Точки для телепорта
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

-- Настройки
local delayBetweenTP = 3     -- Задержка между точками
local holdTime = 2           -- Зажатие позиции (антиоткат)
local successRange = 5       -- Точность попадания

-- Состояние цикла
local autoTP = false

-- Телепорт с защитой от отката
local function hardTeleport(targetPos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local start = tick()
    local conn

    conn = RunService.RenderStepped:Connect(function()
        if not char or not hrp or not hrp.Parent then
            conn:Disconnect()
            return
        end

        local distance = (hrp.Position - targetPos).Magnitude
        if distance < successRange or tick() - start > holdTime then
            conn:Disconnect()
            return
        end

        char:PivotTo(CFrame.new(targetPos))
    end)
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "AutoCycleTPGui"

-- Кнопка запуска/остановки
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 150, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Авто ТП: OFF"

-- Переключение состояния
toggleBtn.MouseButton1Click:Connect(function()
    autoTP = not autoTP
    toggleBtn.Text = autoTP and "Авто ТП: ON" or "Авто ТП: OFF"
end)

-- Цикл авто ТП
task.spawn(function()
    while true do
        if autoTP then
            for _, pos in ipairs(points) do
                if not autoTP then break end
                hardTeleport(pos)
                task.wait(holdTime + delayBetweenTP)
            end
        else
            task.wait(0.2)
        end
    end
end)
