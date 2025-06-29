local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Список точек
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

-- Настройки
local delayBetweenTP = 3 -- ⏱️ задержка между точками (в секундах)
local holdTime = 2        -- 🛑 сколько секунд спамить телепорт
local successRange = 5    -- 🎯 точность достижения цели
local loop = true         -- 🔁 зациклить

-- Упорный телепорт
local function hardTeleport(targetPos)
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    local start = tick()
    local conn

    conn = RunService.RenderStepped:Connect(function()
        if not char or not hrp or not hrp.Parent then
            conn:Disconnect()
            return
        end

        local distance = (hrp.Position - targetPos).Magnitude
        if distance < successRange then
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

-- 🔁 Цикл по всем точкам
task.spawn(function()
    while loop do
        for _, pos in ipairs(points) do
            local char = player.Character or player.CharacterAdded:Wait()
            hardTeleport(pos)
            task.wait(holdTime + delayBetweenTP)
        end
    end
end)
