--[[
    VORTEEZX FLY V3 (CFRAME MOBILE BYPASS)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexFly_V3"
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
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -125)
MainFrame.Size = UDim2.new(0, 250, 0, 250)
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
Title.Text = "VORTEEZX FLY"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

-- Toggle Button
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
Fill.Size = UDim2.new(0.3, 0, 1, 0) -- Default 60
Fill.BorderSizePixel = 0
local FillCorner = Instance.new("UICorner", Fill)
FillCorner.CornerRadius = UDim.new(1, 0)

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
local FlySpeed = 60
local isMenuOpen = false
local holdingUp = false
local holdingDown = false

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
    FlySpeed = math.floor(10 + relative * 190) -- 10 sampe 200
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

-- Tombol Naik/Turun Listener (Mobile Touch Fix)
UpBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        holdingUp = true
    end
end)
UpBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        holdingUp = false
    end
end)

DownBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        holdingDown = true
    end
end)
DownBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        holdingDown = false
    end
end)

-- Fly Logic (CFrame Bypass)
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
        
        -- Balikin kondisi karakter
        if Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            Player.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
        end
    end
end

ToggleBtn.MouseButton1Click:Connect(ToggleFly)

-- Loop Movement
RunService.RenderStepped:Connect(function(dt)
    if FlyEnabled and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Player.Character.HumanoidRootPart
        local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
        
        -- Maksa karakter biar ga gravitasi
        Humanoid.PlatformStand = true
        
        -- Ambil arah dari joystick (mobile)
        local moveDir = Humanoid.MoveDirection
        
        -- Hitung pergerakan
        local speedMultiplier = FlySpeed * dt * 2 -- Dikali dt biar smooth
        local velocity = moveDir * speedMultiplier
        
        -- Naik / Turun
        if holdingUp then
            velocity = velocity + Vector3.new(0, speedMultiplier, 0)
        elseif holdingDown then
            velocity = velocity - Vector3.new(0, speedMultiplier, 0)
        end
        
        -- Aplikasiin ke CFrame langsung (bypass server velocity check)
        HRP.CFrame = HRP.CFrame + velocity
        HRP.Velocity = Vector3.new(0, 0, 0) -- Reset velocity biar ga melayang sendiri
    end
end)

print("[VORTEEZX] Fly V3 (CFrame Bypass) Loaded!")
