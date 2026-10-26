--========================================--
--       VORTEEZX HUB | MOBILE EDITION
--       BLOX FRUITS GUI FRAMEWORK (FIXED)
--========================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old GUI
local old = playerGui:FindFirstChild("VORTEEZX_HUB")
if old then
    old:Destroy()
end

-- Configuration
local PURPLE = Color3.fromRGB(160, 65, 255)
local DARK = Color3.fromRGB(15, 12, 23)
local CARD = Color3.fromRGB(28, 23, 39)
local WHITE = Color3.fromRGB(245, 240, 255)

local settings = {
    AutoFarm = false,
    AutoMelee = false,
    AutoChest = false,
    AutoFruit = false,
    Speed = 16
}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "VORTEEZX_HUB"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = playerGui

-- Rounded corners helper
local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 12)
    c.Parent = obj
    return c
end

-- Border helper
local function stroke(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or PURPLE
    s.Thickness = thickness or 1.5
    s.Transparency = 0.1
    s.Parent = obj
    return s
end

-- Tween helper
local function tween(obj, duration, props)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(duration, Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

-- Floating skull button
local float = Instance.new("TextButton")
float.Name = "FloatingButton"
float.Size = UDim2.fromOffset(58, 58)
float.Position = UDim2.new(0, 18, 0.48, 0)
float.BackgroundColor3 = DARK
float.Text = "💀"
float.TextSize = 30
float.Font = Enum.Font.GothamBold
float.TextColor3 = WHITE
float.AutoButtonColor = false
float.ZIndex = 10
float.Parent = gui
corner(float, 20)
stroke(float, PURPLE, 2)

-- Neon effect
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 15, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 35, 180))
})
gradient.Rotation = 45
gradient.Parent = float

-- Main window
local main = Instance.new("Frame")
main.Name = "MainWindow"
main.Size = UDim2.fromOffset(310, 390)
main.Position = UDim2.new(0.5, -155, 0.5, -195)
main.BackgroundColor3 = DARK
main.BorderSizePixel = 0
main.Visible = false
main.ClipsDescendants = true
main.Parent = gui
corner(main, 16)
stroke(main, PURPLE, 2)

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 76)
header.BackgroundColor3 = CARD
header.BorderSizePixel = 0
header.Parent = main
corner(header, 15)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -65, 0, 30)
title.Position = UDim2.fromOffset(14, 9)
title.BackgroundTransparency = 1
title.Text = "VORTEEZX HUB"
title.TextColor3 = WHITE
title.TextSize = 20
title.Font = Enum.Font.GothamBlack
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -28, 0, 20)
subtitle.Position = UDim2.fromOffset(14, 42)
subtitle.BackgroundTransparency = 1
subtitle.Text = "BLOX FRUITS  •  MOBILE EDITION"
subtitle.TextColor3 = PURPLE
subtitle.TextSize = 10
subtitle.Font = Enum.Font.GothamBold
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(34, 34)
close.Position = UDim2.new(1, -44, 0, 12)
close.BackgroundColor3 = Color3.fromRGB(70, 30, 90)
close.Text = "✕"
close.TextColor3 = WHITE
close.TextSize = 17
close.Font = Enum.Font.GothamBold
close.Parent = header
corner(close, 10)

-- Scrollable content
local content = Instance.new("ScrollingFrame")
content.Name = "Settings"
content.Size = UDim2.new(1, -20, 1, -94)
content.Position = UDim2.fromOffset(10, 84)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = PURPLE
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.CanvasSize = UDim2.new()
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 9)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 3)
padding.PaddingBottom = UDim.new(0, 10)
padding.Parent = content

-- Section label
local section = Instance.new("TextLabel")
section.Size = UDim2.new(1, 0, 0, 25)
section.BackgroundTransparency = 1
section.Text = "   GAME SETTINGS"
section.TextColor3 = PURPLE
section.TextSize = 11
section.Font = Enum.Font.GothamBold
section.TextXAlignment = Enum.TextXAlignment.Left
section.LayoutOrder = 0
section.Parent = content

