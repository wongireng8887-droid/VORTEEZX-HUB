--[[
    VORTEEZX HUB V8 - ULTIMATE STEAL AN EGG
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VORTEEZX_HUB_V8"
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

-- ================= MAIN FRAME =================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BackgroundTransparency = 0.2
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

-- ================= SIDEBAR =================
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

-- ================= CONTENT AREA =================
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
HomeDesc.Text = "Selamat datang di VORTEEZX HUB V8.\nSilakan atur lokasi dan mutasi di menu Farm.\n\nJika dikosongkan, script akan mengambil Egg secara acak."
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
FarmTitle.Size = UDim2.new(1, 0, 0, 30)
FarmTitle.Font = Enum.Font.GothamBold
FarmTitle.Text = "Auto Steal Settings"
FarmTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmTitle.TextSize = 16
FarmTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Input Lokasi & Mutasi
local LocationBox = Instance.new("TextBox")
LocationBox.Parent = FarmPage
LocationBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
LocationBox.BackgroundTransparency = 0.5
LocationBox.Position = UDim2.new(0, 0, 0, 35)
LocationBox.Size = UDim2.new(0.48, 0, 0, 30)
LocationBox.Font = Enum.Font.Gotham
LocationBox.PlaceholderText = "Lokasi (Kosong = Random)"
LocationBox.Text = ""
LocationBox.TextColor3 = Color3.fromRGB(255, 255, 255)
LocationBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
LocationBox.TextSize = 11
local LocCorner = Instance.new("UICorner", LocationBox)
LocCorner.CornerRadius = UDim.new(0, 6)

local MutationBox = Instance.new("TextBox")
MutationBox.Parent = FarmPage
MutationBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MutationBox.BackgroundTransparency = 0.5
MutationBox.Position = UDim2.new(0.52, 0, 0, 35)
MutationBox.Size = UDim2.new(0.48, 0, 0, 30)
MutationBox.Font = Enum.Font.Gotham
MutationBox.PlaceholderText = "Mutasi (Kosong = Random)"
MutationBox.Text = ""
MutationBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MutationBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
MutationBox.TextSize = 11
local MutCorner = Instance.new("UICorner", MutationBox)
MutCorner.CornerRadius = UDim.new(0, 6)

-- Tombol Toggle
local ToggleAuto = Instance.new("TextButton")
ToggleAuto.Parent = FarmPage
ToggleAuto.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
ToggleAuto.BackgroundTransparency = 0.2
ToggleAuto.Position = UDim2.new(0, 0, 0, 80)
ToggleAuto.Size = UDim2.new(0.48, 0, 0, 35)
ToggleAuto.Font = Enum.Font.GothamBold
ToggleAuto.Text = "AUTO STEAL: OFF"
ToggleAuto.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAuto.TextSize = 12
local TACorner = Instance.new("UICorner", ToggleAuto)
TACorner.CornerRadius = UDim.new(0, 6)

-- Tombol ESP
local ToggleESP = Instance.new("TextButton")
ToggleESP.Parent = FarmPage
ToggleESP.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
ToggleESP.BackgroundTransparency = 0.2
ToggleESP.Position = UDim2.new(0.52, 0, 0, 80)
ToggleESP.Size = UDim2.new(0.48, 0, 0, 35)
ToggleESP.Font = Enum.Font.GothamBold
ToggleESP.Text = "ESP EGG: OFF"
ToggleESP.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleESP.TextSize = 12
local TECorner = Instance.new("UICorner", ToggleESP)
TECorner.CornerRadius = UDim.new(0, 6)

-- Status Text
local StatusText = Instance.new("TextLabel")
StatusText.Parent = FarmPage
StatusText.BackgroundTransparency = 1
StatusText.Position = UDim2.new(0, 0, 0, 120)
StatusText.Size = UDim2.new(1, 0, 0, 30)
StatusText.Font = Enum.Font.GothamMedium
StatusText.Text = "Status: Idle"
StatusText.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusText.TextSize = 12
StatusText.TextXAlignment = Enum.TextXAlignment.Left

-- ================= NAVIGATION LOGIC =================
HomeBtn.MouseButton1Click:Connect(function()
    HomePage.Visible = true; FarmPage.Visible = false
    HomeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    FarmBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
end)

FarmBtn.MouseButton1Click:Connect(function()
    HomePage.Visible = false; FarmPage.Visible = true
    HomeBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
end)

-- ================= LOGIC =================
local isAutoSteal = false
local isESP = false
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "VortexEggESP"

-- Filter Egg (Biar ga salah teleport ke NPC)
local function isRealEgg(v)
    return (v:IsA("Model") or v:IsA("MeshPart")) and string.find(v.Name, "Egg") and not string.find(v.Name, "NPC")
end

-- Teleport Tween
local function TweenTeleport(targetCFrame)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Player.Character.HumanoidRootPart
        local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Sine) -- Lebih smooth
        local tween = TweenService:Create(HRP, tweenInfo, {CFrame = targetCFrame})
        tween:Play()
    end
end

-- Cari Egg Sesuai Filter
local function getTargetEgg()
    local target = nil
    local targetLoc = LocationBox.Text:lower()
    local targetMut = MutationBox.Text:lower()
    
    -- Kumpulin semua egg dulu
    local eggs = {}
    for _, v in pairs(Workspace:GetDescendants()) do
        if isRealEgg(v) then
            table.insert(eggs, v)
        end
    end

    if #eggs == 0 then return nil end

    -- Kalo kosong, ambil random
    if targetLoc == "" and targetMut == "" then
        return eggs[math.random(1, #eggs)]
    end

    -- Kalo diisi, filter
    for _, egg in pairs(eggs) do
        local eggName = egg.Name:lower()
        -- Cek apakah nama egg mengandung lokasi atau mutasi yang dicari
        if (targetLoc ~= "" and string.find(eggName, targetLoc)) or (targetMut ~= "" and string.find(eggName, targetMut)) then
            return egg
        end
    end

    return nil -- Kalo ga nemu yang cocok
end

-- ESP Logic
ToggleESP.MouseButton1Click:Connect(function()
    isESP = not isESP
    if isESP then
        ToggleESP.Text = "ESP EGG: ON"
        ToggleESP.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
    else
        ToggleESP.Text = "ESP EGG: OFF"
        ToggleESP.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
        ESPFolder:ClearAllChildren()
    end
end)

RunService.RenderStepped:Connect(function()
    if isESP then
        for _, v in pairs(Workspace:GetDescendants()) do
            if isRealEgg(v) then
                if not ESPFolder:FindFirstChild(v.Name) then
                    local Billboard = Instance.new("BillboardGui")
                    Billboard.Parent = ESPFolder
                    Billboard.Name = v.Name
                    Billboard.Adornee = v
                    Billboard.Size = UDim2.new(0, 120, 0, 50)
                    Billboard.AlwaysOnTop = true
                    local Text = Instance.new("TextLabel")
                    Text.Parent = Billboard
                    Text.BackgroundTransparency = 1
                    Text.Size = UDim2.new(1, 0, 1, 0)
                    Text.Font = Enum.Font.GothamBold
                    Text.Text = v.Name
                    Text.TextColor3 = Color3.fromRGB(255, 255, 0) -- Warna Kuning
                    Text.TextStrokeTransparency = 0.5
                    Text.TextSize = 12
                end
            end
        end
    end
end)

-- Auto Steal Logic
ToggleAuto.MouseButton1Click:Connect(function()
    isAutoSteal = not isAutoSteal
    if isAutoSteal then
        ToggleAuto.Text = "AUTO STEAL: ON"
        ToggleAuto.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
        StatusText.Text = "Status: Searching..."
        StatusText.TextColor3 = Color3.fromRGB(0, 255, 100)
        
        task.spawn(function()
            while isAutoSteal do
                task.wait(1.5)
                local egg = getTargetEgg()
                if egg then
                    StatusText.Text = "Status: Stealing " .. egg.Name .. "..."
                    local pos = egg:IsA("Model") and egg:GetPivot() or egg.CFrame
                    TweenTeleport(pos)
                else
                    StatusText.Text = "Status: Egg tidak ditemukan (Cek Mutasi/Lokasi)"
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

print("[VORTEEZX] VORTEEZX HUB V8 Loaded!")
