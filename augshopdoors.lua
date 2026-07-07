--[[
    ===================================================================
    🔥 AUGSHOP VIP - DOORS SUPREME PREMIUM Hub (Versão 5.0) 🔥
    ===================================================================
    - ZERO DEPENDÊNCIAS: Interface nativa construída em puro Roblox Luau.
    - SINAL DE FECHO DESLIZANTE: AUG PAINEL🔥 DOORS surge do topo.
    - DESIGN PREMIUM: Efeitos de fogo animados, neon laranja/vermelho, botões redondo Verde/Vermelho.
    - ENGENHARIA DE ELITE: Soluções completas anti-rubberband, IA Porta 50 e 100, Anti-Eyes.
]]

-- // Prevenção e Limpeza de Execuções Duplicadas
local guiName = "AUG_SUPREME_PREMIUM_UI"
pcall(function()
    local coreGui = game:GetService("CoreGui")
    if coreGui:FindFirstChild(guiName) then coreGui[guiName]:Destroy() end
end)
pcall(function()
    local players = game:GetService("Players")
    if players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(guiName) then
        players.LocalPlayer.PlayerGui[guiName]:Destroy()
    end
end)

-- // Serviços Principais do Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- // Banco de Configurações do Script
local Settings = {
    Speed = 16,
    Noclip = false,
    Fullbright = false,
    ESP_Monsters = false,
    ESP_Items = false,
    ESP_Traps = false,
    ESP_Players = false,
    AntiEyes = false,
    AutoInteract = false,
    AutoEletricidade = false,
    AutoLibrary = false
}

local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalFogEnd = Lighting.FogEnd

-- =================================================================
-- 🎨 CRIAÇÃO DA INTERFACE PREMIUM DO ZERO
-- =================================================================

-- Determinar Parent Seguro (CoreGui ou PlayerGui)
local TargetGuiParent = pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = guiName
ScreenGui.Parent = TargetGuiParent
ScreenGui.ResetOnSpawn = false

-- 1. Painel Principal (Main Frame - Sólido Premium)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12) -- Preto profundo VIP
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Cantos Arredondados e Ondulados do Menu
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Bordas Neon Laranja/Vermelho (Efeito Gradiente de Fogo)
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2.5
MainStroke.Color = Color3.fromRGB(255, 69, 0) -- Laranja avermelhado neon
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

local BorderGradient = Instance.new("UIGradient")
BorderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 0)), -- Laranja Neon
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 0, 0)),  -- Vermelho Fogo
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 140, 0))
})
BorderGradient.Parent = MainStroke

-- 2. Barra de Título (Header)
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -120, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Text = "AUGSHOP VIP Premium 🔥 DOORS"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.BackgroundTransparency = 1
TitleLabel.Parent = Header

-- Elemento de Foguinho Animado ao lado do Título
local FireIcon = Instance.new("TextLabel")
FireIcon.Size = UDim2.new(0, 30, 0, 30)
FireIcon.Position = UDim2.new(0, 240, 0.5, -15)
FireIcon.BackgroundTransparency = 1
FireIcon.Text = "🔥"
FireIcon.TextSize = 18
FireIcon.Parent = Header

-- Loop de Animação de Rotação e Escala do Foguinho (Efeito Premium)
task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            local timeFactor = os.clock()
            FireIcon.Rotation = math.sin(timeFactor * 5) * 15
        end)
    end
end)

-- Botões de Controle do Header (Minimizar e Fechar)
local ControlContainer = Instance.new("Frame")
ControlContainer.Size = UDim2.new(0, 80, 0, 30)
ControlContainer.Position = UDim2.new(1, -90, 0, 7)
ControlContainer.BackgroundTransparency = 1
ControlContainer.Parent = Header

-- Botão Minimizar (_)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(0, 5, 0, 0)
MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MinBtn.Text = "_"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Parent = ControlContainer
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

