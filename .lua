-- Кнопка: За карту
local button = Instance.new("TextButton")
button.Parent = screenGui
button.Size = UDim2.new(0, 100, 0, 30)
button.Position = UDim2.new(0, 120, 0, 10) -- справа от остальных
button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 18
button.Font = Enum.Font.SourceSansBold
button.Text = "⬇ За карту"

button.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(9999, -1000, 9999) -- координаты сильно вне карты
end)
