-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, gui in ipairs(PlayerGui:GetChildren()) do
    if gui.Name == "AntiTradeGui" or gui.Name == "NotificationGui" then
        gui:Destroy()
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

-- ========== Create Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AntiTradeGui"
ScreenGui.DisplayOrder = 10
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = MOBILE and UDim2.new(0.9, 0, 0, 300) or UDim2.new(0, 350, 0, 300)
MainFrame.Position = MOBILE and UDim2.new(0.5, 0, 0.1, 0) or UDim2.new(0.5, -175, 0.1, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0)
MainFrame.BackgroundColor3 = BROWN_BG
MainFrame.Active = true
MainFrame.Draggable = not MOBILE
local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", MainFrame)
mainStroke.Thickness = 2
mainStroke.Color = BROWN_BORDER

-- Add tile texture
local tileTexture = Instance.new("ImageLabel", MainFrame)
tileTexture.Size = UDim2.new(1, 0, 1, 0)
tileTexture.BackgroundTransparency = 1
tileTexture.Image = TILE_IMAGE
tileTexture.ImageTransparency = 0.1
tileTexture.ScaleType = Enum.ScaleType.Tile
tileTexture.TileSize = UDim2.new(0, 96, 0, 96)

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = ACCENT_GREEN
local titleBarCorner = Instance.new("UICorner", TitleBar)
titleBarCorner.CornerRadius = UDim.new(0, 12, 0, 0)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Anti-Trade Exploit"
TitleText.Font = FONT
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 26, 0, 26)
CloseButton.Position = UDim2.new(1, -28, 0.5, -13)
CloseButton.BackgroundColor3 = BUTTON_RED
CloseButton.Text = "×"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextSize = 20
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(1, 0)
local closeStroke = Instance.new("UIStroke", CloseButton)
closeStroke.Thickness = 1
closeStroke.Color = Color3.fromRGB(150, 0, 0)

-- Description label
local Description = Instance.new("TextLabel", MainFrame)
Description.Size = UDim2.new(1, -20, 0, 60)
Description.Position = UDim2.new(0, 10, 0, 38)
Description.BackgroundTransparency = 1
Description.Text = "Protect against trade exploits by selecting a player and activating anti-features"
Description.Font = FONT
Description.TextColor3 = Color3.new(1, 1, 1)
Description.TextSize = 14
Description.TextWrapped = true
Description.TextXAlignment = Enum.TextXAlignment.Left

-- Player selection
local DropdownButton = Instance.new("TextButton", MainFrame)
DropdownButton.Name = "DropdownButton"
DropdownButton.Size = UDim2.new(1, -20, 0, 36)
DropdownButton.Position = UDim2.new(0, 10, 0, 105)
DropdownButton.BackgroundColor3 = BROWN_LIGHT
DropdownButton.Text = "Select Player ▼"
DropdownButton.Font = FONT
DropdownButton.TextColor3 = Color3.new(1, 1, 1)
DropdownButton.TextSize = 16
local dropCorner = Instance.new("UICorner", DropdownButton)
dropCorner.CornerRadius = UDim.new(0, 6)
local dropStroke = Instance.new("UIStroke", DropdownButton)
dropStroke.Thickness = 1
dropStroke.Color = BROWN_BORDER

-- Player dropdown
local DropdownFrame = Instance.new("Frame", MainFrame)
DropdownFrame.Name = "DropdownFrame"
DropdownFrame.Size = UDim2.new(1, -20, 0, 120)
DropdownFrame.Position = UDim2.new(0, 10, 0, 145)
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
DropdownScroll.ScrollBarThickness = 6
DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIListLayout = Instance.new("UIListLayout", DropdownScroll)
UIListLayout.Padding = UDim.new(0, 4)

-- Toggles frame
local TogglesFrame = Instance.new("Frame", MainFrame)
TogglesFrame.Name = "TogglesFrame"
TogglesFrame.Size = UDim2.new(1, -20, 0, 80)
TogglesFrame.Position = UDim2.new(0, 10, 0, 145)
TogglesFrame.BackgroundTransparency = 1

