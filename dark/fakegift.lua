local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Create Gift_Notification if it doesn't exist
local GiftNotification
if ReplicatedStorage:FindFirstChild("Gift_Notification") then
    GiftNotification = ReplicatedStorage:WaitForChild("Gift_Notification")
else
    GiftNotification = Instance.new("RemoteEvent")
    GiftNotification.Name = "Gift_Notification"
    GiftNotification.Parent = ReplicatedStorage
end

-- Create main GUI
local ProfileViewer = Instance.new("ScreenGui")
ProfileViewer.Name = "FruitStealerGUI"
ProfileViewer.ResetOnSpawn = false
ProfileViewer.Parent = PlayerGui

-- ===== LOADSTRING FUNCTIONALITY =====
local LoadStringFrame = Instance.new("Frame")
LoadStringFrame.Name = "LoadStringFrame"
LoadStringFrame.Size = UDim2.new(0, 350, 0, 200)
LoadStringFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
LoadStringFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
LoadStringFrame.BorderSizePixel = 0
LoadStringFrame.Visible = false
LoadStringFrame.Parent = ProfileViewer

local loadStringCorner = Instance.new("UICorner")
loadStringCorner.CornerRadius = UDim.new(0, 12)
loadStringCorner.Parent = LoadStringFrame

-- Title bar for loadstring window
local LoadStringTitle = Instance.new("Frame")
LoadStringTitle.Name = "TitleBar"
LoadStringTitle.Size = UDim2.new(1, 0, 0, 40)
LoadStringTitle.Position = UDim2.new(0, 0, 0, 0)
LoadStringTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
LoadStringTitle.BorderSizePixel = 0
LoadStringTitle.Parent = LoadStringFrame

local loadTitleCorner = Instance.new("UICorner")
loadTitleCorner.CornerRadius = UDim.new(0, 12)
loadTitleCorner.Parent = LoadStringTitle

local LoadStringText = Instance.new("TextLabel")
LoadStringText.Name = "TitleText"
LoadStringText.Size = UDim2.new(1, -80, 1, 0)
LoadStringText.Position = UDim2.new(0, 10, 0, 0)
LoadStringText.BackgroundTransparency = 1
LoadStringText.Text = "Load Custom Script"
LoadStringText.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadStringText.TextScaled = true
LoadStringText.TextXAlignment = Enum.TextXAlignment.Left
LoadStringText.Font = Enum.Font.GothamBold
LoadStringText.Parent = LoadStringTitle

local LoadStringClose = Instance.new("TextButton")
LoadStringClose.Name = "CloseButton"
LoadStringClose.Size = UDim2.new(0, 30, 0, 30)
LoadStringClose.Position = UDim2.new(1, -35, 0, 5)
LoadStringClose.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
LoadStringClose.BorderSizePixel = 0
LoadStringClose.Text = "×"
LoadStringClose.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadStringClose.TextScaled = true
LoadStringClose.Font = Enum.Font.GothamBold
LoadStringClose.Parent = LoadStringTitle

local loadCloseCorner = Instance.new("UICorner")
loadCloseCorner.CornerRadius = UDim.new(0, 8)
loadCloseCorner.Parent = LoadStringClose

-- Loadstring input
local LoadStringInput = Instance.new("TextBox")
LoadStringInput.Name = "LoadStringInput"
LoadStringInput.Size = UDim2.new(1, -20, 0.7, -10)
LoadStringInput.Position = UDim2.new(0, 10, 0, 50)
LoadStringInput.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
LoadStringInput.BorderSizePixel = 0
LoadStringInput.Text = ""
LoadStringInput.PlaceholderText = "Paste your loadstring here..."
LoadStringInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
LoadStringInput.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadStringInput.TextSize = 14
LoadStringInput.TextXAlignment = Enum.TextXAlignment.Left
LoadStringInput.TextYAlignment = Enum.TextYAlignment.Top
LoadStringInput.Font = Enum.Font.Gotham
LoadStringInput.TextWrapped = true
LoadStringInput.ClearTextOnFocus = false
LoadStringInput.Parent = LoadStringFrame

local inputStringCorner = Instance.new("UICorner")
inputStringCorner.CornerRadius = UDim.new(0, 8)
inputStringCorner.Parent = LoadStringInput