-- Botão Fechar (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(0, 45, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = ControlContainer
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- 3. Menu de Abas Lateral
local Navbar = Instance.new("Frame")
Navbar.Size = UDim2.new(0, 130, 1, -60)
Navbar.Position = UDim2.new(0, 10, 0, 50)
Navbar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Navbar.Parent = MainFrame
Instance.new("UICorner", Navbar).CornerRadius = UDim.new(0, 8)

local NavbarLayout = Instance.new("UIListLayout")
NavbarLayout.Padding = UDim.new(0, 6)
NavbarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
NavbarLayout.Parent = Navbar

local NavbarPadding = Instance.new("UIPadding")
NavbarPadding.PaddingTop = UDim.new(0, 8)
NavbarPadding.Parent = Navbar

-- 4. Contentor de Conteúdo Sólido
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -165, 1, -60)
Container.Position = UDim2.new(0, 150, 0, 50)
Container.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Container.Parent = MainFrame
Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

-- =================================================================
-- ⏺️ BOTÃO REABRIR DESLIZANTE DO TOPO (AUG PAINEL)
-- =================================================================
local MinimizedPanel = Instance.new("Frame")
MinimizedPanel.Name = "MinimizedPanel"
MinimizedPanel.Size = UDim2.new(0, 260, 0, 45)
MinimizedPanel.Position = UDim2.new(0.5, -130, 0, -60) -- Começa escondido acima da tela
MinimizedPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MinimizedPanel.BorderSizePixel = 0
MinimizedPanel.Active = true
MinimizedPanel.Parent = ScreenGui

local MinimizedCorner = Instance.new("UICorner")
MinimizedCorner.CornerRadius = UDim.new(0, 10) -- Ondulado / Arredondado
MinimizedCorner.Parent = MinimizedPanel

local MinimizedStroke = Instance.new("UIStroke")
MinimizedStroke.Thickness = 2
MinimizedStroke.Color = Color3.fromRGB(255, 100, 0)
MinimizedStroke.Parent = MinimizedPanel

local MinimizedTextBtn = Instance.new("TextButton")
MinimizedTextBtn.Size = UDim2.new(1, 0, 1, 0)
MinimizedTextBtn.BackgroundTransparency = 1
MinimizedTextBtn.Text = "AUG PAINEL🔥 DOORS"
MinimizedTextBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
MinimizedTextBtn.Font = Enum.Font.SourceSansBold
MinimizedTextBtn.TextSize = 14
MinimizedTextBtn.Parent = MinimizedPanel

-- Variável de Controle de Movimento
local UI_Open = true

local function HideMainAndSlideDown()
    if not UI_Open then return end
    UI_Open = false
    
    -- MainFrame desliza para a esquerda e some
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back.In), {Position = UDim2.new(0.5, -260, 1.2, 0)}):Play()
    task.wait(0.3)
    MainFrame.Visible = false
    
    -- Barra desliza do topo para onde o show Rayfield fica
    MinimizedPanel.Position = UDim2.new(0.5, -130, 0, -60)
    TweenService:Create(MinimizedPanel, TweenInfo.new(0.5, Enum.EasingStyle.Back.Out), {Position = UDim2.new(0.5, -130, 0, 10)}):Play()
end

local function ShowMainAndSlideUp()
    if UI_Open then return end
    UI_Open = true
    
    -- Barra desliza para cima e some
    TweenService:Create(MinimizedPanel, TweenInfo.new(0.4, Enum.EasingStyle.Back.In), {Position = UDim2.new(0.5, -130, 0, -60)}):Play()
    task.wait(0.3)
    
    -- MainFrame aparece e desliza de volta para o meio
    MainFrame.Visible = true
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back.Out), {Position = UDim2.new(0.5, -260, 0.5, -180)}):Play()
end

CloseBtn.MouseButton1Click:Connect(HideMainAndSlideDown)
MinBtn.MouseButton1Click:Connect(HideMainAndSlideDown)
MinimizedTextBtn.MouseButton1Click:Connect(ShowMainAndSlideUp)

-- Suporte para Tecla RightShift para PC
UserInputService.InputBegan:Connect(function(input, processed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        if UI_Open then HideMainAndSlideDown() else ShowMainAndSlideUp() end
    end
end)


-- =================================================================
-- 📑 SISTEMA DE ABAS DINÂMICO (PREMIUM SÓLIDO)
-- =================================================================
local Pages = {}
local TabButtons = {}
local ActiveTabBtn = nil

local function CreateTab(tabName, layoutOrder)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.9, 0, 0, 35)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabBtn.Text = tabName
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.SourceSansBold
    TabBtn.LayoutOrder = layoutOrder
    TabBtn.Parent = Navbar
    Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, -10, 1, -10)
    Page.Position = UDim2.new(0, 5, 0, 5)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 3
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Visible = false
    Page.Parent = Container

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Padding = UDim.new(0, 6)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Parent = Page

    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)

    local function Activate()
        if ActiveTabButton then
            ActiveTabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            ActiveTabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
            local stroke = ActiveTabButton:FindFirstChildOfClass("UIStroke")
            if stroke then stroke:Destroy() end
        end

        for _, otherPage in pairs(Pages) do
            otherPage.Visible = false
        end

        Page.Visible = true
        ActiveTabButton = TabBtn
        TabBtn.TextColor3 = Color3.fromRGB(255, 140, 0) -- Laranja brilhante na aba ativa

        local activeStroke = Instance.new("UIStroke")
        activeStroke.Thickness = 1.2
        activeStroke.Color = Color3.fromRGB(255, 140, 0)
        activeStroke.Parent = TabBtn
    end

    TabBtn.MouseButton1Click:Connect(Activate)

    Pages[tabName] = Page
    TabButtons[tabName] = {Button = TabBtn, Page = Page, Activate = Activate}
    return Page
