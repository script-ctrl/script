-- 📦 Создание GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RemoteScannerGUI"
ScreenGui.Parent = game.CoreGui

local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 180, 0, 40)
Button.Position = UDim2.new(0, 20, 0, 100)
Button.Text = "🔍 Сканировать Remote'ы"
Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 16

-- 🛰️ Функция сканирования
local function scanRemotes()
    print("📡 [Remote Scanner] Начинаю сканирование...")

    local total = 0

    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            total += 1
            print("🔧 Найден Remote [" .. obj.ClassName .. "]: " .. obj:GetFullName())
        end
    end

    print("✅ Всего найдено Remote'ов: " .. total)
end

-- 👆 Привязка к кнопке
Button.MouseButton1Click:Connect(scanRemotes)

-- 🕒 Автоскан при запуске
scanRemotes()
