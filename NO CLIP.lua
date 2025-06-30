local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclipEnabled = false

-- Создаем GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraNoclipGui"
screenGui.Parent = game.CoreGui

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 160, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 60)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.Text = "Ultra Noclip: OFF"
toggleBtn.Parent = screenGui

-- Функция ноклипа
local function ultraHardcoreNoclip()
    local character = player.Character
    if not character then return end
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                part.CanCollide = false
                part.Massless = true
                part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                part.Velocity = Vector3.new(0, 30, 0)
                part.RotVelocity = Vector3.new(0, 0, 0)
                part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                part:SetNetworkOwner(nil)
                part.CFrame = part.CFrame + Vector3.new(0, 5, 0)
            end)
        end
    end
end

-- Подключения к циклам
RunService.Stepped:Connect(function()
    if noclipEnabled then ultraHardcoreNoclip() end
end)

RunService.Heartbeat:Connect(function()
    if noclipEnabled then ultraHardcoreNoclip() end
end)

RunService.RenderStepped:Connect(function()
    if noclipEnabled then ultraHardcoreNoclip() end
end)

spawn(function()
    while true do
        if noclipEnabled then ultraHardcoreNoclip() end
        task.wait(0.005)
    end
end)

-- Обработчик кнопки
toggleBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    toggleBtn.Text = noclipEnabled and "Ultra Noclip: ON" or "Ultra Noclip: OFF"
end)
