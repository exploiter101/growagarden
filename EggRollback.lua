-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, guiName in ipairs({"CustomPanelGui", "IntroLoadingGui"}) do
    if PlayerGui:FindFirstChild(guiName) then
        PlayerGui[guiName]:Destroy()
    end
end

-- ========== Theme Settings ==========
local BROWN_BG = Color3.fromRGB(118, 61, 25)
local BROWN_LIGHT = Color3.fromRGB(164, 97, 43)
local BROWN_BORDER = Color3.fromRGB(51, 25, 0)
local ACCENT_GREEN = Color3.fromRGB(110, 196, 99)
local BUTTON_RED = Color3.fromRGB(255, 62, 62)
local BUTTON_GRAY = Color3.fromRGB(190, 190, 190)
local BUTTON_GREEN = Color3.fromRGB(85, 200, 85)
local BUTTON_GREEN_HOVER = Color3.fromRGB(120, 230, 120)
local BLUE_TOGGLE = Color3.fromRGB(100, 180, 255)
local BLUE_TOGGLE_HOVER = Color3.fromRGB(130, 210, 255)
local FONT = Enum.Font.FredokaOne
local TILE_IMAGE = "rbxassetid://15910695828"

-- ========== Loading GUI ==========
local LoadingGui = Instance.new("ScreenGui", PlayerGui)
LoadingGui.Name = "IntroLoadingGui"
LoadingGui.DisplayOrder = 999
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingFrame = Instance.new("Frame", LoadingGui)
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = BROWN_BG
LoadingFrame.BorderSizePixel = 4
LoadingFrame.BorderColor3 = BROWN_BORDER
local frameCorner = Instance.new("UICorner", LoadingFrame)
frameCorner.CornerRadius = UDim.new(0, 16)
local frameStroke = Instance.new("UIStroke", LoadingFrame)
frameStroke.Thickness = 2
frameStroke.Color = BROWN_BORDER

local brownTexture = Instance.new("ImageLabel", LoadingFrame)
brownTexture.Size = UDim2.new(1, 0, 1, 0)
brownTexture.Position = UDim2.new(0, 0, 0, 0)
brownTexture.BackgroundTransparency = 1
brownTexture.Image = TILE_IMAGE
brownTexture.ImageTransparency = 0
brownTexture.ScaleType = Enum.ScaleType.Tile
brownTexture.TileSize = UDim2.new(0, 96, 0, 96)
brownTexture.ZIndex = 1

local LoadingTitle = Instance.new("TextLabel", LoadingFrame)
LoadingTitle.Size = UDim2.new(1, -20, 0.5, 0)
LoadingTitle.Position = UDim2.new(0, 10, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "Loading Player Search..."
LoadingTitle.Font = FONT
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.TextScaled = true
LoadingTitle.TextStrokeTransparency = 0.3

local LoadingBarBackground = Instance.new("Frame", LoadingFrame)
LoadingBarBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
LoadingBarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
LoadingBarBackground.BackgroundColor3 = BROWN_LIGHT
local barBGCorner = Instance.new("UICorner", LoadingBarBackground)
barBGCorner.CornerRadius = UDim.new(0, 8)
local barBGStroke = Instance.new("UIStroke", LoadingBarBackground)
barBGStroke.Color = BROWN_BORDER
barBGStroke.Thickness = 1

local LoadingBar = Instance.new("Frame", LoadingBarBackground)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = ACCENT_GREEN
local barFillCorner = Instance.new("UICorner", LoadingBar)
barFillCorner.CornerRadius = UDim.new(0, 8)

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
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "CustomPanelGui"
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 380)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -190)
MainFrame.BackgroundColor3 = BROWN_BG
MainFrame.Active = true
MainFrame.Draggable = true
local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 16)
local mainStroke = Instance.new("UIStroke", MainFrame)
mainStroke.Thickness = 2
mainStroke.Color = BROWN_BORDER