-- Toggle switch function
local function createToggleSwitch(parent, name, position, callback)
    local toggleFrame = Instance.new("Frame", parent)
    toggleFrame.Name = name.."Toggle"
    toggleFrame.Size = UDim2.new(0.45, 0, 0, 30)
    toggleFrame.Position = position
    toggleFrame.BackgroundTransparency = 1
    
    local toggleLabel = Instance.new("TextLabel", toggleFrame)
    toggleLabel.Size = UDim2.new(1, -50, 1, 0)
    toggleLabel.Position = UDim2.new(0, 0, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = name
    toggleLabel.Font = FONT
    toggleLabel.TextColor3 = Color3.new(1, 1, 1)
    toggleLabel.TextSize = 16
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleContainer = Instance.new("Frame", toggleFrame)
    toggleContainer.Size = UDim2.new(0, 44, 0, 20)
    toggleContainer.Position = UDim2.new(1, -44, 0.5, -10)
    toggleContainer.BackgroundColor3 = BROWN_LIGHT
    local containerCorner = Instance.new("UICorner", toggleContainer)
    containerCorner.CornerRadius = UDim.new(1, 0)
    local containerStroke = Instance.new("UIStroke", toggleContainer)
    containerStroke.Thickness = 1
    containerStroke.Color = BROWN_BORDER
    
    local toggleButton = Instance.new("TextButton", toggleContainer)
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 16, 0, 16)
    toggleButton.Position = UDim2.new(0, 2, 0.5, -8)
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
                Position = UDim2.new(0, 26, 0.5, -8),
                BackgroundColor3 = BLUE_TOGGLE
            }):Play()
        else
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -8),
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
    
    return {Frame = toggleFrame, Button = toggleButton, State = function() return state end}
end

-- Create toggle switches
local antiFreezeToggle = createToggleSwitch(TogglesFrame, "Anti-Freeze", UDim2.new(0, 0, 0, 0), function(state)
    if not targetPlayer then
        showNotification("Error", "Select a player first!", "rbxassetid://6031094677", 2)
        return
    end
    
    antiFreezeEnabled = state
    if state then
        showNotification("Anti-Freeze", "Enabled for "..targetPlayer.DisplayName, "rbxassetid://6031094677", 3)
        StatusLabel.Text = "Anti-Freeze: Active"
        StatusLabel.TextColor3 = BLUE_TOGGLE
        startAntiFreeze()
    else
        StatusLabel.Text = "Anti-Freeze: Disabled"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

local antiAcceptToggle = createToggleSwitch(TogglesFrame, "Anti-Auto Accept", UDim2.new(0.55, 0, 0, 0), function(state)
    if not targetPlayer then
        showNotification("Error", "Select a player first!", "rbxassetid://6031094677", 2)
        return
    end
    
    antiAcceptEnabled = state
    if state then
        showNotification("Anti-Auto Accept", "Enabled for "..targetPlayer.DisplayName, "rbxassetid://6031094677", 3)
        StatusLabel.Text = "Anti-Auto Accept: Active"
        StatusLabel.TextColor3 = ACCENT_GREEN
        startAntiAutoAccept()
    else
        StatusLabel.Text = "Anti-Auto Accept: Disabled"
        StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

-- Settings buttons
local function createSettingsButton(parent, name, position)
    local button = Instance.new("TextButton", parent)
    button.Name = name.."Settings"
    button.Size = UDim2.new(0, 30, 0, 30)
    button.Position = position
    button.BackgroundColor3 = BROWN_LIGHT
    button.Text = "⚙️"
    button.Font = Enum.Font.Gotham
    button.TextSize = 16
    local buttonCorner = Instance.new("UICorner", button)
    buttonCorner.CornerRadius = UDim.new(0, 6)
    local buttonStroke = Instance.new("UIStroke", button)
    buttonStroke.Thickness = 1
    buttonStroke.Color = BROWN_BORDER
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(184, 117, 53)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = BROWN_LIGHT
    end)
    
    return button
end

-- Create settings buttons
local antiFreezeSettings = createSettingsButton(TogglesFrame, "AntiFreeze", UDim2.new(0, 180, 0, 0))
local antiAcceptSettings = createSettingsButton(TogglesFrame, "AntiAccept", UDim2.new(0.55, 180, 0, 0))

-- Status label
local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 24)
StatusLabel.Position = UDim2.new(0, 10, 1, -30)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Select a player to begin"
StatusLabel.Font = FONT
StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- ========== Settings Modal ==========
local ModalFrame = Instance.new("Frame", ScreenGui)
ModalFrame.Name = "SettingsModal"
ModalFrame.Size = UDim2.new(0, 280, 0, 180)
ModalFrame.Position = UDim2.new(0.5, -140, 0.5, -90)
ModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ModalFrame.BackgroundColor3 = BROWN_BG
ModalFrame.Visible = false
local modalCorner = Instance.new("UICorner", ModalFrame)
modalCorner.CornerRadius = UDim.new(0, 12)
local modalStroke = Instance.new("UIStroke", ModalFrame)
modalStroke.Thickness = 2
modalStroke.Color = BROWN_BORDER

