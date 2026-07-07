--[[
    ===================================================================
    👑 AUGSHOP VIP - DOORS ORION SUPREME (Versão 4.0)
    ===================================================================
    - INTERFACE ORION UI: Design redondo, moderno e com animações fluidas.
    - BYPASS DE VELOCIDADE REAL: Usa Velocity-Spoof (Zero Rubberband).
    - NOCLIP ABSOLUTO: Passa por paredes e portas sem cair no vazio.
    - ANTI-EYES GOD MODE: Proteção automática contra o dano dos Eyes.
    - AUTO-INTERACT: Abre gavetas e recolhe itens/ouro sozinho.
    - VISÃO SUPREMA: ESP de Monstros ("Morte"), Chaves e Fullbright.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- // Limpeza de interfaces anteriores e botão flutuante
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Orion") then game:GetService("CoreGui")["Orion"]:Destroy() end
    if game:GetService("CoreGui"):FindFirstChild("AUGSHOP_VIP_BUTTON") then game:GetService("CoreGui")["AUGSHOP_VIP_BUTTON"]:Destroy() end
    if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("AUGSHOP_VIP_BUTTON") then LocalPlayer.PlayerGui["AUGSHOP_VIP_BUTTON"]:Destroy() end
end)

-- // Inicialização da Orion UI (Layout Arredondado)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- // Configurações Globais Avançadas
local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP_Monsters = false,
    ESP_Items = false,
    AntiEyes = false,
    AutoInteract = false,
    AutoEletricidade = false
}

local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

-- =================================================================
-- ⏺️ BOTÃO FLUTUANTE CIRCULAR ORION (AUGSHOP)
-- =================================================================
local TargetGuiParent = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local ButtonGui = Instance.new("ScreenGui")
ButtonGui.Name = "AUGSHOP_VIP_BUTTON"
ButtonGui.Parent = TargetGuiParent
ButtonGui.ResetOnSpawn = false

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 65, 0, 65)
ToggleButton.Position = UDim2.new(0.05, 0, 0.2, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleButton.Text = "AUGSHOP"
ToggleButton.TextColor3 = Color3.fromRGB(0, 180, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 12
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ButtonGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0) -- Círculo Perfeito
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2.5
ToggleStroke.Color = Color3.fromRGB(0, 180, 255)
ToggleStroke.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    pcall(function()
        local orionGui = game:GetService("CoreGui"):FindFirstChild("Orion")
        if orionGui then
            orionGui.Enabled = not orionGui.Enabled
        end
    end)
end)

-- =================================================================
-- 🎨 CRIAÇÃO DA JANELA PRINCIPAL ORION
-- =================================================================
local Window = OrionLib:MakeWindow({
    Name = "👑 AUGSHOP VIP | DOORS V4.0", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "AUGSHOP VIP HUBS",
    IntroIcon = "rbxassetid://4483362458"
})

-- ABA 1: MOVIMENTAÇÃO (BYPASS DE ANTI-CHEAT)
local TabMove = Window:MakeTab({ Name = "Física & Movimento", Icon = "rbxassetid://4483362458", Premium = false })

TabMove:AddSlider({
    Name = "Velocidade (Velocity-Spoof)",
    Min = 16,
    Max = 75,
    Default = 16,
    Color = Color3.fromRGB(0, 180, 255),
    Increment = 1,
    ValueName = "studs/s",
    Callback = function(Value)
        Settings.Speed = Value
    end    
})

TabMove:AddToggle({
    Name = "Noclip de Colisão Seletiva",
    Default = false,
    Callback = function(Value)
        Settings.Noclip = Value
    end
})

-- ABA 2: PERCEPÇÃO VISUAL
local TabVisual = Window:MakeTab({ Name = "Visual ESP", Icon = "rbxassetid://4483362458", Premium = false })

TabVisual:AddToggle({
    Name = "ESP de Monstros (Aviso: 'Morte')",
    Default = false,
    Callback = function(Value) Settings.ESP_Monsters = Value end
})

TabVisual:AddToggle({
    Name = "ESP de Chaves e Itens Úteis",
    Default = false,
    Callback = function(Value) Settings.ESP_Items = Value end
})

TabVisual:AddToggle({
    Name = "Visão Noturna Absoluta (Fullbright)",
    Default = false,
    Callback = function(Value)
        Settings.Fullbright = Value
        if not Value then
            Lighting.Brightness = OriginalBrightness
            Lighting.ClockTime = OriginalClockTime
            Lighting.FogEnd = OriginalFogEnd
        end
    end
})

-- ABA 3: SOBREVIVÊNCIA E AUTOMAÇÃO
local TabAuto = Window:MakeTab({ Name = "Automação & God", Icon = "rbxassetid://4483362458", Premium = false })

TabAuto:AddToggle({
    Name = "Modo Deus contra o 'Eyes'",
    Default = false,
    Callback = function(Value) Settings.AntiEyes = Value end
})

TabAuto:AddToggle({
    Name = "Auto-Interagir (Abrir/Pegar Itens)",
    Default = false,
    Callback = function(Value) Settings.AutoInteract = Value end
})

