local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclip = false
local connection

-- Включаем/отключаем noclip
local function setNoclip(state)
    noclip = state

    if connection then connection:Disconnect() end

    if noclip then
        connection = RunService.Stepped:Connect(function()
            local char = player.Character
            if not char then return end

            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide then
                    part.CanCollide = false
                end
            end
        end)
    end
end

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "NoclipToggleGUI"

local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = screenGui
toggleBtn.Size = UDim2.new(0, 170, 0, 40)
toggleBtn.Position = UDim2.new(0, 10, 0, 60)
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 18
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Text = "Noclip: OFF"

toggleBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    toggleBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF"
    setNoclip(noclip)
end)

-- Отключаем при респауне
player.CharacterAdded:Connect(function()
    if noclip then
        task.wait(1)
        setNoclip(true)
    end
end)