-- Toggle builder
local function createToggle(name, description, key, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -2, 0, 58)
    row.BackgroundColor3 = CARD
    row.BorderSizePixel = 0
    row.LayoutOrder = order
    row.Parent = content
    corner(row, 11)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -90, 0, 25)
    label.Position = UDim2.fromOffset(11, 6)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = WHITE
    label.TextSize = 12
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -90, 0, 17)
    desc.Position = UDim2.fromOffset(11, 31)
    desc.BackgroundTransparency = 1
    desc.Text = description
    desc.TextColor3 = Color3.fromRGB(155, 145, 170)
    desc.TextSize = 9
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(48, 26)
    btn.Position = UDim2.new(1, -59, 0.5, -13)
    btn.BackgroundColor3 = Color3.fromRGB(65, 60, 72)
    btn.Text = "OFF"
    btn.TextColor3 = WHITE
    btn.TextSize = 10
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.Parent = row
    corner(btn, 8)

    btn.Activated:Connect(function()
        settings[key] = not settings[key]

        if settings[key] then
            tween(btn, 0.2, { BackgroundColor3 = PURPLE })
            btn.Text = "ON"
        else
            tween(btn, 0.2, { BackgroundColor3 = Color3.fromRGB(65, 60, 72) })
            btn.Text = "OFF"
        end
    end)
end

createToggle("⚔️ Auto Farm", "Farm automation toggle", "AutoFarm", 1)
createToggle("🥊 Auto Melee & Attack", "Combat setting toggle", "AutoMelee", 2)
createToggle("💰 Auto Farm Chest", "Chest tracking toggle", "AutoChest", 3)
createToggle("🍈 Auto Find Fruit", "Fruit tracking toggle", "AutoFruit", 4)

-- Speed control
local speedRow = Instance.new("Frame")
speedRow.Size = UDim2.new(1, -2, 0, 78)
speedRow.BackgroundColor3 = CARD
speedRow.BorderSizePixel = 0
speedRow.LayoutOrder = 5
speedRow.Parent = content
corner(speedRow, 11)

local speedTitle = Instance.new("TextLabel")
speedTitle.Size = UDim2.new(1, -20, 0, 25)
speedTitle.Position = UDim2.fromOffset(11, 5)
speedTitle.BackgroundTransparency = 1
speedTitle.Text = "⚡ Speed Setting"
speedTitle.TextColor3 = WHITE
speedTitle.TextSize = 12
speedTitle.Font = Enum.Font.GothamBold
speedTitle.TextXAlignment = Enum.TextXAlignment.Left
speedTitle.Parent = speedRow

local speedValue = Instance.new("TextLabel")
speedValue.Size = UDim2.fromOffset(60, 25)
speedValue.Position = UDim2.new(1, -70, 0, 5)
speedValue.BackgroundTransparency = 1
speedValue.Text = "16"
speedValue.TextColor3 = PURPLE
speedValue.TextSize = 13
speedValue.Font = Enum.Font.GothamBold
speedValue.Parent = speedRow

local bar = Instance.new("Frame")
bar.Size = UDim2.new(1, -24, 0, 7)
bar.Position = UDim2.fromOffset(12, 49)
bar.BackgroundColor3 = Color3.fromRGB(65, 55, 75)
bar.BorderSizePixel = 0
bar.Parent = speedRow
corner(bar, 5)

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = PURPLE
fill.BorderSizePixel = 0
fill.Parent = bar
corner(fill, 5)

local knob = Instance.new("TextButton")
knob.Size = UDim2.fromOffset(17, 17)
knob.AnchorPoint = Vector2.new(0.5, 0.5)
knob.Position = UDim2.new(0, 0, 0.5, 0)
knob.BackgroundColor3 = WHITE
knob.Text = ""
knob.Parent = bar
corner(knob, 20)
stroke(knob, PURPLE, 1)

local dragging = false