local mainTexture = Instance.new("ImageLabel", MainFrame)
mainTexture.Size = UDim2.new(1, 0, 1, 0)
mainTexture.Position = UDim2.new(0, 0, 0, 0)
mainTexture.BackgroundTransparency = 1
mainTexture.Image = TILE_IMAGE
mainTexture.ImageTransparency = 0
mainTexture.ScaleType = Enum.ScaleType.Tile
mainTexture.TileSize = UDim2.new(0, 96, 0, 96)
mainTexture.ZIndex = 1

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = ACCENT_GREEN
local titleBarCorner = Instance.new("UICorner", TitleBar)
titleBarCorner.CornerRadius = UDim.new(0, 16)

local titleTexture = Instance.new("ImageLabel", TitleBar)
titleTexture.Size = UDim2.new(1, 0, 1, 0)
titleTexture.Position = UDim2.new(0, 0, 0, 0)
titleTexture.BackgroundTransparency = 1
titleTexture.Image = TILE_IMAGE
titleTexture.ImageTransparency = 0
titleTexture.ScaleType = Enum.ScaleType.Tile
titleTexture.TileSize = UDim2.new(0, 96, 0, 96)
titleTexture.ZIndex = 2

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Player Search Tool"
TitleText.Font = FONT
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextScaled = true
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.TextStrokeTransparency = 0.1
TitleText.ZIndex = 3

local MinimizeButton = Instance.new("TextButton", TitleBar)
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeButton.BackgroundColor3 = BUTTON_GRAY
MinimizeButton.Text = "-"
MinimizeButton.Font = FONT
MinimizeButton.TextColor3 = Color3.fromRGB(65, 65, 65)
MinimizeButton.TextScaled = true
MinimizeButton.TextStrokeTransparency = 0.1
MinimizeButton.ZIndex = 3
local minimizeStroke = Instance.new("UIStroke", MinimizeButton)
minimizeStroke.Color = Color3.fromRGB(120,120,120)
minimizeStroke.Thickness = 1

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.BackgroundColor3 = BUTTON_RED
CloseButton.Text = "X"
CloseButton.Font = FONT
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.TextScaled = true
CloseButton.TextStrokeTransparency = 0.3
CloseButton.ZIndex = 3
local closeStroke = Instance.new("UIStroke", CloseButton)
closeStroke.Color = Color3.fromRGB(107, 0, 0)
closeStroke.Thickness = 1

-- Input frame
local InputFrame = Instance.new("Frame", MainFrame)
InputFrame.Name = "InputFrame"
InputFrame.Size = UDim2.new(1, -24, 0, 40)
InputFrame.Position = UDim2.new(0, 12, 0, 46)
InputFrame.BackgroundColor3 = BROWN_LIGHT
local inputCorner = Instance.new("UICorner", InputFrame)
inputCorner.CornerRadius = UDim.new(0, 8)
local inputStroke = Instance.new("UIStroke", InputFrame)
inputStroke.Thickness = 1
inputStroke.Color = BROWN_BORDER

local TextInput = Instance.new("TextBox", InputFrame)
TextInput.Name = "TextInput"
TextInput.Size = UDim2.new(1, -20, 1, 0)
TextInput.Position = UDim2.new(0, 10, 0, 0)
TextInput.BackgroundTransparency = 1
TextInput.PlaceholderText = "Search player name..."
TextInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
TextInput.Text = ""
TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TextInput.TextSize = 18
TextInput.TextXAlignment = Enum.TextXAlignment.Left
TextInput.Font = FONT
TextInput.ClearTextOnFocus = false

-- Profile frame
local ProfileFrame = Instance.new("Frame", MainFrame)
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(1, -24, 0, 80)
ProfileFrame.Position = UDim2.new(0, 12, 0, 96)
ProfileFrame.BackgroundColor3 = BROWN_LIGHT
ProfileFrame.Visible = false
local profileCorner = Instance.new("UICorner", ProfileFrame)
profileCorner.CornerRadius = UDim.new(0, 8)
local profileStroke = Instance.new("UIStroke", ProfileFrame)
profileStroke.Thickness = 1
profileStroke.Color = BROWN_BORDER

