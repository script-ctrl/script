local ScreenGui = Instance.new("ScreenGui")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "NoclipGUI"

Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 150, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "Noclip: OFF"
Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20
Button.BorderSizePixel = 2

-- Переменные
local noclip = false

-- Включение/выключение Noclip
Button.MouseButton1Click:Connect(function()
    noclip = not noclip
    Button.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)

-- Noclip логика
game:GetService("RunService").Stepped:Connect(function()
    if noclip and game.Players.LocalPlayer.Character then
        for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)
