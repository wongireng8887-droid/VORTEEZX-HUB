--[[
    VORTEEZX BLOX FRUITS HUB
    Script by: wongireng8887-droid
    Credits: VORTEEZX
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- UI Sederhana (Pake Draggable Frame)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local AutoFarmBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")

pcall(function() ScreenGui.Parent = game.CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = Player:WaitForChild("PlayerGui") end

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0, 50, 0, 50)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "VORTEEZX BF HUB"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 18

-- 1. SPEED HACK
SpeedBtn.Parent = MainFrame
SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedBtn.Position = UDim2.new(0.1, 0, 0.2, 0)
SpeedBtn.Size = UDim2.new(0.8, 0, 0, 40)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.Text = "Toggle Speed (100)"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.TextSize = 14

local isSpeedEnabled = false
SpeedBtn.MouseButton1Click:Connect(function()
    isSpeedEnabled = not isSpeedEnabled
    if isSpeedEnabled then
        SpeedBtn.Text = "Speed: ON"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 100
    else
        SpeedBtn.Text = "Speed: OFF"
        SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
    end
end)

-- 2. ESP CHEST & FRUIT
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexESP"

ESPBtn.Parent = MainFrame
ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ESPBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
ESPBtn.Size = UDim2.new(0.8, 0, 0, 40)
ESPBtn.Font = Enum.Font.SourceSansBold
ESPBtn.Text = "ESP Chest & Fruit"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.TextSize = 14

local isESPEnabled = false
local function createESP(obj, color)
    local Billboard = Instance.new("BillboardGui")
    Billboard.Parent = ESPFolder
    Billboard.Adornee = obj
    Billboard.Size = UDim2.new(0, 100, 0, 50)
    Billboard.AlwaysOnTop = true
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Billboard
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.Text = obj.Name
    TextLabel.TextColor3 = color
    TextLabel.TextSize = 14
end

ESPBtn.MouseButton1Click:Connect(function()
    isESPEnabled = not isESPEnabled
    if isESPEnabled then
        ESPBtn.Text = "ESP: ON"
        ESPBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        ESPBtn.Text = "ESP: OFF"
        ESPBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        ESPFolder:ClearAllChildren()
    end
end)

RunService.RenderStepped:Connect(function()
    if isESPEnabled then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Chest" and v:IsA("MeshPart") and not ESPFolder:FindFirstChild(v.Name) then
                createESP(v, Color3.fromRGB(255, 255, 0)) -- Kuning buat Chest
            elseif string.find(v.Name, "Fruit") and v:IsA("Tool") and not ESPFolder:FindFirstChild(v.Name) then
                createESP(v, Color3.fromRGB(0, 255, 0)) -- Hijau buat Fruit
            end
        end
    end
end)

-- 3. AUTO FARM (Sederhana - Nembak NPC Terdekat)
local AutoFarm = false
local function getClosestEnemy()
    local closest = nil
    local dist = math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            local mag = (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
            if mag < dist then
                dist = mag
                closest = v
            end
        end
    end
    return closest
end

AutoFarmBtn.Parent = MainFrame
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoFarmBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
AutoFarmBtn.Size = UDim2.new(0.8, 0, 0, 40)
AutoFarmBtn.Font = Enum.Font.SourceSansBold
AutoFarmBtn.Text = "Auto Farm (Melee)"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.TextSize = 14

AutoFarmBtn.MouseButton1Click:Connect(function()
    AutoFarm = not AutoFarm
    if AutoFarm then
        AutoFarmBtn.Text = "Farm: ON"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        -- Loop Auto Farm
        task.spawn(function()
            while AutoFarm do
                task.wait(0.1)
                local enemy = getClosestEnemy()
                if enemy and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                    -- Teleport ke musuh (Hati-hati kena anti-cheat)
                    Player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    -- Tembak / Pukul
                    local tool = Player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end)
    else
        AutoFarmBtn.Text = "Farm: OFF"
        AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

print("[VORTEEZX HUB] Loaded! Selamat farming, asu!")