local ProfilePictureFrame = Instance.new("Frame", ProfileFrame)
ProfilePictureFrame.Name = "ProfilePictureFrame"
ProfilePictureFrame.Size = UDim2.new(0, 60, 0, 60)
ProfilePictureFrame.Position = UDim2.new(0, 10, 0.5, -30)
ProfilePictureFrame.BackgroundColor3 = BROWN_BG
local picFrameCorner = Instance.new("UICorner", ProfilePictureFrame)
picFrameCorner.CornerRadius = UDim.new(0, 30)
local picFrameStroke = Instance.new("UIStroke", ProfilePictureFrame)
picFrameStroke.Thickness = 1
picFrameStroke.Color = BROWN_BORDER

local ProfilePicture = Instance.new("ImageLabel", ProfilePictureFrame)
ProfilePicture.Name = "ProfilePicture"
ProfilePicture.Size = UDim2.new(1, -4, 1, -4)
ProfilePicture.Position = UDim2.new(0, 2, 0, 2)
ProfilePicture.BackgroundTransparency = 1
ProfilePicture.Image = "rbxassetid://0" -- Default blank
local picCorner = Instance.new("UICorner", ProfilePicture)
picCorner.CornerRadius = UDim.new(0, 28)

local InfoFrame = Instance.new("Frame", ProfileFrame)
InfoFrame.Name = "InfoFrame"
InfoFrame.Size = UDim2.new(1, -80, 1, -20)
InfoFrame.Position = UDim2.new(0, 80, 0.5, -20)
InfoFrame.BackgroundTransparency = 1

local DisplayNameLabel = Instance.new("TextLabel", InfoFrame)
DisplayNameLabel.Name = "DisplayNameLabel"
DisplayNameLabel.Size = UDim2.new(1, 0, 0, 20)
DisplayNameLabel.Position = UDim2.new(0, 0, 0, 0)
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.Text = ""
DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayNameLabel.TextSize = 18
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.Font = FONT
DisplayNameLabel.TextStrokeTransparency = 0.3

local UsernameLabel = Instance.new("TextLabel", InfoFrame)
UsernameLabel.Name = "UsernameLabel"
UsernameLabel.Size = UDim2.new(1, 0, 0, 16)
UsernameLabel.Position = UDim2.new(0, 0, 0, 22)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = ""
UsernameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
UsernameLabel.TextSize = 14
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = FONT
UsernameLabel.TextStrokeTransparency = 0.4

local UserIdLabel = Instance.new("TextLabel", InfoFrame)
UserIdLabel.Name = "UserIdLabel"
UserIdLabel.Size = UDim2.new(1, 0, 0, 16)
UserIdLabel.Position = UDim2.new(0, 0, 0, 40)
UserIdLabel.BackgroundTransparency = 1
UserIdLabel.Text = ""
UserIdLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
UserIdLabel.TextSize = 13
UserIdLabel.TextXAlignment = Enum.TextXAlignment.Left
UserIdLabel.Font = FONT
UserIdLabel.TextStrokeTransparency = 0.5