local ModalTitle = Instance.new("TextLabel", ModalFrame)
ModalTitle.Size = UDim2.new(1, 0, 0, 40)
ModalTitle.Position = UDim2.new(0, 0, 0, 0)
ModalTitle.BackgroundColor3 = ACCENT_GREEN
ModalTitle.Text = "Duration Settings"
ModalTitle.Font = FONT
ModalTitle.TextColor3 = Color3.new(1, 1, 1)
ModalTitle.TextSize = 18
local titleCorner = Instance.new("UICorner", ModalTitle)
titleCorner.CornerRadius = UDim.new(0, 12, 0, 0)

local DurationLabel = Instance.new("TextLabel", ModalFrame)
DurationLabel.Size = UDim2.new(1, -20, 0, 30)
DurationLabel.Position = UDim2.new(0, 10, 0, 50)
DurationLabel.BackgroundTransparency = 1
DurationLabel.Text = "Set duration in seconds:"
DurationLabel.Font = FONT
DurationLabel.TextColor3 = Color3.new(1, 1, 1)
DurationLabel.TextSize = 16
DurationLabel.TextXAlignment = Enum.TextXAlignment.Left

local DurationInput = Instance.new("TextBox", ModalFrame)
DurationInput.Size = UDim2.new(1, -20, 0, 36)
DurationInput.Position = UDim2.new(0, 10, 0, 85)
DurationInput.BackgroundColor3 = BROWN_LIGHT
DurationInput.PlaceholderText = "Enter duration (seconds)"
DurationInput.Text = "30"
DurationInput.TextColor3 = Color3.new(1, 1, 1)
DurationInput.TextSize = 16
DurationInput.Font = FONT
local inputCorner = Instance.new("UICorner", DurationInput)
inputCorner.CornerRadius = UDim.new(0, 6)
local inputStroke = Instance.new("UIStroke", DurationInput)
inputStroke.Thickness = 1
inputStroke.Color = BROWN_BORDER

local ConfirmButton = Instance.new("TextButton", ModalFrame)
ConfirmButton.Size = UDim2.new(0.4, 0, 0, 30)
ConfirmButton.Position = UDim2.new(0.1, 0, 1, -40)
ConfirmButton.BackgroundColor3 = ACCENT_GREEN
ConfirmButton.Text = "CONFIRM"
ConfirmButton.Font = FONT
ConfirmButton.TextColor3 = Color3.new(1, 1, 1)
ConfirmButton.TextSize = 16
local confirmCorner = Instance.new("UICorner", ConfirmButton)
confirmCorner.CornerRadius = UDim.new(0, 6)

local CancelButton = Instance.new("TextButton", ModalFrame)
CancelButton.Size = UDim2.new(0.4, 0, 0, 30)
CancelButton.Position = UDim2.new(0.55, 0, 1, -40)
CancelButton.BackgroundColor3 = BROWN_LIGHT
CancelButton.Text = "CANCEL"
CancelButton.Font = FONT
CancelButton.TextColor3 = Color3.new(1, 1, 1)
CancelButton.TextSize = 16
local cancelCorner = Instance.new("UICorner", CancelButton)
cancelCorner.CornerRadius = UDim.new(0, 6)

