-- LocalScript (place in StarterPlayerScripts)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, guiName in ipairs({"CustomPanelGui", "IntroLoadingGui"}) do
    if playerGui:FindFirstChild(guiName) then
        playerGui[guiName]:Destroy()
    end
end

-- ========== Loading GUI ==========
local LoadingGui = Instance.new("ScreenGui", playerGui)
LoadingGui.Name = "IntroLoadingGui"
LoadingGui.DisplayOrder = 999
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingFrame = Instance.new("Frame", LoadingGui)
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LoadingFrame.BorderSizePixel = 4
LoadingFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)

Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 16)

local LoadingTitle = Instance.new("TextLabel", LoadingFrame)
LoadingTitle.Size = UDim2.new(1, -20, 0.5, 0)
LoadingTitle.Position = UDim2.new(0, 10, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "Bypassing Anti Cheat..."
LoadingTitle.Font = Enum.Font.SourceSansBold
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.TextScaled = true

local LoadingBarBackground = Instance.new("Frame", LoadingFrame)
LoadingBarBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
LoadingBarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local LoadingBar = Instance.new("Frame", LoadingBarBackground)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(100, 255, 100)

for i = 1, 100 do
    LoadingBar.Size = UDim2.new(i / 100, 0, 1, 0)
    task.wait(0.03)
end

for i = 1, 10 do
    LoadingFrame.BackgroundTransparency = i / 10
    LoadingTitle.TextTransparency = i / 10
    LoadingBar.BackgroundTransparency = i / 10
    task.wait(0.05)
end

LoadingGui:Destroy()

-- ========== Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "CustomPanelGui"
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local PanelFrame = Instance.new("Frame", ScreenGui)
PanelFrame.Size = UDim2.new(0, 350, 0, 230)
PanelFrame.Position = UDim2.new(0.5, -175, 0.5, -115)
PanelFrame.AnchorPoint = Vector2.new(0.5, 0.5)
PanelFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PanelFrame.Active = true
PanelFrame.Draggable = true
Instance.new("UICorner", PanelFrame).CornerRadius = UDim.new(0, 16)

local Title = Instance.new("TextLabel", PanelFrame)
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Grow a Garden Scam"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

local MinimizeButton = Instance.new("TextButton", PanelFrame)
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -40, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizeButton.Text = "-"
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextScaled = true

local TextBox = Instance.new("TextBox", PanelFrame)
TextBox.Size = UDim2.new(0.9, 0, 0, 40)
TextBox.Position = UDim2.new(0.05, 0, 0.25, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.PlaceholderText = "Enter username..."
TextBox.Text = ""
TextBox.Font = Enum.Font.SourceSans
TextBox.TextScaled = true
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 12)

local FreezeTrade = Instance.new("TextButton", PanelFrame)
FreezeTrade.Size = UDim2.new(0.9, 0, 0, 40)
FreezeTrade.Position = UDim2.new(0.05, 0, 0.5, 0)
FreezeTrade.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FreezeTrade.Text = "Freeze Trade"
FreezeTrade.Font = Enum.Font.SourceSansBold
FreezeTrade.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeTrade.TextScaled = true
Instance.new("UICorner", FreezeTrade).CornerRadius = UDim.new(0, 12)

local AutoAccept = Instance.new("TextButton", PanelFrame)
AutoAccept.Size = UDim2.new(0.9, 0, 0, 40)
AutoAccept.Position = UDim2.new(0.05, 0, 0.7, 0)
AutoAccept.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoAccept.Text = "Auto Accept"
AutoAccept.Font = Enum.Font.SourceSansBold
AutoAccept.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoAccept.TextScaled = true
Instance.new("UICorner", AutoAccept).CornerRadius = UDim.new(0, 12)

local CreditsLabel = Instance.new("TextLabel", PanelFrame)
CreditsLabel.Size = UDim2.new(1, 0, 0, 20)
CreditsLabel.Position = UDim2.new(0, 0, 0.9, 0)
CreditsLabel.BackgroundTransparency = 1
CreditsLabel.Text = "By Zeo"
CreditsLabel.Font = Enum.Font.SourceSansItalic
CreditsLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
CreditsLabel.TextScaled = true

-- Minimize toggle
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        for _, v in pairs(PanelFrame:GetChildren()) do
            if v:IsA("GuiObject") and v ~= Title and v ~= MinimizeButton then
                v.Visible = false
            end
        end
        game:GetService("TweenService"):Create(PanelFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 40)}):Play()
        MinimizeButton.Text = "+"
    else
        game:GetService("TweenService"):Create(PanelFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 230)}):Play()
        for _, v in pairs(PanelFrame:GetChildren()) do
            if v:IsA("GuiObject") and v ~= Title and v ~= MinimizeButton then
                v.Visible = true
            end
        end
        MinimizeButton.Text = "-"
    end
end)

-- Player search
local function findPlayer(username)
    for _, p in pairs(game.Players:GetPlayers()) do
        if string.lower(p.Name) == string.lower(username) then
            return p.Name
        end
    end
    return nil
end

-- Notification (Right side + Smaller)
local function showNotification(message, isSuccess)
    local frame = Instance.new("Frame", ScreenGui)
    frame.Size = UDim2.new(0, 260, 0, 40)
    frame.Position = UDim2.new(1, -280, 0.05, 0)
    frame.BackgroundColor3 = isSuccess and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    frame.BackgroundTransparency = 0.1
    frame.AnchorPoint = Vector2.new(0, 0)
    frame.ZIndex = 10

    local text = Instance.new("TextLabel", frame)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.TextColor3 = Color3.fromRGB(255, 255, 255)
    text.Font = Enum.Font.GothamBold
    text.TextSize = 16
    text.TextWrapped = true
    text.Text = message
    text.BackgroundTransparency = 1

    task.wait(2)
    frame:Destroy()
end

-- Button Events
FreezeTrade.MouseButton1Click:Connect(function()
    local username = TextBox.Text
    local playerFound = findPlayer(username)
    if playerFound then
        showNotification(playerFound .. " activated Freeze Trade!", true)
    else
        showNotification("Username not in game", false)
    end
end)

AutoAccept.MouseButton1Click:Connect(function()
    local username = TextBox.Text
    local playerFound = findPlayer(username)
    if playerFound then
        showNotification(playerFound .. " enabled Auto Accept!", true)
    else
        showNotification("Username not in game", false)
    end
end)
