--[[
    ===================================================================
    🔥 AUGSHOP VIP - DOORS RAYFIELD EDITION (Laranja Neon v6.0) 🔥
    ===================================================================
    - INTERFACE: Rayfield UI com tema customizado Laranja.
    - MOVIMENTO: Speed e Noclip calibrados para o motor de física do executor.
    - SUPORTE COMPLETO: ESP, Automações e Bypasses inclusos.
]]

-- Limpeza de UI anterior
pcall(function()
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then game:GetService("CoreGui")["Rayfield"]:Destroy() end
end)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP_Monsters = false,
    ESP_Items = false,
    ESP_Traps = false,
    AntiEyes = false,
    AutoInteract = false,
    AutoEletricidade = false
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

-- Criação da Janela com o Tema Laranja Customizado
local Window = Rayfield:CreateWindow({
    Name = "🔥 AUGSHOP VIP | DOORS HUB",
    LoadingTitle = "Carregando AUGSHOP Hub...",
    LoadingSubtitle = "by AUGSHOP",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

-- Modificação da Paleta de Cores da Rayfield para Laranja
pcall(function()
    local cGui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
    if cGui then
        for _, v in pairs(cGui:GetDescendants()) do
            if v:IsA("Frame") and v.BackgroundColor3 == Color3.fromRGB(0, 125, 255) then -- Cor azul padrão
                v.BackgroundColor3 = Color3.fromRGB(255, 100, 0) -- Substitui por Laranja
            elseif v:IsA("TextLabel") and v.TextColor3 == Color3.fromRGB(0, 125, 255) then
                v.TextColor3 = Color3.fromRGB(255, 100, 0)
            elseif v:IsA("UIStroke") and v.Color == Color3.fromRGB(0, 125, 255) then
                v.Color = Color3.fromRGB(255, 100, 0)
            end
        end
    end
end)

-- ABA 1: MOVIMENTO
local TabMove = Window:CreateTab("Movimentação", 4483362458)

local SpeedSlider = TabMove:CreateSlider({
    Name = "Velocidade (Speed)",
    Info = "Ajuste com cuidado para evitar detecção do jogo.",
    Min = 16,
    Max = 60,
    CurrentValue = 16,
    Flag = "SliderSpeed",
    Callback = function(Value)
        Settings.Speed = Value
    end,
})

local NoclipToggle = TabMove:CreateToggle({
    Name = "Atravessar Paredes (Noclip)",
    CurrentValue = false,
    Flag = "ToggleNoclip",
    Callback = function(Value)
        Settings.Noclip = Value
        if not Value then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetChildren()) do
                        if part:IsA("BasePart") then part.CanCollide = true end
                    end
                end
            end)
        end
    end,
})

-- ABA 2: VISUAL (ESP)
local TabVisual = Window:CreateTab("Visual ESP", 4483362458)

TabVisual:CreateToggle({
    Name = "ESP de Monstros",
    CurrentValue = false,
    Flag = "EspMonsters",
    Callback = function(Value) Settings.ESP_Monsters = Value end,
})

TabVisual:CreateToggle({
    Name = "ESP de Chaves & Livros",
    CurrentValue = false,
    Flag = "EspItems",
    Callback = function(Value) Settings.ESP_Items = Value end,
})

TabVisual:CreateToggle({
    Name = "ESP de Armadilhas",
    CurrentValue = false,
    Flag = "EspTraps",
    Callback = function(Value) Settings.ESP_Traps = Value end,
})

TabVisual:CreateToggle({
    Name = "Iluminação Total (Fullbright)",
    CurrentValue = false,
    Flag = "FullbrightToggle",
    Callback = function(Value)
        Settings.Fullbright = Value
        if not Value then
            Lighting.Brightness = OriginalBrightness
            Lighting.ClockTime = OriginalClockTime
            Lighting.FogEnd = OriginalFogEnd
        end
    end,
})

-- ABA 3: AUTOMAÇÕES
local TabAuto = Window:CreateTab("Automações", 4483362458)

