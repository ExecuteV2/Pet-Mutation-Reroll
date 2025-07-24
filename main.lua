-- Pet Mutation Reroll | Set Pet Age to 60 | by @youngsingkit

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mutations = {
    "Shiny", "Inverted", "Frozen", "Windy", "Golden", "Mega",
    "Tiny", "Tranquil", "IronSkin", "Radiant", "Rainbow",
    "Shocked", "Ascended"
}
local currentMutation = mutations[math.random(#mutations)]
local espVisible = true
local uiVisible = true

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "PetMutationFinderVaporwave"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = CoreGui end)

-- Glow Frame Background
local glow = Instance.new("Frame")
glow.Size = UDim2.new(0, 380, 0, 300)
glow.Position = UDim2.new(0.5, -190, 0.5, -150)
glow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
glow.BackgroundTransparency = 1
glow.ZIndex = 0
glow.Parent = gui

-- Main Glass Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 360, 0, 260)
frame.Position = UDim2.new(0.5, -180, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(35, 15, 70)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.ZIndex = 1

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

local glowStroke = Instance.new("UIStroke", frame)
glowStroke.Color = Color3.fromRGB(255, 105, 180)
glowStroke.Thickness = 2.5
glowStroke.Transparency = 0.1

-- Fonts
local font = Enum.Font.Arcade

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🌸 Pet Mutation Reroll"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 120, 255)
title.Font = font
title.TextSize = 22
title.TextStrokeTransparency = 0.3
title.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Credit
local credit = Instance.new("TextLabel", frame)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.Position = UDim2.new(0, 0, 0, 30)
credit.Text = "MADE BY @YOUNGSINGKIT"
credit.TextColor3 = Color3.fromRGB(255, 255, 180)
credit.BackgroundTransparency = 1
credit.Font = font
credit.TextSize = 13
credit.TextStrokeTransparency = 0.3
credit.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Equipped Pet Label
local petLabel = Instance.new("TextLabel", frame)
petLabel.Size = UDim2.new(1, 0, 0, 20)
petLabel.Position = UDim2.new(0, 0, 0, 55)
petLabel.Text = "Equipped Pet: [None]"
petLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
petLabel.BackgroundTransparency = 1
petLabel.Font = font
petLabel.TextSize = 14
petLabel.TextStrokeTransparency = 0.3
petLabel.TextStrokeColor3 = Color3.new(0, 0, 0)

-- Toggle Button
local toggleMainUI = Instance.new("TextButton")
toggleMainUI.Size = UDim2.new(0, 120, 0, 35)
toggleMainUI.Position = UDim2.new(0, 10, 0.5, -120)
toggleMainUI.BackgroundColor3 = Color3.fromRGB(90, 50, 200)
toggleMainUI.BackgroundTransparency = 0.1
toggleMainUI.TextColor3 = Color3.new(1, 1, 1)
toggleMainUI.Font = font
toggleMainUI.TextSize = 14
toggleMainUI.Text = "📂 Toggle Menu"
toggleMainUI.ZIndex = 2
toggleMainUI.TextStrokeTransparency = 0.3
toggleMainUI.TextStrokeColor3 = Color3.new(0, 0, 0)
toggleMainUI.Parent = gui
Instance.new("UICorner", toggleMainUI).CornerRadius = UDim.new(0, 10)

-- Create Button Function
local function createButton(text, posY, color)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9, 0, 0, 28)
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.1
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = font
    btn.TextSize = 14
    btn.TextStrokeTransparency = 0.3
    btn.TextStrokeColor3 = Color3.new(0, 0, 0)
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    return btn
end

-- Buttons
local rerollBtn = createButton("🔁 Reroll Mutation", 80, Color3.fromRGB(255, 128, 255))
local toggleBtn = createButton("👁 Toggle ESP", 115, Color3.fromRGB(128, 255, 220))
local teleportBtn = createButton("📍 Teleport to Machine", 150, Color3.fromRGB(255, 255, 160))
local ageBtn = createButton("⏳ Set Pet Age to 60", 185, Color3.fromRGB(160, 255, 255))

-- Locate Mutation Machine
local machine, basePart
for _, obj in pairs(Workspace:GetDescendants()) do
    if obj:IsA("Model") and obj.Name:lower():find("mutation") then
        machine = obj
        basePart = obj:FindFirstChildWhichIsA("BasePart")
        break
    end
end
if not machine or not basePart then
    warn("Mutation machine not found.")
    return
end

-- ESP Billboard
local espGui = Instance.new("BillboardGui", basePart)
espGui.Name = "MutationESP"
espGui.Adornee = basePart
espGui.Size = UDim2.new(0, 200, 0, 40)
espGui.StudsOffset = Vector3.new(0, 3, 0)
espGui.AlwaysOnTop = true

local espLabel = Instance.new("TextLabel", espGui)
espLabel.Size = UDim2.new(1, 0, 1, 0)
espLabel.BackgroundTransparency = 1
espLabel.TextColor3 = Color3.fromHSV(0, 1, 1)
espLabel.Font = font
espLabel.TextSize = 20
espLabel.TextStrokeTransparency = 0.3
espLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
espLabel.Text = currentMutation

-- Animate ESP Rainbow
local hue = 0
RunService.RenderStepped:Connect(function()
    if espVisible then
        hue = (hue + 0.01) % 1
        espLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end
end)

-- Get Equipped Pet
local function getEquippedPetTool()
    character = player.Character or player.CharacterAdded:Wait()
    for _, child in ipairs(character:GetChildren()) do
        if child:IsA("Tool") and child.Name:find("Age") then
            return child
        end
    end
    return nil
end

RunService.RenderStepped:Connect(function()
    local tool = getEquippedPetTool()
    petLabel.Text = tool and ("Equipped Pet: " .. tool.Name) or "Equipped Pet: [None]"
end)

-- Reroll Mutation
rerollBtn.MouseButton1Click:Connect(function()
    rerollBtn.Text = "Rerolling..."
    for _ = 1, 20 do
        espLabel.Text = mutations[math.random(#mutations)]
        task.wait(0.05)
    end
    currentMutation = mutations[math.random(#mutations)]
    espLabel.Text = currentMutation
    rerollBtn.Text = "🔁 Reroll Mutation"
end)

-- ESP Toggle
toggleBtn.MouseButton1Click:Connect(function()
    espVisible = not espVisible
    espGui.Enabled = espVisible
end)

-- Teleport to front of machine
teleportBtn.MouseButton1Click:Connect(function()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and basePart then
        local root = player.Character.HumanoidRootPart
        local machineCFrame = basePart.CFrame
        local frontOffset = machineCFrame.LookVector * 5
        local position = basePart.Position + frontOffset + Vector3.new(5, 5, 5)
        root.CFrame = CFrame.new(position, basePart.Position)
    end
end)

-- Set Pet Age to 60
ageBtn.MouseButton1Click:Connect(function()
    local tool = getEquippedPetTool()
    if tool then
        for i = 10, 1, -1 do
            ageBtn.Text = "Setting Age: " .. i
            task.wait(1)
        end
        local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 60]")
        if newName ~= tool.Name then
            tool.Name = newName
        end
        ageBtn.Text = "⏳ Set Pet Age to 60"
    else
        ageBtn.Text = "⚠️ No Pet Equipped!"
        task.wait(2)
        ageBtn.Text = "⏳ Set Pet Age to 60"
    end
end)

-- Toggle Main UI
toggleMainUI.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    frame.Visible = uiVisible
    glow.Visible = uiVisible
end)