TabAuto:AddToggle({
    Name = "Auto-Solucionar Disjuntor (Porta 100)",
    Default = false,
    Callback = function(Value) Settings.AutoEletricidade = Value end
})

-- =================================================================
-- ⚙️ SINO DE LOOPS PRINCIPAIS (ENGENHARIA DE BYPASS)
-- =================================================================

-- 1. Loop de Velocidade por Força Linear (Substitui o CFrame e remove o Rubberband)
RunService.PostSimulation:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        if Settings.Speed > 16 then
            if hum.MoveDirection.Magnitude > 0 then
                -- Move o personagem alterando o vetor de força linear aceito pelo servidor
                local targetVelocity = hum.MoveDirection * Settings.Speed
                hrp.AssemblyLinearVelocity = Vector3.new(targetVelocity.X, hrp.AssemblyLinearVelocity.Y, targetVelocity.Z)
            end
        end
    end)
end)

-- 2. Loop de Noclip Avançado por Mudança de Estado
RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if Settings.Noclip then
            hum:ChangeState(Enum.HumanoidStateType.NoPhysics)
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- 3. Loop de Automação, ESP e Anti-Eyes
task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            -- Fullbright
            if Settings.Fullbright then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 999999
            end

            -- Anti-Eyes (God Mode contra Eyes)
            if Settings.AntiEyes and Workspace:FindFirstChild("Eyes") then
                -- Dispara o evento dizendo que você está olhando para trás/baixo, anulando o dano do monstro
                ReplicatedStorage.EntityInfo.EyesLook:FireServer(false)
            end

            -- Auto-Interact (Abre gavetas e coleta ouro/chaves de forma nativa e rápida)
            if Settings.AutoInteract and hrp then
                local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
                if CurrentRooms then
                    for _, room in pairs(CurrentRooms:GetChildren()) do
                        for _, obj in pairs(room:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") and obj.Enabled then
                                local parentName = obj.Parent and obj.Parent.Name or ""
                                if parentName:find("Drawer") or parentName:find("Key") or parentName:find("Gold") or parentName:find("LooseGold") then
                                    local dist = (hrp.Position - obj.Parent:GetPivot().Position).Magnitude
                                    if dist < 15 then
                                        fireproximityprompt(obj)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- Limpeza e Atualização do ESP Supremo
            local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
            if CurrentRooms then
                for _, r in pairs(CurrentRooms:GetChildren()) do
                    for _, c in pairs(r:GetDescendants()) do if c.Name == "AUG_Orion_ESP" then c:Destroy() end end
                end
            end
            for _, m in pairs(Workspace:GetChildren()) do
                for _, c in pairs(m:GetDescendants()) do if c.Name == "AUG_Orion_ESP" then c:Destroy() end end
            end

            -- Renderizar ESP de Monstros
            if Settings.ESP_Monsters then
                for _, monster in pairs(Workspace:GetChildren()) do
                    if monster.Name:find("Moving") or monster.Name == "Figure" or monster.Name == "SeekMoving" or monster.Name == "Eyes" then
                        local part = monster:FindFirstChildOfClass("BasePart")
                        if part then
                            local b = Instance.new("BillboardGui", monster)
                            b.Name = "AUG_Orion_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 90, 0, 35)
                            
                            local f = Instance.new("Frame", b)
                            f.Size = UDim2.new(1,0,1,0)
                            f.BorderColor3 = Color3.fromRGB(255, 0, 0)
                            f.BorderSizePixel = 2
                            f.BackgroundTransparency = 0.6
                            f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

                            local l = Instance.new("TextLabel", f)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = "Morte"
                            l.TextColor3 = Color3.fromRGB(255, 0, 0)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 13
                        end
                    end
                end
            end

            -- Renderizar ESP de Itens
            if Settings.ESP_Items and CurrentRooms then
                for _, room in pairs(CurrentRooms:GetChildren()) do
                    for _, item in pairs(room:GetDescendants()) do
                        if item:IsA("Model") and (item.Name:find("Key") or item.Name:find("Lockpick") or item.Name:find("Vitamins") or item.Name:find("Gold")) then
                            local b = Instance.new("BillboardGui", item)
                            b.Name = "AUG_Orion_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 80, 0, 20)
                            b.StudsOffset = Vector3.new(0, 1.5, 0)
                            
                            local l = Instance.new("TextLabel", b)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = item.Name
                            l.TextColor3 = Color3.fromRGB(0, 180, 255)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 12
                        end
                    end
                end
            end

            -- Auto Solver Porta 100
            if Settings.AutoEletricidade then
                local MainUI = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
                if MainUI and MainUI:FindFirstChild("BreakerMinigame") and MainUI.BreakerMinigame.Visible then
                    local Minigame = MainUI.BreakerMinigame
                    for i = 1, 10 do
                        local box = Minigame:FindFirstChild("Box" .. tostring(i))
                        if box then
                            local targetValue = box:FindFirstChild("Target") and box.Target.Value
                            local currentValue = box:FindFirstChild("Current") and box.Current.Value
                            if targetValue and currentValue and targetValue ~= currentValue then
                                ReplicatedStorage.BrkrEvent:FireServer(i, targetValue)
                            end
                        end
                    end
                end
            end

        end)
    end
end)

OrionLib:Init()
