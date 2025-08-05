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
local DARK_BG = Color3.fromRGB(30, 30, 40)
local CARD_BG = Color3.fromRGB(45, 45, 60)
local ACCENT_BLUE = Color3.fromRGB(70, 130, 200)
local ACCENT_GREEN = Color3.fromRGB(80, 200, 120)
local ACCENT_RED = Color3.fromRGB(220, 80, 80)
local TEXT_MAIN = Color3.fromRGB(240, 240, 240)
local TEXT_SECONDARY = Color3.fromRGB(180, 180, 200)
local TOGGLE_ON = ACCENT_BLUE
local TOGGLE_OFF = Color3.fromRGB(100, 100, 120)
local FONT = Enum.Font.Gotham
local SHADOW_COLOR = Color3.fromRGB(20, 20, 30)

-- ========== Create Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "AntiTradeGui"
ScreenGui.DisplayOrder = 10
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Compact main frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 260, 0, 140)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = DARK_BG
MainFrame.Active = true
MainFrame.Draggable = true
local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 8)
local mainShadow = Instance.new("ImageLabel", MainFrame)
mainShadow.Name = "Shadow"
mainShadow.Size = UDim2.new(1, 10, 1, 10)
mainShadow.Position = UDim2.new(0, -5, 0, -5)
mainShadow.BackgroundTransparency = 1
mainShadow.Image = "rbxassetid://1316045217"
mainShadow.ImageColor3 = SHADOW_COLOR
mainShadow.ImageTransparency = 0.2
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(10, 10, 118, 118)
mainShadow.ZIndex = -1

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 28)
TitleBar.BackgroundColor3 = CARD_BG
local titleBarCorner = Instance.new("UICorner", TitleBar)
titleBarCorner.CornerRadius = UDim.new(0, 8, 0, 0)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(0.7, 0, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TRADE PROTECTION"
TitleText.Font = FONT
TitleText.TextColor3 = TEXT_MAIN
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -28, 0.5, -12)
CloseButton.BackgroundColor3 = ACCENT_RED
CloseButton.Text = "×"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = TEXT_MAIN
CloseButton.TextSize = 18
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(1, 0)

-- ========== Protection Boxes ==========
-- Anti-Freeze Box
local AntiFreezeBox = Instance.new("Frame", MainFrame)
AntiFreezeBox.Name = "AntiFreezeBox"
AntiFreezeBox.Size = UDim2.new(0.45, -10, 0, 70)
AntiFreezeBox.Position = UDim2.new(0, 10, 0, 35)
AntiFreezeBox.BackgroundColor3 = CARD_BG
local boxCorner = Instance.new("UICorner", AntiFreezeBox)
boxCorner.CornerRadius = UDim.new(0, 6)

-- Box header
local FreezeIcon = Instance.new("ImageLabel", AntiFreezeBox)
FreezeIcon.Size = UDim2.new(0, 24, 0, 24)
FreezeIcon.Position = UDim2.new(0.5, -12, 0, 8)
FreezeIcon.BackgroundTransparency = 1
FreezeIcon.Image = "rbxassetid://3926305904" -- Snowflake icon
FreezeIcon.ImageColor3 = TEXT_MAIN

-- Toggle switch
local FreezeToggle = Instance.new("Frame", AntiFreezeBox)
FreezeToggle.Name = "Toggle"
FreezeToggle.Size = UDim2.new(0, 40, 0, 20)
FreezeToggle.Position = UDim2.new(0.5, -20, 1, -28)
FreezeToggle.BackgroundColor3 = TOGGLE_OFF
local toggleCorner = Instance.new("UICorner", FreezeToggle)
toggleCorner.CornerRadius = UDim.new(1, 0)

local ToggleButton = Instance.new("TextButton", FreezeToggle)
ToggleButton.Name = "Button"
ToggleButton.Size = UDim2.new(0, 16, 0, 16)
ToggleButton.Position = UDim2.new(0, 2, 0.5, -8)
ToggleButton.BackgroundColor3 = TEXT_MAIN
ToggleButton.Text = ""
local buttonCorner = Instance.new("UICorner", ToggleButton)
buttonCorner.CornerRadius = UDim.new(1, 0)

