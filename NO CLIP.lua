local Players = game:GetService("Players")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local function tryPickBrainrot()
    local character = player.Character
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- Raycast ignoring стены (игнорируем все кроме Brainrot)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    -- Предположим, что у тебя есть группа или таблица со всеми стенами, которые игнорируем
    -- Если нет, можно указать всю карту, кроме Brainrot, но обычно нужно точное указание

    -- Пример: игнорируем все кроме объектов с именем "Brainrot"
    params.FilterDescendantsInstances = {}
    params.IgnoreWater = true

    local origin = hrp.Position
    local direction = hrp.CFrame.LookVector * 20 -- длина луча 20

    local result = workspace:Raycast(origin, direction, params)
    if result and result.Instance and result.Instance.Name == "Brainrot" then
        print("Brainrot найден, пытаемся взять")
        -- Здесь вызывай логику взятия предмета
        -- Например, RemoteEvent для взятия или просто поднять объект
    else
        print("Brainrot не найден")
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
        tryPickBrainrot()
    end
end)