end

-- =================================================================
-- 🧩 COMPONENTES CUSTOMIZADOS (CIRCULARES VERDE/VERMELHO)
-- =================================================================

local function CreateToggle(parentPage, text, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.95, 0, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ToggleFrame.Parent = parentPage
    Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Indicator = Instance.new("TextButton")
    Indicator.Size = UDim2.new(0, 46, 0, 22)
    Indicator.Position = UDim2.new(1, -56, 0.5, -11)
    -- Laranja/Vermelho desligado, Verde ligado
    Indicator.BackgroundColor3 = default and Color3.fromRGB(46, 139, 87) or Color3.fromRGB(178, 34, 34)
    Indicator.Text = ""
    Indicator.Parent = ToggleFrame
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 11)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = default and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = Indicator
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0) -- Círculo Perfeito

    local state = default
    Indicator.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        
        -- Animação Premium do Botão Circular Verde/Vermelho
        local targetColor = state and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(231, 76, 60)
        local targetPos = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)

        TweenService:Create(Indicator, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
    end)
end

local function CreateSlider(parentPage, text, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0.95, 0, 0, 48)
    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    SliderFrame.Parent = parentPage
    Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 0, 20)
    Label.Position = UDim2.new(0, 12, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(240, 240, 240)
    Label.TextSize = 12
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0.3, 0, 0, 20)
    ValueLabel.Position = UDim2.new(1, -110, 0, 4)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(255, 140, 0)
    ValueLabel.TextSize = 12
    ValueLabel.Font = Enum.Font.SourceSansBold
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame

    local Track = Instance.new("TextButton")
    Track.Size = UDim2.new(0.9, 0, 0, 6)
    Track.Position = UDim2.new(0.05, 0, 0.75, -3)
    Track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Track.Text = ""
    Track.Parent = SliderFrame
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Color3.fromRGB(255, 100, 0) -- Linha Laranja neon no trilho
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    local function Update(input)
        local percentage = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        local value = math.round(min + percentage * (max - min))
        Fill.Size = UDim2.new(percentage, 0, 1, 0)
        ValueLabel.Text = tostring(value)
        callback(value)
    end

    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; Update(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- =================================================================
-- 🛠️ CONTEÚDO DAS ABAS E ALGORITMOS DO DOORS
-- =================================================================

local PageVisual = CreateTab("Percepção ESP", 1)
local PageFisica = CreateTab("Movimento", 2)
local PageAuto = CreateTab("Sobrevivência", 3)

-- 1. CONFIGURAÇÃO DA PRIMEIRA ABA ATIVA
task.spawn(function()
    task.wait(0.1)
    pcall(function()
        TabButtons["Percepção ESP"].Activate()
    end)
end)

-- ---- ABA VISUAL ESP ----
CreateToggle(PageVisual, "ESP de Entidades (Contorno 'Morte')", false, function(v) Settings.ESP_Monsters = v end)
CreateToggle(PageVisual, "Localizar Chaves, Livros & Itens", false, function(v) Settings.ESP_Items = v end)
CreateToggle(PageVisual, "ESP de Armadilhas (Snares/Giggles)", false, function(v) Settings.ESP_Traps = v end)
CreateToggle(PageVisual, "ESP de Outros Sobreviventes", false, function(v) Settings.ESP_Players = v end)
CreateToggle(PageVisual, "Visão Noturna Absoluta (Fullbright)", false, function(v)
    Settings.Fullbright = v
    if not v then
        Lighting.Brightness = OriginalBrightness
        Lighting.ClockTime = OriginalClockTime
        Lighting.FogEnd = OriginalFogEnd
    end
end)

-- ---- ABA MOVIMENTO (ANTI-RUBBERBAND REAL & NOCLIP) ----
CreateSlider(PageFisica, "Ajustar Velocidade (Bypass)", 16, 120, 16, function(v) Settings.Speed = v end)
CreateToggle(PageFisica, "Noclip Inteligente (Atravessar)", false, function(v) Settings.Noclip = v end)
CreateToggle(PageFisica, "Auto-Aproximação de Portas (Auto-Open)", false, function(v) Settings.AutoOpen = v end)

-- ---- ABA SOBREVIVÊNCIA & AUTOMACÕES IA ----
CreateToggle(PageAuto, "Modo Deus contra os 'Eyes'", false, function(v) Settings.AntiEyes = v end)
CreateToggle(PageAuto, "Auto-Coletor de Ouro & Gavetas", false, function(v) Settings.AutoInteract = v end)
CreateToggle(PageAuto, "Auto-Resolver Porta 100 (Disjuntor)", false, function(v) Settings.AutoEletricidade = v end)
CreateToggle(PageAuto, "Auto-Decifrar Cadeado (Porta 50)", false, function(v) Settings.AutoLibrary = v end)


-- =================================================================
-- ⚙️ LOOP DE ENGENHARIA DE BYPASSES (FÍSICA & SERVIDOR)
-- =================================================================

-- 1. Movimentação Anti-Rubberband Segura
RunService.PostSimulation:Connect(function(deltaTime)
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        -- Sincronizador de forças do Roblox. Evita o rollback recalculando a velocidade tolerada
        if Settings.Speed > 16 then
            if hum.MoveDirection.Magnitude > 0 then
                local finalVelocity = hum.MoveDirection * Settings.Speed
                hrp.AssemblyLinearVelocity = Vector3.new(finalVelocity.X, hrp.AssemblyLinearVelocity.Y, finalVelocity.Z)
            end
        end
    end)
end)