-- ========== Notification System ==========
local NotificationGui = Instance.new("ScreenGui", PlayerGui)
NotificationGui.Name = "NotificationGui"
NotificationGui.DisplayOrder = 20
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationFrame = Instance.new("Frame", NotificationGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = MOBILE and UDim2.new(0.9, 0, 0, 0) or UDim2.new(0, 280, 0, 0)
NotificationFrame.Position = MOBILE and UDim2.new(0.5, 0, 0.02, 0) or UDim2.new(0.5, -140, 0.02, 0)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, icon, duration)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame", NotificationFrame)
    Container.Name = notificationId
    Container.Size = UDim2.new(1, 0, 0, 70)
    Container.BackgroundColor3 = BROWN_BG
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0, 0, 0, -70)
    local containerCorner = Instance.new("UICorner", Container)
    containerCorner.CornerRadius = UDim.new(0, 8)
    local containerStroke = Instance.new("UIStroke", Container)
    containerStroke.Thickness = 2
    containerStroke.Color = BROWN_BORDER

    local Icon = Instance.new("ImageLabel", Container)
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 10, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Image = icon

    local TitleLabel = Instance.new("TextLabel", Container)
    TitleLabel.Size = UDim2.new(1, -60, 0.5, 0)
    TitleLabel.Position = UDim2.new(0, 60, 0, 10)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = FONT
    TitleLabel.TextColor3 = Color3.new(1, 1, 1)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Size = UDim2.new(1, -60, 0.5, 0)
    MessageLabel.Position = UDim2.new(0, 60, 0.5, 0)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    MessageLabel.TextSize = 16
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.Font = FONT

    -- Animation
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.3), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()

    -- Remove after duration
    task.delay(duration or 3, function()
        local slideOut = TweenService:Create(Container, TweenInfo.new(0.3), {
            Position = UDim2.new(0, 0, 0, -70)
        })
        slideOut:Play()
        slideOut.Completed:Wait()
        Container:Destroy()
    end)
end

-- ========== Player Management ==========
local targetPlayer = nil
local antiFreezeEnabled = false
local antiAcceptEnabled = false
local antiFreezeDuration = 30  -- Default duration in seconds
local antiAcceptDuration = 30  -- Default duration in seconds

local function createPlayerEntry(player)
    local entry = Instance.new("TextButton", DropdownScroll)
    entry.Name = player.Name
    entry.Size = UDim2.new(1, -8, 0, 30)
    entry.Position = UDim2.new(0, 4, 0, 0)
    entry.BackgroundColor3 = BROWN_LIGHT
    entry.Text = ""
    entry.AutoButtonColor = false
    local entryCorner = Instance.new("UICorner", entry)
    entryCorner.CornerRadius = UDim.new(0, 4)
    local entryStroke = Instance.new("UIStroke", entry)
    entryStroke.Thickness = 1
    entryStroke.Color = BROWN_BORDER

    local DisplayName = Instance.new("TextLabel", entry)
    DisplayName.Size = UDim2.new(0.7, 0, 1, 0)
    DisplayName.Position = UDim2.new(0, 10, 0, 0)
    DisplayName.BackgroundTransparency = 1
    DisplayName.Text = player.DisplayName
    DisplayName.Font = FONT
    DisplayName.TextColor3 = Color3.new(1, 1, 1)
    DisplayName.TextSize = 16
    DisplayName.TextXAlignment = Enum.TextXAlignment.Left

    local Username = Instance.new("TextLabel", entry)
    Username.Size = UDim2.new(0.3, -10, 1, 0)
    Username.Position = UDim2.new(0.7, 0, 0, 0)
    Username.BackgroundTransparency = 1
    Username.Text = "@"..player.Name
    Username.Font = FONT
    Username.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    Username.TextSize = 14
    Username.TextXAlignment = Enum.TextXAlignment.Right

    -- Highlight on hover
    entry.MouseEnter:Connect(function()
        entry.BackgroundColor3 = Color3.fromRGB(140, 80, 35)
    end)
    
    entry.MouseLeave:Connect(function()
        entry.BackgroundColor3 = BROWN_LIGHT
    end)

    -- Select player on click
    entry.MouseButton1Click:Connect(function()
        targetPlayer = player
        DropdownButton.Text = player.DisplayName
        DropdownFrame.Visible = false
        StatusLabel.Text = "Selected: "..player.DisplayName
        StatusLabel.TextColor3 = ACCENT_GREEN
    end)
    
    return entry
end

local function updatePlayerList()
    -- Clear existing entries
    for _, child in ipairs(DropdownScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Create new entries
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createPlayerEntry(player)
        end
    end
    
    -- Update canvas size
    local entryCount = #Players:GetPlayers() - 1
    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, entryCount * 34)
end

