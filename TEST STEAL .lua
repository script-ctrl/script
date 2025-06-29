local Players = game:GetService("Players")
local player = Players.LocalPlayer
local desiredSpeed = 200 -- скорость при включении

local boosted = false
local connection

-- Включить скорость
local function enableSpeed()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")

    -- Устанавливаем скорость
    humanoid.WalkSpeed = desiredSpeed

    -- Следим, чтобы не сбрасывалась
    connection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if boosted and humanoid.WalkSpeed ~= desiredSpeed then
            humanoid.WalkSpeed = desiredSpeed
        end
    end)
end

-- Отключить скорость
local function disableSpeed()
    boosted = false
    if connection then connection:Disconnect() end

    local char = player.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16 -- стандарт
        end
    end
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "SpeedToggleGUI"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 170, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Скорость: OFF"

toggleBtn.MouseButton1Click:Connect(function()
    boosted = not boosted
    toggleBtn.Text = boosted and "Скорость: ON" or "Скорость: OFF"

    if boosted then
        enableSpeed()
    else
        disableSpeed()
    end
end)

-- Автовключение при респауне
player.CharacterAdded:Connect(function()
    if boosted then
        task.wait(1)
        enableSpeed()
    end
end)
