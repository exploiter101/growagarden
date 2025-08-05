-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, guiName in ipairs({"CustomPanelGui", "IntroLoadingGui", "PlayerSearchGui"}) do
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
local BLUE_TOGGLE = Color3.fromRGB(100, 180, 255)
local BLUE_TOGGLE_HOVER = Color3.fromRGB(130, 210, 255)
local FONT = Enum.Font.FredokaOne
local TILE_IMAGE = "rbxassetid://15910695828"
local MOBILE = UserInputService.TouchEnabled

-- ========== Mobile-Friendly Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "PlayerSearchGui"
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Compact main frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = MOBILE and UDim2.new(0.8, 0, 0, 260) or UDim2.new(0, 280, 0, 260)
MainFrame.Position = MOBILE and UDim2.new(0.5, 0, 0.1, 0) or UDim2.new(0.5, -140, 0.1, 0)
MainFrame.AnchorPoint = MOBILE and Vector2.new(0.5, 0) or Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = BROWN_BG
MainFrame.Active = true
MainFrame.Draggable = true
local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)
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
mainTexture.TileSize = UDim2.new(0, 72, 0, 72)
mainTexture.ZIndex = 1

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.BackgroundColor3 = ACCENT_GREEN
local titleBarCorner = Instance.new("UICorner", TitleBar)
titleBarCorner.CornerRadius = UDim.new(0, 12)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 8, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Trade Manager"
TitleText.Font = FONT
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.TextStrokeTransparency = 0.1

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -26, 0.5, -12)
CloseButton.BackgroundColor3 = BUTTON_RED
CloseButton.Text = "X"
CloseButton.Font = FONT
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.TextSize = 14
CloseButton.ZIndex = 3
local closeStroke = Instance.new("UIStroke", CloseButton)
closeStroke.Color = Color3.fromRGB(107, 0, 0)
closeStroke.Thickness = 1

-- Player dropdown
local DropdownButton = Instance.new("TextButton", MainFrame)
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(1, -16, 0, 32)
DropdownButton.Position = UDim2.new(0, 8, 0, 32)
DropdownButton.BackgroundColor3 = BROWN_LIGHT
DropdownButton.Text = "Select Player ▼"
DropdownButton.Font = FONT
DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DropdownButton.TextSize = 14
local dropCorner = Instance.new("UICorner", DropdownButton)
dropCorner.CornerRadius = UDim.new(0, 6)
local dropStroke = Instance.new("UIStroke", DropdownButton)
dropStroke.Thickness = 1
dropStroke.Color = BROWN_BORDER

-- Dropdown frame
local DropdownFrame = Instance.new("Frame", MainFrame)
DropdownFrame.Name = "DropdownFrame"
DropdownFrame.Size = UDim2.new(1, -16, 0, 120)
DropdownFrame.Position = UDim2.new(0, 8, 0, 68)
DropdownFrame.BackgroundColor3 = BROWN_BG
DropdownFrame.Visible = false
DropdownFrame.ClipsDescendants = true
local dropFrameCorner = Instance.new("UICorner", DropdownFrame)
dropFrameCorner.CornerRadius = UDim.new(0, 6)
local dropFrameStroke = Instance.new("UIStroke", DropdownFrame)
dropFrameStroke.Thickness = 2
dropFrameStroke.Color = BROWN_BORDER

local DropdownScroll = Instance.new("ScrollingFrame", DropdownFrame)
DropdownScroll.Name = "Scroll"
DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
DropdownScroll.BackgroundTransparency = 1
DropdownScroll.ScrollBarThickness = 4
DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIListLayout = Instance.new("UIListLayout", DropdownScroll)
UIListLayout.Padding = UDim.new(0, 4)

-- Feature toggles frame
local TogglesFrame = Instance.new("Frame", MainFrame)
TogglesFrame.Name = "TogglesFrame"
TogglesFrame.Size = UDim2.new(1, -16, 0, 70)
TogglesFrame.Position = UDim2.new(0, 8, 0, 70)
TogglesFrame.BackgroundTransparency = 1

