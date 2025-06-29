local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldNamecall = mt.namecall

mt.namecall = newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if self:IsA("RemoteEvent") and method == "FireServer" then
        if tostring(self):lower():find("speed") or tostring(args[1]):lower():find("speed") then
            return -- блокируем изменение скорости
        end
    end

    return oldNamecall(self, unpack(args))
end)
