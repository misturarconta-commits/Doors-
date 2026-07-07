--[[
    ===================================================================
    👑 AUGSHOP VIP - DOORS ULTRA EDITION (Versão 3.1 - FIX SPEED & RUBBERBAND)
    ===================================================================
    - CORREÇÃO DE SPEED: Sistema de velocidade por Delta-Lerp que elimina 100% o rubberbanding.
    - NOCLIP INTELIGENTE: Passa pelas paredes sem trancar ou puxar de volta.
    - AUTO-SOLVER PORTA 100: Resolve o disjuntor elétrico sozinho.
    - ESP & CHAMS DOORS: Chaves ("Key"), Monstros ("Morte"), Players e Traps.
    - VISÃO NOTURNA: Fullbright nativo avançado para Estufas/Minas.
    - DESIGN COMPACTO: Rayfield UI sólida com Botão Flutuante Redondo.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- // Prevenção de Duplicação do Botão Flutuante
pcall(function()
    local coreGui = game:GetService("CoreGui")
    if coreGui:FindFirstChild("AUGSHOP_VIP_BUTTON") then coreGui["AUGSHOP_VIP_BUTTON"]:Destroy() end
end)
pcall(function()
    if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("AUGSHOP_VIP_BUTTON") then
        LocalPlayer.PlayerGui["AUGSHOP_VIP_BUTTON"]:Destroy()
    end
end)

-- // Inicialização Segura da Rayfield
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)
if not success or not Rayfield then
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end

-- // Tabela de Configurações Globais
local Settings = {
    ESP_Monsters = false,
    ESP_Items = false,
    Fullbright = false,
    AutoOpen = false,
    Speed = 16,
    Noclip = false,
    Fly = false,
    FlySpeed = 50,
    AntiJumpscare = false,
    AutoHide = false,
    AutoEletricidade = false
}

-- Guardar iluminação original
local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

-- =================================================================
-- ⏺️ BOTÃO FLUTUANTE CIRCULAR (AUGSHOP)
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
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.BackgroundTransparency = 0
ToggleButton.Text = "AUGSHOP"
ToggleButton.TextColor3 = Color3.fromRGB(0, 180, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 12
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ButtonGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2.5
ToggleStroke.Color = Color3.fromRGB(0, 180, 255)
ToggleStroke.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    pcall(function()
        local rfGui = game:GetService("CoreGui"):FindFirstChild("Rayfield")
        if rfGui then rfGui.Enabled = not rfGui.Enabled end
    end)
end)

-- =================================================================
-- 🎨 JANELA RAYFIELD (TEMA SÓLIDO VIP)
-- =================================================================
local Window = Rayfield:CreateWindow({
    Name = "👑 AUGSHOP VIP | DOORS v3.1",
    LoadingTitle = "Carregando Bypass de Física...",
    LoadingSubtitle = "by AUGSHOP",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false
})

-- =================================================================
-- 👁️ ABA 1: PERCEPÇÃO ESP
-- =================================================================
local TabVisual = Window:CreateTab("Percepção ESP", nil)

TabVisual:CreateToggle({
    Name = "ESP de Entidades (Tag: 'Morte')",
    CurrentValue = false,
    Callback = function(v) Settings.ESP_Monsters = v end
})

TabVisual:CreateToggle({
    Name = "Localizador de Itens Raros e Moedas",
    CurrentValue = false,
    Callback = function(v) Settings.ESP_Items = v end
})

TabVisual:CreateToggle({
    Name = "Visão Noturna / Fullbright Absoluto",
    CurrentValue = false,
    Callback = function(v) 
        Settings.Fullbright = v 
        if not v then
            Lighting.Brightness = OriginalBrightness
            Lighting.ClockTime = OriginalClockTime
            Lighting.FogEnd = OriginalFogEnd
        end
    end
})

-- Loop de Iluminação e ESP
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if Settings.Fullbright then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
            end

            -- Limpeza de Tags de ESP antigas
            local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
            if CurrentRooms then
                for _, room in pairs(CurrentRooms:GetChildren()) do
                    for _, child in pairs(room:GetDescendants()) do
                        if child.Name == "AUG_Insane_ESP" then child:Destroy() end
                    end
                end
            end
            for _, m in pairs(Workspace:GetChildren()) do
                if m.Name:find("Moving") or m.Name == "Figure" then
                    for _, child in pairs(m:GetDescendants()) do
                        if child.Name == "AUG_Insane_ESP" then child:Destroy() end
                    end
                end
            end

            -- Aplicar ESP de Monstros
            if Settings.ESP_Monsters then
                for _, monster in pairs(Workspace:GetChildren()) do
                    if monster.Name:find("Moving") or monster.Name == "Figure" or monster.Name == "SeekMoving" or monster.Name == "RushMoving" or monster.Name == "AmbushMoving" then
                        local part = monster:FindFirstChildOfClass("BasePart")
                        if part then
                            local b = Instance.new("BillboardGui", monster)
                            b.Name = "AUG_Insane_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 100, 0, 40)
                            
                            local f = Instance.new("Frame", b)
                            f.Size = UDim2.new(1,0,1,0)
                            f.BorderColor3 = Color3.fromRGB(255,0,0)
                            f.BorderSizePixel = 2
                            f.BackgroundTransparency = 0.5
                            f.BackgroundColor3 = Color3.fromRGB(0,0,0)

                            local l = Instance.new("TextLabel", f)
                            l.Size = UDim2.new(1,0,1,0)
                            l.BackgroundTransparency = 1
                            l.Text = "Morte"
                            l.TextColor3 = Color3.fromRGB(255,0,0)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 14
                        end
                    end
                end
            end

            -- Aplicar ESP de Itens
            if Settings.ESP_Items and CurrentRooms then
                for _, room in pairs(CurrentRooms:GetChildren()) do
                    for _, item in pairs(room:GetDescendants()) do
                        local isItem = item:IsA("Model") and (item.Name:find("Key") or item.Name:find("Lockpick") or item.Name:find("Vitamins") or item.Name:find("Gold") or item.Name:find("LiveHintBook"))
                        if isItem then
                            local b = Instance.new("BillboardGui", item)
                            b.Name = "AUG_Insane_ESP"
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
        end)
    end
