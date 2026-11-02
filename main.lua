--[[
    VORTEEZX HUB - TROLL EDITION V10.2
    Features: Fly, Car Fly, Exhaust Smoke (dynamic), ESP, TP, Freeze
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VORTEEZX_HUB_TROLL"
ScreenGui.ResetOnSpawn = false
pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui); ScreenGui.Parent = game.CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = Player:WaitForChild("PlayerGui")
    end
end)

local THEME = {
    BG = Color3.fromRGB(25, 25, 25),
    SIDEBAR = Color3.fromRGB(18, 18, 18),
    TOPBAR = Color3.fromRGB(15, 15, 15),
    ACCENT = Color3.fromRGB(200, 0, 50),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_DIM = Color3.fromRGB(150, 150, 150),
    ITEM_BG = Color3.fromRGB(35, 35, 35)
}

local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexPlayerESP"
local CarFlyEnabled = false

-- ============ EXHAUST SYSTEM STATE ============
local ExhaustEnabled = false
local ExhaustPosition = "back"
local ExhaustRate = 60
local ExhaustSize = 2.5
local ExhaustLifetime = 2.0
local ExhaustColor = Color3.fromRGB(10, 10, 10)
local ExhaustEmitters = {}
local ExhaustLastCar = nil

local function ClearExhaust()
    for _, emitter in pairs(ExhaustEmitters) do
        pcall(function() emitter:Destroy() end)
    end
    ExhaustEmitters = {}
    ExhaustLastCar = nil
end

local function UpdateExhaustEmitters()
    for _, pe in pairs(ExhaustEmitters) do
        if pe and pe.Parent then
            pcall(function()
                pe.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, ExhaustSize * 0.3),
                    NumberSequenceKeypoint.new(0.5, ExhaustSize),
                    NumberSequenceKeypoint.new(1, ExhaustSize * 2.5)
                })
                pe.Lifetime = NumberRange.new(ExhaustLifetime * 0.7, ExhaustLifetime * 1.3)
                pe.Color = ColorSequence.new(ExhaustColor)
            end)
        end
    end
end

local function CreateExhaustAt(primary, offsetVec)
    local att = Instance.new("Attachment")
    att.Name = "VortexExhaustAtt"
    att.Position = offsetVec
    att.Parent = primary

    local pe = Instance.new("ParticleEmitter")
    pe.Name = "VortexExhaustPE"
    pe.Parent = att

    pe.Texture = "rbxasset://textures/particles/smoke_main.dds"
    pe.LightEmission = 0
    pe.LightInfluence = 1
    pe.Color = ColorSequence.new(ExhaustColor)
    pe.Size = NumberSequence.new({
        NumberSequenceKeypoint.new(0, ExhaustSize * 0.3),
        NumberSequenceKeypoint.new(0.5, ExhaustSize),
        NumberSequenceKeypoint.new(1, ExhaustSize * 2.5)
    })
    pe.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.4, 0.4),
        NumberSequenceKeypoint.new(1, 1)
    })
    pe.Lifetime = NumberRange.new(ExhaustLifetime * 0.7, ExhaustLifetime * 1.3)
    pe.Rate = 0
    pe.Speed = NumberRange.new(5, 12)
    pe.Drag = 3
    pe.Acceleration = Vector3.new(0, 8, 0)
    pe.SpreadAngle = Vector2.new(20, 20)
    pe.RotSpeed = NumberRange.new(-90, 90)
    pe.Rotation = NumberRange.new(0, 360)
    pe.VelocityInheritance = 0.5
    pe.EmissionDirection = Enum.NormalId.Top
    pe.Enabled = true

    table.insert(ExhaustEmitters, pe)
    return pe
end

local function ApplyExhaust(car)
    ClearExhaust()
    local primary = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
    if not primary then return end
    ExhaustLastCar = car

    local F_OFF = 4.5
    local S_OFF = 2
    local Y_OFF = 0.5

    if ExhaustPosition == "back" then
        CreateExhaustAt(primary, Vector3.new(0, Y_OFF, -F_OFF))
    elseif ExhaustPosition == "front" then
        CreateExhaustAt(primary, Vector3.new(0, Y_OFF, F_OFF))
    elseif ExhaustPosition == "left" then
        CreateExhaustAt(primary, Vector3.new(-S_OFF, Y_OFF, 0))
    elseif ExhaustPosition == "right" then
        CreateExhaustAt(primary, Vector3.new(S_OFF, Y_OFF, 0))
    elseif ExhaustPosition == "dual" then
        CreateExhaustAt(primary, Vector3.new(-S_OFF, Y_OFF, -F_OFF))
        CreateExhaustAt(primary, Vector3.new(S_OFF, Y_OFF, -F_OFF))
    end
end

local FloatBtn = Instance.new("ImageButton")
FloatBtn.Parent = ScreenGui
FloatBtn.BackgroundColor3 = THEME.ACCENT
FloatBtn.BackgroundTransparency = 0.3
FloatBtn.Position = UDim2.new(0, 20, 0.5, -25)
FloatBtn.Size = UDim2.new(0, 50, 0, 50)
FloatBtn.BorderSizePixel = 0
FloatBtn.Draggable = true
FloatBtn.Image = "rbxassetid://124025278726144"
FloatBtn.ImageColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", FloatBtn).CornerRadius = UDim.new(1, 0)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = THEME.BG
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)

local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = THEME.TOPBAR
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BorderSizePixel = 0
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 6)

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Font = Enum.Font.GothamBlack
Title.Text = "VORTEEZX TROLL V10.2"
Title.TextColor3 = THEME.ACCENT
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
CloseBtn.Position = UDim2.new(1, -30, 0, 7)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = THEME.TEXT
CloseBtn.TextSize = 12
CloseBtn.BorderSizePixel = 0
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)

local ResizeHandle = Instance.new("TextButton")
ResizeHandle.Parent = MainFrame
ResizeHandle.BackgroundTransparency = 1
ResizeHandle.Size = UDim2.new(0, 25, 0, 25)
ResizeHandle.Position = UDim2.new(1, -25, 1, -25)
ResizeHandle.Text = "◢"
ResizeHandle.TextColor3 = THEME.TEXT_DIM
ResizeHandle.TextSize = 18
ResizeHandle.Font = Enum.Font.GothamBold
ResizeHandle.ZIndex = 10
ResizeHandle.AnchorPoint = Vector2.new(1, 1)

local isResizing, startSize, startPos = false, nil, nil
ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
        isResizing = true; startSize = MainFrame.AbsoluteSize; startPos = input.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - startPos
        MainFrame.Size = UDim2.fromOffset(math.max(300, startSize.X + delta.X), math.max(200, startSize.Y + delta.Y))
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isResizing = false end
end)

local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = THEME.SIDEBAR
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 120, 1, -35)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 6)

