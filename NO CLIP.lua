-- 🌈 Интерфейс
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "WallBypassGUI"

Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 180, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "Пройти сквозь стену"
Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 18
Button.BorderSizePixel = 2
Button.AutoButtonColor = true

-- ⚡ Функция телепорта вперёд (на 5 единиц)
local function teleportForward()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local lookVector = root.CFrame.lookVector
    local newPosition = root.Position + (lookVector * 5)

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
    local goal = {CFrame = CFrame.new(newPosition)}
    local tween = TweenService:Create(root, tweenInfo, goal)
    tween:Play()
end

-- 👆 Привязка к кнопке
Button.MouseButton1Click:Connect(function()
    teleportForward()
end)
