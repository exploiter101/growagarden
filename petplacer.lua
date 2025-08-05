-- LocalScript (place in StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove old GUIs
for _, guiName in ipairs({"PlayerSearchGUI", "IntroLoadingGui"}) do
    if PlayerGui:FindFirstChild(guiName) then
        PlayerGui[guiName]:Destroy()
    end
end

-- ========== Loading GUI ==========
local LoadingGui = Instance.new("ScreenGui", PlayerGui)
LoadingGui.Name = "IntroLoadingGui"
LoadingGui.DisplayOrder = 999
LoadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local LoadingFrame = Instance.new("Frame", LoadingGui)
LoadingFrame.Size = UDim2.new(0, 300, 0, 150)
LoadingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LoadingFrame.BorderSizePixel = 4
LoadingFrame.BorderColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 16)

local LoadingTitle = Instance.new("TextLabel", LoadingFrame)
LoadingTitle.Size = UDim2.new(1, -20, 0.5, 0)
LoadingTitle.Position = UDim2.new(0, 10, 0, 10)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "Loading Player Search Tool..."
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.TextScaled = true

local LoadingBarBackground = Instance.new("Frame", LoadingFrame)
LoadingBarBackground.Size = UDim2.new(0.8, 0, 0.1, 0)
LoadingBarBackground.Position = UDim2.new(0.1, 0, 0.7, 0)
LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", LoadingBarBackground).CornerRadius = UDim.new(0, 8)

local LoadingBar = Instance.new("Frame", LoadingBarBackground)
LoadingBar.Size = UDim2.new(0, 0, 1, 0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", LoadingBar).CornerRadius = UDim.new(0, 8)

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

-- ========== Anti-Trade Freezer System ==========
local antiFreezeEnabled = false
local lastTradeAttempt = 0
local tradeCooldown = 5 -- seconds

-- Simulated trade events (in a real game, you'd connect to actual trade events)
local function simulateTradeAttempt()
    if antiFreezeEnabled then
        local currentTime = os.time()
        if currentTime - lastTradeAttempt > tradeCooldown then
            lastTradeAttempt = currentTime
            return true
        end
        return false
    end
    return true
end

-- Anti-freeze functionality
local function antiFreezeLoop()
    while antiFreezeEnabled do
        -- In a real game, this would check for trade freeze attempts
        if os.time() - lastTradeAttempt < tradeCooldown then
            -- Simulate protection
            local protectionLevel = 100 - ((os.time() - lastTradeAttempt) / tradeCooldown * 100)
        end
        task.wait(0.1)
    end
end

-- ========== Main GUI ==========
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "PlayerSearchGUI"
ScreenGui.DisplayOrder = 999
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 350)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Title bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Player Search Tool"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextScaled = true
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold

local MinimizeButton = Instance.new("TextButton", TitleBar)
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.TextScaled = true
MinimizeButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinimizeButton).CornerRadius = UDim.new(0, 8)

local CloseButton = Instance.new("TextButton", TitleBar)
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 8)

-- Input frame
local InputFrame = Instance.new("Frame", MainFrame)
InputFrame.Name = "InputFrame"
InputFrame.Size = UDim2.new(1, -20, 0, 40)
InputFrame.Position = UDim2.new(0, 10, 0, 50)
InputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
InputFrame.BorderSizePixel = 0
Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 8)

local SearchIcon = Instance.new("ImageLabel", InputFrame)
SearchIcon.Name = "SearchIcon"
SearchIcon.Size = UDim2.new(0, 25, 0, 25)
SearchIcon.Position = UDim2.new(0, 10, 0.5, -12.5)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = "rbxassetid://3926305904"
SearchIcon.ImageRectOffset = Vector2.new(964, 324)
SearchIcon.ImageRectSize = Vector2.new(36, 36)

local TextInput = Instance.new("TextBox", InputFrame)
TextInput.Name = "TextInput"
TextInput.Size = UDim2.new(1, -50, 1, 0)
TextInput.Position = UDim2.new(0, 45, 0, 0)
TextInput.BackgroundTransparency = 1
TextInput.PlaceholderText = "Search player name..."
TextInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
TextInput.Text = ""
TextInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TextInput.TextSize = 16
TextInput.TextXAlignment = Enum.TextXAlignment.Left
TextInput.Font = Enum.Font.Gotham
TextInput.ClearTextOnFocus = false

-- Profile frame
local ProfileFrame = Instance.new("Frame", MainFrame)
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(1, -20, 0, 80)
ProfileFrame.Position = UDim2.new(0, 10, 0, 100)
ProfileFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Visible = false
Instance.new("UICorner", ProfileFrame).CornerRadius = UDim.new(0, 8)

local ProfilePictureFrame = Instance.new("Frame", ProfileFrame)
ProfilePictureFrame.Name = "ProfilePictureFrame"
ProfilePictureFrame.Size = UDim2.new(0, 60, 0, 60)
ProfilePictureFrame.Position = UDim2.new(0, 10, 0, 10)
ProfilePictureFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
ProfilePictureFrame.BorderSizePixel = 0
Instance.new("UICorner", ProfilePictureFrame).CornerRadius = UDim.new(0, 30)

