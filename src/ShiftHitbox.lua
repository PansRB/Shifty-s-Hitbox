local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Hitbox = {} -- MODULE
local Hitboxes = {} -- ACTIVE HITBOXES
Hitbox.__index = Hitbox

--[[
SHIFT HITBOX MODULE
- Shifty Universe

Usage :
- Hitbox.new(Settings : table)
	Create a new hitbox.

	- Parameters :
		- Settings : a Settings for Hitbox : 
			1* - Type : Number [Default : 1] = 1 = Blocked Hitbox.
											   2 = Object based.
			2* - Activation : Number [Default : 1] = 1 = Instant [Hitbox will instantly detecting and stops.]
							  				    	 2 = Always [Hitbox will always active until stops.]
			3* - Ignore : Table = Objects that Hitbox will ignore.
			4* - Object : Instance = Object based hitbox. [Type = 2]
			4* - Size : Vector3 [Default : Vector3.new(1, 1, 1)] = Size of the hitbox. [Type = 1]
			5* - CFrames : CFrame = CFrame of the Hitbox. [Type = 1]
	- Returns : 
		- Table : a Table for hitbox

- Hitbox:Stop()
	Stop current hitbox.
	
- Hitbox:Connect()
	Connect and Fire the function when it's hitbox hit objects.
]]--

function Hitbox.new(Settings : table, ...)
	if (Settings.Type == 1 and not Settings.Size) or (Settings.Type == 2 and not Settings.Object) then error("Object/Size is not defined/nil") end
	
	local self
	if Settings.Type == 1 then
		local Overlap = OverlapParams.new()
		Overlap.FilterDescendantsInstances = {type(Settings.Ignore) == "table" and unpack(Settings.Ignore) or Settings.Ignore}
		
		self = setmetatable(Settings, Hitbox)
		self.Started = tick()
		self.Activated = true
		self.Overlap = Overlap
		self.Connection = nil
		Hitboxes[self.CFrame] = self
	elseif Settings.Type == 2 then
		local Overlap = OverlapParams.new()
		Overlap.FilterDescendantsInstances = {type(Settings.Ignore) == "table" and unpack(Settings.Ignore) or Settings.Ignore}

		self = setmetatable(Settings, Hitbox)
		self.Started = tick()
		self.Activated = true
		self.Object = Settings.Object
		self.Overlap = Overlap
		self.Connection = nil
		Hitboxes[self.Object] = self
	end

	return self
end

function Hitbox:Stop()
	if not self then error("Hitbox is not defined/nil. Hitbox:Stop() will only work if it has 'self'. make sure you use the Hitbox.new() when creating hitbox") end
	self.Activated = false
	return self
end

function Hitbox:Connect(Function)
	if not self then error("Hitbox is not defined/nil. Hitbox:Connect() will only work if it has 'self'. make sure you use the Hitbox.new() when creating hitbox") end
	self.Connection = Function
	return self
end

RunService.Heartbeat:Connect(function(delta)
	for _, self in pairs(Hitboxes) do
		if not self.Activated then Hitboxes[self["Object"] or self["CFrames"]] = nil self = nil continue end

		local Parts = (self.Type == 1 and workspace:GetPartBoundsInBox(self.CFrames, self.Size, self.Overlap)) or (self.Type == 2 and workspace:GetPartsInPart(self.Object, self.Overlap))
		for _, Part in pairs(Parts) do
			if self.Connection then self.Connection(Part) end
		end
		
		if self.Activation == 1 then
			self:Stop()
		end
	end
end)

return Hitbox
