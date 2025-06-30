local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

local noclipEnabled = false
local speedBoost = 2.3 -- множитель скорости

-- GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 160, 0, 40)
toggleBtn.Position = UDim2.new(0, 20, 0, 60)
toggleBtn.Text = "Noclip + Boost: OFF"
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

toggleBtn.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	toggleBtn.Text = noclipEnabled and "Noclip + Boost: ON" or "Noclip + Boost: OFF"
	humanoid.WalkSpeed = noclipEnabled and 16 * speedBoost or 16
end)

-- Непрерывно отключаем столкновения, пока включено
RunService.Stepped:Connect(function()
	if noclipEnabled and player.Character then
		for _, part in pairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)
