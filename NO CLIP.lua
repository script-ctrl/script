-- Разбиение телепорта на много маленьких шагов
local function stepTeleportForward(steps, distance)
    local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    for i = 1, steps do
        root.CFrame = root.CFrame + root.CFrame.lookVector * (distance / steps)
        wait(0.05)
    end
end

-- Пример: шагов 10, всего на 5 юнитов вперёд
stepTeleportForward(10, 5)