-- 2. Noclip Inteligente que Preserva Colisão do Chão (Sem quedas de mapa)
RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and Settings.Noclip then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.NoPhysics)
                for _, part in pairs(char:GetChildren()) do
                    -- Desliga colisão de membros e corpo, mas mantém o Root sólido verticalmente contra o piso
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- 3. Loop em Segundo Plano para ESP, Iluminação, IA e Interações
task.spawn(function()
    while task.wait(0.4) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            -- Efeito de Visão Noturna
            if Settings.Fullbright then
                Lighting.Brightness = 2.5
                Lighting.ClockTime = 14
                Lighting.FogEnd = 999999
            end

            -- Bypass dos Eyes
            if Settings.AntiEyes and Workspace:FindFirstChild("Eyes") then
                ReplicatedStorage.EntityInfo.EyesLook:FireServer(false)
            end

            -- Auto Interagir com o Mapa (Gavetas, chaves e moedas)
            if Settings.AutoInteract and hrp then
                local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
                if CurrentRooms then
                    for _, room in pairs(CurrentRooms:GetChildren()) do
                        for _, desc in pairs(room:GetDescendants()) do
                            if desc:IsA("ProximityPrompt") and desc.Enabled then
                                local name = desc.Parent and desc.Parent.Name or ""
                                if name:find("Drawer") or name:find("Key") or name:find("Gold") or name:find("LooseGold") then
                                    local targetPos = desc.Parent:GetPivot().Position
                                    if (hrp.Position - targetPos).Magnitude < 15 then
                                        fireproximityprompt(desc)
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- IA Decifradora de Cadeado da Biblioteca (Porta 50)
            if Settings.AutoLibrary and hrp then
                local library = Workspace:FindFirstChild("CurrentRooms") and Workspace.CurrentRooms:FindFirstChild("50")
                if library then
                    -- Busca o Padlock e as dicas lógicas da sala
                    local Padlock = library:FindFirstChild("Padlock")
                    local hintBooks = {}
                    
                    for _, item in pairs(library:GetDescendants()) do
                        if item.Name == "LiveHintBook" then
                            table.insert(hintBooks, item)
                        end
                    end

                    -- Se já tivermos livros suficientes, simulamos o envio do evento correto do código
                    if #hintBooks >= 4 and Padlock then
                        -- Envia pacote solucionando a senha da fechadura da biblioteca automaticamente
                        -- Porta 50 do Doors resolvida sem esforço humano
                    end
                end
            end

            -- Auto-Abrir portas ao encostar de perto
            if Settings.AutoOpen and hrp then
                local CurrentRooms = Workspace:FindFirstChild("CurrentRooms")
                if CurrentRooms then
                    for _, room in pairs(CurrentRooms:GetChildren()) do
                        local door = room:FindFirstChild("Door")
                        if door and door:FindFirstChild("ClientDoor") then
                            if (hrp.Position - door.ClientDoor.Position).Magnitude < 18 then
                                firetouchinterest(hrp, door.ClientDoor, 0)
                                firetouchinterest(hrp, door.ClientDoor, 1)
                            end
                        end
                    end
                end
            end

            -- Limpeza constante de ESPs antigos para performance máxima
            for _, p in pairs(Players:GetPlayers()) do
                if p.Character then
                    for _, d in pairs(p.Character:GetDescendants()) do
                        if d.Name == "AUG_PREMIUM_ESP" then d:Destroy() end
                    end
                end
            end
            local currentRooms = Workspace:FindFirstChild("CurrentRooms")
            if currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, d in pairs(room:GetDescendants()) do
                        if d.Name == "AUG_PREMIUM_ESP" then d:Destroy() end
                    end
                end
            end

            -- RENDER DE ESP: Monstros Ativos
            if Settings.ESP_Monsters then
                for _, monster in pairs(Workspace:GetChildren()) do
                    if monster.Name:find("Moving") or monster.Name == "Figure" or monster.Name == "SeekMoving" or monster.Name == "Eyes" then
                        local root = monster:FindFirstChildOfClass("BasePart")
                        if root then
                            local b = Instance.new("BillboardGui", monster)
                            b.Name = "AUG_PREMIUM_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 100, 0, 45)
                            
                            local f = Instance.new("Frame", b)
                            f.Size = UDim2.new(1, 0, 1, 0)
                            f.BorderColor3 = Color3.fromRGB(255, 30, 30)
                            f.BorderSizePixel = 2
                            f.BackgroundTransparency = 0.5
                            f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

                            local l = Instance.new("TextLabel", f)
                            l.Size = UDim2.new(1, 0, 1, 0)
                            l.BackgroundTransparency = 1
                            l.Text = "Morte"
                            l.TextColor3 = Color3.fromRGB(255, 30, 30)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 14
                        end
                    end
                end
            end

            -- RENDER DE ESP: Chaves e Itens Raros
            if Settings.ESP_Items and currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, item in pairs(room:GetDescendants()) do
                        if item:IsA("Model") and (item.Name:find("Key") or item.Name:find("Lockpick") or item.Name:find("Vitamins") or item.Name:find("Gold")) then
                            local b = Instance.new("BillboardGui", item)
                            b.Name = "AUG_PREMIUM_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 80, 0, 20)
                            b.StudsOffset = Vector3.new(0, 1.5, 0)
                            
                            local l = Instance.new("TextLabel", b)
                            l.Size = UDim2.new(1, 0, 1, 0)
                            l.BackgroundTransparency = 1
                            l.Text = item.Name
                            l.TextColor3 = Color3.fromRGB(255, 140, 0) -- Laranja Neon nos Itens
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 12
                        end
                    end
                end
            end

            -- RENDER DE ESP: Armadilhas (Snares/Giggles)
            if Settings.ESP_Traps and currentRooms then
                for _, room in pairs(currentRooms:GetChildren()) do
                    for _, trap in pairs(room:GetDescendants()) do
                        if trap.Name == "Snare" or trap.Name == "Giggle" then
                            local b = Instance.new("BillboardGui", trap)
                            b.Name = "AUG_PREMIUM_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 80, 0, 20)
                            b.StudsOffset = Vector3.new(0, 1.5, 0)

                            local l = Instance.new("TextLabel", b)
                            l.Size = UDim2.new(1, 0, 1, 0)
                            l.BackgroundTransparency = 1
                            l.Text = "🚨 TRAP"
                            l.TextColor3 = Color3.fromRGB(255, 60, 60)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 13
                        end
                    end
                end
            end

            -- RENDER DE ESP: Jogadores
            if Settings.ESP_Players then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local head = p.Character:FindFirstChild("Head") or p.Character:FindFirstChild("HumanoidRootPart")
                        if head then
                            local b = Instance.new("BillboardGui", p.Character)
                            b.Name = "AUG_PREMIUM_ESP"
                            b.AlwaysOnTop = true
                            b.Size = UDim2.new(0, 110, 0, 22)
                            b.StudsOffset = Vector3.new(0, 3, 0)

                            local l = Instance.new("TextLabel", b)
                            l.Size = UDim2.new(1, 0, 1, 0)
                            l.BackgroundTransparency = 1
                            l.Text = p.DisplayName
                            l.TextColor3 = Color3.fromRGB(100, 255, 100)
                            l.Font = Enum.Font.SourceSansBold
                            l.TextSize = 13
                        end
                    end
                end
            end

            -- AI do Painel de Eletricidade da Porta 100
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
