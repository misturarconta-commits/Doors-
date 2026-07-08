--[[
    🔥 AUGSHOP GRATIS - DOORS RAYFIELD (Versão Free v1.0) 🔥
    - LIMITE SEGURO: Velocidade limitada a 22 studs/s para evitar 100% de rubberband.
    - ESP ESTÁVEL: Rastreamento preciso de Monstros e Itens do mapa.
    - AUTO-INTERACT: Abertura automática de gavetas sem tempo de espera.
    - PREPARAÇÃO VIP: Base sólida para a futura versão paga do projeto.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Configurações Globais (Edição Gratuita)
local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP_Monsters = false,
    ESP_Items = false,
    AutoInteract = false
}

local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

-- Limpeza de interfaces anteriores
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
        game:GetService("CoreGui").Rayfield:Destroy()
    end
end)

-- Carregar Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 AUGSHOP GRATIS | DOORS HUB",
    LoadingTitle = "Injetando Versão Gratuita...",
    LoadingSubtitle = "by AUGSHOP",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Customização de Cores: Laranja Neon
task.spawn(function()
    task.wait(1)
    pcall(function()
        for _, v in pairs(game:GetService("CoreGui").Rayfield:GetDescendants()) do
            if v:IsA("Frame") and v.BackgroundColor3 == Color3.fromRGB(0, 125, 255) then
                v.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
            elseif v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(0, 125, 255) then
                v.TextColor3 = Color3.fromRGB(255, 100, 0)
            elseif v:IsA("UIStroke") and v.Color == Color3.fromRGB(0, 125, 255) then
                v.Color = Color3.fromRGB(255, 100, 0)
            end
        end
    end)
end)

-- ==========================================
-- 🏃 ABA 1: MOVIMENTAÇÃO (GRATIS - LIMITADO)
-- ==========================================
local TabMove = Window:CreateTab("🏃 Movimentação", 4483362458)

TabMove:CreateSlider({
    Name = "Velocidade Segura (Speed)",
    Info = "Limitado a 22 studs/s na versão grátis para segurança total.",
    Range = {16, 22}, -- Limitado até 22 conforme solicitado
    Increment = 1,
    CurrentValue = 16,
    Flag = "SliderSpeed",
    Callback = function(Value)
        Settings.Speed = Value
    end,
})

TabMove:CreateToggle({
    Name = "Atravessar Paredes (Noclip)",
    CurrentValue = false,
    Flag = "ToggleNoclip",
    Callback = function(Value)
        Settings.Noclip = Value
        if not Value then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, v in pairs(char:GetDescendants()) do
                        if v:IsA("BasePart") then v.CanCollide = true end
                    end
                end
            end)
        end
    end,
})

-- ==========================================
-- 👁️ ABA 2: VISUAIS & ESP
-- ==========================================
local TabVisual = Window:CreateTab("👁️ Visuais", 4483362458)

TabVisual:CreateToggle({
    Name = "ESP Monstros",
    CurrentValue = false,
    Flag = "EspMonstersToggle",
    Callback = function(Value)
        Settings.ESP_Monsters = Value
        if not Value then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "AUG_ESP_MONSTER" then v:Destroy() end
            end
        end
    end,
})

TabVisual:CreateToggle({
    Name = "ESP Chaves e Itens Úteis",
    CurrentValue = false,
    Flag = "EspItemsToggle",
    Callback = function(Value)
        Settings.ESP_Items = Value
        if not Value then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "AUG_ESP_ITEM" then v:Destroy() end
            end
        end
    end,
})

TabVisual:CreateToggle({
    Name = "Visão Noturna (Fullbright)",
    CurrentValue = false,
    Flag = "ToggleLight",
    Callback = function(Value)
        Settings.Fullbright = Value
        if not Value then
            Lighting.Brightness = 1
            Lighting.ClockTime = 14
            Lighting.FogEnd = 250
        end
    end,
})

