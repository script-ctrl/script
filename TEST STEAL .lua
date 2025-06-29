local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Точки
local points = {
    {name = "TP 1", pos = Vector3.new(-348, -6.6, 221)},
    {name = "TP 2", pos = Vector3.new(-348, -6.6, 112)},
    {name = "TP 3", pos = Vector3.new(-348, -6.6, 6)},
    {name = "TP 4", pos = Vector3.new(-348, -6.6, -100)},
    {name = "TP 5", pos = Vector3.new(-471, -6.6, 221)},
    {name = "TP 6", pos = Vector3.new(-471, -6.6, 112)},
    {name = "TP 7", pos = Vector3.new(-471, -6.6, 6)},
    {name = "TP 8", pos = Vector3.new(-471, -6.6, -100)},
}

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HardTPGui"

-- Настройки
local holdTime = 2 -- сколько секунд спамить
local successRange = 5 -- насколько близко нужно подойти

-- Функция упорного телепорта
local function hardTeleport(targetPos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local start = tick()
    local reached = false

    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not char or not hrp or not hrp.Parent then
            conn:Disconnect()
            return
        end

        local distance = (hrp.Position - targetPos).Magnitude
        if distance < successRange then
            reached = true
            conn:Disconnect()
            return
        end

        if tick() - start > holdTime then
            conn:Disconnect()
            return
        end

        char:PivotTo(CFrame.new(targetPos))
    end)
end

-- Создание кнопок
for i, tp in ipairs(points) do
    local button = Instance.new("TextButton")
    button.Parent = gui
    button.Size = UDim2.new(0, 140, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 10 + (i - 1) * 35)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 18
    button.Font = Enum.Font.SourceSansBold
    button.Text = tp.name

    button.MouseButton1Click:Connect(function()
        hardTeleport(tp.pos)
    end)
end
