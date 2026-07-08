--[[
    🔥 AUGSHOP GRATIS - DOORS (Versão Ultimate Corrigida v3.0) 🔥
    - PORTA VERDE/VERMELHA: ESP de portas reais (Verde) e falsas/Dupe (Vermelho).
    - ALERTA "CUIDADO!": Aviso gigante no centro do ecrã quando monstros surgem.
    - AUTO-INTERACT GLOBAL: Abre gavetas e pega chaves/ouro em qualquer sala do jogo.
    - MOVIMENTAÇÃO SEGURA: Velocidade limitada a 22 studs/s para evitar rubberband.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Configurações Globais (Edição Gratuita Completa)
local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP_Monsters = false,
    ESP_Items = false,
    ESP_Doors = false,
    AutoInteract = false,
    EntityNotifier = false,
    AntiScreech = false,
    ReachInteraction = false
}

local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

-- Limpeza de interfaces anteriores
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
        game:GetService("CoreGui").Rayfield:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild("AUG_GiantAlert") then
        LocalPlayer.PlayerGui["AUG_GiantAlert"]:Destroy()
    end
end)

-- ==========================================
-- 🚨 CRIAÇÃO DO ALERTA GIGANTE DE TELA "CUIDADO!"
-- ==========================================
local AlertGui = Instance.new("ScreenGui")
AlertGui.Name = "AUG_GiantAlert"
AlertGui.ResetOnSpawn = false
AlertGui.Enabled = false
AlertGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local AlertLabel = Instance.new("TextLabel")
AlertLabel.Size = UDim2.new(1, 0, 0, 100)
AlertLabel.Position = UDim2.new(0, 0, 0.35, 0)
AlertLabel.BackgroundTransparency = 1
AlertLabel.Text = "CUIDADO!"
AlertLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
AlertLabel.TextSize = 80
AlertLabel.Font = Enum.Font.SourceSansBold
AlertLabel.TextStrokeTransparency = 0
AlertLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
AlertLabel.Parent = AlertGui

local function TriggerGiantAlert()
    task.spawn(function()
        AlertGui.Enabled = true
        for i = 1, 10 do
            AlertLabel.Visible = true
            task.wait(0.25)
            AlertLabel.Visible = false
            task.wait(0.25)
        end
        AlertGui.Enabled = false
    end)
end

-- ==========================================
-- 🎨 INICIALIZAR RAYFIELD UI
-- ==========================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 AUGSHOP GRATIS | DOORS HUB",
    LoadingTitle = "Injetando Versão Grátis...",
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
-- 🏃 ABA 1: MOVIMENTAÇÃO
-- ==========================================
local TabMove = Window:CreateTab("🏃 Movimentação", 4483362458)

TabMove:CreateSlider({
    Name = "Velocidade Segura (Speed)",
    Info = "Limitado a 22 para segurança absoluta contra o anti-cheat.",
    Range = {16, 22},
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
    Name = "ESP de Portas (Verde / Vermelho)",
    CurrentValue = false,
    Flag = "EspDoorsToggle",
    Callback = function(Value)
        Settings.ESP_Doors = Value
        if not Value then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "AUG_ESP_DOOR" then v:Destroy() end
            end
        end
    end,
})

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
-- ⚙️ ABA 3: AUTOMAÇÕES & PROTEÇÃO
-- ==========================================
local TabAuto = Window:CreateTab("⚙️ Automações", 4483362458)

TabAuto:CreateToggle({
    Name = "Alerta de Entidades (Aviso Gigante)",
    CurrentValue = false,
    Flag = "ToggleNotifier",
    Callback = function(Value)
        Settings.EntityNotifier = Value
    end,
})

TabAuto:CreateToggle({
    Name = "Anti-Screech (Olhar Automático)",
    CurrentValue = false,
    Flag = "ToggleAntiScreech",
    Callback = function(Value)
        Settings.AntiScreech = Value
    end,
})

TabAuto:CreateToggle({
    Name = "Alcance Estendido (Longa Distância)",
    CurrentValue = false,
    Flag = "ToggleReach",
    Callback = function(Value)
        Settings.ReachInteraction = Value
    end,
})

TabAuto:CreateToggle({
    Name = "Auto-Coletor de Ouro & Gavetas",
    CurrentValue = false,
    Flag = "ToggleAutoInteract",
    Callback = function(Value)
        Settings.AutoInteract = Value
    end,
})

-- ==========================================
-- 🚀 LOOPS E SISTEMAS DO SCRIPT
-- ==========================================

-- NOCLIP
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

-- SPEED MOVEMENT
RunService.RenderStepped:Connect(function(dt)
    pcall(function()
        if Settings.Speed > 16 then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.MoveDirection.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * ((Settings.Speed - 16) * dt))
            end
        end
    end)
end)