local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = THEME.BG
ContentArea.Position = UDim2.new(0, 120, 0, 35)
ContentArea.Size = UDim2.new(1, -120, 1, -35)
ContentArea.BorderSizePixel = 0
ContentArea.ClipsDescendants = true
Instance.new("UICorner", ContentArea).CornerRadius = UDim.new(0, 6)

local function CreateSidebarBtn(text, yPos, pageToOpen)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.BackgroundColor3 = THEME.SIDEBAR
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "  " .. text
    btn.TextColor3 = THEME.TEXT_DIM
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    local indicator = Instance.new("Frame")
    indicator.Parent = btn
    indicator.BackgroundColor3 = THEME.ACCENT
    indicator.Position = UDim2.new(0, 0, 0, 5)
    indicator.Size = UDim2.new(0, 3, 0, 25)
    indicator.Visible = false
    Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 2)
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(Sidebar:GetChildren()) do
            if v:IsA("TextButton") then v.TextColor3 = THEME.TEXT_DIM; v:FindFirstChildOfClass("Frame").Visible = false end
        end
        for _, v in pairs(ContentArea:GetChildren()) do
            if v:IsA("Frame") then v.Visible = false end
        end
        btn.TextColor3 = THEME.ACCENT
        indicator.Visible = true
        pageToOpen.Visible = true
    end)
    return btn
end

local function CreateToggle(parent, text, yPos, defaultState, callback)
    local row = Instance.new("Frame")
    row.Parent = parent
    row.BackgroundColor3 = THEME.ITEM_BG
    row.Position = UDim2.new(0, 10, 0, yPos)
    row.Size = UDim2.new(1, -20, 0, 35)
    row.BorderSizePixel = 0
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)
    local label = Instance.new("TextLabel")
    label.Parent = row
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Font = Enum.Font.GothamMedium
    label.Text = text
    label.TextColor3 = THEME.TEXT
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    local switchBg = Instance.new("TextButton")
    switchBg.Parent = row
    switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    switchBg.Position = UDim2.new(1, -45, 0.5, -10)
    switchBg.Size = UDim2.new(0, 35, 0, 20)
    switchBg.AutoButtonColor = false
    switchBg.Text = ""
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)
    local circle = Instance.new("Frame")
    circle.Parent = switchBg
    circle.BackgroundColor3 = THEME.TEXT
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.Size = UDim2.new(0, 16, 0, 16)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)
    local state = defaultState
    if state then
        switchBg.BackgroundColor3 = THEME.ACCENT
        circle.Position = UDim2.new(1, -18, 0.5, -8)
    end
    switchBg.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = THEME.ACCENT}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
        else
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
        end
        if callback then callback(state) end
    end)
end

local UpBtn = Instance.new("TextButton")
UpBtn.Parent = ScreenGui
UpBtn.Size = UDim2.new(0, 50, 0, 50)
UpBtn.Position = UDim2.new(1, -80, 1, -200)
UpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
UpBtn.BackgroundTransparency = 0.3
UpBtn.Text = "⬆"
UpBtn.TextColor3 = THEME.ACCENT
UpBtn.Font = Enum.Font.GothamBold
UpBtn.TextSize = 24
UpBtn.Visible = false
Instance.new("UICorner", UpBtn).CornerRadius = UDim.new(1, 0)

local DownBtn = Instance.new("TextButton")
DownBtn.Parent = ScreenGui
DownBtn.Size = UDim2.new(0, 50, 0, 50)
DownBtn.Position = UDim2.new(1, -140, 1, -200)
DownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
DownBtn.BackgroundTransparency = 0.3
DownBtn.Text = "⬇"
DownBtn.TextColor3 = THEME.ACCENT
DownBtn.Font = Enum.Font.GothamBold
DownBtn.TextSize = 24
DownBtn.Visible = false
Instance.new("UICorner", DownBtn).CornerRadius = UDim.new(1, 0)

local holdingUp, holdingDown = false, false
UpBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingUp = true end end)
UpBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingUp = false end end)
DownBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingDown = true end end)
DownBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingDown = false end end)

local ForwardBtn = Instance.new("TextButton")
ForwardBtn.Parent = ScreenGui
ForwardBtn.Size = UDim2.new(0, 50, 0, 50)
ForwardBtn.Position = UDim2.new(0, 20, 1, -200)
ForwardBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ForwardBtn.BackgroundTransparency = 0.3
ForwardBtn.Text = "MAJU"
ForwardBtn.TextColor3 = THEME.ACCENT
ForwardBtn.Font = Enum.Font.GothamBold
ForwardBtn.TextSize = 13
ForwardBtn.Visible = false
Instance.new("UICorner", ForwardBtn).CornerRadius = UDim.new(1, 0)

local BackwardBtn = Instance.new("TextButton")
BackwardBtn.Parent = ScreenGui
BackwardBtn.Size = UDim2.new(0, 50, 0, 50)
BackwardBtn.Position = UDim2.new(0, 20, 1, -140)
BackwardBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
BackwardBtn.BackgroundTransparency = 0.3
BackwardBtn.Text = "MUNDUR"
BackwardBtn.TextColor3 = THEME.ACCENT
BackwardBtn.Font = Enum.Font.GothamBold
BackwardBtn.TextSize = 11
BackwardBtn.Visible = false
Instance.new("UICorner", BackwardBtn).CornerRadius = UDim.new(1, 0)

local holdingForward, holdingBackward = false, false
ForwardBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingForward = true end end)
ForwardBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingForward = false end end)
BackwardBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingBackward = true end end)
BackwardBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingBackward = false end end)

local MovePage = Instance.new("Frame")
MovePage.Parent = ContentArea
MovePage.BackgroundTransparency = 1
MovePage.Size = UDim2.new(1, 0, 1, 0)
MovePage.Visible = true

local MoveTitle = Instance.new("TextLabel")
MoveTitle.Parent = MovePage
MoveTitle.BackgroundTransparency = 1
MoveTitle.Position = UDim2.new(0, 10, 0, 10)
MoveTitle.Size = UDim2.new(1, 0, 0, 20)
MoveTitle.Font = Enum.Font.GothamBold
MoveTitle.Text = "MOVEMENT SETTINGS"
MoveTitle.TextColor3 = THEME.ACCENT
MoveTitle.TextSize = 12
MoveTitle.TextXAlignment = Enum.TextXAlignment.Left

local FlyEnabled, RunEnabled, WaterEnabled, InfJumpEnabled = false, false, false, false
CreateToggle(MovePage, "Enable Fly", 40, false, function(state) FlyEnabled = state; UpBtn.Visible = state or CarFlyEnabled; DownBtn.Visible = state or CarFlyEnabled end)
CreateToggle(MovePage, "Walk on Water", 85, false, function(state) WaterEnabled = state end)
CreateToggle(MovePage, "Infinite Jump", 130, false, function(state) InfJumpEnabled = state end)
CreateToggle(MovePage, "Enable Run Speed", 175, false, function(state) RunEnabled = state end)

UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local FlySpeedFrame = Instance.new("Frame")
FlySpeedFrame.Parent = MovePage
FlySpeedFrame.BackgroundColor3 = THEME.ITEM_BG
FlySpeedFrame.Position = UDim2.new(0, 10, 0, 225)
FlySpeedFrame.Size = UDim2.new(1, -20, 0, 50)
FlySpeedFrame.BorderSizePixel = 0
Instance.new("UICorner", FlySpeedFrame).CornerRadius = UDim.new(0, 6)
local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Parent = FlySpeedFrame
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.Position = UDim2.new(0, 10, 0, 5)
FlySpeedLabel.Size = UDim2.new(1, 0, 0, 20)
FlySpeedLabel.Font = Enum.Font.GothamMedium
FlySpeedLabel.Text = "Fly Speed: 60"
FlySpeedLabel.TextColor3 = THEME.TEXT
FlySpeedLabel.TextSize = 11
FlySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
local FlyBar = Instance.new("TextButton")
FlyBar.Parent = FlySpeedFrame
FlyBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlyBar.Position = UDim2.new(0, 10, 0, 30)
FlyBar.Size = UDim2.new(1, -20, 0, 6)
FlyBar.AutoButtonColor = false
FlyBar.Text = ""
Instance.new("UICorner", FlyBar).CornerRadius = UDim.new(1, 0)
local FlyFill = Instance.new("Frame")
FlyFill.Parent = FlyBar
FlyFill.BackgroundColor3 = THEME.ACCENT
FlyFill.Size = UDim2.new(0.05, 0, 1, 0)
FlyFill.BorderSizePixel = 0
Instance.new("UICorner", FlyFill).CornerRadius = UDim.new(1, 0)
local FlySpeed = 60
local draggingFlySlider = false
local function updateFlySpeed(input)
    local width = FlyBar.AbsoluteSize.X
    if width <= 0 then return end
    local relative = math.clamp((input.Position.X - FlyBar.AbsolutePosition.X) / width, 0, 1)
    FlySpeed = math.floor(10 + relative * 490)
    FlySpeedLabel.Text = "Fly Speed: " .. FlySpeed
    FlyFill.Size = UDim2.new(relative, 0, 1, 0)
