local function duplicateAndMove(object, direction, distance)
    local newObject = object:Clone()
    newObject.Parent = object.Parent
    
    if direction == "right" then
        newObject.Position = newObject.Position + Vector3.new(distance, 0, 0)
    elseif direction == "left" then
        newObject.Position = newObject.Position + Vector3.new(-distance, 0, 0)
    elseif direction == "up" then
        newObject.Position = newObject.Position + Vector3.new(0, distance, 0)
    elseif direction == "down" then
        newObject.Position = newObject.Position + Vector3.new(0, -distance, 0)
    end
    
    return newObject
end

local function createMovementGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 150)
    frame.Position = UDim2.new(0.5, -100, 0.5, -75)
    frame.BackgroundColor3 = Color3.new(0.8, 0.8, 0.8)
    frame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = "Move Duplicated Object"
    title.Parent = frame
    
    local directions = {"Right", "Left", "Up", "Down"}
    local buttonSize = UDim2.new(0.4, 0, 0, 30)
    local spacing = 10
    
    for i, dir in ipairs(directions) do
        local button = Instance.new("TextButton")
        button.Size = buttonSize
        button.Position = UDim2.new(0.1, 0, 0, 40 + (i-1) * (buttonSize.Y.Offset + spacing))
        button.Text = dir
        button.Parent = frame
        
        button.MouseButton1Click:Connect(function()
            local selectedObject = game.Workspace.SelectedObject
            if selectedObject then
                duplicateAndMove(selectedObject, dir:lower(), 5)
            else
                print("No object selected")
            end
        end)
    end
end

createMovementGUI()

-- Fungsi untuk memilih objek
local function selectObject()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local input = game:GetService("UserInputService")
    
    input.InputBegan:Connect(function(inputObject)
        if inputObject.UserInputType == Enum.UserInputType.MouseButton1 then
            local target = mouse.Target
            if target and target:IsA("BasePart") then
                game.Workspace.SelectedObject = target
                print("Selected object:", target.Name)
            end
        end
    end)
end

selectObject()