-- ========== Anti-Exploit Functions ==========
local function startAntiFreeze()
    if not targetPlayer then return end
    
    showNotification("Anti-Freeze", "Protecting against freeze exploits ("..antiFreezeDuration.."s)", "rbxassetid://6031094677", 3)
    
    -- Simulate protection
    local endTime = tick() + antiFreezeDuration
    while tick() < endTime and antiFreezeEnabled do
        StatusLabel.Text = string.format("Anti-Freeze: Active (%d sec left)", math.ceil(endTime - tick()))
        task.wait(1)
    end
    
    if antiFreezeEnabled then
        antiFreezeEnabled = false
        antiFreezeToggle.Button.BackgroundColor3 = BUTTON_GRAY
        antiFreezeToggle.Button.Position = UDim2.new(0, 2, 0.5, -8)
        StatusLabel.Text = "Anti-Freeze: Expired"
        showNotification("Anti-Freeze", "Protection expired for "..targetPlayer.DisplayName, "rbxassetid://6031094677", 3)
    end
end

local function startAntiAutoAccept()
    if not targetPlayer then return end
    
    showNotification("Anti-Auto Accept", "Protecting against auto-accept ("..antiAcceptDuration.."s)", "rbxassetid://6031094677", 3)
    
    -- Simulate protection
    local endTime = tick() + antiAcceptDuration
    while tick() < endTime and antiAcceptEnabled do
        StatusLabel.Text = string.format("Anti-Auto Accept: Active (%d sec left)", math.ceil(endTime - tick()))
        task.wait(1)
    end
    
    if antiAcceptEnabled then
        antiAcceptEnabled = false
        antiAcceptToggle.Button.BackgroundColor3 = BUTTON_GRAY
        antiAcceptToggle.Button.Position = UDim2.new(0, 2, 0.5, -8)
        StatusLabel.Text = "Anti-Auto Accept: Expired"
        showNotification("Anti-Auto Accept", "Protection expired for "..targetPlayer.DisplayName, "rbxassetid://6031094677", 3)
    end
end

-- ========== GUI Interactions ==========
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
    NotificationGui:Destroy()
end)

-- Settings buttons
antiFreezeSettings.MouseButton1Click:Connect(function()
    ModalFrame.Visible = true
    ModalTitle.Text = "Anti-Freeze Duration"
    currentSetting = "AntiFreeze"
    DurationInput.Text = tostring(antiFreezeDuration)
end)

antiAcceptSettings.MouseButton1Click:Connect(function()
    ModalFrame.Visible = true
    ModalTitle.Text = "Anti-Auto Accept Duration"
    currentSetting = "AntiAccept"
    DurationInput.Text = tostring(antiAcceptDuration)
end)

-- Modal buttons
ConfirmButton.MouseButton1Click:Connect(function()
    local duration = tonumber(DurationInput.Text)
    if duration and duration > 0 then
        if currentSetting == "AntiFreeze" then
            antiFreezeDuration = duration
            showNotification("Duration Set", "Anti-Freeze: "..duration.." seconds", "rbxassetid://6031094677", 3)
        elseif currentSetting == "AntiAccept" then
            antiAcceptDuration = duration
            showNotification("Duration Set", "Anti-Auto Accept: "..duration.." seconds", "rbxassetid://6031094677", 3)
        end
    else
        showNotification("Error", "Invalid duration value", "rbxassetid://6031094677", 3)
    end
    ModalFrame.Visible = false
end)

CancelButton.MouseButton1Click:Connect(function()
    ModalFrame.Visible = false
end)

-- Handle player leaving
Players.PlayerRemoving:Connect(function(player)
    if player == targetPlayer then
        targetPlayer = nil
        DropdownButton.Text = "Select Player ▼"
        StatusLabel.Text = "Player left - select another"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
        showNotification("Player Left", player.DisplayName.." left", "rbxassetid://6031094677", 3)
        
        -- Reset toggles
        antiFreezeEnabled = false
        antiAcceptEnabled = false
        antiFreezeToggle.Button.BackgroundColor3 = BUTTON_GRAY
        antiFreezeToggle.Button.Position = UDim2.new(0, 2, 0.5, -8)
        antiAcceptToggle.Button.BackgroundColor3 = BUTTON_GRAY
        antiAcceptToggle.Button.Position = UDim2.new(0, 2, 0.5, -8)
    end
end)

-- Initialize player list
Players.PlayerAdded:Connect(updatePlayerList)
updatePlayerList()

-- Initial welcome notification
task.delay(1, function()
    showNotification(
        "Anti-Trade Exploit",
        "Select a player and set protection durations",
        "rbxassetid://6031094677",
        4
    )
end)

-- Mobile drag functionality
if MOBILE then
    local dragging = false
    local dragStart, startPos
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
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
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
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