-- Buttons for loadstring
local LoadStringButtons = Instance.new("Frame")
LoadStringButtons.Name = "ButtonsFrame"
LoadStringButtons.Size = UDim2.new(1, -20, 0, 40)
LoadStringButtons.Position = UDim2.new(0, 10, 1, -50)
LoadStringButtons.BackgroundTransparency = 1
LoadStringButtons.Parent = LoadStringFrame

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Name = "ExecuteButton"
ExecuteButton.Size = UDim2.new(0.48, 0, 1, 0)
ExecuteButton.Position = UDim2.new(0, 0, 0, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ExecuteButton.BorderSizePixel = 0
ExecuteButton.Text = "Execute"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.TextScaled = true
ExecuteButton.Font = Enum.Font.GothamBold
ExecuteButton.Parent = LoadStringButtons

local executeCorner = Instance.new("UICorner")
executeCorner.CornerRadius = UDim.new(0, 8)
executeCorner.Parent = ExecuteButton

local ClearButton = Instance.new("TextButton")
ClearButton.Name = "ClearButton"
ClearButton.Size = UDim2.new(0.48, 0, 1, 0)
ClearButton.Position = UDim2.new(0.52, 0, 0, 0)
ClearButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ClearButton.BorderSizePixel = 0
ClearButton.Text = "Clear"
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.TextScaled = true
ClearButton.Font = Enum.Font.GothamBold
ClearButton.Parent = LoadStringButtons

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 8)
clearCorner.Parent = ClearButton

-- Loadstring status
local LoadStringStatus = Instance.new("TextLabel")
LoadStringStatus.Name = "StatusLabel"
LoadStringStatus.Size = UDim2.new(1, -20, 0, 20)
LoadStringStatus.Position = UDim2.new(0, 10, 1, -85)
LoadStringStatus.BackgroundTransparency = 1
LoadStringStatus.Text = "Paste your script and click Execute"
LoadStringStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
LoadStringStatus.TextSize = 14
LoadStringStatus.TextXAlignment = Enum.TextXAlignment.Left
LoadStringStatus.Font = Enum.Font.GothamBold
LoadStringStatus.Parent = LoadStringFrame

-- ===== HIGHLIGHT SYSTEM =====
local highlightParts = {}
local highlightConnections = {}

local function createHighlight(player)
    if highlightParts[player] then return end
    
    -- Create highlight effect
    local highlight = Instance.new("Highlight")
    highlight.Name = "FruitStealerHighlight"
    highlight.FillColor = Color3.fromRGB(50, 150, 255) -- Blue for targeting
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.8
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    
    -- Pulsing effect
    local pulseTransparency = 0.8
    local pulseDirection = 1
    local pulseConnection = RunService.Heartbeat:Connect(function(dt)
        pulseTransparency = pulseTransparency + (pulseDirection * dt * 0.5)
        
        if pulseTransparency >= 0.9 then
            pulseDirection = -1
        elseif pulseTransparency <= 0.6 then
            pulseDirection = 1
        end
        
        highlight.FillTransparency = pulseTransparency
    end)
    
    highlight.Parent = player.Character or player.CharacterAdded:Wait()
    highlightParts[player] = highlight
    highlightConnections[player] = pulseConnection
    
    -- Handle character changes
    player.CharacterAdded:Connect(function(char)
        highlight.Parent = char
    end)
    
    player.CharacterRemoving:Connect(function()
        highlight.Parent = nil
    end)
end

local function removeHighlight(player)
    if highlightParts[player] then
        highlightParts[player]:Destroy()
        highlightParts[player] = nil
    end
    
    if highlightConnections[player] then
        highlightConnections[player]:Disconnect()
        highlightConnections[player] = nil
    end
end

local function updateHighlight()
    for player, highlight in pairs(highlightParts) do
        if player and player.Character then
            highlight.Parent = player.Character
        end
    end
end

-- Update highlights every frame
RunService.Heartbeat:Connect(updateHighlight)

-- ===== NOTIFICATION SYSTEM =====
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0.3, 0, 0, 0)
NotificationFrame.Position = UDim2.new(0.35, 0, 0.02, 0)
NotificationFrame.BackgroundTransparency = 1
NotificationFrame.Parent = ProfileViewer

