local image = "https://static.wixstatic.com/media/2cd43b_ad23f564a47043fbb05fd123ecf4eb8f~mv2.png/v1/fill/w_320,h_320,q_90/2cd43b_ad23f564a47043fbb05fd123ecf4eb8f~mv2.png"
local scaledown = "9"




local PartName = "TitaniumBlock"











_G.Generating = true
local currentColor = Color3.new(1,0,0)
function colorPart(Part,Color,FolderPart)
	if _G.Generating == true then


				local args = {
					[1] = {
						[1] = {
							[1] = Part,
							[2] = currentColor
						}
					}
				}

				game:GetService("Players"):WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("Backpack"):WaitForChild("PaintingTool"):WaitForChild("RF"):InvokeServer(unpack(args))
				local args = {
					[1] = Part,
					[2] = Vector3.new(100,100,100),
					[3] = Part.PPart.CFrame
				}

				game:GetService("Players"):WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("Backpack"):FindFirstChild("ScalingTool"):WaitForChild("RF"):InvokeServer(unpack(args))
				
				
			end


end
workspace:WaitForChild("ClearAllPlayersBoatParts"):FireServer()
local number = tonumber(game:GetService("Players").LocalPlayer.PlayerGui.BuildGui.InventoryFrame.ScrollingFrame.BlocksFrame[PartName].AmountText.Text)
function createPart(CFRAME)
local args = {
    [1] = PartName,
    [2] = number,
    [3] = nil,
    [4] = CFRAME,
    [5] = true,
    [6] = 1,
    [7] = CFRAME,
    [8] = false
}

game:GetService("Players").LocalPlayer.Backpack.BuildingTool.RF:InvokeServer(unpack(args))

end
game.Workspace.ChildAdded:Connect(function(part)
	if part.Name == PartName then
		if tostring(part:WaitForChild("Tag").Value) == game.Players.LocalPlayer.Name then
		colorPart(part,currentColor)
		end
	end
end)


  -- just put an image url here inside ""




local convert = loadstring(game:HttpGet("https://raw.githubusercontent.com/titusj3026/MyFiles/main/RobloxScripts/BuildABoat/convert.lua", true))()

local lp = game.Players.LocalPlayer
local rs = game:GetService"RunService"


local PartFolder = Instance.new("Folder",workspace)
PartFolder.Name = math.random(-500,500)
local folder = {}

local resize = function(image,size,s)
    local size = size
    if s then
     size = Vector2.new(image.size.X/s,image.size.Y/s)
    end
    local new = {}
    local is = Vector2.new(image.size.X/size.X,image.size.Y/size.Y)
    for x = 1,size.X do
        for y = 1,size.Y do
            local pix = image.image[tostring(Vector2.new(math.floor(x*is.X+.5),math.floor(y*is.Y+.5)))]
            pix.x = x;pix.y = y
            new[#new+1] =  pix
        end
    end
    return new
end

local origin = lp.Character.PrimaryPart.Position+Vector3.new(0,0,0)
local skip = 0
for i,v in pairs(resize(convert(image,file),nil,scaledown)) do
    if skip >= 3000 then skip = 0 rs.Heartbeat:Wait() end
    skip=skip+1 
    local part = Instance.new("Part")
    part.Position = origin + Vector3.new(v.x/3,i*0.0001,v.y/3)
    part.Color = Color3.new(v.r,v.g,v.b)
    part.Parent = workspace
    part.Anchored = true
    part.Size = Vector3.new(100,100,100)
    currentColor = part.Color
    createPart(part.CFrame)
    part.Parent = PartFolder
    part.Transparency = 1
    folder[#folder+1]=part
    end

    _G.Generating = false