TabAuto:CreateToggle({
    Name = "Imunidade ao Eyes (Anti-Eyes)",
    CurrentValue = false,
    Flag = "AntiEyes",
    Callback = function(Value) Settings.AntiEyes = Value end,
})

TabAuto:CreateToggle({
    Name = "Auto-Abrir Gavetas & Coletar Ouro",
    CurrentValue = false,
    Flag = "AutoInteract",
    Callback = function(Value) Settings.AutoInteract = Value end,
})

TabAuto:CreateToggle({
    Name = "Auto-Disjuntor (Porta 100)",
    CurrentValue = false,
    Flag = "AutoBreaker",
    Callback = function(Value) Settings.AutoEletricidade = Value end,
})


-- =================================================================
-- ⚙️ SISTEMA DE EXECUÇÃO EM SINE (LOOPS DE JOGO)
-- =================================================================

-- Loop do Noclip e do Speed via Engine Física do Servidor
RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        -- Gerenciamento de Noclip Seguro
        if Settings.Noclip then
            for _, part in pairs(char:GetChildren()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = false
                end
            end
        end

        -- Aplicação de Velocidade Estabilizada
        if hum and Settings.Speed > 16 then
            hum.WalkSpeed = Settings.Speed
            -- Remove a fricção linear se o anti-cheat tentar puxar de volta
            if hrp and hum.MoveDirection.Magnitude > 0 then
                hrp.AssemblyLinearVelocity = Vector3.new(hum.MoveDirection.X * Settings.Speed, hrp.AssemblyLinearVelocity.Y, hum.MoveDirection.Z * Settings.Speed)
            end
        end
    end)
end)

-- Loop Geral de Utilidades (ESP, Light e Bypasses)
task.spawn(function()
    while task.wait(0.4) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if Settings.Fullbright then
                Lighting.Brightness = 2.5
                Lighting.ClockTime = 14
                Lighting.FogEnd = 999999
            end

            if Settings.AntiEyes and Workspace:FindFirstChild("Eyes") then
                ReplicatedStorage.EntityInfo.EyesLook:FireServer(false)
            end

            if Settings.AutoInteract and hrp then
                local currentRooms = Workspace:FindFirstChild("CurrentRooms")
                if currentRooms then
                    for _, room in pairs(currentRooms:GetChildren()) do
                        for _, desc in pairs(room:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") and desc.Enabled then
                                local name = desc.Parent and desc.Parent.Name or ""
                                if name:find("Drawer") or name:find("Key") or name:find("Gold") or name:find("LooseGold") then
                                    if (hrp.Position - desc.Parent:GetPivot().Position).Magnitude < 15 then
                                        fireproximityprompt(desc)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- Sistema de Renderização e Limpeza de ESP
            local currentRooms = Workspace:FindFirstChild("CurrentRooms")
            if currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, d in pairs(room:GetDescendants()) do if d.Name == "AUG_RAY_ESP" then d:Destroy() end end
                end
            end
            for _, monster in pairs(Workspace:GetChildren()) do
                for _, d in pairs(monster:GetDescendants()) do if d.Name == "AUG_RAY_ESP" then d:Destroy() end end
            end

            if Settings.ESP_Monsters then
                for _, monster in pairs(Workspace:GetChildren()) do
                    if monster.Name:find("Moving") or monster.Name == "Figure" or monster.Name == "SeekMoving" or monster.Name == "Eyes" then
                        if monster:FindFirstChildOfClass("BasePart") then
                            local b = Instance.new("BillboardGui", monster)
                            b.Name = "AUG_RAY_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 100, 0, 40)
                            local f = Instance.new("Frame", b)
                            f.Size = UDim2.new(1,0,1,0)
                            f.BackgroundColor3 = Color3.fromRGB(20,20,20)
                            f.BorderColor3 = Color3.fromRGB(255,100,0)
                            f.BorderSizePixel = 15
                            local l = Instance.new("TextLabel", f)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = "MONSTRO 🚨"
                            l.TextColor3 = Color3.fromRGB(255,50,0)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 12
                        end
                    end
                end
            end

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