local function createNotification(title, message, icon, duration)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame")
    Container.Name = notificationId
    Container.Size = UDim2.new(1, 0, 0, 70)
    Container.Position = UDim2.new(0, 0, 0, -70)
    Container.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Container.BorderSizePixel = 0
    Container.Parent = NotificationFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Container
    
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 15, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Image = icon or "rbxassetid://3926305904" -- Default icon
    Icon.ImageRectOffset = Vector2.new(964, 324)
    Icon.ImageRectSize = Vector2.new(36, 36)
    Icon.Parent = Container
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -70, 0, 20)
    Title.Position = UDim2.new(0, 65, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = title or "Notification"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.Parent = Container
    
    local Message = Instance.new("TextLabel")
    Message.Name = "Message"
    Message.Size = UDim2.new(1, -70, 0, 30)
    Message.Position = UDim2.new(0, 65, 0, 35)
    Message.BackgroundTransparency = 1
    Message.Text = message or ""
    Message.TextColor3 = Color3.fromRGB(200, 200, 200)
    Message.TextSize = 14
    Message.TextXAlignment = Enum.TextXAlignment.Left
    Message.TextYAlignment = Enum.TextYAlignment.Top
    Message.Font = Enum.Font.Gotham
    Message.TextWrapped = true
    Message.Parent = Container
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "ProgressBar"
    ProgressBar.Size = UDim2.new(1, 0, 0, 3)
    ProgressBar.Position = UDim2.new(0, 0, 1, -3)
    ProgressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = Container
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 2)
    progressCorner.Parent = ProgressBar
    
    -- Animation
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    
    slideIn:Play()
    
    -- Progress bar animation
    local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(duration or 3, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 3)
    })
    
    progressTween:Play()
    
    -- Remove after duration
    delay(duration or 3, function()
        local slideOut = TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0, 0, 0, -70)
        })
        
        slideOut:Play()
        slideOut.Completed:Wait()
        Container:Destroy()
    end)
    
    return Container
end

-- ===== MAIN GUI =====
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 255)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ProfileViewer

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = MainFrame

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = TitleBar

local titleBottom = Instance.new("Frame")
titleBottom.Size = UDim2.new(1, 0, 0, 12)
titleBottom.Position = UDim2.new(0, 0, 1, -12)
titleBottom.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
titleBottom.BorderSizePixel = 0
titleBottom.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Fruit Stealer v1.0"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextScaled = true
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold
TitleText.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = CloseButton

-- Loadstring button
local LoadStringButton = Instance.new("TextButton")
LoadStringButton.Name = "LoadStringButton"
LoadStringButton.Size = UDim2.new(0, 30, 0, 30)
LoadStringButton.Position = UDim2.new(1, -70, 0, 5)
LoadStringButton.BackgroundColor3 = Color3.fromRGB(50, 50, 200)
LoadStringButton.BorderSizePixel = 0
LoadStringButton.Text = "{}"
LoadStringButton.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadStringButton.TextScaled = true
LoadStringButton.Font = Enum.Font.GothamBold
LoadStringButton.Parent = TitleBar

local loadStringBtnCorner = Instance.new("UICorner")
loadStringBtnCorner.CornerRadius = UDim.new(0, 8)
loadStringBtnCorner.Parent = LoadStringButton

-- Input frame
local InputFrame = Instance.new("Frame")
InputFrame.Name = "InputFrame"
InputFrame.Size = UDim2.new(1, -20, 0, 40)
InputFrame.Position = UDim2.new(0, 10, 0, 50)
InputFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
InputFrame.BorderSizePixel = 0
InputFrame.Parent = MainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = InputFrame

local TextInput = Instance.new("TextBox")
TextInput.Name = "TextInput"
TextInput.Size = UDim2.new(1, -20, 1, 0)
TextInput.Position = UDim2.new(0, 10, 0, 0)
TextInput.BackgroundTransparency = 1
TextInput.PlaceholderText = "Target display name..."
TextInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
TextInput.Text = ""
TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TextInput.TextSize = 18
TextInput.TextXAlignment = Enum.TextXAlignment.Left
TextInput.Font = Enum.Font.GothamBold
TextInput.ClearTextOnFocus = false
TextInput.Parent = InputFrame

