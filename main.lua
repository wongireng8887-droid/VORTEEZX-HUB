--[[
    VORTEEZX BLOX FRUITS HUB V7 (RESIZABLE UI + FIXED FEATURES)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexBF_V7"
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
if not ScreenGui.Parent then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end

-- ================= FLOATING BUTTON =================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Parent = ScreenGui
FloatBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
FloatBtn.Position = UDim2.new(0, 20, 0.5, -25)
FloatBtn.Size = UDim2.new(0, 50, 0, 50)
FloatBtn.Font = Enum.Font.GothamBold
FloatBtn.Text = "V"
FloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatBtn.TextSize = 24
FloatBtn.BorderSizePixel = 0
local FloatCorner = Instance.new("UICorner", FloatBtn)
FloatCorner.CornerRadius = UDim.new(1, 0)
FloatBtn.Draggable = true

-- ================= MAIN MENU =================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -250)
MainFrame.Size = UDim2.new(0, 320, 0, 500) -- Ukuran lebih gede
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true -- Biar rapi pas di-resize

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(255, 0, 50)
UIStroke.Thickness = 1.5

-- Header
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BorderSizePixel = 0
local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 10)
local HeaderMask = Instance.new("Frame")
HeaderMask.Parent = MainFrame
HeaderMask.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
HeaderMask.Position = UDim2.new(0, 0, 0, 30)
HeaderMask.Size = UDim2.new(1, 0, 0, 15)
HeaderMask.BorderSizePixel = 0
HeaderMask.ZIndex = 1

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "VORTEEZX HUB V7"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2

-- Tombol Resize
local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Parent = Header
ResizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
ResizeBtn.Position = UDim2.new(1, -35, 0.5, -12)
ResizeBtn.Size = UDim2.new(0, 24, 0, 24)
ResizeBtn.Font = Enum.Font.GothamBold
ResizeBtn.Text = "⤢"
ResizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeBtn.TextSize = 14
local RCorner = Instance.new("UICorner", ResizeBtn)
RCorner.CornerRadius = UDim.new(0, 4)

local isBig = false
ResizeBtn.MouseButton1Click:Connect(function()
    isBig = not isBig
    if isBig then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 600)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -200, 0.5, -300)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 320, 0, 500)}):Play()
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Position = UDim2.new(0.5, -160, 0.5, -250)}):Play()
    end
end)

local isMenuOpen = false
FloatBtn.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
end)

-- Container
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 10, 0, 60)
Content.Size = UDim2.new(1, -20, 1, -70)

-- ================= UI COMPONENTS =================
local function CreateToggle(text, yPos)
    local Frame = Instance.new("Frame")
    Frame.Parent = Content
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Position = UDim2.new(0, 0, 0, yPos)
    Frame.Size = UDim2.new(1, 0, 0, 40)
    Frame.BorderSizePixel = 0
    local Corner = Instance.new("UICorner", Frame)
    Corner.CornerRadius = UDim.new(0, 6)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Font = Enum.Font.GothamMedium
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Btn = Instance.new("TextButton")
    Btn.Parent = Frame
    Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    Btn.Position = UDim2.new(1, -50, 0.5, -12)
    Btn.Size = UDim2.new(0, 40, 0, 24)
    Btn.AutoButtonColor = false
    Btn.Text = ""
    local BtnCorner = Instance.new("UICorner", Btn)
    BtnCorner.CornerRadius = UDim.new(1, 0)
    
    local Circle = Instance.new("Frame")
    Circle.Parent = Btn
    Circle.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    Circle.Position = UDim2.new(0, 2, 0.5, -10)
    Circle.Size = UDim2.new(0, 20, 0, 20)
    local CircleCorner = Instance.new("UICorner", Circle)
    CircleCorner.CornerRadius = UDim.new(1, 0)
    
    return {Frame = Frame, Label = Label, Btn = Btn, Circle = Circle, State = false}
end

local SpeedToggle = CreateToggle("Speed Hack", 0)
local ESPChestToggle = CreateToggle("ESP Chest", 50)
local ESPFruitToggle = CreateToggle("ESP Fruit", 100)
local FarmToggle = CreateToggle("Auto Farm (Melee)", 150)
local ChestToggle = CreateToggle("Auto Collect Chest", 200)
local FruitToggle = CreateToggle("Auto Collect Fruit", 250)

