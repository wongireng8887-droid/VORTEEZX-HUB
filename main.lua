--[[
    VORTEEZX HUB - FINAL FULL EDITION (RED + RUN SPEED)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VORTEEZX_HUB_FINAL"
ScreenGui.ResetOnSpawn = false
pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = game.CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = Player:WaitForChild("PlayerGui")
    end
end)

-- Warna Tema (Merah Darah)
local THEME = {
    BG = Color3.fromRGB(25, 25, 25),
    SIDEBAR = Color3.fromRGB(18, 18, 18),
    TOPBAR = Color3.fromRGB(15, 15, 15),
    ACCENT = Color3.fromRGB(200, 0, 50), -- MERAH
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_DIM = Color3.fromRGB(150, 150, 150),
    ITEM_BG = Color3.fromRGB(35, 35, 35)
}

-- ================= TOMBOL NAIK / TURUN =================
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
local UpCorner = Instance.new("UICorner", UpBtn)
UpCorner.CornerRadius = UDim.new(1, 0)

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
local DownCorner = Instance.new("UICorner", DownBtn)
DownCorner.CornerRadius = UDim.new(1, 0)

local holdingUp = false
local holdingDown = false

UpBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingUp = true end end)
UpBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingUp = false end end)
DownBtn.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingDown = true end end)
DownBtn.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingDown = false end end)

-- ================= TOMBOL FLOATING (IMAGE) =================
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
local FloatCorner = Instance.new("UICorner", FloatBtn)
FloatCorner.CornerRadius = UDim.new(1, 0)

-- ================= MAIN FRAME =================
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
local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 6)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = THEME.TOPBAR
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BorderSizePixel = 0
local TopBarCorner = Instance.new("UICorner", TopBar)
TopBarCorner.CornerRadius = UDim.new(0, 6)

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Font = Enum.Font.GothamBlack
Title.Text = "VORTEEZX HUB"
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
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(1, 0)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = THEME.SIDEBAR
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 120, 1, -35)
Sidebar.BorderSizePixel = 0
local SidebarCorner = Instance.new("UICorner", Sidebar)
SidebarCorner.CornerRadius = UDim.new(0, 6)

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundColor3 = THEME.BG
ContentArea.Position = UDim2.new(0, 120, 0, 35)
ContentArea.Size = UDim2.new(1, -120, 1, -35)
ContentArea.BorderSizePixel = 0
local ContentCorner = Instance.new("UICorner", ContentArea)
ContentCorner.CornerRadius = UDim.new(0, 6)

-- Resize Handle
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

local isResizing = false
local startSize, startPos

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isResizing = true
        startSize = MainFrame.AbsoluteSize
        startPos = input.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - startPos
        local newWidth = math.max(300, startSize.X + delta.X)
        local newHeight = math.max(200, startSize.Y + delta.Y)
        MainFrame.Size = UDim2.fromOffset(newWidth, newHeight)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isResizing = false
    end
end)

-- ================= HELPER =================
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
    local indCorner = Instance.new("UICorner", indicator)
    indCorner.CornerRadius = UDim.new(0, 2)
    
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(Sidebar:GetChildren()) do
            if v:IsA("TextButton") then
                v.TextColor3 = THEME.TEXT_DIM
                v:FindFirstChildOfClass("Frame").Visible = false
            end
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
    local rCorner = Instance.new("UICorner", row)
    rCorner.CornerRadius = UDim.new(0, 6)

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
    local swCorner = Instance.new("UICorner", switchBg)
    swCorner.CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame")
    circle.Parent = switchBg
    circle.BackgroundColor3 = THEME.TEXT
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.Size = UDim2.new(0, 16, 0, 16)
    local cCorner = Instance.new("UICorner", circle)
    cCorner.CornerRadius = UDim.new(1, 0)

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

-- ================= HALAMAN (PAGES) =================

-- Halaman 1: MOVEMENT
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

-- Fly Toggle
local FlyEnabled = false
CreateToggle(MovePage, "Enable Fly (Terbang)", 40, false, function(state)
    FlyEnabled = state
    UpBtn.Visible = state
    DownBtn.Visible = state
    if not state and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
        Player.Character.Humanoid.PlatformStand = false
    end
end)