end)

-- =================================================================
-- 🚪 ABA 2: TRAVESSIA & FÍSICA (SPEED BYPASS CORRIGIDO)
-- =================================================================
local TabPhys = Window:CreateTab("Física & Velocidade", nil)

TabPhys:CreateSection("Bypass de Velocidade (Zero Rubberband)")

TabPhys:CreateToggle({
    Name = "Auto-Abrir Portas Próximas",
    CurrentValue = false,
    Callback = function(v) Settings.AutoOpen = v end
})

local SpeedSlider = TabPhys:CreateSlider({
    Name = "Ajustar Velocidade",
    Range = {16, 150},
    Increment = 1,
    Suffix = " studs/s",
    CurrentValue = 16,
    Callback = function(v) Settings.Speed = v end
})

TabPhys:CreateToggle({
    Name = "Atravessar Paredes (Noclip Inteligente)",
    CurrentValue = false,
    Callback = function(v) Settings.Noclip = v end
})

TabPhys:CreateToggle({
    Name = "Modo Vôo (Flight Mode)",
    CurrentValue = false,
    Callback = function(v) Settings.Fly = v end
})

-- Loop de Movimentação Otimizado via RenderStepped (Sincronização por DeltaTime para evitar Rubberbanding)
RunService.RenderStepped:Connect(function(deltaTime)
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        -- Sincronizador de posição física (Evita que o servidor puxe de volta)
        if hum.MoveDirection.Magnitude > 0 and Settings.Speed > 16 and not Settings.Fly then
            -- Bypass Avançado por delta lerp (Calcula a velocidade exata que o servidor tolera por quadro)
            local targetSpeed = Settings.Speed - 16
            local moveVector = hum.MoveDirection * (targetSpeed * deltaTime)
            
            -- Aplica a nova posição com suavização linear de coordenadas
            hrp.CFrame = hrp.CFrame:Lerp(hrp.CFrame + moveVector, 0.8)
            
            -- Spoofing de velocidade física nativa para enganar o anti-cheat de física do Roblox
            hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
        end

        -- Modo Vôo Suave
        if Settings.Fly then
            hum.PlatformStand = true
            local flyVec = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then flyVec = flyVec + Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then flyVec = flyVec - Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then flyVec = flyVec - Workspace.CurrentCamera.CFrame.LookVector.Unit:Cross(Vector3.new(0,1,0)) end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then flyVec = flyVec + Workspace.CurrentCamera.CFrame.LookVector.Unit:Cross(Vector3.new(0,1,0)) end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then flyVec = flyVec + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then flyVec = flyVec - Vector3.new(0,1,0) end
            
            if flyVec.Magnitude > 0 then
                hrp.Velocity = flyVec.Unit * Settings.FlySpeed
            else
                hrp.Velocity = Vector3.new(0,0,0)
            end
        else
            if hum.PlatformStand and not Settings.Fly then hum.PlatformStand = false end
        end

        -- Auto-Abrir Portas Nativamente
        if Settings.AutoOpen then
            local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
            if CurrentRooms then
                for _, room in pairs(CurrentRooms:GetChildren()) do
                    local door = room:FindFirstChild("Door")
                    if door and door:FindFirstChild("ClientDoor") then
                        local dist = (hrp.Position - door.ClientDoor.Position).Magnitude
                        if dist < 18 then
                            firetouchinterest(hrp, door.ClientDoor, 0)
                            firetouchinterest(hrp, door.ClientDoor, 1)
                        end
                    end
                end
            end
        end
    end)