end
FlyBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFlySlider = true; updateFlySpeed(input) end end)
UserInputService.InputChanged:Connect(function(input) if draggingFlySlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateFlySpeed(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFlySlider = false end end)

local RunSpeedFrame = Instance.new("Frame")
RunSpeedFrame.Parent = MovePage
RunSpeedFrame.BackgroundColor3 = THEME.ITEM_BG
RunSpeedFrame.Position = UDim2.new(0, 10, 0, 285)
RunSpeedFrame.Size = UDim2.new(1, -20, 0, 50)
RunSpeedFrame.BorderSizePixel = 0
Instance.new("UICorner", RunSpeedFrame).CornerRadius = UDim.new(0, 6)
local RunSpeedLabel = Instance.new("TextLabel")
RunSpeedLabel.Parent = RunSpeedFrame
RunSpeedLabel.BackgroundTransparency = 1
RunSpeedLabel.Position = UDim2.new(0, 10, 0, 5)
RunSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
RunSpeedLabel.Font = Enum.Font.GothamMedium
RunSpeedLabel.Text = "Run Speed: 16"
RunSpeedLabel.TextColor3 = THEME.TEXT
RunSpeedLabel.TextSize = 11
RunSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
local RunBar = Instance.new("TextButton")
RunBar.Parent = RunSpeedFrame
RunBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
RunBar.Position = UDim2.new(0, 10, 0, 30)
RunBar.Size = UDim2.new(1, -20, 0, 6)
RunBar.AutoButtonColor = false
RunBar.Text = ""
Instance.new("UICorner", RunBar).CornerRadius = UDim.new(1, 0)
local RunFill = Instance.new("Frame")
RunFill.Parent = RunBar
RunFill.BackgroundColor3 = THEME.ACCENT
RunFill.Size = UDim2.new(0, 0, 1, 0)
RunFill.BorderSizePixel = 0
Instance.new("UICorner", RunFill).CornerRadius = UDim.new(1, 0)
local RunSpeed = 16
local draggingRunSlider = false
local function updateRunSpeed(input)
    local width = RunBar.AbsoluteSize.X
    if width <= 0 then return end
    local relative = math.clamp((input.Position.X - RunBar.AbsolutePosition.X) / width, 0, 1)
    RunSpeed = math.floor(16 + relative * 484)
    RunSpeedLabel.Text = "Run Speed: " .. RunSpeed
    RunFill.Size = UDim2.new(relative, 0, 1, 0)
end
RunBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingRunSlider = true; updateRunSpeed(input) end end)
UserInputService.InputChanged:Connect(function(input) if draggingRunSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateRunSpeed(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingRunSlider = false end end)

local CombatPage = Instance.new("Frame")
CombatPage.Parent = ContentArea
CombatPage.BackgroundTransparency = 1
CombatPage.Size = UDim2.new(1, 0, 1, 0)
CombatPage.Visible = false

local CombatTitle = Instance.new("TextLabel")
CombatTitle.Parent = CombatPage
CombatTitle.BackgroundTransparency = 1
CombatTitle.Position = UDim2.new(0, 10, 0, 10)
CombatTitle.Size = UDim2.new(1, 0, 0, 20)
CombatTitle.Font = Enum.Font.GothamBold
CombatTitle.Text = "CAR SPEED SETTINGS"
CombatTitle.TextColor3 = THEME.ACCENT
CombatTitle.TextSize = 12
CombatTitle.TextXAlignment = Enum.TextXAlignment.Left

local CarSpeedEnabled = false
CreateToggle(CombatPage, "Enable Car Speed", 40, false, function(state) CarSpeedEnabled = state end)

local CarSpeedFrame = Instance.new("Frame")
CarSpeedFrame.Parent = CombatPage
CarSpeedFrame.BackgroundColor3 = THEME.ITEM_BG
CarSpeedFrame.Position = UDim2.new(0, 10, 0, 85)
CarSpeedFrame.Size = UDim2.new(1, -20, 0, 50)
CarSpeedFrame.BorderSizePixel = 0
Instance.new("UICorner", CarSpeedFrame).CornerRadius = UDim.new(0, 6)
local CarSpeedLabel = Instance.new("TextLabel")
CarSpeedLabel.Parent = CarSpeedFrame
CarSpeedLabel.BackgroundTransparency = 1
CarSpeedLabel.Position = UDim2.new(0, 10, 0, 5)
CarSpeedLabel.Size = UDim2.new(1, 0, 0, 20)
CarSpeedLabel.Font = Enum.Font.GothamMedium
CarSpeedLabel.Text = "Car Speed: 100"
CarSpeedLabel.TextColor3 = THEME.TEXT
CarSpeedLabel.TextSize = 11
CarSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
local CarBar = Instance.new("TextButton")
CarBar.Parent = CarSpeedFrame
CarBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CarBar.Position = UDim2.new(0, 10, 0, 30)
CarBar.Size = UDim2.new(1, -20, 0, 6)
CarBar.AutoButtonColor = false
CarBar.Text = ""
Instance.new("UICorner", CarBar).CornerRadius = UDim.new(1, 0)
local CarFill = Instance.new("Frame")
CarFill.Parent = CarBar
CarFill.BackgroundColor3 = THEME.ACCENT
CarFill.Size = UDim2.new(0.1, 0, 1, 0)
CarFill.BorderSizePixel = 0
Instance.new("UICorner", CarFill).CornerRadius = UDim.new(1, 0)
local CarSpeed = 100
local draggingCarSlider = false
local function updateCarSpeed(input)
    local width = CarBar.AbsoluteSize.X
    if width <= 0 then return end
    local relative = math.clamp((input.Position.X - CarBar.AbsolutePosition.X) / width, 0, 1)
    CarSpeed = math.floor(50 + relative * 450)
    CarSpeedLabel.Text = "Car Speed: " .. CarSpeed
    CarFill.Size = UDim2.new(relative, 0, 1, 0)
end
CarBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingCarSlider = true; updateCarSpeed(input) end end)
UserInputService.InputChanged:Connect(function(input) if draggingCarSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateCarSpeed(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingCarSlider = false end end)

local TrollPage = Instance.new("Frame")
TrollPage.Parent = ContentArea
TrollPage.BackgroundTransparency = 1
TrollPage.Size = UDim2.new(1, 0, 1, 0)
TrollPage.Visible = false

local TrollTitle = Instance.new("TextLabel")
TrollTitle.Parent = TrollPage
TrollTitle.BackgroundTransparency = 1
TrollTitle.Position = UDim2.new(0, 10, 0, 10)
TrollTitle.Size = UDim2.new(1, 0, 0, 20)
TrollTitle.Font = Enum.Font.GothamBold
TrollTitle.Text = "CAR CONTROL (FLY / SIZE)"
TrollTitle.TextColor3 = THEME.ACCENT
TrollTitle.TextSize = 12
TrollTitle.TextXAlignment = Enum.TextXAlignment.Left

CreateToggle(TrollPage, "Enable Car Fly", 40, false, function(state)
    CarFlyEnabled = state
    UpBtn.Visible = state or FlyEnabled
    DownBtn.Visible = state or FlyEnabled
    ForwardBtn.Visible = state
    BackwardBtn.Visible = state
    if not state then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v.Name == "VortexCarFly" then v:Destroy() end
        end
    end
end)

local CFlyFrame = Instance.new("Frame")
CFlyFrame.Parent = TrollPage
CFlyFrame.BackgroundColor3 = THEME.ITEM_BG
CFlyFrame.Position = UDim2.new(0, 10, 0, 80)
CFlyFrame.Size = UDim2.new(1, -20, 0, 45)
CFlyFrame.BorderSizePixel = 0
Instance.new("UICorner", CFlyFrame).CornerRadius = UDim.new(0, 6)

local CFlyLabel = Instance.new("TextLabel")
CFlyLabel.Parent = CFlyFrame
CFlyLabel.BackgroundTransparency = 1
CFlyLabel.Position = UDim2.new(0, 10, 0, 5)
CFlyLabel.Size = UDim2.new(1, 0, 0, 15)
CFlyLabel.Font = Enum.Font.GothamMedium
CFlyLabel.Text = "Car Fly Speed: 100"
CFlyLabel.TextColor3 = THEME.TEXT
CFlyLabel.TextSize = 11
CFlyLabel.TextXAlignment = Enum.TextXAlignment.Left

local CFlyBar = Instance.new("TextButton")
CFlyBar.Parent = CFlyFrame
CFlyBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CFlyBar.Position = UDim2.new(0, 10, 0, 25)
CFlyBar.Size = UDim2.new(1, -20, 0, 6)
CFlyBar.AutoButtonColor = false
CFlyBar.Text = ""
Instance.new("UICorner", CFlyBar).CornerRadius = UDim.new(1, 0)

local CFlyFill = Instance.new("Frame")
CFlyFill.Parent = CFlyBar
CFlyFill.BackgroundColor3 = THEME.ACCENT
CFlyFill.Size = UDim2.new(0.1, 0, 1, 0)
CFlyFill.BorderSizePixel = 0
Instance.new("UICorner", CFlyFill).CornerRadius = UDim.new(1, 0)

local CarFlySpeed = 100
local draggingCFly = false
local function updateCarFlySpeed(input)
    local w = CFlyBar.AbsoluteSize.X
    if w <= 0 then return end
    local rel = math.clamp((input.Position.X - CFlyBar.AbsolutePosition.X) / w, 0, 1)
    CarFlySpeed = math.floor(50 + rel * 450)
    CFlyLabel.Text = "Car Fly Speed: " .. CarFlySpeed
    CFlyFill.Size = UDim2.new(rel, 0, 1, 0)
end
CFlyBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingCFly = true; updateCarFlySpeed(i) end end)
UserInputService.InputChanged:Connect(function(i) if draggingCFly and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then updateCarFlySpeed(i) end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingCFly = false end end)

local SizeFrame = Instance.new("Frame")
SizeFrame.Parent = TrollPage
SizeFrame.BackgroundColor3 = THEME.ITEM_BG
SizeFrame.Position = UDim2.new(0, 10, 0, 130)
SizeFrame.Size = UDim2.new(1, -20, 0, 55)
SizeFrame.BorderSizePixel = 0
Instance.new("UICorner", SizeFrame).CornerRadius = UDim.new(0, 6)

local SizeLabel = Instance.new("TextLabel")
SizeLabel.Parent = SizeFrame
SizeLabel.BackgroundTransparency = 1
SizeLabel.Position = UDim2.new(0, 10, 0, 5)
SizeLabel.Size = UDim2.new(1, 0, 0, 15)
SizeLabel.Font = Enum.Font.GothamBold
SizeLabel.Text = "Car Size Changer"
SizeLabel.TextColor3 = THEME.TEXT
SizeLabel.TextSize = 11
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left

local function CreateSizeBtn(text, xPos, sizeVal)
    local btn = Instance.new("TextButton")
    btn.Parent = SizeFrame
    btn.BackgroundColor3 = THEME.ACCENT
    btn.Position = UDim2.new(0, xPos, 0, 25)
    btn.Size = UDim2.new(0.3, 0, 0, 22)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = THEME.TEXT
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        local seat = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character.Humanoid.SeatPart
        if seat then
            local vehicle = seat:FindFirstAncestorOfClass("Model")
            if vehicle then pcall(function() vehicle:ScaleTo(sizeVal) end) end
        end
    end)