-- Slider Fly Speed
local FlySpeedFrame = Instance.new("Frame")
FlySpeedFrame.Parent = MovePage
FlySpeedFrame.BackgroundColor3 = THEME.ITEM_BG
FlySpeedFrame.Position = UDim2.new(0, 10, 0, 85)
FlySpeedFrame.Size = UDim2.new(1, -20, 0, 50)
FlySpeedFrame.BorderSizePixel = 0
local FSF_Corner = Instance.new("UICorner", FlySpeedFrame)
FSF_Corner.CornerRadius = UDim.new(0, 6)

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
local FBarCorner = Instance.new("UICorner", FlyBar)
FBarCorner.CornerRadius = UDim.new(1, 0)

local FlyFill = Instance.new("Frame")
FlyFill.Parent = FlyBar
FlyFill.BackgroundColor3 = THEME.ACCENT
FlyFill.Size = UDim2.new(0.3, 0, 1, 0)
FlyFill.BorderSizePixel = 0
local FFillCorner = Instance.new("UICorner", FlyFill)
FFillCorner.CornerRadius = UDim.new(1, 0)

local FlySpeed = 60
local draggingFlySlider = false
local function updateFlySpeed(input)
    local width = FlyBar.AbsoluteSize.X
    if width <= 0 then return end
    local relative = math.clamp((input.Position.X - FlyBar.AbsolutePosition.X) / width, 0, 1)
    FlySpeed = math.floor(10 + relative * 190)
    FlySpeedLabel.Text = "Fly Speed: " .. FlySpeed
    FlyFill.Size = UDim2.new(relative, 0, 1, 0)
end
FlyBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFlySlider = true; updateFlySpeed(input) end end)
UserInputService.InputChanged:Connect(function(input) if draggingFlySlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateFlySpeed(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingFlySlider = false end end)

-- Run Toggle
local RunEnabled = false
CreateToggle(MovePage, "Enable Run Speed", 150, false, function(state)
    RunEnabled = state
end)

-- Slider Run Speed
local RunSpeedFrame = Instance.new("Frame")
RunSpeedFrame.Parent = MovePage
RunSpeedFrame.BackgroundColor3 = THEME.ITEM_BG
RunSpeedFrame.Position = UDim2.new(0, 10, 0, 195)
RunSpeedFrame.Size = UDim2.new(1, -20, 0, 50)
RunSpeedFrame.BorderSizePixel = 0
local RSF_Corner = Instance.new("UICorner", RunSpeedFrame)
RSF_Corner.CornerRadius = UDim.new(0, 6)

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
local RBarCorner = Instance.new("UICorner", RunBar)
RBarCorner.CornerRadius = UDim.new(1, 0)

local RunFill = Instance.new("Frame")
RunFill.Parent = RunBar
RunFill.BackgroundColor3 = THEME.ACCENT
RunFill.Size = UDim2.new(0, 0, 1, 0)
RunFill.BorderSizePixel = 0
local RFillCorner = Instance.new("UICorner", RunFill)
RFillCorner.CornerRadius = UDim.new(1, 0)

local RunSpeed = 16
local draggingRunSlider = false
local function updateRunSpeed(input)
    local width = RunBar.AbsoluteSize.X
    if width <= 0 then return end
    local relative = math.clamp((input.Position.X - RunBar.AbsolutePosition.X) / width, 0, 1)
    RunSpeed = math.floor(16 + relative * 284)
    RunSpeedLabel.Text = "Run Speed: " .. RunSpeed
    RunFill.Size = UDim2.new(relative, 0, 1, 0)
end
RunBar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingRunSlider = true; updateRunSpeed(input) end end)
UserInputService.InputChanged:Connect(function(input) if draggingRunSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then updateRunSpeed(input) end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingRunSlider = false end end)

-- Halaman 2: VISUAL
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
CreateToggle(VisualPage, "ESP Player (Wallhack)", 40, false, function(state)
    ESPEnabled = state
    if not state then
        for _, v in pairs(game.CoreGui:GetChildren()) do
            if v.Name == "VortexPlayerESP" then v:Destroy() end
        end
    end
end)

-- Halaman 3: TELEPORT
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
TPTitle.Text = "TELEPORT TO PLAYER"
TPTitle.TextColor3 = THEME.ACCENT
TPTitle.TextSize = 12
TPTitle.TextXAlignment = Enum.TextXAlignment.Left

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = TPPage
PlayerList.BackgroundColor3 = THEME.ITEM_BG
PlayerList.Position = UDim2.new(0, 10, 0, 40)
PlayerList.Size = UDim2.new(1, -20, 1, -90)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.ScrollBarImageColor3 = THEME.ACCENT
local PLCorner = Instance.new("UICorner", PlayerList)
PLCorner.CornerRadius = UDim.new(0, 6)
local PLLayout = Instance.new("UIListLayout", PlayerList)
PLLayout.SortOrder = Enum.SortOrder.Name
PLLayout.Padding = UDim.new(0, 2)