-- FUNÇÃO AUXILIAR DE ESP
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
            billboard.Size = UDim2.new(0, 130, 0, 30)
            billboard.Parent = targetPart

            local frame = Instance.new("Frame", billboard)
            frame.Size = UDim2.new(1, 0, 1, 0)
            frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
            frame.BackgroundTransparency = 0.25
            frame.BorderColor3 = color
            frame.BorderSizePixel = 1.5

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

-- LOOP CENTRALIZADO DE RENDERIZAÇÃO
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local camera = Workspace.CurrentCamera

            -- 1. FULLBRIGHT
            if Settings.Fullbright then
                Lighting.Brightness = 3
                Lighting.ClockTime = 12
                Lighting.FogEnd = 999999
            end

            -- 2. ALERTA GIGANTE DE MONSTROS
            if Settings.EntityNotifier then
                for _, obj in pairs(Workspace:GetChildren()) do
                    if (obj.Name == "RushMoving" or obj.Name == "AmbushMoving") and not obj:FindFirstChild("AUG_Notified") then
                        Instance.new("BoolValue", obj).Name = "AUG_Notified"
                        TriggerGiantAlert()
                    end
                end
            end

            -- 3. ANTI-SCREECH
            if Settings.AntiScreech then
                local screech = camera:FindFirstChild("Screech") or Workspace:FindFirstChild("Screech")
                if screech then
                    local part = screech:FindFirstChild("Core") or screech:FindFirstChildWhichIsA("BasePart")
                    if part then
                        camera.CFrame = CFrame.new(camera.CFrame.Position, part.Position)
                    end
                end
            end

            -- 4. ALCANCE DE INTERAÇÃO (REACH)
            if Settings.ReachInteraction then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        obj.MaxActivationDistance = 22
                    end
                end
            end

            -- 5. AUTO-INTERACT GLOBAL (Agora escaneia os arredores do jogador diretamente!)
            if Settings.AutoInteract and hrp then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") and obj.Enabled then
                        local parent = obj.Parent
                        if parent then
                            local pName = parent.Name
                            -- Verifica se o objeto está num raio de 16 studs de distância do jogador
                            local pos = parent:IsA("Model") and parent:GetPivot().Position or (parent:IsA("BasePart") and parent.Position or nil)
                            if pos and (hrp.Position - pos).Magnitude < 16 then
                                -- Filtra apenas chaves, moedas, gavetas ou itens
                                if pName:find("Drawer") or pName:find("Key") or pName:find("Gold") or pName:find("Lockpick") or pName:find("Lighter") or pName:find("Vitamins") then
                                    obj.HoldDuration = 0
                                    fireproximityprompt(obj)
                                end
                            end
                        end
                    end
                end
            end

            -- ==========================================
            -- 🧹 RE-RENDERIZAÇÃO SELETIVA DE ESP
            -- ==========================================
            
            -- Limpar marcas antigas
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "AUG_ESP_MONSTER" or v.Name == "AUG_ESP_ITEM" or v.Name == "AUG_ESP_DOOR" then
                    v:Destroy()
                end
            end

            -- ESP DE MONSTROS
            if Settings.ESP_Monsters then
                for _, obj in pairs(Workspace:GetChildren()) do
                    if obj.Name:find("Moving") or obj.Name == "Figure" or obj.Name == "SeekMoving" or obj.Name == "Eyes" then
                        CreateESP(obj, "🚨 MONSTRO", Color3.fromRGB(255, 30, 30), "AUG_ESP_MONSTER")
                    end
                end
            end

            -- ESP DE ITENS
            if Settings.ESP_Items then
                for _, item in pairs(Workspace:GetDescendants()) do
                    if item:IsA("Model") then
                        local iName = item.Name
                        if iName:find("Key") or iName:find("Lockpick") or iName:find("Lighter") or iName:find("Vitamins") then
                            CreateESP(item, "🔑 " .. iName, Color3.fromRGB(255, 140, 0), "AUG_ESP_ITEM")
                        end
                    end
                end
            end

            -- ESP DE PORTAS (VERDE E VERMELHO)
            if Settings.ESP_Doors then
                local currentRooms = Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in pairs(currentRooms:GetChildren()) do
                        for _, obj in pairs(room:GetChildren()) do
                            -- Detetar portas normais (Reais)
                            if obj.Name == "Door" and obj:FindFirstChild("ClientDoor") then
                                CreateESP(obj.ClientDoor, "🚪 PORTA REAL", Color3.fromRGB(46, 204, 113), "AUG_ESP_DOOR")
                            end
                            -- Detetar portas do Dupe (Falsas)
                            if obj.Name == "DupeDoor" and obj:FindFirstChild("Door") then
                                CreateESP(obj.Door, "🚨 PORTA FALSA!", Color3.fromRGB(231, 76, 60), "AUG_ESP_DOOR")
                            end
                        end
                    end
                end
            end

        end)
    end
end)