end
CreateSizeBtn("Mini", 5, 0.5)
CreateSizeBtn("Normal", 85, 1.0)
CreateSizeBtn("Giant", 165, 2.5)

local VisualPage = Instance.new("Frame")
VisualPage.Parent = ContentArea
VisualPage.BackgroundTransparency = 1
VisualPage.Size = UDim2.new(1, 0, 1, 0)
VisualPage.Visible = false

local VisTitle = Instance.new("TextLabel")
VisTitle.Parent = VisualPage
VisTitle.BackgroundTransparency = 1
VisTitle.Position = UDim2.new(0, 10, 0, 10)
VisTitle.Size = UDim2.new(1, 0, 0, 20)
VisTitle.Font = Enum.Font.GothamBold
VisTitle.Text = "VISUAL SETTINGS"
VisTitle.TextColor3 = THEME.ACCENT
VisTitle.TextSize = 12
VisTitle.TextXAlignment = Enum.TextXAlignment.Left

local ESPEnabled = false
CreateToggle(VisualPage, "ESP Player (Wallhack)", 40, false, function(state) ESPEnabled = state; if not state then ESPFolder:ClearAllChildren() end end)

CreateToggle(VisualPage, "Enable Exhaust Smoke", 85, false, function(state)
    ExhaustEnabled = state
    if not state then
        ClearExhaust()
    else
        local seat = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character.Humanoid.SeatPart
        local car = seat and seat:FindFirstAncestorOfClass("Model")
        if car then ApplyExhaust(car) end
    end
end)

local PosFrame = Instance.new("Frame")
PosFrame.Parent = VisualPage
PosFrame.BackgroundColor3 = THEME.ITEM_BG
PosFrame.Position = UDim2.new(0, 10, 0, 130)
PosFrame.Size = UDim2.new(1, -20, 0, 65)
PosFrame.BorderSizePixel = 0
Instance.new("UICorner", PosFrame).CornerRadius = UDim.new(0, 6)

local PosLabel = Instance.new("TextLabel")
PosLabel.Parent = PosFrame
PosLabel.BackgroundTransparency = 1
PosLabel.Position = UDim2.new(0, 10, 0, 3)
PosLabel.Size = UDim2.new(1, 0, 0, 15)
PosLabel.Font = Enum.Font.GothamBold
PosLabel.Text = "Exhaust Position: BACK"
PosLabel.TextColor3 = THEME.TEXT
PosLabel.TextSize = 10
PosLabel.TextXAlignment = Enum.TextXAlignment.Left

local PosButtons = {}
local posOptions = {
    {key = "back", label = "BACK"},
    {key = "front", label = "FRONT"},
    {key = "left", label = "LEFT"},
    {key = "right", label = "RIGHT"},
    {key = "dual", label = "DUAL"}
}
for i, opt in ipairs(posOptions) do
    local btn = Instance.new("TextButton")
    btn.Parent = PosFrame
    btn.BackgroundColor3 = (opt.key == "back") and THEME.ACCENT or Color3.fromRGB(60, 60, 60)
    btn.Position = UDim2.new(0, 5 + (i - 1) * 74, 0, 22)
    btn.Size = UDim2.new(0, 70, 0, 28)
    btn.Font = Enum.Font.GothamBold
    btn.Text = opt.label
    btn.TextColor3 = THEME.TEXT
    btn.TextSize = 9
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    PosButtons[opt.key] = btn
    btn.MouseButton1Click:Connect(function()
        for _, b in pairs(PosButtons) do b.BackgroundColor3 = Color3.fromRGB(60, 60, 60) end
        btn.BackgroundColor3 = THEME.ACCENT
        ExhaustPosition = opt.key
        PosLabel.Text = "Exhaust Position: " .. opt.label
        if ExhaustEnabled then
            local seat = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") and Player.Character.Humanoid.SeatPart
            local car = seat and seat:FindFirstAncestorOfClass("Model")
            if car then ApplyExhaust(car) end
        end
    end)
end

local RateFrame = Instance.new("Frame")
RateFrame.Parent = VisualPage
RateFrame.BackgroundColor3 = THEME.ITEM_BG
RateFrame.Position = UDim2.new(0, 10, 0, 205)
RateFrame.Size = UDim2.new(1, -20, 0, 45)
RateFrame.BorderSizePixel = 0
Instance.new("UICorner", RateFrame).CornerRadius = UDim.new(0, 6)

local RateLabel = Instance.new("TextLabel")
RateLabel.Parent = RateFrame
RateLabel.BackgroundTransparency = 1
RateLabel.Position = UDim2.new(0, 10, 0, 3)
RateLabel.Size = UDim2.new(1, 0, 0, 15)
RateLabel.Font = Enum.Font.GothamMedium
RateLabel.Text = "Smoke Density: 60"
RateLabel.TextColor3 = THEME.TEXT
RateLabel.TextSize = 10
RateLabel.TextXAlignment = Enum.TextXAlignment.Left

local RateBar = Instance.new("TextButton")
RateBar.Parent = RateFrame
RateBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
RateBar.Position = UDim2.new(0, 10, 0, 22)
RateBar.Size = UDim2.new(1, -20, 0, 6)
RateBar.AutoButtonColor = false
RateBar.Text = ""
Instance.new("UICorner", RateBar).CornerRadius = UDim.new(1, 0)

local RateFill = Instance.new("Frame")
RateFill.Parent = RateBar
RateFill.BackgroundColor3 = THEME.ACCENT
RateFill.Size = UDim2.new(0.6, 0, 1, 0)
RateFill.BorderSizePixel = 0
Instance.new("UICorner", RateFill).CornerRadius = UDim.new(1, 0)

local draggingRate = false
local function updateRate(input)
    local w = RateBar.AbsoluteSize.X
    if w <= 0 then return end
    local rel = math.clamp((input.Position.X - RateBar.AbsolutePosition.X) / w, 0, 1)
    ExhaustRate = math.floor(5 + rel * 195)
    RateLabel.Text = "Smoke Density: " .. ExhaustRate
    RateFill.Size = UDim2.new(rel, 0, 1, 0)
    UpdateExhaustEmitters()
end
RateBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingRate = true; updateRate(i) end end)
UserInputService.InputChanged:Connect(function(i) if draggingRate and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then updateRate(i) end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingRate = false end end)

local SizeSldFrame = Instance.new("Frame")
SizeSldFrame.Parent = VisualPage
SizeSldFrame.BackgroundColor3 = THEME.ITEM_BG
SizeSldFrame.Position = UDim2.new(0, 10, 0, 255)
SizeSldFrame.Size = UDim2.new(1, -20, 0, 45)
SizeSldFrame.BorderSizePixel = 0
Instance.new("UICorner", SizeSldFrame).CornerRadius = UDim.new(0, 6)

