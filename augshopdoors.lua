--[[
    ===================================================================
    🔥 AUGSHOP VIP - DOORS RAYFIELD (Laranja Neon Final) 🔥
    ===================================================================
    - CORREÇÃO DE ABAS: Estrutura linear blindada para evitar crash no executor.
    - BYPASS DE SPEED DEFINITIVO: Usa manipulação de Velocity no Heartbeat (Zero Rubberband).
    - NOCLIP REAL: Loop Stepped para atravessar portas sem cair.
    - VISUAL COMPLETO: ESP Monstros, Itens, Armadilhas e Visão Noturna.
]]

-- // 1. Limpeza de Execuções Anteriores
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
        game:GetService("CoreGui")["Rayfield"]:Destroy()
    end
end)

-- // 2. Variáveis Principais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP_Monsters = false,
    ESP_Items = false,
    ESP_Traps = false,
    AntiEyes = false,
    AutoInteract = false
}

-- // 3. Inicialização Segura da Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 AUGSHOP VIP | DOORS HUB",
    LoadingTitle = "Injetando Bypass Final...",
    LoadingSubtitle = "by AUGSHOP",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- // 4. Alteração do Tema para Laranja Neon
task.spawn(function()
    task.wait(1)
    pcall(function()
        local cGui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
        if cGui then
            for _, v in pairs(cGui:GetDescendants()) do
                if v:IsA("Frame") and v.BackgroundColor3 == Color3.fromRGB(0, 125, 255) then
                    v.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
                elseif v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(0, 125, 255) then
                    v.TextColor3 = Color3.fromRGB(255, 100, 0)
                elseif v:IsA("UIStroke") and v.Color == Color3.fromRGB(0, 125, 255) then
                    v.Color = Color3.fromRGB(255, 100, 0)
                end
            end
        end
    end)
end)

-- =================================================================
-- 📑 CRIAÇÃO DE TODAS AS ABAS PRIMEIRO (Evita que o menu suma)
-- =================================================================
local TabMove = Window:CreateTab("🏃 Movimentação", 4483362458)
local TabVisual = Window:CreateTab("👁️ Visual ESP", 4483362458)
local TabAuto = Window:CreateTab("⚙️ Automações", 4483362458)

-- =================================================================
-- 🏃 ABA 1: MOVIMENTAÇÃO (SPEED & NOCLIP)
-- =================================================================
TabMove:CreateSection("Controles Físicos")

TabMove:CreateSlider({
    Name = "Velocidade Bypass (Speed)",
    Info = "Podes passar de 22 studs! O script usa Velocity para não te puxar para trás.",
    Min = 16,
    Max = 60,
    CurrentValue = 16,
    Flag = "SpeedVal",
    Callback = function(Value)
        Settings.Speed = Value
    end,
})

TabMove:CreateToggle({
    Name = "Atravessar Paredes (Noclip)",
    CurrentValue = false,
    Flag = "NoclipVal",
    Callback = function(Value)
        Settings.Noclip = Value
        if not Value then
            -- Restaura a colisão imediatamente ao desligar
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = true end
                    end
                end
            end)
        end
    end,
})

-- =================================================================
-- 👁️ ABA 2: VISUAL (ESP & LUZ)
-- =================================================================
TabVisual:CreateSection("Radares do Jogo")

TabVisual:CreateToggle({
    Name = "ESP de Monstros (Alerta: Morte)",
    CurrentValue = false,
    Flag = "MonstersESP",
    Callback = function(Value) Settings.ESP_Monsters = Value end,
})

TabVisual:CreateToggle({
    Name = "ESP de Chaves, Ouro & Itens",
    CurrentValue = false,
    Flag = "ItemsESP",
    Callback = function(Value) Settings.ESP_Items = Value end,
})

TabVisual:CreateToggle({
    Name = "ESP de Armadilhas (Snare/Giggle)",
    CurrentValue = false,
    Flag = "TrapsESP",
    Callback = function(Value) Settings.ESP_Traps = Value end,
})

TabVisual:CreateToggle({
    Name = "Visão Noturna (Fullbright)",
    CurrentValue = false,
    Flag = "LightToggle",
    Callback = function(Value)
        Settings.Fullbright = Value
        if not Value then
            Lighting.Brightness = OriginalBrightness
            Lighting.ClockTime = OriginalClockTime
            Lighting.FogEnd = OriginalFogEnd
        end
    end,
})

-- =================================================================
-- ⚙️ ABA 3: AUTOMAÇÕES E HACKS
-- =================================================================
TabAuto:CreateSection("Sobrevivência")

TabAuto:CreateToggle({
    Name = "Modo Deus contra o 'Eyes'",
    CurrentValue = false,
    Flag = "AntiEyes",
    Callback = function(Value) Settings.AntiEyes = Value end,
})