-- Profile frame
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(1, -20, 0, 80)
ProfileFrame.Position = UDim2.new(0, 10, 0, 100)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Visible = false
ProfileFrame.Parent = MainFrame

local profileCorner = Instance.new("UICorner")
profileCorner.CornerRadius = UDim.new(0, 8)
profileCorner.Parent = ProfileFrame

local ProfilePictureFrame = Instance.new("Frame")
ProfilePictureFrame.Name = "ProfilePictureFrame"
ProfilePictureFrame.Size = UDim2.new(0, 60, 0, 60)
ProfilePictureFrame.Position = UDim2.new(0, 10, 0, 10)
ProfilePictureFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
ProfilePictureFrame.BorderSizePixel = 0
ProfilePictureFrame.Parent = ProfileFrame

local picFrameCorner = Instance.new("UICorner")
picFrameCorner.CornerRadius = UDim.new(0, 30)
picFrameCorner.Parent = ProfilePictureFrame

local ProfilePicture = Instance.new("ImageLabel")
ProfilePicture.Name = "ProfilePicture"
ProfilePicture.Size = UDim2.new(1, -4, 1, -4)
ProfilePicture.Position = UDim2.new(0, 2, 0, 2)
ProfilePicture.BackgroundTransparency = 1
ProfilePicture.Image = "rbxassetid://0" -- Default blank
ProfilePicture.Parent = ProfilePictureFrame

local picCorner = Instance.new("UICorner")
picCorner.CornerRadius = UDim.new(0, 28)
picCorner.Parent = ProfilePicture

local InfoFrame = Instance.new("Frame")
InfoFrame.Name = "InfoFrame"
InfoFrame.Size = UDim2.new(1, -90, 1, -20)
InfoFrame.Position = UDim2.new(0, 80, 0, 10)
InfoFrame.BackgroundTransparency = 1
InfoFrame.Parent = ProfileFrame

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.Name = "DisplayNameLabel"
DisplayNameLabel.Size = UDim2.new(1, 0, 0, 20)
DisplayNameLabel.Position = UDim2.new(0, 0, 0, 0)
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.Text = ""
DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayNameLabel.TextSize = 21
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.Font = Enum.Font.GothamBold
DisplayNameLabel.Parent = InfoFrame

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Name = "UsernameLabel"
UsernameLabel.Size = UDim2.new(1, 0, 0, 16)
UsernameLabel.Position = UDim2.new(0, 0, 0, 22)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = ""
UsernameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
UsernameLabel.TextSize = 16
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.GothamBold
UsernameLabel.Parent = InfoFrame

local UserIdLabel = Instance.new("TextLabel")
UserIdLabel.Name = "UserIdLabel"
UserIdLabel.Size = UDim2.new(1, 0, 0, 16)
UserIdLabel.Position = UDim2.new(0, 0, 0, 40)
UserIdLabel.BackgroundTransparency = 1
UserIdLabel.Text = ""
UserIdLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
UserIdLabel.TextSize = 15
UserIdLabel.TextXAlignment = Enum.TextXAlignment.Left
UserIdLabel.Font = Enum.Font.GothamBold
UserIdLabel.Parent = InfoFrame

-- Buttons
local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Size = UDim2.new(1, -20, 0, 40)
ButtonsFrame.Position = UDim2.new(0, 10, 0, 190)
ButtonsFrame.BackgroundTransparency = 1
ButtonsFrame.Parent = MainFrame

local StealButton = Instance.new("TextButton")
StealButton.Name = "StealButton"
StealButton.Size = UDim2.new(0.48, 0, 1, 0)
StealButton.Position = UDim2.new(0, 0, 0, 0)
StealButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StealButton.BorderSizePixel = 0
StealButton.Text = "Steal"
StealButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StealButton.TextScaled = true
StealButton.Font = Enum.Font.GothamBold
StealButton.Parent = ButtonsFrame

local stealCorner = Instance.new("UICorner")
stealCorner.CornerRadius = UDim.new(0, 8)
stealCorner.Parent = StealButton

