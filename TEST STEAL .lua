local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Попытка увеличить SimulationRadius для обхода античита
pcall(function()
    sethiddenproperty(player, "SimulationRadius", math.huge)
    sethiddenproperty(player, "MaximumSimulationRadius", math.huge)
end)

local points = {
    Vector3.new(-348, -6.6, 221),
    Vector3.new(-348, -6.6, 112),
    Vector3.new(-348, -6.6, 6),
    Vector3.new(-348, -6.6, -100),
    Vector3.new(-471, -6.6, 221),
    Vector3.new(-471, -6.6, 112),
    Vector3.new(-471, -6.6, 6),
    Vector3.new(-471, -6.6, -100),
}

local function smoothTeleport(targetPos)
    local stepSize = 2 -- маленький шаг, 2 студии
    local currentPos = hrp.Position
    local direction = (targetPos - currentPos).Unit
    local distance = (targetPos - currentPos).Magnitude
    local steps = math.floor(distance / stepSize)

    for i = 1, steps do
        local newPos = currentPos + direction * (i * stepSize)
        char:PivotTo(CFrame.new(newPos))
        task.wait(0.01) -- очень короткая задержка
    end

    -- Финальный шаг
    char:PivotTo(CFrame.new(targetPos))
end

-- Пример вызова телепорта для первой точки
smoothTeleport(points[1])