-- Blue Toggle Switch Function
local function createToggleSwitch(parent, name, position, callback)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Name = name.."Toggle"
    toggleFrame.Size = UDim2.new(0, 50, 0, 24)
    toggleFrame.Position = position
    toggleFrame.BackgroundColor3 = BROWN_LIGHT
    local toggleCorner = Instance.new("UICorner", toggleFrame)
    toggleCorner.CornerRadius = UDim.new(1, 0)
    local toggleStroke = Instance.new("UIStroke", toggleFrame)
    toggleStroke.Thickness = 1
    toggleStroke.Color = BROWN_BORDER
    
    local toggleButton = Instance.new("TextButton", toggleFrame)
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 20, 0, 20)
    toggleButton.Position = UDim2.new(0, 2, 0.5, -10)
    toggleButton.BackgroundColor3 = BUTTON_GRAY
    toggleButton.Text = ""
    local buttonCorner = Instance.new("UICorner", toggleButton)
    buttonCorner.CornerRadius = UDim.new(1, 0)
    local buttonStroke = Instance.new("UIStroke", toggleButton)
    buttonStroke.Thickness = 1
    buttonStroke.Color = BROWN_BORDER
    
    local state = false
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 28, 0.5, -10),
                BackgroundColor3 = BLUE_TOGGLE
            }):Play()
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -10),
                BackgroundColor3 = BUTTON_GRAY
            }):Play()
        end
        callback(state)
    end)
    
    toggleButton.MouseEnter:Connect(function()
        if state then
            toggleButton.BackgroundColor3 = BLUE_TOGGLE_HOVER
        else
            toggleButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        end
    end)
    
    toggleButton.MouseLeave:Connect(function()
        if state then
            toggleButton.BackgroundColor3 = BLUE_TOGGLE
        else
            toggleButton.BackgroundColor3 = BUTTON_GRAY
        end
    end)
    
    return toggleFrame
end

-- Buttons Frame
local ButtonsFrame = Instance.new("Frame", MainFrame)
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Size = UDim2.new(1, -24, 0, 120)
ButtonsFrame.Position = UDim2.new(0, 12, 0, 186)
ButtonsFrame.BackgroundTransparency = 1

-- Feature Labels
local freezeLabel = Instance.new("TextLabel", ButtonsFrame)
freezeLabel.Size = UDim2.new(0.7, 0, 0, 30)
freezeLabel.Position = UDim2.new(0, 0, 0, 0)
freezeLabel.BackgroundTransparency = 1
freezeLabel.Text = "Freeze Trade"
freezeLabel.Font = FONT
freezeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
freezeLabel.TextSize = 18
freezeLabel.TextXAlignment = Enum.TextXAlignment.Left
freezeLabel.TextStrokeTransparency = 0.3

local acceptLabel = Instance.new("TextLabel", ButtonsFrame)
acceptLabel.Size = UDim2.new(0.7, 0, 0, 30)
acceptLabel.Position = UDim2.new(0, 0, 0, 40)
acceptLabel.BackgroundTransparency = 1
acceptLabel.Text = "Auto Accept"
acceptLabel.Font = FONT
acceptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
acceptLabel.TextSize = 18
acceptLabel.TextXAlignment = Enum.TextXAlignment.Left
acceptLabel.TextStrokeTransparency = 0.3

-- Create toggle switches
local freezeToggle = createToggleSwitch(ButtonsFrame, "Freeze", UDim2.new(1, -52, 0, 3), function(state)
    freezeTradeEnabled = state
    updateButtonStates()
    
    if targetPlayer then
        if state then
            showNotification("Freeze Trade", "Enabled for "..targetPlayer.DisplayName, "rbxassetid://3926307971", 3)
            task.spawn(freezeTradeEffect, targetPlayer)
        else
            showNotification("Freeze Trade", "Disabled", "rbxassetid://3926305904", 3)
        end
    end
end)

local acceptToggle = createToggleSwitch(ButtonsFrame, "Accept", UDim2.new(1, -52, 0, 43), function(state)
    autoAcceptEnabled = state
    updateButtonStates()
    
    if targetPlayer then
        if state then
            showNotification("Auto Accept", "Enabled for "..targetPlayer.DisplayName, "rbxassetid://3926307971", 3)
            task.spawn(autoAcceptEffect, targetPlayer)
        else
            showNotification("Auto Accept", "Disabled", "rbxassetid://3926305904", 3)
        end
    end
end)