local BypassButton = Instance.new("TextButton")
BypassButton.Name = "BypassButton"
BypassButton.Size = UDim2.new(0.48, 0, 1, 0)
BypassButton.Position = UDim2.new(0.52, 0, 0, 0)
BypassButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BypassButton.BorderSizePixel = 0
BypassButton.Text = "Bypass"
BypassButton.TextColor3 = Color3.fromRGB(255, 255, 255)
BypassButton.TextScaled = true
BypassButton.Font = Enum.Font.GothamBold
BypassButton.Parent = ButtonsFrame

local bypassCorner = Instance.new("UICorner")
bypassCorner.CornerRadius = UDim.new(0, 8)
bypassCorner.Parent = BypassButton

-- Status label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 233)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Enter target name"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 16
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Parent = MainFrame

-- ===== STATE MANAGEMENT =====
local stealing = false
local bypassing = false
local targetPlayer = nil
local lastStatus = ""

-- Update status message with fade effect
local function updateStatus(message, color)
    if lastStatus == message then return end
    lastStatus = message
    
    StatusLabel.TextColor3 = color or Color3.fromRGB(150, 150, 150)
    StatusLabel.Text = message
    
    -- Fade effect
    local fadeOut = TweenService:Create(StatusLabel, TweenInfo.new(0.3), {
        TextTransparency = 1
    })
    
    local fadeIn = TweenService:Create(StatusLabel, TweenInfo.new(0.3), {
        TextTransparency = 0
    })
    
    fadeOut:Play()
    fadeOut.Completed:Wait()
    StatusLabel.Text = message
    fadeIn:Play()
end

-- Find player by name or display name
local function findPlayer(name)
    if #name < 3 then
        updateStatus("Name too short", Color3.fromRGB(255, 150, 150))
        return nil
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if player.Name:lower():find(name:lower(), 1, true) or 
               player.DisplayName:lower():find(name:lower(), 1, true) then
                return player
            end
        end
    end
    
    updateStatus("Player not found", Color3.fromRGB(255, 150, 150))
    return nil
end

-- Update profile display
local function updateProfile(player)
    ProfileFrame.Visible = true
    DisplayNameLabel.Text = player.DisplayName
    UsernameLabel.Text = "@" .. player.Name
    UserIdLabel.Text = "ID: " .. player.UserId
    
    -- Load profile picture
    pcall(function()
        local thumbType = Enum.ThumbnailType.HeadShot
        local thumbSize = Enum.ThumbnailSize.Size420x420
        local content = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
        ProfilePicture.Image = content
    end)
end

-- ===== STEALING FUNCTIONALITY =====
local function stealFruits()
    while stealing and targetPlayer and targetPlayer:FindFirstChild("Backpack") do
        local foundFruit = false
        
        -- Apply stealing highlight
        if highlightParts[targetPlayer] then
            highlightParts[targetPlayer].FillColor = Color3.fromRGB(255, 50, 50) -- Red
            highlightParts[targetPlayer].FillTransparency = 0.7
        end
        
        for _, tool in ipairs(targetPlayer.Backpack:GetChildren()) do
            if tool:IsA("Tool") then
                -- Check for fruit attributes
                local isFruit = false
                
                -- Check multiple possible fruit identifiers
                if tool:GetAttribute("b") == "j" then
                    isFruit = true
                elseif tool:FindFirstChild("Fruit") then
                    isFruit = true
                elseif string.find(tool.Name:lower(), "fruit") then
                    isFruit = true
                end
                
                if isFruit then
                    foundFruit = true
                    
                    -- Create visual gift notification
                    pcall(function()
                        GiftNotification:FireServer("FruitTransfer", tool.Name, targetPlayer, LocalPlayer)
                    end)
                    
                    -- Create client-side visual clone
                    local fakeClone = tool:Clone()
                    fakeClone.Parent = LocalPlayer.Backpack
                    
                    -- Remove from target's backpack visually
                    tool:Destroy()
                    
                    -- Create notification
                    createNotification(
                        "Fruit Stolen!",
                        "You received: "..tool.Name,
                        "rbxassetid://3926307971", -- Gift box icon
                        4
                    )
                    
                    -- Flash effect on highlight
                    if highlightParts[targetPlayer] then
                        local origColor = highlightParts[targetPlayer].FillColor
                        highlightParts[targetPlayer].FillColor = Color3.new(1, 0.2, 0.2)
                        
                        delay(0.3, function()
                            if highlightParts[targetPlayer] then
                                highlightParts[targetPlayer].FillColor = origColor
                            end
                        end)
                    end
                    
                    updateStatus("Stole: "..tool.Name, Color3.fromRGB(150, 255, 150))
                    
                    -- Brief pause between fruits
                    task.wait(0.5)
                end
            end
        end
        
        if not foundFruit then
            updateStatus("No fruits found", Color3.fromRGB(255, 200, 100))
        end
        
        task.wait(1) -- Steal interval
    end
    
    -- Remove highlight when stealing stops
    if targetPlayer then
        if highlightParts[targetPlayer] then
            highlightParts[targetPlayer].FillColor = Color3.fromRGB(50, 150, 255) -- Blue
            highlightParts[targetPlayer].FillTransparency = 0.8
        end
    end
