-- 📦 Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RemoteScannerGUI"
ScreenGui.Parent = game.CoreGui

local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 180, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "🔍 Сканировать Remote'ы"
Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 16

-- 🛰️ Функция сканирования
local function scanRemotes()
    print("📡 [Remote Scanner] Начинаю сканирование...")

    local total = 0

    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            total += 1
            print("🔧 Найден Remote [" .. obj.ClassName .. "]: " .. obj:GetFullName())
        end
    end

    print("✅ Всего найдено Remote'ов: " .. total)
end

-- 👆 Привязка к кнопке
Button.MouseButton1Click:Connect(scanRemotes)

-- 🕒 Автоскан при запуске
scanRemotes()

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
-- Разбиение телепорта на много маленьких шагов
local function stepTeleportForward(steps, distance)
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for i = 1, steps do
        root.CFrame = root.CFrame + root.CFrame.lookVector * (distance / steps)
        wait(0.05)
    end
end
