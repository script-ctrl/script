local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Координаты точек
local points = {
    {name = "TP 1", pos = CFrame.new(-348, -7, 221)},
    {name = "TP 2", pos = CFrame.new(-348, -7, 112)},
    {name = "TP 3", pos = CFrame.new(-348, -7, 6)},
    {name = "TP 4", pos = CFrame.new(-348, -7, -100)},
    {name = "TP 5", pos = CFrame.new(-471, -7, 221)},
    {name = "TP 6", pos = CFrame.new(-471, -7, 112)},
    {name = "TP 7", pos = CFrame.new(-471, -7, 6)},
    {name = "TP 8", pos = CFrame.new(-471, -7, -100)},
}

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "TPGui"

for i, tp in ipairs(points) do
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Size = UDim2.new(0, 100, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.SourceSansBold
    button.Text = tp.name

    button.MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local duration = 100 -- удержание позиции 100 секунд
        local startTime = tick()

        local conn
        conn = RunService.RenderStepped:Connect(function()
            if tick() - startTime < duration then
                hrp.CFrame = tp.pos
            else
                conn:Disconnect()
            end
        end)
    end)
end