-- Settings button
local FreezeSettings = Instance.new("TextButton", AntiFreezeBox)
FreezeSettings.Name = "SettingsButton"
FreezeSettings.Size = UDim2.new(0, 24, 0, 24)
FreezeSettings.Position = UDim2.new(1, -28, 0, 8)
FreezeSettings.BackgroundTransparency = 1
FreezeSettings.Text = "⚙️"
FreezeSettings.Font = Enum.Font.Gotham
FreezeSettings.TextSize = 14
FreezeSettings.TextColor3 = TEXT_MAIN

-- Status label
local FreezeStatus = Instance.new("TextLabel", AntiFreezeBox)
FreezeStatus.Size = UDim2.new(1, -10, 0, 16)
FreezeStatus.Position = UDim2.new(0, 5, 1, -40)
FreezeStatus.BackgroundTransparency = 1
FreezeStatus.Text = "Inactive"
FreezeStatus.Font = FONT
FreezeStatus.TextColor3 = TEXT_SECONDARY
FreezeStatus.TextSize = 12
FreezeStatus.TextXAlignment = Enum.TextXAlignment.Center

-- Anti-Auto Accept Box
local AntiAcceptBox = Instance.new("Frame", MainFrame)
AntiAcceptBox.Name = "AntiAcceptBox"
AntiAcceptBox.Size = UDim2.new(0.45, -10, 0, 70)
AntiAcceptBox.Position = UDim2.new(1, -120, 0, 35)
AntiAcceptBox.BackgroundColor3 = CARD_BG
local boxCorner2 = Instance.new("UICorner", AntiAcceptBox)
boxCorner2.CornerRadius = UDim.new(0, 6)

-- Box header
local AcceptIcon = Instance.new("ImageLabel", AntiAcceptBox)
AcceptIcon.Size = UDim2.new(0, 24, 0, 24)
AcceptIcon.Position = UDim2.new(0.5, -12, 0, 8)
AcceptIcon.BackgroundTransparency = 1
AcceptIcon.Image = "rbxassetid://3926307971" -- Checkmark icon
AcceptIcon.ImageColor3 = TEXT_MAIN

-- Toggle switch
local AcceptToggle = Instance.new("Frame", AntiAcceptBox)
AcceptToggle.Name = "Toggle"
AcceptToggle.Size = UDim2.new(0, 40, 0, 20)
AcceptToggle.Position = UDim2.new(0.5, -20, 1, -28)
AcceptToggle.BackgroundColor3 = TOGGLE_OFF
local toggleCorner2 = Instance.new("UICorner", AcceptToggle)
toggleCorner2.CornerRadius = UDim.new(1, 0)

local ToggleButton2 = Instance.new("TextButton", AcceptToggle)
ToggleButton2.Name = "Button"
ToggleButton2.Size = UDim2.new(0, 16, 0, 16)
ToggleButton2.Position = UDim2.new(0, 2, 0.5, -8)
ToggleButton2.BackgroundColor3 = TEXT_MAIN
ToggleButton2.Text = ""
local buttonCorner2 = Instance.new("UICorner", ToggleButton2)
buttonCorner2.CornerRadius = UDim.new(1, 0)

-- Settings button
local AcceptSettings = Instance.new("TextButton", AntiAcceptBox)
AcceptSettings.Name = "SettingsButton"
AcceptSettings.Size = UDim2.new(0, 24, 0, 24)
AcceptSettings.Position = UDim2.new(1, -28, 0, 8)
AcceptSettings.BackgroundTransparency = 1
AcceptSettings.Text = "⚙️"
AcceptSettings.Font = Enum.Font.Gotham
AcceptSettings.TextSize = 14
AcceptSettings.TextColor3 = TEXT_MAIN

