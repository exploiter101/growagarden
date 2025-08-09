local Players = game:GetService("Players") 
local lp = Players.LocalPlayer 
local playerGui = lp:WaitForChild("PlayerGui") 
local workspace = game:GetService("Workspace") 
local UserInputService = game:GetService("UserInputService") 

-- ✅ Set your key here
local correctKey = "chrolinkzhub123" 

-- 🧽 Cleanup
local old = playerGui:FindFirstChild("MakeHugeGui") 
if old then old:Destroy() end 
local oldKeyGui = playerGui:FindFirstChild("KeyInputGui") 
if oldKeyGui then oldKeyGui:Destroy() end 

-- 🔐 Key GUI
local keyGui = Instance.new("ScreenGui", playerGui)
keyGui.Name = "KeyInputGui"
keyGui.ResetOnSpawn = false

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0, 300, 0, 150)
keyFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyFrame.BorderSizePixel = 0
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Enter Access Key"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.8, 0, 0, 30)
keyBox.Position = UDim2.new(0.1, 0, 0, 50)
keyBox.PlaceholderText = "Enter your key here..."
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 6)

local errorLabel = Instance.new("TextLabel", keyFrame)
errorLabel.Size = UDim2.new(1, -20, 0, 20)
errorLabel.Position = UDim2.new(0, 10, 0, 85)
errorLabel.BackgroundTransparency = 1
errorLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
errorLabel.Font = Enum.Font.Gotham
errorLabel.TextSize = 14
errorLabel.Text = ""

local submitButton = Instance.new("TextButton", keyFrame)
submitButton.Size = UDim2.new(0.6, 0, 0, 30)
submitButton.Position = UDim2.new(0.2, 0, 0, 110)
submitButton.Text = "Submit"
submitButton.Font = Enum.Font.GothamBlack
submitButton.TextSize = 14
submitButton.TextColor3 = Color3.new(1, 1, 1)
submitButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
Instance.new("UICorner", submitButton).CornerRadius = UDim.new(0, 6)

-- 🔓 Key logic
submitButton.MouseButton1Click:Connect(function() 
	if keyBox.Text == correctKey then 
		keyGui:Destroy() 
		loadHugeGui() 
	else 
		errorLabel.Text = "Invalid key. Try again." 
	end 
end)

-- 🎬 Main GUI & Timer Function
function loadHugeGui()
	local gui = Instance.new("ScreenGui", playerGui)
	gui.Name = "MakeHugeGui"
	gui.ResetOnSpawn = false
	
	local frame = Instance.new("Frame", gui)
	frame.Size = UDim2.new(0, 280, 0, 100)
	frame.Position = UDim2.new(0.5, -140, 0.5, -50)
	frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	frame.BorderSizePixel = 0
	frame.Active = true
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
	
	local title = Instance.new("TextLabel", frame)
	title.Size = UDim2.new(1, -30, 0, 24)
	title.Position = UDim2.new(0, 10, 0, 6)
	title.BackgroundTransparency = 1
	title.Text = "CHROLINKZHUB.DEV"
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.Font = Enum.Font.GothamSemibold
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left
	
	local closeButton = Instance.new("TextButton", frame)
	closeButton.Size = UDim2.new(0, 20, 0, 20)
	closeButton.Position = UDim2.new(1, -30, 0, 6)
	closeButton.Text = "X"
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextColor3 = Color3.new(1, 1, 1)
	closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	closeButton.TextSize = 14
	closeButton.AutoButtonColor = false
	Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)
	closeButton.MouseButton1Click:Connect(function() gui:Destroy() end)
	
	local button = Instance.new("TextButton", frame)
	button.Size = UDim2.new(0.9, 0, 0, 40)
	button.Position = UDim2.new(0.05, 0, 0, 40)
	button.Text = "Please wait..."
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.GothamBlack
	button.TextScaled = true
	button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	button.AutoButtonColor = false
	button.Active = false
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)
	
	local loadingLabel = Instance.new("TextLabel", frame)
	loadingLabel.Size = UDim2.new(1, -20, 0, 20)
	loadingLabel.Position = UDim2.new(0, 10, 1, -25)
	loadingLabel.BackgroundTransparency = 1
	loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	loadingLabel.Font = Enum.Font.Gotham
	loadingLabel.TextSize = 14
	loadingLabel.Text = "Loading... Please wait 15 seconds"  -- Changed to 15 seconds
	
	local progressBarBg = Instance.new("Frame", frame)
	progressBarBg.Size = UDim2.new(0.9, 0, 0, 8)
	progressBarBg.Position = UDim2.new(0.05, 0, 1, -10)
	progressBarBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	progressBarBg.BorderSizePixel = 0
	Instance.new("UICorner", progressBarBg).CornerRadius = UDim.new(0, 4)
	
	local progressBar = Instance.new("Frame", progressBarBg)
	progressBar.Size = UDim2.new(0, 0, 1, 0)
	progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	progressBar.BorderSizePixel = 0
	Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 4)
	
	local dragging = false
	local dragInput, dragStart, startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
	
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
	
	-- 🧠 Scale logic
	local function makeHuge(pet)
		if not pet:IsA("Model") then return end
		if not pet.PrimaryPart then
			local part = pet:FindFirstChildWhichIsA("BasePart")
			if part then pet.PrimaryPart = part end
		end
		if pet.PrimaryPart then
			pet:ScaleTo(12)
		end
	end
	
	local function scaleAllDragonflies()
		for _, obj in workspace:GetDescendants() do
			if obj:IsA("Model") and obj.Name:lower():find("dragonfly") then
				makeHuge(obj)
			end
		end
	end
	
	button.MouseButton1Click:Connect(scaleAllDragonflies)
	
	workspace.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("Model") and descendant.Name:lower():find("dragonfly") then
			task.delay(0.2, function() makeHuge(descendant) end)
		end
	end)
	
	-- ⏳ Timer logic (changed to 15 seconds)
	local totalTime = 15  -- Reduced from 1200 to 15 seconds
	local startTime = tick()
	
	task.spawn(function()
		while true do
			local elapsed = tick() - startTime
			local remaining = math.max(totalTime - elapsed, 0)
			local minutes = math.floor(remaining / 60)
			local seconds = math.floor(remaining % 60)
			loadingLabel.Text = string.format("Loading... %02d:%02d remaining", minutes, seconds)
			local percent = math.clamp(elapsed / totalTime, 0, 1)
			progressBar.Size = UDim2.new(percent, 0, 1, 0)
			
			if remaining <= 0 then break end
			task.wait(1)
		end
		
		-- Enable button after countdown
		button.Text = "Enlarge"
		button.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
		button.AutoButtonColor = true
		button.Active = true
		loadingLabel.Text = "Ready!"
	end)
end
