local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclipEnabled = false
local moveSpeed = 1 -- скорость смещения (можно увеличить)

local function noclipMove()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not noclipEnabled then
            conn:Disconnect()
            return
        end

        local moveDir = Vector3.new()
        -- Управление WASD для ноклипа (можно расширить)
        local UserInputService = game:GetService("UserInputService")
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + hrp.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - hrp.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - hrp.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + hrp.CFrame.RightVector end

        if moveDir.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + moveDir.Unit * moveSpeed * 0.2
        end
    end)
end

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 60)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.Text = "Noclip: OFF"
toggleBtn.Parent = screenGui

toggleBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    toggleBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    if noclipEnabled then noclipMove() end
end)

player.CharacterAdded:Connect(function()
    noclipEnabled = false
    toggleBtn.Text = "Noclip: OFF"
end)
