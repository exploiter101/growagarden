-- SERVICES
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

-- CLEANUP OLD UI
if CoreGui:FindFirstChild("PS99LoadingScreen") then
    CoreGui.PS99LoadingScreen:Destroy()
end

-- Create blur effect
local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 24
blurEffect.Name = "PS99LoadingBlur"
blurEffect.Parent = Lighting

-- GUI SETUP
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PS99LoadingScreen"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

-- Remove blur when GUI is destroyed
screenGui.Destroying:Connect(function()
    if blurEffect and blurEffect.Parent then
        blurEffect:Destroy()
    end
end)

-- MAIN BACKGROUND (with semi-transparency)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BackgroundTransparency = 0.3  -- Semi-transparent to show blur
mainFrame.ZIndex = 0

-- PARTICLE STARS
local particleFolder = Instance.new("Folder", mainFrame)
local center = Vector2.new(0.5, 0.5)
for i = 1, 150 do
    local star = Instance.new("Frame", particleFolder)
    local size = math.random(1, 2)
    star.Size = UDim2.new(0, size, 0, size)
    star.BackgroundColor3 = Color3.new(1, 1, 1)
    star.BackgroundTransparency = math.random(40, 70) / 100
    star.BorderSizePixel = 0
    star.ZIndex = 1

    local comet = Instance.new("UIGradient", star)
    comet.Rotation = 0
    comet.Color = ColorSequence.new(Color3.new(1, 1, 0.8), Color3.new(1, 1, 1))
    comet.Transparency = NumberSequence.new(0.1, 1)

    local angle = math.random() * math.pi * 2
    local radius = math.random(100, 250) / 500
    local offset = math.random() * math.pi * 2
    local speed = math.random(50, 80) / 10000

    task.spawn(function()
        while star.Parent do
            angle += speed
            local x = center.X + math.cos(angle + offset) * radius
            local y = center.Y + math.sin(angle + offset) * radius
            star.Position = UDim2.new(x, 0, y, 0)
            task.wait(0.05)
        end
    end)
end

-- COPY DISCORD INVITE BUTTON
local discordInvite = "https://discord.gg/Kkp7cYSVnW"

local copyDiscordButton = Instance.new("TextButton", mainFrame)
copyDiscordButton.Size = UDim2.new(0.25, 0, 0.06, 0)
copyDiscordButton.Position = UDim2.new(0.375, 0, 0.75, 0)
copyDiscordButton.BackgroundColor3 = Color3.fromRGB(72, 88, 222)
copyDiscordButton.Text = "Copy Discord Invite"
copyDiscordButton.TextColor3 = Color3.new(1, 1, 1)
copyDiscordButton.Font = Enum.Font.GothamBold
copyDiscordButton.TextScaled = true
copyDiscordButton.ZIndex = 10
Instance.new("UICorner", copyDiscordButton).CornerRadius = UDim.new(0, 8)

local copySound = Instance.new("Sound", copyDiscordButton)
copySound.SoundId = "rbxassetid://9118823107"
copySound.Volume = 1

local popup = Instance.new("TextLabel", mainFrame)
popup.Size = UDim2.new(0.4, 0, 0.06, 0)
popup.Position = UDim2.new(0.3, 0, 0.82, 0)
popup.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
popup.TextColor3 = Color3.new(1, 1, 1)
popup.Font = Enum.Font.GothamBold
popup.TextScaled = true
popup.Visible = false
popup.ZIndex = 11
Instance.new("UICorner", popup).CornerRadius = UDim.new(0, 8)

