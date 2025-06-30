local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local noclipEnabled = true

local function ultraHardcoreNoclip()
    local character = player.Character
    if not character then return end
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(function()
                -- Полное отключение коллизии
                part.CanCollide = false
                -- Уменьшаем массу
                part.Massless = true
                -- Обнуляем физические свойства
                part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                -- Обнуляем скорости
                part.Velocity = Vector3.new(0, 30, 0)
                part.RotVelocity = Vector3.new(0, 0, 0)
                part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                -- Отключаем сетевой контроль клиента (передаём серверу)
                part:SetNetworkOwner(nil)
                -- Принудительно ставим позицию (на всякий случай)
                part.CFrame = part.CFrame + Vector3.new(0, 5, 0)
            end)
        end
    end
end

-- Массив событий и таймеров для максимальной частоты вызова
local connections = {}

connections[#connections + 1] = RunService.Stepped:Connect(function()
    if noclipEnabled then ultraHardcoreNoclip() end
end)

connections[#connections + 1] = RunService.Heartbeat:Connect(function()
    if noclipEnabled then ultraHardcoreNoclip() end
end)

connections[#connections + 1] = RunService.RenderStepped:Connect(function()
    if noclipEnabled then ultraHardcoreNoclip() end
end)

spawn(function()
    while noclipEnabled do
        ultraHardcoreNoclip()
        task.wait(0.005) -- максимум частоты
    end
end)

print("Ultra Hardcore Noclip is running! Stay safe.")

-- Чтобы отключить (если нужно), можно вызвать:
-- noclipEnabled = false
-- for _, conn in pairs(connections) do conn:Disconnect() end