local ProfilePicture = Instance.new("ImageLabel", ProfilePictureFrame)
ProfilePicture.Name = "ProfilePicture"
ProfilePicture.Size = UDim2.new(1, -4, 1, -4)
ProfilePicture.Position = UDim2.new(0, 2, 0, 2)
ProfilePicture.BackgroundTransparency = 1
ProfilePicture.Image = "rbxassetid://0" -- Default blank
Instance.new("UICorner", ProfilePicture).CornerRadius = UDim.new(0, 28)

local InfoFrame = Instance.new("Frame", ProfileFrame)
InfoFrame.Name = "InfoFrame"
InfoFrame.Size = UDim2.new(1, -90, 1, -20)
InfoFrame.Position = UDim2.new(0, 80, 0, 10)
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
DisplayNameLabel.Font = Enum.Font.GothamBold

local UsernameLabel = Instance.new("TextLabel", InfoFrame)
UsernameLabel.Name = "UsernameLabel"
UsernameLabel.Size = UDim2.new(1, 0, 0, 16)
UsernameLabel.Position = UDim2.new(0, 0, 0, 22)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.Text = ""
UsernameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
UsernameLabel.TextSize = 14
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.Gotham

local UserIdLabel = Instance.new("TextLabel", InfoFrame)
UserIdLabel.Name = "UserIdLabel"
UserIdLabel.Size = UDim2.new(1, 0, 0, 16)
UserIdLabel.Position = UDim2.new(0, 0, 0, 40)
UserIdLabel.BackgroundTransparency = 1
UserIdLabel.Text = ""
UserIdLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
UserIdLabel.TextSize = 13
UserIdLabel.TextXAlignment = Enum.TextXAlignment.Left
UserIdLabel.Font = Enum.Font.Gotham

-- Buttons
local ButtonsFrame = Instance.new("Frame", MainFrame)
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Size = UDim2.new(1, -20, 0, 100)
ButtonsFrame.Position = UDim2.new(0, 10, 0, 190)
ButtonsFrame.BackgroundTransparency = 1

local FreezeButton = Instance.new("TextButton", ButtonsFrame)
FreezeButton.Name = "FreezeButton"
FreezeButton.Size = UDim2.new(1, 0, 0, 40)
FreezeButton.Position = UDim2.new(0, 0, 0, 0)
FreezeButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
FreezeButton.BorderSizePixel = 0
FreezeButton.Text = "FREEZE TRADE"
FreezeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FreezeButton.TextSize = 16
FreezeButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", FreezeButton).CornerRadius = UDim.new(0, 8)

local AcceptButton = Instance.new("TextButton", ButtonsFrame)
AcceptButton.Name = "AcceptButton"
AcceptButton.Size = UDim2.new(1, 0, 0, 40)
AcceptButton.Position = UDim2.new(0, 0, 0, 50)
AcceptButton.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
AcceptButton.BorderSizePixel = 0
AcceptButton.Text = "AUTO ACCEPT"
AcceptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AcceptButton.TextSize = 16
AcceptButton.Font = Enum.Font.GothamBold
Instance.new("UICorner", AcceptButton).CornerRadius = UDim.new(0, 8)

-- Anti-Freeze Panel
local AntiFreezePanel = Instance.new("Frame", MainFrame)
AntiFreezePanel.Name = "AntiFreezePanel"
AntiFreezePanel.Size = UDim2.new(1, -20, 0, 50)
AntiFreezePanel.Position = UDim2.new(0, 10, 0, 300)
AntiFreezePanel.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
AntiFreezePanel.BorderSizePixel = 0
Instance.new("UICorner", AntiFreezePanel).CornerRadius = UDim.new(0, 8)

local AntiFreezeLabel = Instance.new("TextLabel", AntiFreezePanel)
AntiFreezeLabel.Name = "AntiFreezeLabel"
AntiFreezeLabel.Size = UDim2.new(0.6, 0, 1, 0)
AntiFreezeLabel.Position = UDim2.new(0, 10, 0, 0)
AntiFreezeLabel.BackgroundTransparency = 1
AntiFreezeLabel.Text = "ANTI-TRADE FREEZER"
AntiFreezeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiFreezeLabel.TextSize = 16
AntiFreezeLabel.TextXAlignment = Enum.TextXAlignment.Left
AntiFreezeLabel.Font = Enum.Font.GothamBold

local AntiFreezeToggle = Instance.new("TextButton", AntiFreezePanel)
AntiFreezeToggle.Name = "AntiFreezeToggle"
AntiFreezeToggle.Size = UDim2.new(0.3, 0, 0.7, 0)
AntiFreezeToggle.Position = UDim2.new(0.65, 0, 0.15, 0)
AntiFreezeToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
AntiFreezeToggle.Text = "OFF"
AntiFreezeToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
AntiFreezeToggle.TextSize = 14
AntiFreezeToggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", AntiFreezeToggle).CornerRadius = UDim.new(0, 12)

