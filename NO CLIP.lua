local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local speed = 2.5 -- скорость передвижения в noclip
local noclipEnabled = false

-- Движение игрока
local moveDir = Vector3.zero
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then moveDir = Vector3.new(0, 0, -1) end
    if input.KeyCode == Enum.KeyCode.S then moveDir = Vector3.new(0, 0, 1) end
    if input.KeyCode == Enum.KeyCode.A then moveDir = Vector3.new(-1, 0, 0) end
    if input.KeyCode == Enum.KeyCode.D then moveDir = Vector3.new(1, 0, 0) end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or
       input.KeyCode == Enum.KeyCode.S or
       input.KeyCode == Enum.KeyCode.A or
       input.KeyCode == Enum.KeyCode.D then
        moveDir = Vector3.zero
    end
end)

-- Главное движение
local function startNoclipMovement()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not noclipEnabled then conn:Disconnect() return end

        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local direction = (workspace.CurrentCamera.CFrame:VectorToWorldSpace(moveDir)).Unit
        if direction.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + direction * speed * 0.1
        end

        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end)
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "NoclipBypassGUI"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 170, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 110)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Noclip: OFF"

toggleBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    toggleBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"

    if noclipEnabled then
        startNoclipMovement()
    end
end)

-- Респавн поддержка
player.CharacterAdded:Connect(function()
    noclipEnabled = false
    toggleBtn.Text = "Noclip: OFF"
end)
