--[[
    VORTEEZX STEAL AN EGG (BASIC HUB)
--]]

local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Setup (Sederhana)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VortexEgg"
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

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "VORTEEZX EGG STEALER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 10)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = ScrollingFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi Teleport (Anti-Rubberband)
local function TweenTeleport(target)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = Player.Character.HumanoidRootPart
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
        local goal = {CFrame = target}
        local tween = TweenService:Create(HRP, tweenInfo, goal)
        tween:Play()
    end
end

-- Fungsi Nge-scan Egg
local function LoadEggs()
    -- Hapus tombol lama
    for _, v in pairs(ScrollingFrame:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    local count = 0
    -- Cari objek yang namanya mengandung "Egg" di dalam Workspace
    for _, obj in pairs(Workspace:GetDescendants()) do
        if (obj:IsA("Model") or obj:IsA("Part") or obj:IsA("MeshPart")) and string.find(obj.Name, "Egg") then
            
            -- Cek apakah ada bagian yang bisa di-teleport
            local targetPos = obj:IsA("Model") and obj:GetPivot() or obj.CFrame
            
            local btn = Instance.new("TextButton")
            btn.Parent = ScrollingFrame
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            btn.Size = UDim2.new(1, 0, 0, 35)
            btn.Font = Enum.Font.GothamMedium
            btn.Text = "TP to: " .. obj.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 12
            local btnCorner = Instance.new("UICorner", btn)
            btnCorner.CornerRadius = UDim.new(0, 5)

            btn.MouseButton1Click:Connect(function()
                TweenTeleport(targetPos)
                btn.Text = "Teleporting..."
                task.wait(0.5)
                btn.Text = "TP to: " .. obj.Name
            end)
            
            count = count + 1
        end
    end
    
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, count * 40)
    if count == 0 then
        local lbl = Instance.new("TextLabel")
        lbl.Parent = ScrollingFrame
        lbl.BackgroundTransparency = 1
        lbl.Size = UDim2.new(1, 0, 0, 40)
        lbl.Font = Enum.Font.GothamBold
        lbl.Text = "Egg belum spawn, asu!"
        lbl.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- Tombol Refresh
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Parent = MainFrame
RefreshBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
RefreshBtn.Position = UDim2.new(0, 10, 1, -45)
RefreshBtn.Size = UDim2.new(1, -20, 0, 35)
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Text = "REFRESH EGG LIST"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.TextSize = 14
local RefCorner = Instance.new("UICorner", RefreshBtn)
RefCorner.CornerRadius = UDim.new(0, 5)

RefreshBtn.MouseButton1Click:Connect(function()
    RefreshBtn.Text = "Scanning..."
    task.wait(0.5)
    LoadEggs()
    RefreshBtn.Text = "REFRESH EGG LIST"
end)

-- Jalanin pertama kali
LoadEggs()

print("[VORTEEZX] Steal An Egg Script Loaded!")