-- Toggle switch function
local function createToggleSwitch(parent, name, position, callback)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Name = name.."Toggle"
    toggleFrame.Size = UDim2.new(0.4, 0, 0, 24)
    toggleFrame.Position = position
    toggleFrame.BackgroundTransparency = 1
    
    local toggleButton = Instance.new("TextButton", toggleFrame)
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(0, 0, 0.5, -10)
    toggleButton.BackgroundColor3 = BUTTON_GRAY
    toggleButton.Text = ""
    local buttonCorner = Instance.new("UICorner", toggleButton)
    buttonCorner.CornerRadius = UDim.new(1, 0)
    local buttonStroke = Instance.new("UIStroke", toggleButton)
    buttonStroke.Thickness = 1
    buttonStroke.Color = BROWN_BORDER
    
    local toggleLabel = Instance.new("TextLabel", toggleFrame)
    toggleLabel.Size = UDim2.new(1, -44, 1, 0)
    toggleLabel.Position = UDim2.new(0, 44, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = name
    toggleLabel.Font = FONT
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.TextSize = 14
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local state = false
    
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        if state then
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = BLUE_TOGGLE
            }):Play()
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
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

-- Create toggle switches
local freezeToggle = createToggleSwitch(TogglesFrame, "Freeze Trade", UDim2.new(0, 0, 0, 0), function(state)
    if not targetPlayer then
        showNotification("Error", "Select a player first!", "rbxassetid://3926305904", 2)
        return
    end
    
    freezeTradeEnabled = state
    if state then
        showNotification("Freeze Active", "Waiting for "..targetPlayer.DisplayName, "rbxassetid://3926307971", 3)
        StatusLabel.Text = "Freeze: Waiting for trade..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    else
        StatusLabel.Text = "Freeze: Disabled"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

local acceptToggle = createToggleSwitch(TogglesFrame, "Auto Accept", UDim2.new(0.5, 0, 0, 0), function(state)
    if not targetPlayer then
        showNotification("Error", "Select a player first!", "rbxassetid://3926305904", 2)
        return
    end
    
    autoAcceptEnabled = state
    if state then
        showNotification("Auto Accept", "Scanning for offers...", "rbxassetid://3926307971", 3)
        StatusLabel.Text = "Auto Accept: Scanning..."
        StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    else
        StatusLabel.Text = "Auto Accept: Disabled"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

-- Status label
local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -16, 0, 20)
StatusLabel.Position = UDim2.new(0, 8, 1, -50)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Select a player to begin"
StatusLabel.Font = FONT
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
StatusLabel.TextSize = 12
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Action buttons
local ButtonsFrame = Instance.new("Frame", MainFrame)
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Size = UDim2.new(1, -16, 0, 30)
ButtonsFrame.Position = UDim2.new(0, 8, 1, -30)
ButtonsFrame.BackgroundTransparency = 1

local TradeButton = Instance.new("TextButton", ButtonsFrame)
TradeButton.Name = "TradeButton"
TradeButton.Size = UDim2.new(0.48, 0, 1, 0)
TradeButton.Position = UDim2.new(0, 0, 0, 0)
TradeButton.BackgroundColor3 = ACCENT_GREEN
TradeButton.Text = "TRADE"
TradeButton.Font = FONT
TradeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TradeButton.TextSize = 14
local tradeCorner = Instance.new("UICorner", TradeButton)
tradeCorner.CornerRadius = UDim.new(0, 6)
local tradeStroke = Instance.new("UIStroke", TradeButton)
tradeStroke.Thickness = 1
tradeStroke.Color = BROWN_BORDER

local ProfileButton = Instance.new("TextButton", ButtonsFrame)
ProfileButton.Name = "ProfileButton"
ProfileButton.Size = UDim2.new(0.48, 0, 1, 0)
ProfileButton.Position = UDim2.new(0.52, 0, 0, 0)
ProfileButton.BackgroundColor3 = BROWN_LIGHT
ProfileButton.Text = "PROFILE"
ProfileButton.Font = FONT
ProfileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileButton.TextSize = 14
local profileCorner = Instance.new("UICorner", ProfileButton)
profileCorner.CornerRadius = UDim.new(0, 6)
local profileStroke = Instance.new("UIStroke", ProfileButton)
profileStroke.Thickness = 1
profileStroke.Color = BROWN_BORDER

-- ===== Notification System =====
local NotificationFrame = Instance.new("Frame", ScreenGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = MOBILE and UDim2.new(0.9, 0, 0, 0) or UDim2.new(0.3, 0, 0, 0)
NotificationFrame.Position = MOBILE and UDim2.new(0.5, 0, 0.02, 0) or UDim2.new(0.7, 0, 0.02, 0)
NotificationFrame.AnchorPoint = MOBILE and Vector2.new(0.5, 0) or Vector2.new(0.5, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, icon, duration)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame", NotificationFrame)
    Container.Name = notificationId
    Container.Size = UDim2.new(1, 0, 0, 60)
    Container.BackgroundColor3 = BROWN_BG
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0, 0, 0, -60)
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
    texture.TileSize = UDim2.new(0, 72, 0, 72)
    texture.ZIndex = 1

    local Icon = Instance.new("ImageLabel", Container)
    Icon.Size = UDim2.new(0, 30, 0, 30)
    Icon.Position = UDim2.new(0, 10, 0.5, -15)
    Icon.BackgroundTransparency = 1
    Icon.Image = icon

    local TitleLabel = Instance.new("TextLabel", Container)
    TitleLabel.Size = UDim2.new(1, -50, 0.5, 0)
    TitleLabel.Position = UDim2.new(0, 50, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = FONT
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.TextStrokeTransparency = 0.3

    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Size = UDim2.new(1, -50, 0.5, 0)
    MessageLabel.Position = UDim2.new(0, 50, 0.5, 0)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    MessageLabel.TextSize = 14
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.Font = FONT

    -- Animation
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()

    -- Remove after duration
    delay(duration or 3, function()
        local slideOut = TweenService:Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Position = UDim2.new(0, 0, 0, -60)
        })
        slideOut:Play()
        slideOut.Completed:Wait()
        Container:Destroy()
    end)