-- Status label
local AcceptStatus = Instance.new("TextLabel", AntiAcceptBox)
AcceptStatus.Size = UDim2.new(1, -10, 0, 16)
AcceptStatus.Position = UDim2.new(0, 5, 1, -40)
AcceptStatus.BackgroundTransparency = 1
AcceptStatus.Text = "Inactive"
AcceptStatus.Font = FONT
AcceptStatus.TextColor3 = TEXT_SECONDARY
AcceptStatus.TextSize = 12
AcceptStatus.TextXAlignment = Enum.TextXAlignment.Center

-- Global status
local GlobalStatus = Instance.new("TextLabel", MainFrame)
GlobalStatus.Size = UDim2.new(1, -20, 0, 18)
GlobalStatus.Position = UDim2.new(0, 10, 1, -22)
GlobalStatus.BackgroundTransparency = 1
GlobalStatus.Text = "Protections inactive"
GlobalStatus.Font = FONT
GlobalStatus.TextColor3 = TEXT_SECONDARY
GlobalStatus.TextSize = 12
GlobalStatus.TextXAlignment = Enum.TextXAlignment.Center

-- ========== Settings Modal ==========
local ModalFrame = Instance.new("Frame", ScreenGui)
ModalFrame.Name = "SettingsModal"
ModalFrame.Size = UDim2.new(0, 220, 0, 160)
ModalFrame.Position = UDim2.new(0.5, -110, 0.5, -80)
ModalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
ModalFrame.BackgroundColor3 = CARD_BG
ModalFrame.Visible = false
local modalCorner = Instance.new("UICorner", ModalFrame)
modalCorner.CornerRadius = UDim.new(0, 8)
local modalShadow = Instance.new("ImageLabel", ModalFrame)
modalShadow.Name = "Shadow"
modalShadow.Size = UDim2.new(1, 10, 1, 10)
modalShadow.Position = UDim2.new(0, -5, 0, -5)
modalShadow.BackgroundTransparency = 1
modalShadow.Image = "rbxassetid://1316045217"
modalShadow.ImageColor3 = SHADOW_COLOR
modalShadow.ImageTransparency = 0.2
modalShadow.ScaleType = Enum.ScaleType.Slice
modalShadow.SliceCenter = Rect.new(10, 10, 118, 118)
modalShadow.ZIndex = -1

local ModalTitle = Instance.new("TextLabel", ModalFrame)
ModalTitle.Size = UDim2.new(1, 0, 0, 32)
ModalTitle.Position = UDim2.new(0, 0, 0, 0)
ModalTitle.BackgroundColor3 = ACCENT_BLUE
ModalTitle.Text = "DURATION SETTINGS"
ModalTitle.Font = FONT
ModalTitle.TextColor3 = TEXT_MAIN
ModalTitle.TextSize = 14
local titleCorner = Instance.new("UICorner", ModalTitle)
titleCorner.CornerRadius = UDim.new(0, 8, 0, 0)

local DurationLabel = Instance.new("TextLabel", ModalFrame)
DurationLabel.Size = UDim2.new(1, -20, 0, 24)
DurationLabel.Position = UDim2.new(0, 10, 0, 40)
DurationLabel.BackgroundTransparency = 1
DurationLabel.Text = "Set duration (seconds):"
DurationLabel.Font = FONT
DurationLabel.TextColor3 = TEXT_SECONDARY
DurationLabel.TextSize = 12
DurationLabel.TextXAlignment = Enum.TextXAlignment.Left

local DurationInput = Instance.new("TextBox", ModalFrame)
DurationInput.Size = UDim2.new(1, -30, 0, 30)
DurationInput.Position = UDim2.new(0, 15, 0, 70)
DurationInput.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
DurationInput.PlaceholderText = "Enter duration"
DurationInput.Text = "300"
DurationInput.TextColor3 = TEXT_MAIN
DurationInput.TextSize = 14
DurationInput.Font = FONT
local inputCorner = Instance.new("UICorner", DurationInput)
inputCorner.CornerRadius = UDim.new(0, 6)

