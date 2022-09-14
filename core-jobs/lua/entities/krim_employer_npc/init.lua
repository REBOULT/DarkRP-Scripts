--=================ДЕЛАЛ ТИТИНЕ А ТЫ БОМШ=================--

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

function ENT:Initialize()
    self:SetModel("models/Humans/Group03/male_02.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetUseType(SIMPLE_USE)
    self:SetHullSizeNormal()
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE or CAP_USE_SHOT_REGULATOR or CAP_TURN_HEAD or CAP_AIM_GUN)
    self:SetMaxYawSpeed(5000)
    local PhysAwake = self.Entity:GetPhysicsObject()
    if PhysAwake:IsValid() then
        PhysAwake:Wake()
    end 
end

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" and Caller:IsPlayer() then
		Caller:ConCommand("krim_menu")
	end
end
