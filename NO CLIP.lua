-- Кнопка Noclip-телепорта
local noclipButton = Instance.new("TextButton", screenGui)
noclipButton.Size = UDim2.new(0, 120, 0, 40)
noclipButton.Position = UDim2.new(0, 20, 0, 110)
noclipButton.Text = "Сквозь стену"
noclipButton.Font = Enum.Font.SourceSansBold
noclipButton.TextSize = 18
noclipButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)

noclipButton.MouseButton1Click:Connect(function()
    local player = game:GetService("Players").LocalPlayer
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local direction = hrp.CFrame.LookVector.Unit
    local stepSize = 1 -- 1 студ
    local steps = 20
    local delay = 0.01

    for i = 1, steps do
        hrp.CFrame = hrp.CFrame + (direction * stepSize)
        task.wait(delay)
    end
end)