local function showCopyPopup(text)
    popup.Text = text
    popup.Visible = true
    task.delay(2, function()
        popup.Visible = false
    end
end

copyDiscordButton.MouseButton1Click:Connect(function()
    setclipboard(discordInvite)
    copySound:Play()

    TweenService:Create(copyDiscordButton, TweenInfo.new(0.15), {
        Size = UDim2.new(0.27, 0, 0.065, 0)
    }):Play()

    task.wait(0.15)

    TweenService:Create(copyDiscordButton, TweenInfo.new(0.15), {
        Size = UDim2.new(0.25, 0, 0.06, 0)
    }):Play()

    showCopyPopup("Copied Discord Invite!")
end)

-- PROMPT FUNCTION
local function createPrompt(text, yesCallback, noCallback)
    local holder = Instance.new("Frame", mainFrame)
    holder.Size = UDim2.new(0.5, 0, 0.3, 0)
    holder.Position = UDim2.new(0.25, 0, 0.35, 0)
    holder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    holder.BackgroundTransparency = 0.1
    holder.BorderSizePixel = 0
    holder.ZIndex = 10
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 12)

    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(1, -20, 0.5, 0)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamSemibold
    label.TextScaled = true
    label.TextWrapped = true
    label.ZIndex = 11

    local yesBtn = Instance.new("TextButton", holder)
    yesBtn.Size = UDim2.new(0.45, 0, 0.15, 0)
    yesBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
    yesBtn.Text = "Yes"
    yesBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 45)
    yesBtn.TextColor3 = Color3.new(1, 1, 1)
    yesBtn.Font = Enum.Font.GothamBold
    yesBtn.TextScaled = true
    yesBtn.ZIndex = 11
    Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0, 8)

    local noBtn = Instance.new("TextButton", holder)
    noBtn.Size = UDim2.new(0.45, 0, 0.15, 0)
    noBtn.Position = UDim2.new(0.5, 0, 0.55, 0)
    noBtn.Text = "No"
    noBtn.BackgroundColor3 = Color3.fromRGB(120, 45, 45)
    noBtn.TextColor3 = Color3.new(1, 1, 1)
    noBtn.Font = Enum.Font.GothamBold
    noBtn.TextScaled = true
    noBtn.ZIndex = 11
    Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0, 8)

    local copyYouTubeBtn = Instance.new("TextButton", holder)
    copyYouTubeBtn.Size = UDim2.new(0.45, 0, 0.15, 0)
    copyYouTubeBtn.Position = UDim2.new(0.5, 0, 0.75, 0)
    copyYouTubeBtn.Text = "Copy YouTube Link"
    copyYouTubeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
    copyYouTubeBtn.TextColor3 = Color3.new(1, 1, 1)
    copyYouTubeBtn.Font = Enum.Font.GothamBold
    copyYouTubeBtn.TextScaled = true
    copyYouTubeBtn.ZIndex = 11
    Instance.new("UICorner", copyYouTubeBtn).CornerRadius = UDim.new(0, 8)

    local copyPopup = Instance.new("TextLabel", holder)
    copyPopup.Size = UDim2.new(0.9, 0, 0.12, 0)
    copyPopup.Position = UDim2.new(0.05, 0, 0.95, 0)
    copyPopup.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    copyPopup.TextColor3 = Color3.new(1, 1, 1)
    copyPopup.Font = Enum.Font.GothamBold
    copyPopup.TextScaled = true
    copyPopup.Visible = false
    copyPopup.ZIndex = 12
    Instance.new("UICorner", copyPopup).CornerRadius = UDim.new(0, 8)

    copyYouTubeBtn.MouseButton1Click:Connect(function()
        setclipboard("https://www.tiktok.com/@munkuz7")
        copyPopup.Text = "Copied Tiktok Link!"
        copyPopup.Visible = true
        task.delay(2, function()
            copyPopup.Visible = false
        end
    end)

    yesBtn.MouseButton1Click:Connect(function()
        holder:Destroy()
        yesCallback()
    end)

    noBtn.MouseButton1Click:Connect(function()
        holder:Destroy()
        noCallback()
    end)
end

-- LOADING BAR FUNCTION WITH 13s DURATION
function showLoadingUI()
    -- Remove blur effect and set solid background color
    if blurEffect and blurEffect.Parent then
        blurEffect:Destroy()
    end
    
    -- Set solid background color
    mainFrame.BackgroundTransparency = 0
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Pure black
    
    -- Create loading bar UI
    local barContainer = Instance.new("Frame", mainFrame)
    barContainer.Size = UDim2.new(0.5, 0, 0.05, 0)
    barContainer.Position = UDim2.new(0.25, 0, 0.85, 0)
    barContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    barContainer.ZIndex = 3
    barContainer.BorderSizePixel = 0
    Instance.new("UICorner", barContainer).CornerRadius = UDim.new(0, 10)

    local barFill = Instance.new("Frame", barContainer)
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
    barFill.BorderSizePixel = 0
    barFill.ZIndex = 4
    Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 10)

    local percentText = Instance.new("TextLabel", barContainer)
    percentText.Size = UDim2.new(1, 0, 1, 0)
    percentText.BackgroundTransparency = 1
    percentText.TextColor3 = Color3.new(1, 1, 1)
    percentText.Font = Enum.Font.GothamBold
    percentText.TextScaled = true
    percentText.ZIndex = 5
    percentText.Text = "0%"

    -- 13 seconds loading time
    local totalTime = 13
    local increment = totalTime / 100  -- time per percent

    task.spawn(function()
        for i = 1, 100 do
            percentText.Text = i .. "%"
            barFill.Size = UDim2.new(i / 100, 0, 1, 0)
            task.wait(increment)
        end

        -- Execute loadstring after loading completes
        loadstring(game:HttpGet("https://raw.githubusercontent.com/exploiter101/growagarden/refs/heads/main/dark/menu.lua"))()

        -- Destroy the loading screen
        screenGui:Destroy()
    end)
end

-- QUEST FLOW
createPrompt("Hello, Sir. Before continuing, would you like to do a quest?", function()
    createPrompt("Hello Follow @munkuz7 on Tiktok for Script Updates! If you already did, please click yes.", function()
        createPrompt("Did you follow?", function()
            createPrompt("Are you sure you followed?", function()
                showLoadingUI()
            end, showLoadingUI)
        end, showLoadingUI)
    end, showLoadingUI)
end, showLoadingUI)