local StatusLabel = Instance.new("TextLabel", MainFrame)
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 360)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Enter player name to search"
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.TextSize = 14
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.Gotham

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
    Container.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Container.BorderSizePixel = 0
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 8)

    local Icon = Instance.new("ImageLabel", Container)
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 40, 0, 40)
    Icon.Position = UDim2.new(0, 15, 0.5, -20)
    Icon.BackgroundTransparency = 1
    Icon.Image = icon or "rbxassetid://3926305904"
    Icon.ImageRectOffset = Vector2.new(964, 324)
    Icon.ImageRectSize = Vector2.new(36, 36)

    local TitleLabel = Instance.new("TextLabel", Container)
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -70, 0, 20)
    TitleLabel.Position = UDim2.new(0, 65, 0, 15)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Font = Enum.Font.GothamBold

    local MessageLabel = Instance.new("TextLabel", Container)
    MessageLabel.Name = "Message"
    MessageLabel.Size = UDim2.new(1, -70, 0, 30)
    MessageLabel.Position = UDim2.new(0, 65, 0, 35)
    MessageLabel.BackgroundTransparency = 1
    MessageLabel.Text = message
    MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    MessageLabel.TextSize = 14
    MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
    MessageLabel.TextYAlignment = Enum.TextYAlignment.Top
    MessageLabel.Font = Enum.Font.Gotham
    MessageLabel.TextWrapped = true

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

-- ===== GUI Interactions =====
-- Player search
TextInput:GetPropertyChangedSignal("Text"):Connect(function()
    if #TextInput.Text > 2 then
        local player = findPlayer(TextInput.Text)
        if player then
            updateProfile(player)
            StatusLabel.Text = "Player found: "..player.DisplayName
            StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
        else
            ProfileFrame.Visible = false
        end
    end
end)

-- Button actions
FreezeButton.MouseButton1Click:Connect(function()
    if TextInput.Text ~= "" then
        local player = findPlayer(TextInput.Text)
        if player then
            showNotification("Freeze Trade", "Enabled for "..player.DisplayName, "rbxassetid://3926307971", 3)
        end
    else
        StatusLabel.Text = "Enter player name first"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    end
end)

AcceptButton.MouseButton1Click:Connect(function()
    if TextInput.Text ~= "" then
        local player = findPlayer(TextInput.Text)
        if player then
            showNotification("Auto Accept", "Enabled for "..player.DisplayName, "rbxassetid://3926305904", 3)
        end
    else
        StatusLabel.Text = "Enter player name first"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    end
end)

-- Anti-Freeze Toggle
AntiFreezeToggle.MouseButton1Click:Connect(function()
    antiFreezeEnabled = not antiFreezeEnabled
    if antiFreezeEnabled then
        AntiFreezeToggle.Text = "ON"
        AntiFreezeToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
        AntiFreezeToggle.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        showNotification("Anti-Freeze", "Protection activated", "rbxassetid://3926307971", 3)
        task.spawn(antiFreezeLoop)
    else
        AntiFreezeToggle.Text = "OFF"
        AntiFreezeToggle.TextColor3 = Color3.fromRGB(255, 100, 100)
        AntiFreezeToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        showNotification("Anti-Freeze", "Protection deactivated", "rbxassetid://3926305904", 3)
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
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 350, 0, 350)}):Play()
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
    antiFreezeEnabled = false
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
local function createHoverEffect(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = normalColor
    end)
end

createHoverEffect(FreezeButton, Color3.fromRGB(45, 45, 50), Color3.fromRGB(55, 55, 60))
createHoverEffect(AcceptButton, Color3.fromRGB(45, 45, 50), Color3.fromRGB(55, 55, 60))
createHoverEffect(MinimizeButton, Color3.fromRGB(40, 40, 45), Color3.fromRGB(50, 50, 55))
createHoverEffect(CloseButton, Color3.fromRGB(200, 50, 50), Color3.fromRGB(220, 60, 60))
createHoverEffect(AntiFreezeToggle, Color3.fromRGB(60, 60, 65), Color3.fromRGB(70, 70, 75))

-- Initial welcome notification
delay(1, function()
    showNotification(
        "Player Search Tool",
        "Search for players and manage trades",
        "rbxassetid://3926307971",
        5
    )
end)

-- Anti-freeze status indicator
RunService.Heartbeat:Connect(function()
    if antiFreezeEnabled then
        local protectionLevel = 100 - ((os.time() - lastTradeAttempt) / tradeCooldown * 100)
        if protectionLevel < 0 then protectionLevel = 0 end
        AntiFreezeLabel.Text = "ANTI-TRADE FREEZER: "..math.floor(protectionLevel).."%"
    else
        AntiFreezeLabel.Text = "ANTI-TRADE FREEZER"
    end
end)
