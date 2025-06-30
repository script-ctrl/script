local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- === GUI ===
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "EventScannerGUI"

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 350, 0, 300)
frame.Position = UDim2.new(0, 20, 0, 160)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Visible = false

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Text = "Remote & Bindable Events"
title.BorderSizePixel = 0

local closeButton = Instance.new("TextButton", title)
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "X"
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)

closeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Size = UDim2.new(1, -10, 1, -50)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 8

local uiListLayout = Instance.new("UIListLayout", scrollFrame)
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0, 4)

-- === Кнопка: открыть чат ===
local openButton = Instance.new("TextButton", screenGui)
openButton.Size = UDim2.new(0, 120, 0, 40)
openButton.Position = UDim2.new(0, 20, 0, 60)
openButton.Text = "Открыть чат"
openButton.Font = Enum.Font.SourceSansBold
openButton.TextSize = 18
openButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)

openButton.MouseButton1Click:Connect(function()
    frame.Visible = true
end)

-- === Кнопка: noclip прыжок ===
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
    local stepSize = 1 -- шаг
    local steps = 20   -- сколько шагов
    local delay = 0.01

    for i = 1, steps do
        hrp.CFrame = hrp.CFrame + (direction * stepSize)
        task.wait(delay)
    end
end)

-- === Сканер Remote'ов и Bindable ===
local function scanRemotes()
    for _, child in pairs(scrollFrame:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end

    local containers = {
        game:GetService("ReplicatedStorage"),
        game:GetService("ReplicatedFirst"),
        game:GetService("Workspace"),
        game:GetService("StarterGui"),
        game:GetService("Players"),
        game:GetService("Lighting"),
        game:GetService("StarterPack"),
        game:GetService("StarterPlayer"),
    }

    local count = 0
    for _, container in pairs(containers) do
        for _, obj in ipairs(container:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") or obj:IsA("BindableEvent") or obj:IsA("BindableFunction") then
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -10, 0, 25)
                label.BackgroundTransparency = 0.5
                label.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.Font = Enum.Font.SourceSans
                label.TextSize = 16
                label.Text = string.format("[%s] %s", obj.ClassName, obj:GetFullName())
                label.Parent = scrollFrame
                count += 1
            end
        end
    end

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, count * 29)
end

-- Запуск сканера
scanRemotes()
 
