
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("storerob_core/config/sh_config.lua")
include("shared.lua")
include("storerob_core/config/sh_config.lua")

local canrob = true
local joballow = false

function ENT:Initialize()
	self:SetModel(NPCRobSystem.Config.RobMoneybagModel)
	self:SetUseType(SIMPLE_USE)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

end

function ENT:AcceptInput(name, activator, caller)
	activator:addMoney(isfunction(NPCRobSystem.Config.RobAmount) and NPCRobSystem.Config.RobAmount() or NPCRobSystem.Config.RobAmount)
	net.Start( "ncprobmsg" )
		net.WriteString( string.format( "Ты поднял "..(isfunction(NPCRobSystem.Config.RobAmount) and NPCRobSystem.Config.RobAmount() or NPCRobSystem.Config.RobAmount).."Р" ) )
	net.Send(activator)

	self:Remove()
end


function ENT:Think()
end

-- t.me/urbanichka