local TPExecBtn = Instance.new("TextButton")
TPExecBtn.Parent = TPPage
TPExecBtn.BackgroundColor3 = THEME.ACCENT
TPExecBtn.Position = UDim2.new(0, 10, 1, -40)
TPExecBtn.Size = UDim2.new(1, -20, 0, 30)
TPExecBtn.Font = Enum.Font.GothamBold
TPExecBtn.Text = "TELEPORT"
TPExecBtn.TextColor3 = THEME.TEXT
TPExecBtn.TextSize = 12
local TPE_Corner = Instance.new("UICorner", TPExecBtn)
TPE_Corner.CornerRadius = UDim.new(0, 6)

-- Nav Sidebar
local NavMove = CreateSidebarBtn("MOVEMENT", 10, MovePage)
local NavVis = CreateSidebarBtn("VISUAL", 50, VisualPage)
local NavTP = CreateSidebarBtn("TELEPORT", 90, TPPage)
NavMove.TextColor3 = THEME.ACCENT
NavMove:FindFirstChildOfClass("Frame").Visible = true

-- ================= LOGIC =================
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexPlayerESP"
local SelectedTarget = nil

local function RefreshPlayerList()
    for _, v in pairs(PlayerList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end
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
            local c = Instance.new("UICorner", btn)        
            c.CornerRadius = UDim.new(0, 4)
            
            btn.MouseButton1Click:Connect(function()
                SelectedTarget = p
                for _, otherBtn in pairs(PlayerList:GetChildren()) do
                    if otherBtn:IsA("TextButton") then otherBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end
                end
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
    else
        TPExecBtn.Text = "TARGET INVALID!"
        task.wait(1)
        TPExecBtn.Text = "TELEPORT"
    end
end)

-- Main Loop
RunService.RenderStepped:Connect(function(dt)
    -- Logika Run Speed (Hanya aktif jika tidak sedang terbang)
    if RunEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") and not FlyEnabled then
        Player.Character.Humanoid.WalkSpeed = RunSpeed
    elseif not RunEnabled and Player.Character and Player.Character:FindFirstChild("Humanoid") and not FlyEnabled then
        Player.Character.Humanoid.WalkSpeed = 16
    end

    -- Logika Fly
    if FlyEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Player.Character.HumanoidRootPart
        local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        Humanoid.PlatformStand = true
        local moveDir = Humanoid.MoveDirection
        local speedMultiplier = FlySpeed * dt * 2 
        local velocity = moveDir * speedMultiplier
        
        if holdingUp then velocity = velocity + Vector3.new(0, speedMultiplier, 0)
        elseif holdingDown then velocity = velocity - Vector3.new(0, speedMultiplier, 0) end
        
        HRP.CFrame = HRP.CFrame + velocity
        HRP.Velocity = Vector3.new(0, 0, 0) 
    end

    -- Logika ESP
    if ESPEnabled then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                local char = p.Character
                local hrp = char.HumanoidRootPart
                if char.Humanoid.Health > 0 then
                    if not ESPFolder:FindFirstChild(p.Name .. "_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = p.Name .. "_Highlight"
                        highlight.Adornee = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.Parent = ESPFolder
                    end
                    if not ESPFolder:FindFirstChild(p.Name .. "_Text") then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = p.Name .. "_Text"
                        billboard.Adornee = hrp
                        billboard.Size = UDim2.new(0, 100, 0, 50)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = ESPFolder
                        
                        local text = Instance.new("TextLabel")
                        text.Parent = billboard
                        text.BackgroundTransparency = 1
                        text.Size = UDim2.new(1, 0, 1, 0)
                        text.Font = Enum.Font.GothamBold
                        text.TextColor3 = Color3.fromRGB(255, 0, 0)
                        text.TextStrokeTransparency = 0.5
                        text.TextSize = 12
                        text.Name = "Text"
                    end
                    local distance = math.floor((Player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    local textLabel = ESPFolder:FindFirstChild(p.Name .. "_Text"):FindFirstChild("Text")
                    textLabel.Text = p.Name .. "\n[" .. distance .. " studs]"
                end
            end
        end
    end
end)

print("[VORTEEZX] FINAL FULL EDITION Loaded - No Icon, With Run Speed!")
