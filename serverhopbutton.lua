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
local ServerTPButton = Instance.new("TextButton")

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

-- Server Teleport Button via RemoteEvent
ServerTPButton.Parent = ScreenGui
ServerTPButton.BackgroundColor3 = Color3.fromRGB(110, 110, 110)
ServerTPButton.Position = UDim2.new(0, 10, 0, 60)
ServerTPButton.Size = UDim2.new(0, 160, 0, 40)
ServerTPButton.Font = Enum.Font.SourceSansBold
ServerTPButton.Text = "TP to Hand Boos"
ServerTPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ServerTPButton.TextSize = 18

ServerTPButton.MouseButton1Click:Connect(function()
    local remote = ReplicatedStorage:WaitForChild("3beb6e1c-5f7e-4bca-80b1-4dcdd35e2ce7", 10)
    if remote then
        local args = {
            Base = "Hand Boos"
        }
        remote:FireServer(args)
        print("✅ Remote отправлен:", args)
    else
        warn("❌ RemoteEvent не найден!")
    end
end)

-- Server Hop Logic
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

Button.MouseButton1Click:Connect(serverHop)