local ConfirmButton = Instance.new("TextButton", ModalFrame)
ConfirmButton.Size = UDim2.new(0.4, 0, 0, 28)
ConfirmButton.Position = UDim2.new(0.1, 0, 1, -34)
ConfirmButton.BackgroundColor3 = ACCENT_GREEN
ConfirmButton.Text = "CONFIRM"
ConfirmButton.Font = FONT
ConfirmButton.TextColor3 = TEXT_MAIN
ConfirmButton.TextSize = 12
local confirmCorner = Instance.new("UICorner", ConfirmButton)
confirmCorner.CornerRadius = UDim.new(0, 6)

local CancelButton = Instance.new("TextButton", ModalFrame)
CancelButton.Size = UDim2.new(0.4, 0, 0, 28)
CancelButton.Position = UDim2.new(0.55, 0, 1, -34)
CancelButton.BackgroundColor3 = ACCENT_RED
CancelButton.Text = "CANCEL"
CancelButton.Font = FONT
CancelButton.TextColor3 = TEXT_MAIN
CancelButton.TextSize = 12
local cancelCorner = Instance.new("UICorner", CancelButton)
cancelCorner.CornerRadius = UDim.new(0, 6)

-- ========== Notification System ==========
local NotificationGui = Instance.new("ScreenGui", PlayerGui)
NotificationGui.Name = "NotificationGui"
NotificationGui.DisplayOrder = 20
NotificationGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local NotificationFrame = Instance.new("Frame", NotificationGui)
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0, 240, 0, 0)
NotificationFrame.Position = UDim2.new(0.5, -120, 0.02, 0)
NotificationFrame.AnchorPoint = Vector2.new(0.5, 0)
NotificationFrame.BackgroundTransparency = 1