-- Status label
local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -24, 0, 24)
StatusLabel.Position = UDim2.new(0, 12, 1, -32)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Enter player name to search"
StatusLabel.Font = FONT
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.TextStrokeTransparency = 0.5

-- Credit label
local CreditLabel = Instance.new("TextLabel", MainFrame)
CreditLabel.Name = "CreditLabel"
CreditLabel.Size = UDim2.new(1, -24, 0, 20)
CreditLabel.Position = UDim2.new(0, 12, 1, -60)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Designed by @Zeo"
CreditLabel.Font = FONT
CreditLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CreditLabel.TextSize = 14
CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
CreditLabel.TextTransparency = 0.5
CreditLabel.TextStrokeTransparency = 0.7

-- ===== Notification System =====
local NotificationFrame = Instance.new("Frame", ScreenGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0.3, 0, 0, 0)
NotificationFrame.Position = UDim2.new(0.7, 0, 0.02, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, icon, duration)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame", NotificationFrame)
    Container.Name = notificationId
    Container.Size = UDim2.new(1, -20, 0, 70)
    Container.Position = UDim2.new(0, 0, 0, -70)
    Container.BackgroundColor3 = BROWN_BG
    Container.BorderSizePixel = 0
    local containerCorner = Instance.new("UICorner", Container)
    containerCorner.CornerRadius = UDim.new(0, 8)
    local containerStroke = Instance.new("UIStroke", Container)
    containerStroke.Thickness = 2
    containerStroke.Color = BROWN_BORDER
    
    local texture = Instance.new("ImageLabel", Container)
    texture.Size = UDim2.new(1, 0, 1, 0)
    texture.Position = UDim2.new(0, 0, 0, 0)
    texture.BackgroundTransparency = 1
    texture.Image = TILE_IMAGE
    texture.ImageTransparency = 0
    texture.ScaleType = Enum.ScaleType.Tile
    texture.TileSize = UDim2.new(0, 96, 0, 96)
    texture.ZIndex = 1

    local topBar = Instance.new("Frame", Container)
    topBar.Size = UDim2.new(1, 0, 0, 22)
    topBar.BackgroundColor3 = ACCENT_GREEN
    local topBarCorner = Instance.new("UICorner", topBar)
    topBarCorner.CornerRadius = UDim.new(0, 8)

    local topLabel = Instance.new("TextLabel", topBar)
    topLabel.Size = UDim2.new(1, -12, 1, 0)
    topLabel.Position = UDim2.new(0, 6, 0, 0)
    topLabel.BackgroundTransparency = 1
    topLabel.Text = title
    topLabel.Font = FONT
    topLabel.TextColor3 = Color3.new(1, 1, 1)
    topLabel.TextStrokeTransparency = 0
    topLabel.TextScaled = true
    topLabel.TextXAlignment = Enum.TextXAlignment.Left
    topLabel.ZIndex = 2

    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Name = "Message"
    MessageLabel.Size = UDim2.new(1, -10, 1, -22)
    MessageLabel.Position = UDim2.new(0, 5, 0, 22)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    MessageLabel.TextSize = 14
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.Font = FONT
    MessageLabel.TextWrapped = true
    MessageLabel.TextStrokeTransparency = 0.3

    -- Animation
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()

    -- Remove after duration
    delay(duration or 3, function()
        local slideOut = TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0, 0, 0, -70)
        })
        slideOut:Play()
        slideOut.Completed:Wait()
        Container:Destroy()
    end)
end

-- ===== Player Search Functionality =====
local function findPlayer(name)
    if #name < 3 then
        StatusLabel.Text = "Name too short"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
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
    
    StatusLabel.Text = "Player not found"
    StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    return nil
end

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

-- ===== Toggle Functionality =====
local freezeTradeEnabled = false
local autoAcceptEnabled = false
local targetPlayer = nil

local function updateButtonStates()
    -- Visual feedback is handled directly in the toggle switch