local SizeSldLabel = Instance.new("TextLabel")
SizeSldLabel.Parent = SizeSldFrame
SizeSldLabel.BackgroundTransparency = 1
SizeSldLabel.Position = UDim2.new(0, 10, 0, 3)
SizeSldLabel.Size = UDim2.new(1, 0, 0, 15)
SizeSldLabel.Font = Enum.Font.GothamMedium
SizeSldLabel.Text = "Smoke Size: 2.5"
SizeSldLabel.TextColor3 = THEME.TEXT
SizeSldLabel.TextSize = 10
SizeSldLabel.TextXAlignment = Enum.TextXAlignment.Left

local SizeSldBar = Instance.new("TextButton")
SizeSldBar.Parent = SizeSldFrame
SizeSldBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SizeSldBar.Position = UDim2.new(0, 10, 0, 22)
SizeSldBar.Size = UDim2.new(1, -20, 0, 6)
SizeSldBar.AutoButtonColor = false
SizeSldBar.Text = ""
Instance.new("UICorner", SizeSldBar).CornerRadius = UDim.new(1, 0)

local SizeSldFill = Instance.new("Frame")
SizeSldFill.Parent = SizeSldBar
SizeSldFill.BackgroundColor3 = THEME.ACCENT
SizeSldFill.Size = UDim2.new(0.4, 0, 1, 0)
SizeSldFill.BorderSizePixel = 0
Instance.new("UICorner", SizeSldFill).CornerRadius = UDim.new(1, 0)

local draggingSize = false
local function updateSize(input)
    local w = SizeSldBar.AbsoluteSize.X
    if w <= 0 then return end
    local rel = math.clamp((input.Position.X - SizeSldBar.AbsolutePosition.X) / w, 0, 1)
    ExhaustSize = math.floor((0.5 + rel * 5.5) * 10) / 10
    SizeSldLabel.Text = "Smoke Size: " .. ExhaustSize
    SizeSldFill.Size = UDim2.new(rel, 0, 1, 0)
    UpdateExhaustEmitters()
end
SizeSldBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSize = true; updateSize(i) end end)
UserInputService.InputChanged:Connect(function(i) if draggingSize and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then updateSize(i) end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingSize = false end end)

local LifeFrame = Instance.new("Frame")
LifeFrame.Parent = VisualPage
LifeFrame.BackgroundColor3 = THEME.ITEM_BG
LifeFrame.Position = UDim2.new(0, 10, 0, 305)
LifeFrame.Size = UDim2.new(1, -20, 0, 45)
LifeFrame.BorderSizePixel = 0
Instance.new("UICorner", LifeFrame).CornerRadius = UDim.new(0, 6)

local LifeLabel = Instance.new("TextLabel")
LifeLabel.Parent = LifeFrame
LifeLabel.BackgroundTransparency = 1
LifeLabel.Position = UDim2.new(0, 10, 0, 3)
LifeLabel.Size = UDim2.new(1, 0, 0, 15)
LifeLabel.Font = Enum.Font.GothamMedium
LifeLabel.Text = "Smoke Lifetime: 2.0s"
LifeLabel.TextColor3 = THEME.TEXT
LifeLabel.TextSize = 10
LifeLabel.TextXAlignment = Enum.TextXAlignment.Left

local LifeBar = Instance.new("TextButton")
LifeBar.Parent = LifeFrame
LifeBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
LifeBar.Position = UDim2.new(0, 10, 0, 22)
LifeBar.Size = UDim2.new(1, -20, 0, 6)
LifeBar.AutoButtonColor = false
LifeBar.Text = ""
Instance.new("UICorner", LifeBar).CornerRadius = UDim.new(1, 0)

local LifeFill = Instance.new("Frame")
LifeFill.Parent = LifeBar
LifeFill.BackgroundColor3 = THEME.ACCENT
LifeFill.Size = UDim2.new(0.5, 0, 1, 0)
LifeFill.BorderSizePixel = 0
Instance.new("UICorner", LifeFill).CornerRadius = UDim.new(1, 0)

local draggingLife = false
local function updateLife(input)
    local w = LifeBar.AbsoluteSize.X
    if w <= 0 then return end
    local rel = math.clamp((input.Position.X - LifeBar.AbsolutePosition.X) / w, 0, 1)
    ExhaustLifetime = math.floor((0.5 + rel * 3.5) * 10) / 10
    LifeLabel.Text = "Smoke Lifetime: " .. ExhaustLifetime .. "s"
    LifeFill.Size = UDim2.new(rel, 0, 1, 0)
    UpdateExhaustEmitters()
end
LifeBar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingLife = true; updateLife(i) end end)
UserInputService.InputChanged:Connect(function(i) if draggingLife and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then updateLife(i) end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then draggingLife = false end end)

local ColorFrame = Instance.new("Frame")
ColorFrame.Parent = VisualPage
ColorFrame.BackgroundColor3 = THEME.ITEM_BG
ColorFrame.Position = UDim2.new(0, 10, 0, 355)
ColorFrame.Size = UDim2.new(1, -20, 0, 55)
ColorFrame.BorderSizePixel = 0
Instance.new("UICorner", ColorFrame).CornerRadius = UDim.new(0, 6)

local ColorLabel = Instance.new("TextLabel")
ColorLabel.Parent = ColorFrame
ColorLabel.BackgroundTransparency = 1
ColorLabel.Position = UDim2.new(0, 10, 0, 3)
ColorLabel.Size = UDim2.new(1, 0, 0, 15)
ColorLabel.Font = Enum.Font.GothamBold
ColorLabel.Text = "Smoke Color"
ColorLabel.TextColor3 = THEME.TEXT
ColorLabel.TextSize = 10
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left

local colorPresets = {
    {name = "BLACK", col = Color3.fromRGB(10, 10, 10)},
    {name = "WHITE", col = Color3.fromRGB(240, 240, 240)},
    {name = "GREEN", col = Color3.fromRGB(50, 200, 50)},
    {name = "RED", col = Color3.fromRGB(220, 30, 30)},
    {name = "PINK", col = Color3.fromRGB(255, 100, 200)},
    {name = "GOLD", col = Color3.fromRGB(255, 200, 0)}
}
for i, preset in ipairs(colorPresets) do
    local btn = Instance.new("TextButton")
    btn.Parent = ColorFrame
    btn.BackgroundColor3 = preset.col
    btn.Position = UDim2.new(0, 5 + (i - 1) * 60, 0, 22)
    btn.Size = UDim2.new(0, 55, 0, 25)
    btn.Font = Enum.Font.GothamBold
    btn.Text = ""
    btn.TextColor3 = THEME.TEXT
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function()
        ExhaustColor = preset.col
        UpdateExhaustEmitters()
    end)
end