local function showNotification(title, message, color)
    local notificationId = "Notification_"..HttpService:GenerateGUID(false)
    
    local Container = Instance.new("Frame", NotificationFrame)
    Container.Name = notificationId
    Container.Size = UDim2.new(1, 0, 0, 60)
    Container.BackgroundColor3 = CARD_BG
    Container.Position = UDim2.new(0, 0, 0, -60)
    local containerCorner = Instance.new("UICorner", Container)
    containerCorner.CornerRadius = UDim.new(0, 8)
    local containerShadow = Instance.new("ImageLabel", Container)
    containerShadow.Name = "Shadow"
    containerShadow.Size = UDim2.new(1, 10, 1, 10)
    containerShadow.Position = UDim2.new(0, -5, 0, -5)
    containerShadow.BackgroundTransparency = 1
    containerShadow.Image = "rbxassetid://1316045217"
    containerShadow.ImageColor3 = SHADOW_COLOR
    containerShadow.ImageTransparency = 0.2
    containerShadow.ScaleType = Enum.ScaleType.Slice
    containerShadow.SliceCenter = Rect.new(10, 10, 118, 118)
    containerShadow.ZIndex = -1

    local TitleLabel = Instance.new("TextLabel", Container)
    TitleLabel.Size = UDim2.new(1, -20, 0.5, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.Font = FONT
    TitleLabel.TextColor3 = TEXT_MAIN
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Size = UDim2.new(1, -20, 0.5, 0)
    MessageLabel.Position = UDim2.new(0, 10, 0.5, 0)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.Font = FONT
    MessageLabel.TextColor3 = TEXT_SECONDARY
    MessageLabel.TextSize = 12
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left

    local AccentBar = Instance.new("Frame", Container)
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.Position = UDim2.new(0, 0, 0, 0)
    AccentBar.BackgroundColor3 = color
    local barCorner = Instance.new("UICorner", AccentBar)
    barCorner.CornerRadius = UDim.new(0, 8, 0, 0)

    -- Animation
    local slideIn = TweenService:Create(Container, TweenInfo.new(0.3), {
        Position = UDim2.new(0, 0, 0, 0)
    })
    slideIn:Play()

    -- Remove after duration
    task.delay(3, function()
        local slideOut = TweenService:Create(Container, TweenInfo.new(0.3), {
            Position = UDim2.new(0, 0, 0, -60)
        })
        slideOut:Play()
        slideOut.Completed:Wait()
        Container:Destroy()
    end)
end

-- ========== Anti-Exploit Functions ==========
local antiFreezeEnabled = false
local antiAcceptEnabled = false
local antiFreezeDuration = 300
local antiAcceptDuration = 300
local currentSetting = ""
local freezeEndTime = 0
local acceptEndTime = 0

-- Update status labels
local function updateStatusLabels()
    -- Anti-Freeze status
    if antiFreezeEnabled then
        local remaining = math.ceil(freezeEndTime - tick())
        if remaining > 0 then
            FreezeStatus.Text = remaining.."s"
            FreezeStatus.TextColor3 = ACCENT_BLUE
        else
            antiFreezeEnabled = false
            FreezeStatus.Text = "Inactive"
            FreezeStatus.TextColor3 = TEXT_SECONDARY
        end
    else
        FreezeStatus.Text = "Inactive"
        FreezeStatus.TextColor3 = TEXT_SECONDARY
    end
    
    -- Anti-Auto Accept status
    if antiAcceptEnabled then
        local remaining = math.ceil(acceptEndTime - tick())
        if remaining > 0 then
            AcceptStatus.Text = remaining.."s"
            AcceptStatus.TextColor3 = ACCENT_GREEN
        else
            antiAcceptEnabled = false
            AcceptStatus.Text = "Inactive"
            AcceptStatus.TextColor3 = TEXT_SECONDARY
        end
    else
        AcceptStatus.Text = "Inactive"
        AcceptStatus.TextColor3 = TEXT_SECONDARY
    end
    
    -- Global status
    if antiFreezeEnabled or antiAcceptEnabled then
        GlobalStatus.Text = "Protections active"
        GlobalStatus.TextColor3 = TEXT_MAIN
    else
        GlobalStatus.Text = "Protections inactive"
        GlobalStatus.TextColor3 = TEXT_SECONDARY
    end
end

-- Toggle animations
local function toggleSwitch(button, frame, state)
    if state then
        TweenService:Create(button, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 22, 0.5, -8),
            BackgroundColor3 = TEXT_MAIN
        }):Play()
        TweenService:Create(frame, TweenInfo.new(0.2), {
            BackgroundColor3 = TOGGLE_ON
        }):Play()
    else
        TweenService:Create(button, TweenInfo.new(0.2), {
            Position = UDim2.new(0, 2, 0.5, -8),
            BackgroundColor3 = TEXT_MAIN
        }):Play()
        TweenService:Create(frame, TweenInfo.new(0.2), {
            BackgroundColor3 = TOGGLE_OFF
        }):Play()
    end
end

-- Anti-Freeze protection
local function startAntiFreeze()
    antiFreezeEnabled = true
    freezeEndTime = tick() + antiFreezeDuration
    toggleSwitch(ToggleButton, FreezeToggle, true)
    showNotification("Anti-Freeze", "Active for "..antiFreezeDuration.."s", ACCENT_BLUE)
    
    -- Simulate protection
    while tick() < freezeEndTime and antiFreezeEnabled do
        updateStatusLabels()
        task.wait(1)
    end
    
    if antiFreezeEnabled then
        antiFreezeEnabled = false
        toggleSwitch(ToggleButton, FreezeToggle, false)
        showNotification("Anti-Freeze", "Protection expired", TEXT_SECONDARY)
    end
    updateStatusLabels()
end

-- Anti-Auto Accept protection
local function startAntiAutoAccept()
    antiAcceptEnabled = true
    acceptEndTime = tick() + antiAcceptDuration
    toggleSwitch(ToggleButton2, AcceptToggle, true)
    showNotification("Anti-Auto Accept", "Active for "..antiAcceptDuration.."s", ACCENT_GREEN)
    
    -- Simulate protection
    while tick() < acceptEndTime and antiAcceptEnabled do
        updateStatusLabels()
        task.wait(1)
    end
    
    if antiAcceptEnabled then
        antiAcceptEnabled = false
        toggleSwitch(ToggleButton2, AcceptToggle, false)
        showNotification("Anti-Auto Accept", "Protection expired", TEXT_SECONDARY)
    end
    updateStatusLabels()