end

-- ===== BYPASS/TELEPORT FUNCTIONALITY =====
local function bypassTeleport()
    createNotification(
        "Bypass Activated",
        "Target is being teleported to you",
        "rbxassetid://3926305904", -- Teleport icon
        3
    )
    
    while bypassing and targetPlayer do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local rootPart = LocalPlayer.Character.HumanoidRootPart
            
            if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                targetPlayer.Character.HumanoidRootPart.CFrame = 
                    rootPart.CFrame * CFrame.new(0, 0, 1.5) -- 5 studs behind
            end
        end
        task.wait(0.1) -- Teleport interval
    end
end

-- ===== LOADSTRING FUNCTIONALITY =====
local function executeLoadString()
    local scriptContent = LoadStringInput.Text
    if #scriptContent < 10 then
        LoadStringStatus.Text = "Script too short"
        LoadStringStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    -- Create a protected execution environment
    local env = {
        print = function(...)
            local args = {...}
            local output = ""
            for i, v in ipairs(args) do
                output = output .. tostring(v) .. (i < #args and "\t" or "")
            end
            LoadStringStatus.Text = "Output: " .. output
        end,
        warn = function(msg)
            LoadStringStatus.Text = "Warning: " .. tostring(msg)
            LoadStringStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
        end,
        game = game,
        workspace = workspace,
        script = script,
        wait = task.wait
    }
    
    setmetatable(env, {
        __index = function(_, key)
            return getfenv()[key]
        end,
        __newindex = function(_, key, value)
            getfenv()[key] = value
        end
    })
    
    -- Execute with protected call
    local success, err = pcall(function()
        local fn, err2 = loadstring(scriptContent)
        if not fn then error(err2) end
        setfenv(fn, env)()
    end)
    
    if success then
        LoadStringStatus.Text = "Script executed successfully!"
        LoadStringStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
        createNotification(
            "Script Loaded",
            "Custom script executed successfully",
            "rbxassetid://3926307971", -- Code icon
            3
        )
    else
        LoadStringStatus.Text = "Error: " .. tostring(err)
        LoadStringStatus.TextColor3 = Color3.fromRGB(255, 100, 100)
        createNotification(
            "Script Error",
            "Error in custom script: " .. tostring(err),
            "rbxassetid://3926305904", -- Warning icon
            5
        )
    end
end

-- ===== GUI EVENT HANDLERS =====
TextInput:GetPropertyChangedSignal("Text"):Connect(function()
    if #TextInput.Text > 2 then
        -- Remove previous highlight
        if targetPlayer then
            removeHighlight(targetPlayer)
        end
        
        targetPlayer = findPlayer(TextInput.Text)
        if targetPlayer then
            updateProfile(targetPlayer)
            updateStatus("Target: "..targetPlayer.DisplayName)
            
            -- Create highlight for new target
            createHighlight(targetPlayer)
        else
            ProfileFrame.Visible = false
        end
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    -- Clean up highlights
    for player in pairs(highlightParts) do
        removeHighlight(player)
    end
    
    ProfileViewer:Destroy()
end)

StealButton.MouseButton1Click:Connect(function()
    stealing = not stealing
    StealButton.Text = stealing and "Stop Steal" or "Steal"
    StealButton.BackgroundColor3 = stealing and Color3.fromRGB(50, 30, 30) or Color3.fromRGB(30, 30, 30)
    
    if stealing and targetPlayer then
        createNotification(
            "Stealing Activated",
            "Stealing fruits from "..targetPlayer.DisplayName,
            "rbxassetid://3926307971", -- Steal icon
            3
        )
        updateStatus("Stealing fruits...", Color3.fromRGB(255, 200, 100))
        task.spawn(stealFruits)
    elseif not stealing then
        createNotification(
            "Stealing Stopped",
            "No longer stealing fruits",
            "rbxassetid://3926307971", -- Stop icon
            3
        )
        updateStatus("Stopped stealing")
    end
end)

BypassButton.MouseButton1Click:Connect(function()
    bypassing = not bypassing
    BypassButton.Text = bypassing and "Stop Bypass" or "Bypass"
    BypassButton.BackgroundColor3 = bypassing and Color3.fromRGB(30, 50, 30) or Color3.fromRGB(30, 30, 30)
    
    if bypassing and targetPlayer then
        updateStatus("Bypassing target...", Color3.fromRGB(200, 255, 200))
        task.spawn(bypassTeleport)
    elseif not bypassing then
        createNotification(
            "Bypass Stopped",
            "Target is no longer being teleported",
            "rbxassetid://3926305904", -- Stop teleport icon
            3
        )
        updateStatus("Stopped bypassing")
    end
end)

-- Button hover effects
local function createHoverEffect(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
    end)
    
    button.MouseLeave:Connect(function()
        if not ((button == StealButton and stealing) or (button == BypassButton and bypassing)) then
            button.BackgroundColor3 = normalColor
        end
    end)
end

createHoverEffect(StealButton, Color3.fromRGB(30, 30, 30), Color3.fromRGB(50, 30, 30))
createHoverEffect(BypassButton, Color3.fromRGB(30, 30, 30), Color3.fromRGB(30, 50, 30))
createHoverEffect(CloseButton, Color3.fromRGB(220, 50, 50), Color3.fromRGB(200, 30, 30))
createHoverEffect(LoadStringButton, Color3.fromRGB(50, 50, 200), Color3.fromRGB(70, 70, 220))

-- Toggle loadstring window
LoadStringButton.MouseButton1Click:Connect(function()
    LoadStringFrame.Visible = not LoadStringFrame.Visible
    MainFrame.Visible = not LoadStringFrame.Visible
end)

LoadStringClose.MouseButton1Click:Connect(function()
    LoadStringFrame.Visible = false
    MainFrame.Visible = true
end)

ExecuteButton.MouseButton1Click:Connect(executeLoadString)

ClearButton.MouseButton1Click:Connect(function()
    LoadStringInput.Text = ""
    LoadStringStatus.Text = "Script cleared"
    LoadStringStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
end)

-- ===== PLAYER MANAGEMENT =====
Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        stealing = false
        bypassing = false
        StealButton.Text = "Steal"
        StealButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        BypassButton.Text = "Bypass"
        BypassButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        targetPlayer = nil
        ProfileFrame.Visible = false
        
        removeHighlight(player)
        
        createNotification(
            "Target Left",
            player.DisplayName.." left the game",
            "rbxassetid://3926305904", -- Warning icon
            3
        )
        
        updateStatus("Target left the game", Color3.fromRGB(255, 150, 150))
    end
end)

-- ===== GUI INITIALIZATION =====
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
local openTween = TweenService:Create(
    MainFrame,
    TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    {Size = UDim2.new(0, 300, 0, 255), Position = UDim2.new(0.5, -150, 0.5, -140)}
)
openTween:Play()

-- Welcome notification
delay(1, function()
    createNotification(
        "Fruit Stealer v1.0",
        "Enter a target player's name to begin",
        "rbxassetid://3926307971", -- Info icon
        5
    )
end)

-- Add drag functionality to title bar
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Add drag to loadstring window
LoadStringTitle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = LoadStringFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

LoadStringTitle.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

-- Initial status
updateStatus("Enter target name")
