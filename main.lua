--[[
    VORTEEZX FLY V4 (+ ESP PLAYER)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexFly_V4"
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

-- ================= FLOATING BUTTON =================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Parent = ScreenGui
FloatBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
FloatBtn.BackgroundTransparency = 0.3
FloatBtn.Position = UDim2.new(0, 20, 0.5, -25)
FloatBtn.Size = UDim2.new(0, 50, 0, 50)
FloatBtn.Font = Enum.Font.GothamBlack
FloatBtn.Text = "F"
FloatBtn.TextColor3 = Color3.fromRGB(0, 255, 204)
FloatBtn.TextSize = 24
FloatBtn.BorderSizePixel = 0
FloatBtn.Draggable = true

local FloatCorner = Instance.new("UICorner", FloatBtn)
FloatCorner.CornerRadius = UDim.new(1, 0)
local FloatStroke = Instance.new("UIStroke", FloatBtn)
FloatStroke.Color = Color3.fromRGB(0, 255, 204)
FloatStroke.Thickness = 2

-- ================= MAIN FRAME =================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150) -- Sedikit lebih tinggi buat muat tombol baru
MainFrame.Size = UDim2.new(0, 250, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Thickness = 1
UIStroke.Transparency = 0.5

-- Header
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Header.BackgroundTransparency = 0.3
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BorderSizePixel = 0
local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "VORTEEZX FLY & ESP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

-- Toggle Fly Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
ToggleBtn.BackgroundTransparency = 0.2
ToggleBtn.Position = UDim2.new(0.1, 0, 0, 60)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "FLY: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 14
local ToggleCorner = Instance.new("UICorner", ToggleBtn)
ToggleCorner.CornerRadius = UDim.new(0, 8)

-- Speed Slider UI
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Parent = MainFrame
SpeedFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedFrame.BackgroundTransparency = 0.5
SpeedFrame.Position = UDim2.new(0.1, 0, 0, 120)
SpeedFrame.Size = UDim2.new(0.8, 0, 0, 60)
SpeedFrame.BorderSizePixel = 0
local SpeedCorner = Instance.new("UICorner", SpeedFrame)
SpeedCorner.CornerRadius = UDim.new(0, 8)

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = SpeedFrame
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0, 10, 0, 5)
SpeedLabel.Size = UDim2.new(1, -20, 0, 20)
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.Text = "Kecepatan: 60"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
SpeedLabel.TextSize = 12
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local Bar = Instance.new("TextButton")
Bar.Parent = SpeedFrame
Bar.BackgroundColor3 = Color3.fromRGB(65, 55, 75)
Bar.Position = UDim2.new(0, 10, 0, 35)
Bar.Size = UDim2.new(1, -20, 0, 8)
Bar.AutoButtonColor = false
Bar.Text = ""
local BarCorner = Instance.new("UICorner", Bar)
BarCorner.CornerRadius = UDim.new(1, 0)

local Fill = Instance.new("Frame")
Fill.Parent = Bar
Fill.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
Fill.Size = UDim2.new(0.3, 0, 1, 0)
Fill.BorderSizePixel = 0
local FillCorner = Instance.new("UICorner", Fill)
FillCorner.CornerRadius = UDim.new(1, 0)

-- ESP Toggle Button (BARU)
local ESPBtn = Instance.new("TextButton")
ESPBtn.Parent = MainFrame
ESPBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
ESPBtn.BackgroundTransparency = 0.2
ESPBtn.Position = UDim2.new(0.1, 0, 0, 195)
ESPBtn.Size = UDim2.new(0.8, 0, 0, 40)
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.Text = "ESP PLAYER: OFF"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.TextSize = 14
local ESPCorner = Instance.new("UICorner", ESPBtn)
ESPCorner.CornerRadius = UDim.new(0, 8)

-- Tombol Naik / Turun
local UpBtn = Instance.new("TextButton")
UpBtn.Parent = ScreenGui
UpBtn.Size = UDim2.new(0, 50, 0, 50)
UpBtn.Position = UDim2.new(1, -80, 1, -200)
UpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
UpBtn.BackgroundTransparency = 0.3
UpBtn.Text = "⬆"
UpBtn.TextColor3 = Color3.fromRGB(0, 255, 204)
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
DownBtn.TextColor3 = Color3.fromRGB(0, 255, 204)
DownBtn.Font = Enum.Font.GothamBold
DownBtn.TextSize = 24
DownBtn.Visible = false
local DownCorner = Instance.new("UICorner", DownBtn)
DownCorner.CornerRadius = UDim.new(1, 0)

-- ================= LOGIC =================
local FlyEnabled = false
local ESPEnabled = false
local FlySpeed = 60
local isMenuOpen = false
local holdingUp = false
local holdingDown = false

-- ESP Folder
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexPlayerESP"

-- Toggle Menu
FloatBtn.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
end)

-- Slider Logic
local dragging = false
local function updateSpeed(input)
    local width = Bar.AbsoluteSize.X
    if width <= 0 then return end
    local relative = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / width, 0, 1)
    FlySpeed = math.floor(10 + relative * 190) 
    SpeedLabel.Text = "Kecepatan: " .. FlySpeed
    Fill.Size = UDim2.new(relative, 0, 1, 0)
end

Bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        updateSpeed(input)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSpeed(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Naik/Turun Listener
UpBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingUp = true end
end)
UpBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingUp = false end
end)
DownBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingDown = true end
end)
DownBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then holdingDown = false end
end)

-- Fly Logic
local function ToggleFly()
    FlyEnabled = not FlyEnabled
    if FlyEnabled then
        ToggleBtn.Text = "FLY: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        UpBtn.Visible = true
        DownBtn.Visible = true
    else
        ToggleBtn.Text = "FLY: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
        UpBtn.Visible = false
        DownBtn.Visible = false
        holdingUp = false
        holdingDown = false
        
        if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            Player.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
        end
    end
end

ToggleBtn.MouseButton1Click:Connect(ToggleFly)

-- ESP Player Logic
ESPBtn.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        ESPBtn.Text = "ESP PLAYER: ON"
        ESPBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
    else
        ESPBtn.Text = "ESP PLAYER: OFF"
        ESPBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
        for _, v in pairs(ESPFolder:GetChildren()) do
            v:Destroy()
        end
    end
end)

-- Loop ESP & Fly
RunService.RenderStepped:Connect(function(dt)
    -- 1. LOGIKA FLY
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

    -- 2. LOGIKA ESP PLAYER
    if ESPEnabled then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
                local char = p.Character
                local hrp = char.HumanoidRootPart
                local hum = char.Humanoid
                
                if hum.Health > 0 then
                    -- Bikin Highlight (Kotak warna di tubuh)
                    if not ESPFolder:FindFirstChild(p.Name .. "_Highlight") then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = p.Name .. "_Highlight"
                        highlight.Adornee = char
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = ESPFolder
                    end
                    
                    -- Bikin Billboard (Teks Jarak & Nama)
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
                    
                    -- Update Jarak (Distance)
                    local distance = math.floor((Player.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    local textLabel = ESPFolder:FindFirstChild(p.Name .. "_Text"):FindFirstChild("Text")
                    textLabel.Text = p.Name .. "\n[" .. distance .. " studs]"
                end
            end
        end
    end
end)

print("[VORTEEZX] Fly V4 + ESP Player Loaded!")
