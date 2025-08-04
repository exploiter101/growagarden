local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

local PLANT_ASSET_IDS = {
    ["PlantModels"] = "rbxassetid://79072467152226"
}

local function loadAssets()
    -- Clear existing assets
    local existing = ReplicatedStorage:FindFirstChild("PlantModels")
    if existing then existing:Destroy() end
    
    wait(0.1)
    
    for modelName, assetUrl in pairs(PLANT_ASSET_IDS) do
        local success, result = pcall(function()
            return game:GetObjects(assetUrl)
        end)
        
        if success and result and #result > 0 then
            local model = result[1]
            model.Name = modelName
            model.Parent = ReplicatedStorage
            
            -- Anchor all parts
            for _, part in pairs(model:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
        end
    end
end

local function spawnPlant(position)
    local template = ReplicatedStorage:FindFirstChild("PlantModels")
    if not template then return nil end
    
    local newPlant = template:Clone()
    newPlant.Parent = workspace
    newPlant.Name = "Plant_" .. player.Name
    
    -- Position the plant
    if newPlant.PrimaryPart then
        newPlant:SetPrimaryPartCFrame(CFrame.new(position))
    else
        local firstPart = newPlant:FindFirstChildOfClass("BasePart")
        if firstPart then
            firstPart.CFrame = CFrame.new(position)
        end
    end
    
    -- Unanchor parts
    for _, part in pairs(newPlant:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
        end
    end
    
    return newPlant
end

-- Load assets and test spawn
spawn(function()
    loadAssets()
    wait(1)
    
    -- Test spawn near player
    local testPos = Vector3.new(0, 10, 0)
    if player.Character and player.Character.PrimaryPart then
        testPos = player.Character.PrimaryPart.Position + Vector3.new(5, 0, 5)
    end
    
    spawnPlant(testPos)
end)

-- Global functions
_G.SpawnPlant = spawnPlant
_G.ReloadPlants = loadAssets