end

-- ===== Player Dropdown Functionality =====
local targetPlayer = nil
local freezeTradeEnabled = false
local autoAcceptEnabled = false

local function createPlayerEntry(player)
    local entry = Instance.new("TextButton", DropdownScroll)
    entry.Name = player.Name
    entry.Size = UDim2.new(1, 0, 0, 28)
    entry.BackgroundColor3 = BROWN_LIGHT
    entry.Text = ""
    local entryCorner = Instance.new("UICorner", entry)
    entryCorner.CornerRadius = UDim.new(0, 4)
    local entryStroke = Instance.new("UIStroke", entry)
    entryStroke.Thickness = 1
    entryStroke.Color = BROWN_BORDER

    local DisplayName = Instance.new("TextLabel", entry)
    DisplayName.Size = UDim2.new(0.7, 0, 1, 0)
    DisplayName.Position = UDim2.new(0, 8, 0, 0)
    DisplayName.BackgroundTransparency = 1
    DisplayName.Text = player.DisplayName
    DisplayName.Font = FONT
    DisplayName.TextColor3 = Color3.fromRGB(255, 255, 255)
    DisplayName.TextSize = 14
    DisplayName.TextXAlignment = Enum.TextXAlignment.Left

    local Username = Instance.new("TextLabel", entry)
    Username.Size = UDim2.new(0.3, -8, 1, 0)
    Username.Position = UDim2.new(0.7, 0, 0, 0)
    Username.BackgroundTransparency = 1
    Username.Text = "@"..player.Name
    Username.Font = FONT
    Username.TextColor3 = Color3.fromRGB(200, 200, 200)
    Username.TextSize = 12
    Username.TextXAlignment = Enum.TextXAlignment.Right

    entry.MouseButton1Click:Connect(function()
        targetPlayer = player
        DropdownButton.Text = player.DisplayName
        DropdownFrame.Visible = false
        StatusLabel.Text = "Selected: "..player.DisplayName
        StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    end)
    
    return entry