end

-- ========== Fake Live Protection Indicator ==========
local LiveIndicator = Instance.new("Frame", MainFrame)
LiveIndicator.Name = "LiveIndicator"
LiveIndicator.Size = UDim2.new(0, 8, 0, 8)
LiveIndicator.Position = UDim2.new(1, -15, 1, -15)
LiveIndicator.BackgroundColor3 = ACCENT_RED
LiveIndicator.BorderSizePixel = 0
local indicatorCorner = Instance.new("UICorner", LiveIndicator)
indicatorCorner.CornerRadius = UDim.new(1, 0)

local LiveText = Instance.new("TextLabel", MainFrame)
LiveText.Name = "LiveText"
LiveText.Size = UDim2.new(0, 50, 0, 12)
LiveText.Position = UDim2.new(1, -60, 1, -16)
LiveText.BackgroundTransparency = 1
LiveText.Text = "INACTIVE"
LiveText.Font = FONT
LiveText.TextColor3 = TEXT_SECONDARY
LiveText.TextSize = 10
LiveText.TextXAlignment = Enum.TextXAlignment.Right

-- Function to update live status
local function updateLiveStatus()
    if antiFreezeEnabled or antiAcceptEnabled then
        LiveIndicator.BackgroundColor3 = ACCENT_GREEN
        LiveText.Text = "LIVE"
        LiveText.TextColor3 = ACCENT_GREEN
        
        -- Add pulse animation when active
        local pulse = TweenService:Create(LiveIndicator, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.5
        })
        pulse:Play()
    else
        LiveIndicator.BackgroundColor3 = ACCENT_RED
        LiveText.Text = "INACTIVE"
        LiveText.TextColor3 = TEXT_SECONDARY
        
        -- Stop any existing animations
        TweenService:GetTween(LiveIndicator):Cancel()
        LiveIndicator.BackgroundTransparency = 0
    end
end

-- ========== Trading Ticket Detection ==========
local function detectTradingTicketUse()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
        if humanoid.Sit then
            -- Player is sitting (simulating trade initiation)
            if antiFreezeEnabled or antiAcceptEnabled then
                showNotification("Trade Analysis", "Initializing trade security scan...", ACCENT_BLUE)
                
                -- Simulate scanning process
                for i = 1, 3 do
                    task.wait(0.5)
                    showNotification("Trade Analysis", "Scanning trade partner... ("..i.."/3)", ACCENT_BLUE)
                end
                
                -- Randomly detect threats
                local freezeDetected = false
                local acceptDetected = false
                
                if antiFreezeEnabled and math.random() > 0.7 then
                    freezeDetected = true
                    showNotification("Trade Guard", "Potential freeze exploit detected!", ACCENT_RED)
                end
                
                if antiAcceptEnabled and math.random() > 0.7 then
                    acceptDetected = true
                    showNotification("Trade Guard", "Auto-accept pattern detected!", ACCENT_RED)
                end
                
                if not freezeDetected and not acceptDetected then
                    showNotification("Trade Analysis", "Trade verified - No threats found", ACCENT_GREEN)
                else
                    showNotification("Trade Guard", "Security measures applied", Color3.fromRGB(200, 150, 0))
                end
            end
        end
    end)
end

-- ========== Fake Protection Events ==========
local function simulateLiveProtectionEvents()
    while true do
        if antiFreezeEnabled or antiAcceptEnabled then
            -- Randomly show protection events
            if math.random() < 0.3 then  -- 30% chance per interval
                local eventType = math.random(1, 4)
                local eventText = ""
                local eventColor = ACCENT_BLUE
                
                if eventType == 1 then
                    eventText = "Verified trade request"
                elseif eventType == 2 then
                    eventText = "Scanning trade items"
                    eventColor = ACCENT_GREEN
                elseif eventType == 3 then
                    eventText = "Protected against exploit"
                    eventColor = ACCENT_RED
                else
                    eventText = "Monitoring trade activity"
                    eventColor = Color3.fromRGB(200, 180, 80) -- Yellow
                end
                
                showNotification("Trade Guard", eventText, eventColor)
            end
        end
        task.wait(math.random(3, 8))  -- Random interval between events
    end
