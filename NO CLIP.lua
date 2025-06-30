-- TP GUI для Fluxus - Steal a Brainrot
-- Телепортирует к координатам (-348, -6.6, 221)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Button = Instance.new("TextButton")

Button.Size = UDim2.new(0, 120, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Text = "TP to Point"
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 18
Button.Parent = ScreenGui

-- Координаты
local targetPosition = Vector3.new(-348, -6.6, 221)

-- Телепорт при нажатии
Button.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end)

print("GUI телепорт загружен.")