local TPPage = Instance.new("Frame")
TPPage.Parent = ContentArea
TPPage.BackgroundTransparency = 1
TPPage.Size = UDim2.new(1, 0, 1, 0)
TPPage.Visible = false
local TPTitle = Instance.new("TextLabel")
TPTitle.Parent = TPPage
TPTitle.BackgroundTransparency = 1
TPTitle.Position = UDim2.new(0, 10, 0, 10)
TPTitle.Size = UDim2.new(1, 0, 0, 20)
TPTitle.Font = Enum.Font.GothamBold
TPTitle.Text = "TELEPORT & FREEZE TARGET"
TPTitle.TextColor3 = THEME.ACCENT
TPTitle.TextSize = 12
TPTitle.TextXAlignment = Enum.TextXAlignment.Left

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = TPPage
PlayerList.BackgroundColor3 = THEME.ITEM_BG
PlayerList.Position = UDim2.new(0, 10, 0, 40)
PlayerList.Size = UDim2.new(1, -20, 1, -130)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.ScrollBarImageColor3 = THEME.ACCENT
Instance.new("UICorner", PlayerList).CornerRadius = UDim.new(0, 6)
local PLLayout = Instance.new("UIListLayout", PlayerList)
PLLayout.SortOrder = Enum.SortOrder.Name
PLLayout.Padding = UDim.new(0, 2)

local TPExecBtn = Instance.new("TextButton")
TPExecBtn.Parent = TPPage
TPExecBtn.BackgroundColor3 = THEME.ACCENT
TPExecBtn.Position = UDim2.new(0, 10, 1, -85)
TPExecBtn.Size = UDim2.new(1, -20, 0, 30)
TPExecBtn.Font = Enum.Font.GothamBold
TPExecBtn.Text = "TELEPORT"
TPExecBtn.TextColor3 = THEME.TEXT
TPExecBtn.TextSize = 12
Instance.new("UICorner", TPExecBtn).CornerRadius = UDim.new(0, 6)

local FreezeCarBtn = Instance.new("TextButton")
FreezeCarBtn.Parent = TPPage
FreezeCarBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
FreezeCarBtn.Position = UDim2.new(0, 10, 1, -45)
FreezeCarBtn.Size = UDim2.new(1, -20, 0, 30)
FreezeCarBtn.Font = Enum.Font.GothamBold
FreezeCarBtn.Text = "FREEZE TARGET CAR (5s)"
FreezeCarBtn.TextColor3 = THEME.TEXT
FreezeCarBtn.TextSize = 12
Instance.new("UICorner", FreezeCarBtn).CornerRadius = UDim.new(0, 6)

local NavMove = CreateSidebarBtn("MOVEMENT", 10, MovePage)
local NavCombat = CreateSidebarBtn("CAR SPEED", 50, CombatPage)
local NavTroll = CreateSidebarBtn("TROLL", 90, TrollPage)
local NavVis = CreateSidebarBtn("VISUAL", 130, VisualPage)
local NavTP = CreateSidebarBtn("TELEPORT", 170, TPPage)
NavMove.TextColor3 = THEME.ACCENT
NavMove:FindFirstChildOfClass("Frame").Visible = true

local SelectedTarget = nil
local function RefreshPlayerList()
    for _, v in pairs(PlayerList:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= Player then
            local btn = Instance.new("TextButton")
            btn.Parent = PlayerList
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.Size = UDim2.new(1, -6, 0, 25)
            btn.Font = Enum.Font.GothamMedium
            btn.Text = p.Name
            btn.TextColor3 = THEME.TEXT
            btn.TextSize = 11
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            btn.MouseButton1Click:Connect(function()
                SelectedTarget = p
                for _, otherBtn in pairs(PlayerList:GetChildren()) do if otherBtn:IsA("TextButton") then otherBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end end
                btn.BackgroundColor3 = THEME.ACCENT
                btn.TextColor3 = Color3.fromRGB(0, 0, 0)
            end)
        end
    end
end

local isOpen = false
FloatBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
    if isOpen then RefreshPlayerList() end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    isOpen = false
end)

TPExecBtn.MouseButton1Click:Connect(function()
    if SelectedTarget and SelectedTarget.Character and SelectedTarget.Character:FindFirstChild("HumanoidRootPart") then
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = SelectedTarget.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        end
    end
end)

FreezeCarBtn.MouseButton1Click:Connect(function()
    if not SelectedTarget or not SelectedTarget.Character then
        print("[VORTEEZX] No target selected")
        return
    end
    local hum = SelectedTarget.Character:FindFirstChildOfClass("Humanoid")
    local seat = hum and hum.SeatPart
    if not (seat and seat:IsA("VehicleSeat")) then
        print("[VORTEEZX] Target not in vehicle")
        return
    end
    local veh = seat:FindFirstAncestorOfClass("Model")
    if not veh then return end
    local interaction = ReplicatedStorage:FindFirstChild("Interaction")
    if interaction then
        local req = interaction:FindFirstChild("ClientRequestOwnership")
        if req and veh.PrimaryPart then pcall(function() req:FireServer(veh.PrimaryPart) end) end
    end
    for _, p in pairs(veh:GetDescendants()) do
        if p:IsA("BasePart") then
            pcall(function() p:SetNetworkOwner(Player) end)
        end
    end
    local endTime = tick() + 5
    task.spawn(function()
        while tick() < endTime do
            for _, p in pairs(veh:GetDescendants()) do
                if p:IsA("BasePart") then
                    pcall(function()
                        p.AssemblyLinearVelocity = Vector3.zero
                        p.AssemblyAngularVelocity = Vector3.zero
                    end)
                end
            end
            task.wait(0.05)
        end
    end)
    print("[VORTEEZX] Freezing car: " .. veh.Name)
end)

