--[[
    VORTEEZX HUB - SENA STYLE (LIQUID GLASS)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VORTEEZX_HUB"
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

-- ================= FLOATING BUTTON (LIQUID GLASS V) =================
local FloatBtn = Instance.new("TextButton")
FloatBtn.Parent = ScreenGui
FloatBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
FloatBtn.BackgroundTransparency = 0.3 -- Efek Kaca
FloatBtn.Position = UDim2.new(0, 20, 0.5, -25)
FloatBtn.Size = UDim2.new(0, 50, 0, 50)
FloatBtn.Font = Enum.Font.GothamBlack
FloatBtn.Text = "V"
FloatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FloatBtn.TextSize = 28
FloatBtn.BorderSizePixel = 0
FloatBtn.Draggable = true

local FloatCorner = Instance.new("UICorner", FloatBtn)
FloatCorner.CornerRadius = UDim.new(1, 0)

local FloatStroke = Instance.new("UIStroke", FloatBtn)
FloatStroke.Color = Color3.fromRGB(200, 0, 50)
FloatStroke.Thickness = 2
FloatStroke.Transparency = 0.2

-- ================= MAIN FRAME (SENA STYLE) =================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.2 -- Liquid Glass Background
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Color = Color3.fromRGB(100, 100, 100)
UIStroke.Thickness = 1
UIStroke.Transparency = 0.5

local isMenuOpen = false
FloatBtn.MouseButton1Click:Connect(function()
    isMenuOpen = not isMenuOpen
    MainFrame.Visible = isMenuOpen
end)

-- ================= SIDEBAR (KIRI) =================
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Sidebar.BackgroundTransparency = 0.3
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BorderSizePixel = 0
local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local Title = Instance.new("TextLabel")
Title.Parent = Sidebar
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBlack
Title.Text = "VORTEEZX"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Position = UDim2.new(0, 15, 0, 10)

local SubTitle = Instance.new("TextLabel")
SubTitle.Parent = Sidebar
SubTitle.BackgroundTransparency = 1
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.Text = "HUB"
SubTitle.TextColor3 = Color3.fromRGB(200, 0, 50)
SubTitle.TextSize = 11
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Position = UDim2.new(0, 15, 0, 28)

-- Container Tombol Sidebar
local NavContainer = Instance.new("Frame")
NavContainer.Parent = Sidebar
NavContainer.BackgroundTransparency = 1
NavContainer.Position = UDim2.new(0, 10, 0, 60)
NavContainer.Size = UDim2.new(1, -20, 0, 200)

local function CreateNavBtn(text, yPos, iconText)
    local btn = Instance.new("TextButton")
    btn.Parent = NavContainer
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    btn.BackgroundTransparency = 0.5
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "  " .. iconText .. "  " .. text
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)
    return btn
end

local HomeBtn = CreateNavBtn("Home", 0, "🏠")
local FarmBtn = CreateNavBtn("Farm", 45, "🌾")

-- ================= CONTENT AREA (KANAN) =================
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 160, 0, 0)
ContentArea.Size = UDim2.new(1, -170, 1, 0)

-- Halaman Home
local HomePage = Instance.new("Frame")
HomePage.Parent = ContentArea
HomePage.BackgroundTransparency = 1
HomePage.Size = UDim2.new(1, 0, 1, 0)
HomePage.Visible = true

local HomeTitle = Instance.new("TextLabel")
HomeTitle.Parent = HomePage
HomeTitle.BackgroundTransparency = 1
HomeTitle.Size = UDim2.new(1, 0, 0, 40)
HomeTitle.Font = Enum.Font.GothamBold
HomeTitle.Text = "Dashboard"
HomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTitle.TextSize = 18
HomeTitle.TextXAlignment = Enum.TextXAlignment.Left

local HomeDesc = Instance.new("TextLabel")
HomeDesc.Parent = HomePage
HomeDesc.BackgroundTransparency = 1
HomeDesc.Position = UDim2.new(0, 0, 0, 40)
HomeDesc.Size = UDim2.new(1, 0, 0, 100)
HomeDesc.Font = Enum.Font.Gotham
HomeDesc.Text = "Selamat datang di VORTEEZX HUB.\nPilih menu 'Farm' di sebelah kiri untuk mulai mencuri Egg otomatis.\n\nPastikan fitur Auto Steal tidak digunakan secara berlebihan agar akun Anda aman."
HomeDesc.TextColor3 = Color3.fromRGB(150, 150, 150)
HomeDesc.TextSize = 12
HomeDesc.TextXAlignment = Enum.TextXAlignment.Left
HomeDesc.TextYAlignment = Enum.TextYAlignment.Top
HomeDesc.TextWrapped = true

