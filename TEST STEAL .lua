local DesiredSpeed = 32 -- обычная скорость игрока

-- Получаем игрока и его персонажа
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Авто-возврат скорости
humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if humanoid.WalkSpeed ~= DesiredSpeed then
        humanoid.WalkSpeed = DesiredSpeed
    end
end)

-- На случай если персонаж переспавнится
player.CharacterAdded:Connect(function(char)
    character = char
    humanoid = character:WaitForChild("Humanoid")

    humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        if humanoid.WalkSpeed ~= DesiredSpeed then
            humanoid.WalkSpeed = DesiredSpeed
        end
    end)
end)

-- Установка начальной скорости
humanoid.WalkSpeed = DesiredSpeed