end

-- Simulate freeze trade effect
local function freezeTradeEffect(player)
    while freezeTradeEnabled and targetPlayer == player do
        -- In a real implementation, this would freeze the player's trade ability
        StatusLabel.Text = "Freezing trades for "..player.DisplayName
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(0.5)
    end
end

-- Simulate auto accept effect
local function autoAcceptEffect(player)
    while autoAcceptEnabled and targetPlayer == player do
        -- In a real implementation, this would auto-accept trades
        StatusLabel.Text = "Auto accepting for "..player.DisplayName
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(0.5)
    end
end

-- ===== GUI Interactions =====
-- Player search
TextInput:GetPropertyChangedSignal("Text"):Connect(function()
    if #TextInput.Text > 2 then
        local player = findPlayer(TextInput.Text)
        if player then
            -- If we have a new player, reset toggles
            if targetPlayer ~= player then
                freezeTradeEnabled = false
                autoAcceptEnabled = false
                updateButtonStates()
                
                -- Reset toggle positions
                for _, toggle in ipairs(ButtonsFrame:GetChildren()) do
                    if toggle.Name:find("Toggle") then
                        local button = toggle:FindFirstChild("ToggleButton")
                        if button then
                            TweenService:Create(button, TweenInfo.new(0.2), {
                                Position = UDim2.new(0, 2, 0.5, -10),
                                BackgroundColor3 = BUTTON_GRAY
                            }):Play()
                        end
                    end
                end
            end
            
            targetPlayer = player
            updateProfile(player)
            StatusLabel.Text = "Player found: "..player.DisplayName
            StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
        else
            ProfileFrame.Visible = false
            targetPlayer = nil
        end
    else
        ProfileFrame.Visible = false
        targetPlayer = nil
        StatusLabel.Text = "Enter player name to search"
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- Minimize toggle
local minimized = false
MinimizeButton.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        for _, v in pairs(MainFrame:GetChildren()) do
            if v:IsA("GuiObject") and v ~= TitleBar then
                v.Visible = false
            end
        end
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 40)}):Play()
        MinimizeButton.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 380)}):Play()
        for _, v in pairs(MainFrame:GetChildren()) do
            if v:IsA("GuiObject") and v ~= TitleBar then
                v.Visible = true
            end
        end
        MinimizeButton.Text = "-"
    end
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag functionality
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

-- Button hover effects
MinimizeButton.MouseEnter:Connect(function() 
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(220, 220, 220) 
end)
MinimizeButton.MouseLeave:Connect(function() 
    MinimizeButton.BackgroundColor3 = BUTTON_GRAY 
end)

CloseButton.MouseEnter:Connect(function() 
    CloseButton.BackgroundColor3 = Color3.fromRGB(220, 62, 62) 
end)
CloseButton.MouseLeave:Connect(function() 
    CloseButton.BackgroundColor3 = BUTTON_RED 
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        targetPlayer = nil
        freezeTradeEnabled = false
        autoAcceptEnabled = false
        updateButtonStates()
        ProfileFrame.Visible = false
        StatusLabel.Text = "Player left the game"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
        showNotification("Player Left", player.DisplayName.." left the game", "rbxassetid://3926305904", 3)
        
        -- Reset toggle positions
        for _, toggle in ipairs(ButtonsFrame:GetChildren()) do
            if toggle.Name:find("Toggle") then
                local button = toggle:FindFirstChild("ToggleButton")
                if button then
                    TweenService:Create(button, TweenInfo.new(0.2), {
                        Position = UDim2.new(0, 2, 0.5, -10),
                        BackgroundColor3 = BUTTON_GRAY
                    }):Play()
                end
            end
        end
    end
end)

-- Initial welcome notification
delay(1, function()
    showNotification(
        "Player Search Tool",
        "Search for players and manage trades",
        "rbxassetid://3926307971",
        5
    )
end)
