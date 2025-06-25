local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local PlaceId = game.PlaceId

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Button = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.8, 0, 0.8, 0)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Active = true
Frame.Draggable = true

Button.Parent = Frame
Button.BackgroundColor3 = Color3.fromRGB(0, 191, 255) -- Голубой цвет
Button.Position = UDim2.new(0.1, 0, 0.25, 0)
Button.Size = UDim2.new(0.8, 0, 0.5, 0)
Button.Font = Enum.Font.SourceSansBold
Button.Text = "Server Hop"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.TextSize = 24

local function waitForSeconds(seconds)
    local start = tick()
    repeat
        wait()
    until tick() - start >= seconds
end

local function serverHop()
    Button.Text = "Loading..."
    Button.Active = false
    Button.AutoButtonColor = false

    local req = syn and syn.request or http_request or request
    if not req then
        print("Executor не поддерживает HTTP запросы")
        Button.Text = "Server Hop"
        Button.Active = true
        Button.AutoButtonColor = true
        return
    end

    local success, response = pcall(function()
        return req({
            Url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        })
    end)

    if not success or not response then
        print("Ошибка при запросе серверов")
        Button.Text = "Server Hop"
        Button.Active = true
        Button.AutoButtonColor = true
        return
    end

    local decodeSuccess, body = pcall(HttpService.JSONDecode, HttpService, response.Body)
    if not decodeSuccess or not body or not body.data then
        print("Не удалось получить список серверов")
        Button.Text = "Server Hop"
        Button.Active = true
        Button.AutoButtonColor = true
        return
    end

    local servers = {}
    for _, v in ipairs(body.data) do
        if v.playing >= 5 and v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end

    if #servers > 0 then
        local serverId = servers[math.random(#servers)]
        print("Переподключение на сервер:", serverId)
        waitForSeconds(0.5) -- небольшая задержка перед телепортом
        TeleportService:TeleportToPlaceInstance(PlaceId, serverId, game.Players.LocalPlayer)
    else
        print("Нет подходящих серверов для хопа.")
        Button.Text = "Server Hop"
        Button.Active = true
        Button.AutoButtonColor = true
    end
end

Button.MouseButton1Click:Connect(serverHop)
