--[[
    🔥 AUGSHOP VIP - DOORS RAYFIELD (LARANJA NEON) 🔥
    - BYPASS DE CACHE: Código 100% otimizado para evitar crash no executor.
    - NOCLIP AGRESSIVO: Força a passagem por portas e paredes (60 FPS).
    - SPEED C-FRAME: Anda rápido sem o rubberband (sem puxar pra trás).
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Configurações Globais
local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP = false,
    AutoInteract = false
}

-- Destruir interfaces antigas para não bugar
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
        game:GetService("CoreGui").Rayfield:Destroy()
    end
end)

-- Carregar Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "🔥 AUGSHOP VIP | DOORS HUB",
    LoadingTitle = "Injetando Bypasses...",
    LoadingSubtitle = "by AUGSHOP",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- Mudar a cor para Laranja
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
local TabMove = Window:CreateTab("Movimentação", 4483362458)

TabMove:CreateSlider({
    Name = "Velocidade Segura (Speed)",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = 16,
    Flag = "SliderSpeed",
    Callback = function(Value)
        Settings.Speed = Value
    end,
})

TabMove:CreateToggle({
    Name = "Atravessar Tudo (Noclip Agressivo)",
    CurrentValue = false,
    Flag = "ToggleNoclip",
    Callback = function(Value)
        Settings.Noclip = Value
        if not Value then
            local char = LocalPlayer.Character
            if char then
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = true end
                end
            end
        end
    end,
})

-- ==========================================
-- 👁️ ABA 2: VISUAL E ESP
-- ==========================================
local TabVisual = Window:CreateTab("Visuais", 4483362458)

TabVisual:CreateToggle({
    Name = "Visão Noturna Absoluta (Fullbright)",
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

TabVisual:CreateToggle({
    Name = "ESP Supremo (Monstros e Itens)",
    CurrentValue = false,
    Flag = "ToggleESP",
    Callback = function(Value)
        Settings.ESP = Value
        if not Value then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name == "AUG_ESP" then v:Destroy() end
            end
        end
    end,
})

-- ==========================================
-- ⚙️ ABA 3: AUTOMAÇÕES
-- ==========================================
local TabAuto = Window:CreateTab("Automações", 4483362458)

TabAuto:CreateToggle({
    Name = "Coleta Automática (Gavetas/Itens)",
    CurrentValue = false,
    Flag = "ToggleAuto",
    Callback = function(Value)
        Settings.AutoInteract = Value
    end,
})

-- ==========================================
-- 🚀 LOOPS DO MOTOR DO JOGO (BYPASSES)
-- ==========================================

-- NOCLIP AGRESSIVO: Força a desativação da colisão 60x por segundo
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

-- SPEED C-FRAME: Anda adicionando distância para evitar o Rubberband
RunService.RenderStepped:Connect(function(dt)
    pcall(function()
        if Settings.Speed > 16 then
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.MoveDirection.Magnitude > 0 then
                -- Move o personagem pela diferença da velocidade sem mexer no WalkSpeed
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * ((Settings.Speed - 16) * dt))
            end
        end
    end)
end)

-- LOOP GERAL: Luz, ESP e Automações
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            -- FULLBRIGHT
            if Settings.Fullbright then
                Lighting.Brightness = 3
                Lighting.ClockTime = 12
                Lighting.FogEnd = 999999
            end

            -- AUTO INTERACT
            if Settings.AutoInteract then
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj:IsA("ProximityPrompt") and obj.Enabled then
                            local parentName = obj.Parent and obj.Parent.Name or ""
                            if parentName:find("Drawer") or parentName:find("Gold") or parentName:find("Key") then
                                if (hrp.Position - obj.Parent:GetPivot().Position).Magnitude < 15 then
                                    fireproximityprompt(obj)
                                end
                            end
                        end
                    end
                end
            end

            -- ESP
            if Settings.ESP then
                -- Limpa ESP Antigo
                for _, v in pairs(Workspace:GetDescendants()) do
                    if v.Name == "AUG_ESP" then v:Destroy() end
                end

                -- Adiciona ESP
                for _, obj in pairs(Workspace:GetDescendants()) do
                    local isMonster = obj.Name:find("Moving") or obj.Name == "Figure"
                    local isItem = obj:IsA("Model") and (obj.Name:find("Key") or obj.Name:find("Gold") or obj.Name:find("Lockpick"))
                    
                    if (isMonster or isItem) and obj:FindFirstChildOfClass("BasePart") then
                        local b = Instance.new("BillboardGui", obj)
                        b.Name = "AUG_ESP"
                        b.AlwaysOnTop = true
                        b.Size = UDim2.new(0, 100, 0, 30)
                        
                        local l = Instance.new("TextLabel", b)
                        l.Size = UDim2.new(1,0,1,0)
                        l.BackgroundTransparency = 1
                        l.Font = Enum.Font.SourceSansBold
                        l.TextSize = 13

                        if isMonster then
                            l.Text = "🚨 MONSTRO"
                            l.TextColor3 = Color3.fromRGB(255, 0, 0)
                        else
                            l.Text = obj.Name
                            l.TextColor3 = Color3.fromRGB(255, 140, 0)
                        end
                    end
                end
            end
        end)
    end
end)
