-- ... (previous code remains the same until the end) ...

-- Update status labels periodically
RunService.Heartbeat:Connect(function()
    updateStatusLabels()
end)

-- ========== Fake Live Protection Indicator ==========
-- Add a small indicator at the bottom to show "live" protection status
local LiveIndicator = Instance.new("Frame", MainFrame)
LiveIndicator.Name = "LiveIndicator"
LiveIndicator.Size = UDim2.new(0, 10, 0, 10)
LiveIndicator.Position = UDim2.new(1, -15, 1, -15)
LiveIndicator.BackgroundColor3 = ACCENT_RED
LiveIndicator.BorderSizePixel = 0
local indicatorCorner = Instance.new("UICorner", LiveIndicator)
indicatorCorner.CornerRadius = UDim.new(1, 0)

local LiveText = Instance.new("TextLabel", MainFrame)
LiveText.Name = "LiveText"
LiveText.Size = UDim2.new(0, 40, 0, 12)
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

-- Add fake protection events
local function simulateLiveProtectionEvents()
    while true do
        if antiFreezeEnabled or antiAcceptEnabled then
            -- Randomly show protection events
            if math.random() < 0.3 then  -- 30% chance per interval
                local eventType = math.random(1, 3)
                local eventText = ""
                local eventColor = ACCENT_BLUE
                
                if eventType == 1 then
                    eventText = "Verified trade request"
                elseif eventType == 2 then
                    eventText = "Scanning trade items"
                    eventColor = ACCENT_GREEN
                else
                    eventText = "Protected against exploit"
                    eventColor = ACCENT_RED
                end
                
                showNotification("Trade Guard", eventText, eventColor)
            end
        end
        task.wait(math.random(5, 10))  -- Random interval between events
    end
end

-- Initialize live status
updateLiveStatus()

-- Connect protection toggles to live status
ToggleButton.MouseButton1Click:Connect(function()
    -- ... existing toggle code ...
    updateLiveStatus()
end)

ToggleButton2.MouseButton1Click:Connect(function()
    -- ... existing toggle code ...
    updateLiveStatus()
end)

-- Start fake protection events
task.spawn(simulateLiveProtectionEvents)