-- ==========================================
-- ⚙️ ABA 3: AUTOMAÇÕES
-- ==========================================
local TabAuto = Window:CreateTab("⚙️ Automações", 4483362458)

TabAuto:CreateToggle({
    Name = "Auto-Coletor de Ouro & Gavetas",
    CurrentValue = false,
    Flag = "ToggleAutoInteract",
    Callback = function(Value)
        Settings.AutoInteract = Value
    end,
})

-- ==========================================
-- 🚀 SISTEMA DE LOOPS DO CLIENT
-- ==========================================

-- LOOP DE NOCLIP
RunService.Stepped:Connect(function()
    pcall(function()
        if Settings.Noclip then
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- LOOP DE MOVIMENTO SUAVE (ATÉ 22 STUDS)
RunService.RenderStepped:Connect(function(dt)
    pcall(function()
        if Settings.Speed > 16 then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.MoveDirection.Magnitude > 0 then
                -- Movimenta suavemente sem mexer na propriedade WalkSpeed padrão
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * ((Settings.Speed - 16) * dt))
            end
        end
    end)
end)

-- FUNÇÃO AUXILIAR DE ESP (Sempre atrelada a uma BasePart válida)
local function CreateESP(parentObject, title, color, espName)
    pcall(function()
        local targetPart = nil
        if parentObject:IsA("BasePart") then
            targetPart = parentObject
        elseif parentObject:IsA("Model") then
            targetPart = parentObject.PrimaryPart or parentObject:FindFirstChildWhichIsA("BasePart")
        end

        if targetPart and not targetPart:FindFirstChild(espName) then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = espName
            billboard.Adornee = targetPart
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.Parent = targetPart

            local frame = Instance.new("Frame", billboard)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            frame.BackgroundTransparency = 0.3
            frame.BorderColor3 = color
            frame.BorderSizePixel = 1

            local label = Instance.new("TextLabel", frame)
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = title
            label.TextColor3 = color
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = 12
        end
    end)
end

-- LOOP PRINCIPAL (ESP, FULLBRIGHT & AUTO-INTERACT)
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            -- FULLBRIGHT
            if Settings.Fullbright then
                Lighting.Brightness = 3
                Lighting.ClockTime = 12
                Lighting.FogEnd = 999999
            end

            -- AUTO INTERACT
            if Settings.AutoInteract and hrp then
                local currentRooms = Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in pairs(currentRooms:GetChildren()) do
                        for _, desc in pairs(room:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") and desc.Enabled then
                                local pName = desc.Parent and desc.Parent.Name or ""
                                if pName:find("Drawer") or pName:find("Key") or pName:find("Gold") or pName:find("Lockpick") or pName:find("Lighter") then
                                    local pos = desc.Parent:IsA("Model") and desc.Parent:GetPivot().Position or (desc.Parent:IsA("BasePart") and desc.Parent.Position or nil)
                                    if pos and (hrp.Position - pos).Magnitude < 14 then
                                        desc.HoldDuration = 0 -- Remove delay para pegar na hora
                                        fireproximityprompt(desc)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- ESP MONSTROS
            if Settings.ESP_Monsters then
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj.Name:find("Moving") or obj.Name == "Figure" or obj.Name == "SeekMoving" or obj.Name == "Eyes" then
                        CreateESP(obj, "🚨 MONSTRO", Color3.fromRGB(255, 30, 30), "AUG_ESP_MONSTER")
                    end
                end
            end

            -- ESP ITENS
            if Settings.ESP_Items then
                local currentRooms = Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in pairs(currentRooms:GetChildren()) do
                        for _, item in pairs(room:GetDescendants()) do
                            if item:IsA("Model") then
                                local iName = item.Name
                                if iName:find("Key") or iName:find("Lockpick") or iName:find("Lighter") or iName:find("Vitamins") then
                                    CreateESP(item, iName, Color3.fromRGB(255, 140, 0), "AUG_ESP_ITEM")
                                end
                            end
                        end
                    end
                end
            end

        end)
    end
end)