-- Slider Speed (Dirapihin)
local SpeedSliderFrame = Instance.new("Frame")
SpeedSliderFrame.Parent = Content
SpeedSliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedSliderFrame.Position = UDim2.new(0, 0, 0, 295)
SpeedSliderFrame.Size = UDim2.new(1, 0, 0, 45)
SpeedSliderFrame.BorderSizePixel = 0
local SSFCorner = Instance.new("UICorner", SpeedSliderFrame)
SSFCorner.CornerRadius = UDim.new(0, 6)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedSliderFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Kecepatan: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 12

local SpeedBar = Instance.new("TextButton")
SpeedBar.Parent = SpeedSliderFrame
SpeedBar.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
SpeedBar.Position = UDim2.new(0, 10, 0, 25)
SpeedBar.Size = UDim2.new(1, -20, 0, 10)
SpeedBar.AutoButtonColor = false
SpeedBar.Text = ""
local SBCorner = Instance.new("UICorner", SpeedBar)
SBCorner.CornerRadius = UDim.new(1, 0)

local SpeedFill = Instance.new("Frame")
SpeedFill.Parent = SpeedBar
SpeedFill.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
SpeedFill.Size = UDim2.new(0.2, 0, 1, 0)
SpeedFill.BorderSizePixel = 0
local SFCorner = Instance.new("UICorner", SpeedFill)
SFCorner.CornerRadius = UDim.new(1, 0)

local currentSpeed = 16

local function UpdateSlider(input)
    local pos = math.clamp((input.Position.X - SpeedBar.AbsolutePosition.X) / SpeedBar.AbsoluteSize.X, 0, 1)
    currentSpeed = math.floor(16 + (pos * 284))
    SpeedFill.Size = UDim2.new(pos, 0, 1, 0)
    SpeedLabel.Text = "Kecepatan: " .. currentSpeed
end

SpeedBar.MouseButton1Down:Connect(function() UpdateSlider({Position = UserInputService:GetMouseLocation()}) end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if SpeedBar:IsHovered() or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            UpdateSlider(input)
        end
    end
end)

-- Teleport Buttons
local TPFrame = Instance.new("Frame")
TPFrame.Parent = Content
TPFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TPFrame.Position = UDim2.new(0, 0, 0, 350)
TPFrame.Size = UDim2.new(1, 0, 0, 65)
TPFrame.BorderSizePixel = 0
local TPCorner = Instance.new("UICorner", TPFrame)
TPCorner.CornerRadius = UDim.new(0, 6)

local TPLabel = Instance.new("TextLabel")
TPLabel.Parent = TPFrame
TPLabel.BackgroundTransparency = 1
TPLabel.Position = UDim2.new(0, 10, 0, 0)
TPLabel.Size = UDim2.new(1, -20, 0, 25)
TPLabel.Font = Enum.Font.GothamBold
TPLabel.Text = "Teleport ke Pulau"
TPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TPLabel.TextSize = 12
TPLabel.TextXAlignment = Enum.TextXAlignment.Left

local function CreateTPBtn(text, xPos)
    local btn = Instance.new("TextButton")
    btn.Parent = TPFrame
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
    btn.Position = UDim2.new(0, xPos, 0, 35)
    btn.Size = UDim2.new(0.45, 0, 0, 22)
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 10
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 4)
    return btn
end

local TPIsland1 = CreateTPBtn("Pulau 1 (Bandit)", 5)
local TPIsland2 = CreateTPBtn("Pulau 2 (Marine)", 135)

-- ================= VISUAL LOGIC =================
local function UpdateToggle(t, isOn)
    t.State = isOn
    if isOn then
        t.Btn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        TweenService:Create(t.Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -22, 0.5, -10), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        t.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        t.Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        TweenService:Create(t.Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10), BackgroundColor3 = Color3.fromRGB(150, 150, 150)}):Play()
        t.Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end

-- ================= FEATURE LOGIC =================

-- 1. SPEED HACK
SpeedToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(SpeedToggle, not SpeedToggle.State)
    if not SpeedToggle.State and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 16
    end
end)

RunService.Heartbeat:Connect(function()
    if SpeedToggle.State and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = currentSpeed
    end
end)

-- 2. ESP (FIXED LAG)
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexESP"

ESPChestToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(ESPChestToggle, not ESPChestToggle.State)
    if not ESPChestToggle.State then
        for _, v in pairs(ESPFolder:GetChildren()) do
            if string.find(v.Name, "Chest_") then v:Destroy() end
        end
    end
end)

ESPFruitToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(ESPFruitToggle, not ESPFruitToggle.State)
    if not ESPFruitToggle.State then
        for _, v in pairs(ESPFolder:GetChildren()) do
            if string.find(v.Name, "Fruit_") then v:Destroy() end
        end
    end
end)

-- Fungsi bikin ESP baru
local function createESP(v, type)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = type .. "_" .. v.Name
    Billboard.Parent = ESPFolder
    Billboard.Adornee = v
    Billboard.Size = UDim2.new(0, 120, 0, 50)
    Billboard.AlwaysOnTop = true
    
    local Text = Instance.new("TextLabel")
    Text.Parent = Billboard
    Text.BackgroundTransparency = 1
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.Font = Enum.Font.GothamBold
    Text.Text = (type == "Chest" and "CHEST" or v.Name:gsub("Fruit", ""))
    Text.TextColor3 = (type == "Chest" and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 150))
    Text.TextStrokeTransparency = 0.5
    Text.TextSize = 14
end

-- Loop ringan buat ngecek objek baru
Workspace.DescendantAdded:Connect(function(v)
    if ESPChestToggle.State and v.Name == "Chest" and (v:IsA("MeshPart") or v:IsA("Part")) then
        createESP(v, "Chest")
    end
    if ESPFruitToggle.State and string.find(v.Name, "Fruit") and (v:IsA("Tool") or v:IsA("MeshPart")) then
        createESP(v, "Fruit")
    end
end)

-- 3. AUTO FARM (Auto Equip + Auto Hit)
local function getClosestEnemy()
    local closest = nil
    local dist = math.huge
    if Workspace:FindFirstChild("Enemies") then
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                local mag = (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if mag < dist then dist = mag; closest = v end
            end
        end
    end
    return closest
end

local function equipMelee()
    if Player.Backpack then
        for _, v in pairs(Player.Backpack:GetChildren()) do
            if v:IsA("Tool") and (v.ToolTip:lower():find("melee") or v.Name:lower():find("sword") or v.Name:lower():find("blade")) then
                Player.Character.Humanoid:EquipTool(v)
                return
            end
        end
    end
end

FarmToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(FarmToggle, not FarmToggle.State)
    if FarmToggle.State then
        task.spawn(function()
            while FarmToggle.State do
                task.wait(0.2) -- Jeda biar kaga rubberband
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local enemy = getClosestEnemy()
                    if enemy then
                        equipMelee()
                        Player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
                        task.wait(0.1) -- Jeda bentar buat animasi
                        local tool = Player.Character:FindFirstChildOfClass("Tool")
                        if tool then 
                            tool:Activate() 
                        end
                    end
                end
            end
        end)
    end
end)

-- 4. AUTO COLLECT CHEST (FIXED)
ChestToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(ChestToggle, not ChestToggle.State)
    if ChestToggle.State then
        task.spawn(function()
            while ChestToggle.State do
                task.wait(1)
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v.Name == "Chest" and (v:IsA("MeshPart") or v:IsA("Part")) then
                            Player.Character.HumanoidRootPart.CFrame = v.CFrame
                            task.wait(0.5)
                        end
                    end
                end
            end
        end)
    end
end)

-- 5. AUTO COLLECT FRUIT (FITUR BARU)
FruitToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(FruitToggle, not FruitToggle.State)
    if FruitToggle.State then
        task.spawn(function()
            while FruitToggle.State do
                task.wait(1)
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if string.find(v.Name, "Fruit") and (v:IsA("Tool") or v:IsA("Model")) then
                            -- Cari bagian utamanya buat teleport
                            local targetPos = v:IsA("Tool") and v.Handle.CFrame or v:GetPivot()
                            Player.Character.HumanoidRootPart.CFrame = targetPos
                            task.wait(0.5)
                        end
                    end
                end
            end
        end)
    end
end)

-- 6. TELEPORT
TPIsland1.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(1050, 16, 1550)
    end
end)

TPIsland2.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(-1150, 16, 3800)
    end
end)

print("[VORTEEZX HUB V7] Executed with Fixes & Resize!")