TabAuto:CreateToggle({
    Name = "Coleta Automática e Rápida (Gavetas/Itens)",
    CurrentValue = false,
    Flag = "AutoInteract",
    Callback = function(Value) Settings.AutoInteract = Value end,
})

-- =================================================================
-- 🚀 SISTEMA DE LOOPS E BYPASSES ABSOLUTOS
-- =================================================================

-- 1. O VERDADEIRO BYPASS DE VELOCIDADE DO DOORS (HEARTBEAT VELOCITY)
RunService.Heartbeat:Connect(function()
    pcall(function()
        if Settings.Speed > 16 then
            local char = LocalPlayer.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.MoveDirection.Magnitude > 0 then
                    -- Altera a energia física do boneco. O servidor aceita isto e não dá Rubberband!
                    hrp.Velocity = Vector3.new(hum.MoveDirection.X * Settings.Speed, hrp.Velocity.Y, hum.MoveDirection.Z * Settings.Speed)
                end
            end
        end
    end)
end)

-- 2. NOCLIP SEGURO (STEPPED)
RunService.Stepped:Connect(function()
    pcall(function()
        if Settings.Noclip then
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    -- Desativa colisões de tudo MENOS o chão (HumanoidRootPart)
                    if part:IsA("BasePart") and part.CanCollide and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- 3. LOOP DE RENDERIZAÇÃO GERAL (ESP, LUZ E INTERAÇÃO)
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            -- FULLBRIGHT
            if Settings.Fullbright then
                Lighting.Brightness = 3
                Lighting.ClockTime = 14
                Lighting.FogEnd = 999999
            end

            -- ANTI-EYES
            if Settings.AntiEyes and Workspace:FindFirstChild("Eyes") then
                ReplicatedStorage.EntityInfo.EyesLook:FireServer(false)
            end

            -- AUTO-INTERACT
            if Settings.AutoInteract and hrp then
                local currentRooms = Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in pairs(currentRooms:GetChildren()) do
                        for _, obj in pairs(room:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") and obj.Enabled then
                                local name = obj.Parent and obj.Parent.Name or ""
                                if name:find("Drawer") or name:find("Key") or name:find("Gold") or name:find("LooseGold") then
                                    if (hrp.Position - obj.Parent:GetPivot().Position).Magnitude < 15 then
                                        fireproximityprompt(obj)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- LIMPEZA DE ESP
            local currentRooms = Workspace:FindFirstChild("CurrentRooms")
            if currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, d in pairs(room:GetDescendants()) do if d.Name == "AUG_RAY_ESP" then d:Destroy() end end
                end
            end
            for _, monster in pairs(Workspace:GetChildren()) do
                for _, d in pairs(monster:GetDescendants()) do if d.Name == "AUG_RAY_ESP" then d:Destroy() end end
            end

            -- ESP DE MONSTROS
            if Settings.ESP_Monsters then
                for _, monster in pairs(Workspace:GetChildren()) do
                    if monster.Name:find("Moving") or monster.Name == "Figure" or monster.Name == "SeekMoving" or monster.Name == "Eyes" then
                        local part = monster:FindFirstChildOfClass("BasePart")
                        if part then
                            local b = Instance.new("BillboardGui", monster)
                            b.Name = "AUG_RAY_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 100, 0, 40)
                            local f = Instance.new("Frame", b)
                            f.Size = UDim2.new(1,0,1,0)
                            f.BackgroundColor3 = Color3.fromRGB(20,20,20)
                            f.BorderColor3 = Color3.fromRGB(255,100,0)
                            f.BorderSizePixel = 2
                            local l = Instance.new("TextLabel", f)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = "MONSTRO 🚨"
                            l.TextColor3 = Color3.fromRGB(255,50,0)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 13
                        end
                    end
                end
            end

            -- ESP DE ITENS
            if Settings.ESP_Items and currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, item in pairs(room:GetDescendants()) do
                        if item:IsA("Model") and (item.Name:find("Key") or item.Name:find("Lockpick") or item.Name:find("Vitamins") or item.Name:find("Gold")) then
                            local b = Instance.new("BillboardGui", item)
                            b.Name = "AUG_RAY_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 80, 0, 20)
                            local l = Instance.new("TextLabel", b)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = item.Name
                            l.TextColor3 = Color3.fromRGB(255, 140, 0)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 12
                        end
                    end
                end
            end

            -- ESP DE ARMADILHAS
            if Settings.ESP_Traps and currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, trap in pairs(room:GetDescendants()) do
                        if trap.Name == "Snare" or trap.Name == "Giggle" then
                            local b = Instance.new("BillboardGui", trap)
                            b.Name = "AUG_RAY_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 80, 0, 20)
                            local l = Instance.new("TextLabel", b)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = "ARMADILHA 🚨"
                            l.TextColor3 = Color3.fromRGB(255, 0, 0)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 11
                        end
                    end
                end
            end
            
        end)
    end
end)
