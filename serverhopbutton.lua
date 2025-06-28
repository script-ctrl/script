local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local PlaceId = game.PlaceId

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local Status = Instance.new("TextLabel")
local TPButton = Instance.new("TextButton")

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

-- Teleport to Center Button
TPButton.Parent = ScreenGui
TPButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
TPButton.Position = UDim2.new(0, 10, 0, 10)
TPButton.Size = UDim2.new(0, 140, 0, 40)
TPButton.Font = Enum.Font.SourceSansBold
TPButton.Text = "TP to Center"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TPButton.TextSize = 20

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

    wait(10)
    Status.Text = "Ready"
    isBusy = false
end

local function teleportToCenter()
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    -- Центр карты — укажи свои координаты
    local targetCFrame = CFrame.new(0, 10, 0) -- Измени на нужные координаты
    local tween = TweenService:Create(hrp, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = targetCFrame})
    tween:Play()
end

Button.MouseButton1Click:Connect(serverHop)
TPButton.MouseButton1Click:Connect(teleportToCenter)
