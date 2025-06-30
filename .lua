local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Parent = LocalPlayer.PlayerGui

local grabButton = Instance.new("TextButton", screenGui)
grabButton.Size = UDim2.new(0, 160, 0, 40)
grabButton.Position = UDim2.new(0, 20, 0, 210)
grabButton.Text = "Зажать E (Brainrot)"
grabButton.Font = Enum.Font.SourceSansBold
grabButton.TextSize = 18
grabButton.BackgroundColor3 = Color3.fromRGB(100, 60, 60)
grabButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local holding = false
local remoteName = "INTERACT_REMOTE_EVENT"
local remote = ReplicatedStorage:FindFirstChild(remoteName, true)

grabButton.MouseButton1Click:Connect(function()
    holding = not holding
    grabButton.Text = holding and "Отпустить E" or "Зажать E (Brainrot)"
end)

task.spawn(function()
    while true do
        if holding and remote then
            pcall(function()
                remote:FireServer()
            end)
        end
        task.wait(0.1)
    end
end)
