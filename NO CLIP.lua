local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclip = false
local speed = 2.3

-- Убираем физику
sethiddenproperty(player, "SimulationRadius", math.huge)

-- Главная функция
local function superNoclip()
    local char = player.Character
    if not char then return end
    local hrp = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")

    -- Полная физическая изоляция
    hum:ChangeState(Enum.HumanoidStateType.Physics)
    hum.PlatformStand = true

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not noclip then
            conn:Disconnect()
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
            return
        end

        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + dir.Unit * speed * 0.2
        end

        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Velocity = Vector3.zero
            end
        end
    end)
end

-- GUI кнопка
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 170, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 160)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "🟥 Noclip OFF"

toggleBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    toggleBtn.Text = noclip and "🟩 Noclip ON" or "🟥 Noclip OFF"
    if noclip then superNoclip() end
end)

-- Автовключение
Players.LocalPlayer.CharacterAdded:Connect(function()
    noclip = false
    toggleBtn.Text = "🟥 Noclip OFF"
end)