RunService.RenderStepped:Connect(function(dt)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Player.Character.HumanoidRootPart
        local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")

        if RunEnabled and not FlyEnabled then Humanoid.WalkSpeed = RunSpeed
        elseif not RunEnabled and not FlyEnabled then Humanoid.WalkSpeed = 16 end

        if WaterEnabled then
            if Humanoid.FloorMaterial == Enum.Material.Water or Humanoid:GetState() == Enum.HumanoidStateType.Swimming then
                local bf = HRP:FindFirstChild("WaterForce")
                if not bf then bf = Instance.new("BodyForce"); bf.Name = "WaterForce"; bf.Parent = HRP end
                bf.Force = Vector3.new(0, HRP:GetMass() * Workspace.Gravity * 1.1, 0)
                if Humanoid:GetState() == Enum.HumanoidStateType.Swimming then Humanoid:ChangeState(Enum.HumanoidStateType.Running) end
            else
                local bf = HRP:FindFirstChild("WaterForce"); if bf then bf:Destroy() end
            end
        else
            local bf = HRP:FindFirstChild("WaterForce"); if bf then bf:Destroy() end
        end

        if FlyEnabled then
            Humanoid.PlatformStand = true
            local bv = HRP:FindFirstChild("VortexFlyBV")
            if not bv then bv = Instance.new("BodyVelocity"); bv.Name = "VortexFlyBV"; bv.MaxForce = Vector3.new(1e5, 1e5, 1e5); bv.Parent = HRP end
            local velocity = Humanoid.MoveDirection * FlySpeed
            if holdingUp then velocity = velocity + Vector3.new(0, FlySpeed, 0)
            elseif holdingDown then velocity = velocity - Vector3.new(0, FlySpeed, 0) end
            bv.Velocity = velocity
        else
            local bv = HRP:FindFirstChild("VortexFlyBV"); if bv then bv:Destroy() end
        end

        if CarFlyEnabled then
            local seat = Humanoid.SeatPart
            if seat and seat:IsA("VehicleSeat") then
                local veh = seat:FindFirstAncestorOfClass("Model")
                if veh then
                    local primary = veh.PrimaryPart or veh:FindFirstChildWhichIsA("BasePart")
                    if primary then
                        pcall(function() primary:SetNetworkOwner(Player) end)
                        local bv = primary:FindFirstChild("VortexCarFly")
                        if not bv then
                            bv = Instance.new("BodyVelocity")
                            bv.Name = "VortexCarFly"
                            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
                            bv.P = 12500
                            bv.Parent = primary
                        end
                        local dir = Vector3.zero
                        local cam = Workspace.CurrentCamera
                        if cam then
                            local camLook = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
                            if camLook.Magnitude > 0.01 then
                                camLook = camLook.Unit
                                if holdingForward then dir = dir + camLook * CarFlySpeed end
                                if holdingBackward then dir = dir - camLook * CarFlySpeed end
                            end
                        end
                        if Humanoid.MoveDirection.Magnitude > 0.01 then
                            dir = dir + Humanoid.MoveDirection * CarFlySpeed
                        end
                        if holdingUp then dir = dir + Vector3.new(0, CarFlySpeed, 0) end
                        if holdingDown then dir = dir - Vector3.new(0, CarFlySpeed, 0) end
                        bv.Velocity = dir
                    end
                end
            end
        end

        if CarSpeedEnabled then
            local seat = Humanoid.SeatPart
            if seat and seat:IsA("VehicleSeat") then
                local vehicle = seat:FindFirstAncestorOfClass("Model")
                if vehicle then
                    local mainPart = vehicle.PrimaryPart or vehicle:FindFirstChild("HumanoidRootPart") or seat
                    local downForce = mainPart:FindFirstChild("VortexDownForce")
                    if not downForce then downForce = Instance.new("BodyForce"); downForce.Name = "VortexDownForce"; downForce.Parent = mainPart end
                    downForce.Force = Vector3.new(0, -mainPart:GetMass() * Workspace.Gravity * 5, 0)
                    local gyro = mainPart:FindFirstChild("VortexGyro")
                    if not gyro then gyro = Instance.new("BodyGyro"); gyro.Name = "VortexGyro"; gyro.P = 10000; gyro.D = 1000; gyro.MaxTorque = Vector3.new(1e5, 0, 1e5); gyro.Parent = mainPart end
                    gyro.CFrame = CFrame.new(mainPart.Position, mainPart.Position + seat.CFrame.LookVector)
                    local carVel = mainPart:FindFirstChild("VortexSpeed")
                    if not carVel then carVel = Instance.new("BodyVelocity"); carVel.Name = "VortexSpeed"; carVel.Parent = mainPart end
                    carVel.MaxForce = Vector3.new(25000, 0, 25000)
                    carVel.Velocity = seat.CFrame.LookVector * CarSpeed
                end
            end
        else
            if Humanoid.SeatPart then
                local vehicle = Humanoid.SeatPart:FindFirstAncestorOfClass("Model")
                if vehicle then
                    local mainPart = vehicle.PrimaryPart or vehicle:FindFirstChild("HumanoidRootPart") or Humanoid.SeatPart
                    local carVel = mainPart:FindFirstChild("VortexSpeed"); if carVel then carVel:Destroy() end
                    local downForce = mainPart:FindFirstChild("VortexDownForce"); if downForce then downForce:Destroy() end
                    local gyro = mainPart:FindFirstChild("VortexGyro"); if gyro then gyro:Destroy() end
                end
            end
        end

        -- EXHAUST SMOKE (DYNAMIC RATE)
        if ExhaustEnabled then
            local seat = Humanoid.SeatPart
            local car = seat and seat:FindFirstAncestorOfClass("Model")
            if car and car ~= ExhaustLastCar then
                ApplyExhaust(car)
            elseif not car and ExhaustLastCar then
                ClearExhaust()
            end

            if car and #ExhaustEmitters > 0 then
                local throttle = (seat and seat:IsA("VehicleSeat")) and seat.Throttle or 0
                local speedPart = car.PrimaryPart or car:FindFirstChildWhichIsA("BasePart")
                local speedVal = speedPart and speedPart.AssemblyLinearVelocity.Magnitude or 0

                local targetRate = 0
                if throttle ~= 0 then
                    targetRate = ExhaustRate
                elseif speedVal > 5 then
                    targetRate = math.floor(ExhaustRate * 0.5)
                end

                for _, pe in pairs(ExhaustEmitters) do
                    if pe and pe.Parent then
                        pcall(function() pe.Rate = targetRate end)
                    end
                end
            end
        end
    end

    if ESPEnabled then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                local char = p.Character
                local hrp = char.HumanoidRootPart
                if char.Humanoid.Health > 0 then
                    if not ESPFolder:FindFirstChild(p.Name .. "_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = p.Name .. "_Highlight"; highlight.Adornee = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0); highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5; highlight.Parent = ESPFolder
                    end
                    if not ESPFolder:FindFirstChild(p.Name .. "_Text") then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = p.Name .. "_Text"; billboard.Adornee = hrp
                        billboard.Size = UDim2.new(0, 100, 0, 50); billboard.AlwaysOnTop = true; billboard.Parent = ESPFolder
                        local text = Instance.new("TextLabel")
                        text.Parent = billboard; text.BackgroundTransparency = 1; text.Size = UDim2.new(1, 0, 1, 0)
                        text.Font = Enum.Font.GothamBold; text.TextColor3 = Color3.fromRGB(255, 0, 0); text.TextStrokeTransparency = 0.5; text.TextSize = 12; text.Name = "Text"
                    end
                    local distance = math.floor((Player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    local textLabel = ESPFolder:FindFirstChild(p.Name .. "_Text"):FindFirstChild("Text")
                    textLabel.Text = p.Name .. "\n[" .. distance .. " studs]"
                end
            end
        end
    end
end)

print("[VORTEEZX] TROLL V10.2 Loaded - Dynamic Exhaust Active!")