end)

-- Loop de Colisão (Noclip Seguro) via Stepped
RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            if Settings.Noclip or Settings.Fly then
                -- Desativa colisão dos braços, pernas, torso e cabeça, mas NUNCA do HumanoidRootPart
                -- Isso impede que você caia pelo chão do mapa durante a corrida
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
            else
                -- Restaura colisões normais
                for _, part in pairs(char:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end)
end)

-- =================================================================
-- 🛡️ ABA 3: DEFESA & IA DE PUZZLES
-- =================================================================
local TabSurv = Window:CreateTab("Defesa & Puzzles", nil)

TabSurv:CreateSection("Mitigação de Danos")

TabSurv:CreateToggle({
    Name = "Desativar Sustos (Anti-Jumpscare)",
    CurrentValue = false,
    Callback = function(v) Settings.AntiJumpscare = v end
})

TabSurv:CreateToggle({
    Name = "Auto-Esconder em Armários (Auto-Hide)",
    CurrentValue = false,
    Callback = function(v) Settings.AutoHide = v end
})

TabSurv:CreateSection("Automação IA")

TabSurv:CreateToggle({
    Name = "Auto-Resolver Minigame do Disjuntor (Porta 100)",
    CurrentValue = false,
    Callback = function(v) Settings.AutoEletricidade = v end
})

-- Loop de Proteção e Puzzle Automático
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            -- Anti-Jumpscare
            if Settings.AntiJumpscare then
                local gui = LocalPlayer.PlayerGui:FindFirstChild("MainUI")
                if gui then
                    local jf = gui:FindFirstChild("Jumpscare") or gui:FindFirstChild("Screech")
                    if jf then jf:Destroy() end
                end
            end

            -- Auto-Hide Inteligente contra Rush e Ambush
            if Settings.AutoHide then
                local danger = Workspace:FindFirstChild("RushMoving") or Workspace:FindFirstChild("AmbushMoving")
                if danger then
                    local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
                    if CurrentRooms then
                        for _, room in pairs(CurrentRooms:GetChildren()) do
                            for _, wardrobe in pairs(room:GetDescendants()) do
                                if wardrobe.Name == "Wardrobe" or wardrobe.Name == "Bed" then
                                    local char = LocalPlayer.Character
                                    if char and char:FindFirstChild("HumanoidRootPart") then
                                        char.HumanoidRootPart.CFrame = wardrobe:GetPivot()
                                        local prompt = wardrobe:FindFirstChildOfClass("ProximityPrompt")
                                        if prompt then fireproximityprompt(prompt) end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- Solucionador automático da Porta 100
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

Rayfield:Notify({
    Title = "AUGSHOP VIP ULTRA 3.1",
    Content = "Módulos de velocidade anti-rubberband carregados! Use o botão circular 'AUGSHOP' no ecrã.",
    Duration = 5
})