end

local function updatePlayerList()
    for _, child in ipairs(DropdownScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createPlayerEntry(player)
        end
    end
    
    -- Update canvas size
    local entryCount = #Players:GetPlayers() - 1
    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, entryCount * 32)
end

-- ===== GUI Interactions =====
-- Toggle dropdown
DropdownButton.MouseButton1Click:Connect(function()
    DropdownFrame.Visible = not DropdownFrame.Visible
    if DropdownFrame.Visible then
        DropdownButton.Text = "Select Player ▲"
        updatePlayerList()
    else
        DropdownButton.Text = "Select Player ▼"
    end
end)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Trade button
TradeButton.MouseButton1Click:Connect(function()
    if not targetPlayer then
        showNotification("Error", "Select a player first!", "rbxassetid://3926305904", 2)
        return
    end
    
    showNotification("Trade Request", "Sent to "..targetPlayer.DisplayName, "rbxassetid://3926307971", 3)
    StatusLabel.Text = "Trade request sent!"
    StatusLabel.TextColor3 = ACCENT_GREEN
end)

-- Profile button
ProfileButton.MouseButton1Click:Connect(function()
    if not targetPlayer then
        showNotification("Error", "Select a player first!", "rbxassetid://3926305904", 2)
        return
    end
    
    showNotification("Profile", "Viewing "..targetPlayer.DisplayName, "rbxassetid://3926307971", 3)
    StatusLabel.Text = "Profile opened"
    StatusLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        targetPlayer = nil
        freezeTradeEnabled = false
        autoAcceptEnabled = false
        DropdownButton.Text = "Select Player ▼"
        StatusLabel.Text = "Player left - select another"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
        showNotification("Player Left", player.DisplayName.." left", "rbxassetid://3926305904", 3)
        
        -- Reset toggles
        for _, toggle in ipairs(TogglesFrame:GetChildren()) do
            if toggle.Name:find("Toggle") then
                local button = toggle:FindFirstChild("ToggleButton")
                if button then
                    button.BackgroundColor3 = BUTTON_GRAY
                end
            end
        end
    end
    updatePlayerList()
end)

-- Initial setup
Players.PlayerAdded:Connect(updatePlayerList)
updatePlayerList()

-- Initial welcome notification
delay(1, function()
    showNotification(
        "Trade Manager",
        "Select a player to begin",
        "rbxassetid://3926307971",
        4
    )
end)

-- Mobile drag handle
if MOBILE then
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            local dragStart = input.Position
            local startPos = MainFrame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    connection:Disconnect()
                else
                    local delta = input.Position - dragStart
                    MainFrame.Position = UDim2.new(
                        startPos.X.Scale, 
                        startPos.X.Offset + delta.X, 
                        startPos.Y.Scale, 
                        startPos.Y.Offset + delta.Y
                    )
                end
            end)
        end
    end)
end

-- Simulate trade detection
local function simulateTradeDetection()
    while true do
        if targetPlayer and (freezeTradeEnabled or autoAcceptEnabled) then
            -- Random chance to detect a "trade"
            if math.random(1, 100) > 85 then
                if freezeTradeEnabled then
                    StatusLabel.Text = "Trade frozen with "..targetPlayer.DisplayName
                    StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                    showNotification("Trade Frozen", "Blocked trade attempt", "rbxassetid://3926305904", 3)
                end
                
                if autoAcceptEnabled then
                    StatusLabel.Text = "Trade accepted with "..targetPlayer.DisplayName
                    StatusLabel.TextColor3 = ACCENT_GREEN
                    showNotification("Trade Accepted", "Completed with "..targetPlayer.DisplayName, "rbxassetid://3926307971", 3)
                end
            end
        end
        wait(2)
    end
end

task.spawn(simulateTradeDetection)