-- Halaman Farm
local FarmPage = Instance.new("Frame")
FarmPage.Parent = ContentArea
FarmPage.BackgroundTransparency = 1
FarmPage.Size = UDim2.new(1, 0, 1, 0)
FarmPage.Visible = false

local FarmTitle = Instance.new("TextLabel")
FarmTitle.Parent = FarmPage
FarmTitle.BackgroundTransparency = 1
FarmTitle.Size = UDim2.new(1, 0, 0, 40)
FarmTitle.Font = Enum.Font.GothamBold
FarmTitle.Text = "Auto Steal Egg"
FarmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmTitle.TextSize = 18
FarmTitle.TextXAlignment = Enum.TextXAlignment.Left

local ToggleAuto = Instance.new("TextButton")
ToggleAuto.Parent = FarmPage
ToggleAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
ToggleAuto.BackgroundTransparency = 0.2
ToggleAuto.Position = UDim2.new(0, 0, 0, 50)
ToggleAuto.Size = UDim2.new(0, 150, 0, 35)
ToggleAuto.Font = Enum.Font.GothamBold
ToggleAuto.Text = "AUTO STEAL: OFF"
ToggleAuto.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAuto.TextSize = 12
local TACorner = Instance.new("UICorner", ToggleAuto)
TACorner.CornerRadius = UDim.new(0, 6)

local StatusText = Instance.new("TextLabel")
StatusText.Parent = FarmPage
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0, 160, 0, 50)
StatusText.Size = UDim2.new(0, 150, 0, 35)
StatusText.Font = Enum.Font.GothamMedium
StatusText.Text = "Status: Idle"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = 12
StatusText.TextXAlignment = Enum.TextXAlignment.Left

-- ================= NAVIGATION LOGIC =================
HomeBtn.MouseButton1Click:Connect(function()
    HomePage.Visible = true
    FarmPage.Visible = false
    HomeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    FarmBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
end)

FarmBtn.MouseButton1Click:Connect(function()
    HomePage.Visible = false
    FarmPage.Visible = true
    HomeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
end)

-- ================= FARM LOGIC =================
local isAutoSteal = false

local function TweenTeleport(targetCFrame)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Player.Character.HumanoidRootPart
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
        local goal = {CFrame = targetCFrame}
        local tween = TweenService:Create(HRP, tweenInfo, goal)
        tween:Play()
    end
end

local function getClosestEgg()
    local closest = nil
    local dist = math.huge
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        for _, v in pairs(Workspace:GetDescendants()) do
            if (v:IsA("Model") or v:IsA("Part") or v:IsA("MeshPart")) and string.find(v.Name, "Egg") then
                local pos = v:IsA("Model") and v:GetPivot().Position or v.Position
                local mag = (Player.Character.HumanoidRootPart.Position - pos).Magnitude
                if mag < dist then dist = mag; closest = v end
            end
        end
    end
    return closest
end

ToggleAuto.MouseButton1Click:Connect(function()
    isAutoSteal = not isAutoSteal
    if isAutoSteal then
        ToggleAuto.Text = "AUTO STEAL: ON"
        ToggleAuto.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        StatusText.Text = "Status: Searching..."
        StatusText.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        task.spawn(function()
            while isAutoSteal do
                task.wait(1)
                local egg = getClosestEgg()
                if egg then
                    StatusText.Text = "Status: Stealing..."
                    local pos = egg:IsA("Model") and egg:GetPivot() or egg.CFrame
                    TweenTeleport(pos)
                else
                    StatusText.Text = "Status: No Egg Found"
                end
            end
        end)
    else
        ToggleAuto.Text = "AUTO STEAL: OFF"
        ToggleAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
        StatusText.Text = "Status: Idle"
        StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

print("[VORTEEZX] VORTEEZX HUB (Sena Style) Loaded!")
