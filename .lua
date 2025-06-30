-- TP GUI для Fluxus - Steal a Brainrot
-- 8 кнопок с телепортами

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local positions = {
    {name = "TP 1", pos = Vector3.new(-525, -4.8, -100)},
    {name = "TP 2", pos = Vector3.new(-525, -4.8, -6)},
    {name = "TP 3", pos = Vector3.new(-525, -4.8, 113)},
    {name = "TP 4", pos = Vector3.new(-525, -4.8, 220)},
    {name = "TP 5", pos = Vector3.new(-293, -4.8, -100)},
    {name = "TP 6", pos = Vector3.new(-293, -4.8, -6)},
    {name = "TP 7", pos = Vector3.new(-293, -4.8, 113)},
    {name = "TP 8", pos = Vector3.new(-293, -4.8, -100)},
}

for i, data in ipairs(positions) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 120, 0, 30)
    button.Position = UDim2.new(0, 20, 0, 30 + (i - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = data.name
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 16
    button.Parent = ScreenGui

    button.MouseButton1Click:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(data.pos)
        end
    end)
end

print("Все TP кнопки загружены")
