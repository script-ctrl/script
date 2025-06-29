local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local boosted = false
local speedMultiplier = 4 -- во сколько раз быстрее ходишь при включении

-- Функция плавного смещения HumanoidRootPart
local function fakeWalk()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    -- Включаем loop для изменения позиции
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not boosted then
            conn:Disconnect()
            return
        end

        -- Получаем направление движения от управления игрока
        local moveDir = humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            -- Смещаем HRP в направлении движения с ускорением
            hrp.CFrame = hrp.CFrame + moveDir.Unit * speedMultiplier * 0.2
        end
    end)
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "FakeWalkSpeedGUI"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 170, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 10)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Ускорение: OFF"

toggleBtn.MouseButton1Click:Connect(function()
    boosted = not boosted
    toggleBtn.Text = boosted and "Ускорение: ON" or "Ускорение: OFF"

    if boosted then
        fakeWalk()
    end
end)

-- При смене персонажа сбрасываем состояние
player.CharacterAdded:Connect(function()
    boosted = false
    toggleBtn.Text = "Ускорение: OFF"
end)
