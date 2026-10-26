--[[
    VORTEEZX BLOX FRUITS HUB V4 (ULTIMATE)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexBF_Ultimate"
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

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(255, 0, 50)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.2

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
Title.Text = "VORTEEZX HUB V4"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2

-- Container
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 10, 0, 60)
Content.Size = UDim2.new(1, -20, 1, -70)

-- Bikin Tombol & Switch Toggle
local function CreateToggle(text, yPos, defaultState)
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
    
    -- Toggle Switch
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
    
    return {Frame = Frame, Label = Label, Btn = Btn, Circle = Circle, State = defaultState}
end

local SpeedToggle = CreateToggle("Speed Hack (150)", 0, false)
local ESPToggle = CreateToggle("ESP Chest & Fruit", 50, false)
local FarmToggle = CreateToggle("Auto Farm (Melee)", 100, false)
local ChestToggle = CreateToggle("Auto Collect Chest", 150, false)

-- Tombol TP
local TPFrame = Instance.new("Frame")
TPFrame.Parent = Content
TPFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TPFrame.Position = UDim2.new(0, 0, 0, 200)
TPFrame.Size = UDim2.new(1, 0, 0, 60)
TPFrame.BorderSizePixel = 0
local TPUICorner = Instance.new("UICorner", TPFrame)
TPUICorner.CornerRadius = UDim.new(0, 6)

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
    btn.Position = UDim2.new(0, xPos, 0, 30)
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

-- Update Visual Toggle
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

-- ================= LOGIC =================

-- 1. SPEED
SpeedToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(SpeedToggle, not SpeedToggle.State)
    if not SpeedToggle.State and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 16
    end
end)

RunService.Heartbeat:Connect(function()
    if SpeedToggle.State and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 150
    end
end)

-- 2. ESP
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexESP"

ESPToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(ESPToggle, not ESPToggle.State)
    if not ESPToggle.State then ESPFolder:ClearAllChildren() end
end)

RunService.RenderStepped:Connect(function()
    if ESPToggle.State then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("MeshPart") and (v.Name == "Chest" or string.find(v.Name, "Fruit")) then
                if not ESPFolder:FindFirstChild(v.Name) then
                    local Billboard = Instance.new("BillboardGui")
                    Billboard.Parent = ESPFolder
                    Billboard.Adornee = v
                    Billboard.Size = UDim2.new(0, 120, 0, 50)
                    Billboard.AlwaysOnTop = true
                    local Text = Instance.new("TextLabel")
                    Text.Parent = Billboard
                    Text.BackgroundTransparency = 1
                    Text.Size = UDim2.new(1, 0, 1, 0)
                    Text.Font = Enum.Font.GothamBold
                    Text.Text = v.Name
                    Text.TextColor3 = (v.Name == "Chest" and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(0, 255, 150))
                    Text.TextStrokeTransparency = 0.5
                    Text.TextSize = 14
                end
            end
        end
    end
end)

-- 3. AUTO FARM
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

FarmToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(FarmToggle, not FarmToggle.State)
    if FarmToggle.State then
        task.spawn(function()
            while FarmToggle.State do
                task.wait()
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    local enemy = getClosestEnemy()
                    if enemy then
                        Player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
                        for _, tool in pairs(Player.Character:GetChildren()) do
                            if tool:IsA("Tool") then tool:Activate() end
                        end
                    end
                end
            end
        end)
    end
end)

-- 4. AUTO COLLECT CHEST
ChestToggle.Btn.MouseButton1Click:Connect(function()
    UpdateToggle(ChestToggle, not ChestToggle.State)
    if ChestToggle.State then
        task.spawn(function()
            while ChestToggle.State do
                task.wait(0.5)
                if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(Workspace:GetDescendants()) do
                        if v:IsA("MeshPart") and v.Name == "Chest" then
                            -- Teleport ke chest, tunggu bentar, balik lagi (opsional)
                            Player.Character.HumanoidRootPart.CFrame = v.CFrame
                            task.wait(0.2) -- Delay buat ngambil
                        end
                    end
                end
            end
        end)
    end
end)

-- 5. TELEPORT
TPIsland1.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(1050, 16, 1550) -- Koordinat Bandit (Contoh)
    end
end)

TPIsland2.MouseButton1Click:Connect(function()
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(-1150, 16, 3800) -- Koordinat Marine (Contoh)
    end
end)

print("[VORTEEZX HUB V4] Ultimate UI Loaded!")
