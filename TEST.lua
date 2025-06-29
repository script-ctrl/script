local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlaceId = game.PlaceId

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local Status = Instance.new("TextLabel")
local TPButton = Instance.new("TextButton")
local RemoteTPButton = Instance.new("TextButton")
local TPButtons = {}

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Server Hop Frame
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.8, 0, 0.8, 0)
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Button.Position = UDim2.new(0.1, 0, 0.2, 0)
Button.Size = UDim2.new(0.8, 0, 0.4, 0)
Button.Font = Enum.Font.SourceSansBold
Button.Text = "Server Hop"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 24

Status.Parent = Frame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0.1, 0, 0.7, 0)
Status.Size = UDim2.new(0.8, 0, 0.2, 0)
Status.Font = Enum.Font.SourceSans
Status.Text = "Ready"
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.TextSize = 16

-- Remote TP Button (серверный обход античита)
RemoteTPButton.Parent = ScreenGui
RemoteTPButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
RemoteTPButton.Position = UDim2.new(0, 10, 0, 420)
RemoteTPButton.Size = UDim2.new(0, 140, 0, 40)
RemoteTPButton.Font = Enum.Font.SourceSansBold
RemoteTPButton.Text = "Brute Force TP"
RemoteTPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RemoteTPButton.TextSize = 18

-- Функция телепорта с Tween + удержание
local function teleportToPosition(goal)
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    local tween = TweenService:Create(hrp, TweenInfo.new(0.7), {CFrame = goal})
    tween:Play()
    tween.Completed:Wait()

    local t0 = tick()
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if tick() - t0 < 2 then
            hrp.CFrame = goal
        else
            conn:Disconnect()
        end
    end)
end

-- Создание кнопок для каждой позиции
local coordinates = {
    {name = "TP 1", pos = CFrame.new(-348, -5, 221)},
    {name = "TP 2", pos = CFrame.new(-348, -5, 112)},
    {name = "TP 3", pos = CFrame.new(-348, -5, 6)},
    {name = "TP 4", pos = CFrame.new(-348, -5, -100)},
    {name = "TP 5", pos = CFrame.new(-471, -5, 221)},
    {name = "TP 6", pos = CFrame.new(-471, -5, 112)},
    {name = "TP 7", pos = CFrame.new(-471, -5, 6)},
    {name = "TP 8", pos = CFrame.new(-471, -5, -100)}
}

for i, data in ipairs(coordinates) do
    local btn = Instance.new("TextButton")
    btn.Parent = ScreenGui
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.Position = UDim2.new(0, 10, 0, 60 + (i - 1) * 45)
    btn.Size = UDim2.new(0, 140, 0, 40)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = data.name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 18

    btn.MouseButton1Click:Connect(function()
        teleportToPosition(data.pos)
    end)

    table.insert(TPButtons, btn)
end

local isBusy = false

local function serverHop()
    if isBusy then
        print("Подожди...")
        return
    end

    isBusy = true
    Status.Text = "Searching servers..."

    local req = syn and syn.request or http_request or request
    if not req then
        print("Executor не поддерживает HTTP запросы")
        Status.Text = "Error: no http_request"
        isBusy = false
        return
    end

    local success, response = pcall(function()
        return req({
            Url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        })
    end)

    if not success or not response then
        Status.Text = "Request failed"
        isBusy = false
        return
    end

    local body = HttpService:JSONDecode(response.Body)
    local servers = {}

    for _, v in pairs(body.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end

    if #servers > 0 then
        local serverId = servers[math.random(#servers)]
        Status.Text = "Teleporting..."
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, Players.LocalPlayer)
    else
        Status.Text = "No servers found"
    end

    task.wait(10)
    Status.Text = "Ready"
    isBusy = false
end

-- Серверный Brute Force TP
RemoteTPButton.MouseButton1Click:Connect(function()
    local remote = ReplicatedStorage:FindFirstChild("3beb6e1c-5f7e-4bca-80b1-4dcdd35e2ce7")
    if not remote then warn("RemoteEvent не найден") return end

    local attempts = {
        {slot = 1}, {Slot = 1}, {id = 1}, {Id = 1},
        {Zone = "Base1"}, {zone = "Base1"},
        {Base = "Hand Boos"}, {base = "Hand Boos"},
        {Name = "TP1"}, {Target = "TP1"}, {Location = "TP1"},
        {[""] = ""}, {"TP1"}, {"Base1"}, {"Hand Boos"},
    }

    for i, arg in ipairs(attempts) do
        print("🚀 Пробуем вариант #", i)
        pcall(function()
            remote:FireServer(arg)
        end)
        task.wait(0.5)
    end
end)

Button.MouseButton1Click:Connect(serverHop)
