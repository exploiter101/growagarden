-- Rainbow Maker GUI Script for Roblox
-- Place this in StarterPlayerScripts or ServerScriptService

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RainbowMakerGui"
screenGui.Parent = playerGui

-- Main Frame (GUI Container)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Create rounded corners for main frame
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- White outline stroke
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

-- Title Label
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Rainbow Maker"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

-- Rainbow Button
local rainbowButton = Instance.new("TextButton")
rainbowButton.Name = "RainbowButton"
rainbowButton.Size = UDim2.new(0.8, 0, 0, 40)
rainbowButton.Position = UDim2.new(0.1, 0, 0.35, 0)
rainbowButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
rainbowButton.Text = "Make Rainbow!"
rainbowButton.TextColor3 = Color3.fromRGB(255, 255, 255)
rainbowButton.TextScaled = true
rainbowButton.Font = Enum.Font.Gotham
rainbowButton.Parent = mainFrame

-- Create rounded corners for button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = rainbowButton

-- Button stroke
local buttonStroke = Instance.new("UIStroke")
buttonStroke.Color = Color3.fromRGB(100, 100, 100)
buttonStroke.Thickness = 1
buttonStroke.Parent = rainbowButton

-- Gold Button
local goldButton = Instance.new("TextButton")
goldButton.Name = "GoldButton"
goldButton.Size = UDim2.new(0.8, 0, 0, 40)
goldButton.Position = UDim2.new(0.1, 0, 0.55, 0)
goldButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
goldButton.Text = "Make Gold!"
goldButton.TextColor3 = Color3.fromRGB(255, 215, 0)
goldButton.TextScaled = true
goldButton.Font = Enum.Font.Gotham
goldButton.Parent = mainFrame

-- Create rounded corners for gold button
local goldButtonCorner = Instance.new("UICorner")
goldButtonCorner.CornerRadius = UDim.new(0, 10)
goldButtonCorner.Parent = goldButton

-- Gold button stroke
local goldButtonStroke = Instance.new("UIStroke")
goldButtonStroke.Color = Color3.fromRGB(255, 215, 0)
goldButtonStroke.Thickness = 1
goldButtonStroke.Parent = goldButton

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Size = UDim2.new(0.8, 0, 0, 30)
statusLabel.Position = UDim2.new(0.1, 0, 0.78, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Click a button to activate effects!"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
statusLabel.TextScaled = true
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Variables for effects
local rainbowActive = false
local goldActive = false
local rainbowConnection = nil
local time = 0

-- Rainbow color function
local function getRainbowColor(t)
    local r = math.sin(t) * 0.5 + 0.5
    local g = math.sin(t + 2) * 0.5 + 0.5
    local b = math.sin(t + 4) * 0.5 + 0.5
    return Color3.new(r, g, b)
end

-- Function to apply rainbow effect to tools
local function applyRainbowEffect()
    local character = player.Character
    if not character then return end
    
    -- Find all tools in character
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Tool") then
            -- Apply rainbow effect to all parts in the tool
            for _, part in pairs(child:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Create or update rainbow effect
                    local rainbowColor = getRainbowColor(time)
                    part.Color = rainbowColor
                    
                    -- Add glow effect
                    if not part:FindFirstChild("PointLight") then
                        local light = Instance.new("PointLight")
                        light.Color = rainbowColor
                        light.Brightness = 2
                        light.Range = 10
                        light.Parent = part
                    else
                        part.PointLight.Color = rainbowColor
                    end
                end
            end
        end
    end
end

-- Function to apply gold effect to tools
local function applyGoldEffect()
    local character = player.Character
    if not character then return end
    
    -- Find all tools in character
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Tool") then
            -- Apply gold effect to all parts in the tool
            for _, part in pairs(child:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Apply gold color only (no glow)
                    part.Color = Color3.fromRGB(255, 215, 0)
                    part.Material = Enum.Material.Neon
                end
            end
        end
    end
end

-- Function to remove all effects
local function removeAllEffects()
    local character = player.Character
    if not character then return end
    
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Tool") then
            for _, part in pairs(child:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Remove glow effect
                    local light = part:FindFirstChild("PointLight")
                    if light then
                        light:Destroy()
                    end
                    -- Reset to original properties
                    part.Color = Color3.fromRGB(163, 162, 165)
                    part.Material = Enum.Material.Plastic
                end
            end
        end
    end
end

-- Button click events
rainbowButton.MouseButton1Click:Connect(function()
    -- Turn off gold mode if active
    if goldActive then
        goldActive = false
        goldButton.Text = "Make Gold!"
    end
    
    rainbowActive = not rainbowActive
    
    if rainbowActive then
        rainbowButton.Text = "Stop Rainbow"
        statusLabel.Text = "Rainbow effect active!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        
        -- Start rainbow effect
        rainbowConnection = RunService.Heartbeat:Connect(function()
            time = time + 0.05 -- Controls rainbow speed (1 second cycle)
            applyRainbowEffect()
        end)
    else
        rainbowButton.Text = "Make Rainbow!"
        statusLabel.Text = "Click a button to activate effects!"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        
        -- Stop rainbow effect
        if rainbowConnection then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
        end
        removeAllEffects()
    end
end)

-- Gold button click event
goldButton.MouseButton1Click:Connect(function()
    -- Turn off rainbow mode if active
    if rainbowActive then
        rainbowActive = false
        rainbowButton.Text = "Make Rainbow!"
        if rainbowConnection then
            rainbowConnection:Disconnect()
            rainbowConnection = nil
        end
    end
    
    goldActive = not goldActive
    
    if goldActive then
        goldButton.Text = "Stop Gold"
        statusLabel.Text = "Gold effect active!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
        applyGoldEffect()
    else
        goldButton.Text = "Make Gold!"
        statusLabel.Text = "Click a button to activate effects!"
        statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        removeAllEffects()
    end
end)

-- Make GUI draggable
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    game:GetService('TweenService'):Create(mainFrame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

mainFrame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragToggle = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)

game:GetService('UserInputService').InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragToggle then
            updateInput(input)
        end
    end
end)

-- Button hover effects
rainbowButton.MouseEnter:Connect(function()
    TweenService:Create(rainbowButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    }):Play()
end)

rainbowButton.MouseLeave:Connect(function()
    TweenService:Create(rainbowButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    }):Play()
end)

-- Gold button hover effects
goldButton.MouseEnter:Connect(function()
    TweenService:Create(goldButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    }):Play()
end)

goldButton.MouseLeave:Connect(function()
    TweenService:Create(goldButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    }):Play()
end)