local function updateSpeed(x)
    local width = bar.AbsoluteSize.X
    if width <= 0 then return end

    local relative = math.clamp((x - bar.AbsolutePosition.X) / width, 0, 1)
    settings.Speed = math.floor(16 + relative * 134)
    speedValue.Text = tostring(settings.Speed)

    fill.Size = UDim2.new(relative, 0, 1, 0)
    knob.Position = UDim2.new(relative, 0, 0.5, 0)
end

bar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        updateSpeed(input.Position.X)
    end
end)

knob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSpeed(input.Position.X)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Open / close animations
local function openMenu()
    main.Visible = true
    main.Size = UDim2.fromOffset(280, 350)
    main.Position = UDim2.new(0.5, -140, 0.5, -175)
    tween(main, 0.25, {
        Size = UDim2.fromOffset(310, 390),
        Position = UDim2.new(0.5, -155, 0.5, -195)
    })
end

local function closeMenu()
    local anim = tween(main, 0.18, { Size = UDim2.fromOffset(280, 350) })
    anim.Completed:Once(function() main.Visible = false end)
end

float.Activated:Connect(function()
    if main.Visible then closeMenu() else openMenu() end
end)

close.Activated:Connect(closeMenu)

-- Drag floating button
local function makeDraggable(object)
    local draggingObject = false
    local startPosition
    local originalPosition
    local inputObject

    object.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingObject = true
            startPosition = input.Position
            originalPosition = object.Position
            inputObject = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if draggingObject and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startPosition
            object.Position = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset + delta.X, originalPosition.Y.Scale, originalPosition.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input == inputObject then draggingObject = false end
    end)
end

makeDraggable(float)

--========================================--
-- LOGIKA SCRIPT BLOX FRUITS (FIXED & WORKING)
--========================================--

-- 1. SPEED HACK (Anti-Reset Bypass)
RunService.Stepped:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        if settings.Speed > 16 then
            player.Character.Humanoid.WalkSpeed = settings.Speed
        else
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end)

-- 2. AUTO FARM & MELEE LOGIC
local function getClosestEnemy()
    local closest = nil
    local dist = math.huge
    if Workspace:FindFirstChild("Enemies") then
        for _, v in pairs(Workspace.Enemies:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
                local mag = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                if mag < dist then dist = mag; closest = v end
            end
        end
    end
    return closest
end

-- Fungsi Otomatis Pake Melee
local function equipMelee()
    if player.Backpack then
        for _, v in pairs(player.Backpack:GetChildren()) do
            if v:IsA("Tool") and (v.ToolTip:lower():find("melee") or v.Name:lower():find("sword") or v.Name:lower():find("blade") or v.Name:lower():find("trident")) then
                player.Character.Humanoid:EquipTool(v)
                return
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.1) do
        if settings.AutoFarm and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local enemy = getClosestEnemy()
            if enemy then
                -- Teleport ke musuh (Agak mundur dikit biar ga nabrak)
                player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                
                if settings.AutoMelee then
                    -- Pake Melee
                    equipMelee()
                    -- Auto Attack (Spam Activate)
                    local tool = player.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                        task.wait(0.2) -- Jeda biar server ga nge-ban karena terlalu cepet
                        tool:Activate()
                    end
                end
            end
        end
    end
end)

-- 3. AUTO CHEST
task.spawn(function()
    while task.wait(1) do
        if settings.AutoChest and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(Workspace:GetDescendants()) do
                if (v:IsA("MeshPart") or v:IsA("Part")) and v.Name == "Chest" then
                    player.Character.HumanoidRootPart.CFrame = v.CFrame
                    task.wait(0.5)
                end
            end
        end
    end
end)

-- 4. AUTO FIND FRUIT
task.spawn(function()
    while task.wait(1) do
        if settings.AutoFruit and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, v in pairs(Workspace:GetDescendants()) do
                if string.find(v.Name, "Fruit") and (v:IsA("Tool") or v:IsA("Model")) then
                    local targetPos = v:IsA("Tool") and v.Handle.CFrame or v:GetPivot()
                    player.Character.HumanoidRootPart.CFrame = targetPos
                    task.wait(0.5)
                end
            end
        end
    end
end)

print("💀 VORTEEZX HUB V9 - LOGIC INJECTED!")
