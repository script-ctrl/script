-- Noclip переменная
local noclipEnabled = false

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NoclipSpyGui"
ScreenGui.Parent = game.CoreGui

local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 160, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "Noclip: OFF"
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20

-- Noclip логика
game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled and game.Players.LocalPlayer.Character then
        for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

-- Переключение Noclip
Button.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    Button.Text = "Noclip: " .. (noclipEnabled and "ON" or "OFF")
end)

-- Загрузка SimpleSpy
spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
end)