end

-- ========== GUI Interactions ==========
-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    NotificationGui:Destroy()
end)

-- Anti-Freeze toggle
ToggleButton.MouseButton1Click:Connect(function()
    if not antiFreezeEnabled then
        startAntiFreeze()
    else
        antiFreezeEnabled = false
        toggleSwitch(ToggleButton, FreezeToggle, false)
        showNotification("Anti-Freeze", "Protection disabled", TEXT_SECONDARY)
        updateStatusLabels()
    end
    updateLiveStatus()
end)

-- Anti-Auto Accept toggle
ToggleButton2.MouseButton1Click:Connect(function()
    if not antiAcceptEnabled then
        startAntiAutoAccept()
    else
        antiAcceptEnabled = false
        toggleSwitch(ToggleButton2, AcceptToggle, false)
        showNotification("Anti-Auto Accept", "Protection disabled", TEXT_SECONDARY)
        updateStatusLabels()
    end
    updateLiveStatus()
end)

-- Settings buttons
FreezeSettings.MouseButton1Click:Connect(function()
    ModalFrame.Visible = true
    ModalTitle.Text = "ANTI-FREEZE DURATION"
    ModalTitle.BackgroundColor3 = ACCENT_BLUE
    currentSetting = "AntiFreeze"
    DurationInput.Text = tostring(antiFreezeDuration)
end)

AcceptSettings.MouseButton1Click:Connect(function()
    ModalFrame.Visible = true
    ModalTitle.Text = "ANTI-ACCEPT DURATION"
    ModalTitle.BackgroundColor3 = ACCENT_GREEN
    currentSetting = "AntiAccept"
    DurationInput.Text = tostring(antiAcceptDuration)
end)

-- Modal buttons
ConfirmButton.MouseButton1Click:Connect(function()
    local duration = tonumber(DurationInput.Text)
    if duration and duration > 0 then
        if currentSetting == "AntiFreeze" then
            antiFreezeDuration = duration
            showNotification("Anti-Freeze", "Duration: "..duration.."s", ACCENT_BLUE)
        elseif currentSetting == "AntiAccept" then
            antiAcceptDuration = duration
            showNotification("Anti-Auto Accept", "Duration: "..duration.."s", ACCENT_GREEN)
        end
        updateStatusLabels()
    else
        showNotification("Error", "Invalid duration", ACCENT_RED)
    end
    ModalFrame.Visible = false
end)

CancelButton.MouseButton1Click:Connect(function()
    ModalFrame.Visible = false
end)

-- Initial update
updateStatusLabels()
updateLiveStatus()

-- Initial welcome notification
task.delay(1, function()
    showNotification(
        "Trade Protection",
        "Activate protections to secure trades",
        ACCENT_BLUE
    )
end)

-- Simulate trade detection
local function simulateTradeDetection()
    while true do
        if antiFreezeEnabled then
            if math.random(1, 100) > 90 then
                showNotification("Anti-Freeze", "Blocked freeze attempt", ACCENT_BLUE)
            end
        end
        
        if antiAcceptEnabled then
            if math.random(1, 100) > 90 then
                showNotification("Anti-Auto Accept", "Blocked forced trade", ACCENT_GREEN)
            end
        end
        
        task.wait(5)
    end
end

-- Start simulation tasks
task.spawn(simulateTradeDetection)
task.spawn(simulateLiveProtectionEvents)
task.spawn(detectTradingTicketUse)

-- Update status labels periodically
RunService.Heartbeat:Connect(function()
    updateStatusLabels()
end)
