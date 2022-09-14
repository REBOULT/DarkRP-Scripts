AddCSLuaFile()


SWEP.Author = "melkiyy x T1NTINY"
SWEP.SwayScale=3
SWEP.BobScale=3

SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminOnly		= true

SWEP.HoldType = "normal"

SWEP.ViewModel = Model("models/weapons/c_arms_cstrike.mdl")
SWEP.WorldModel	= ""
SWEP.IsAlwaysRaised = true

SWEP.AttackSlowDown=.5

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.FireWhenLowered = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.ReachDistance=90


	SWEP.PrintName = "Руки"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true



function SWEP:SetupDataTables()
	self:NetworkVar("Float",0,"NextIdle")
	self:NetworkVar("Bool",2,"Fists")
	self:NetworkVar("Float",1,"NextDown")
	self:NetworkVar("Bool",3,"Blocking")
end

function SWEP:PreDrawViewModel(vm,wep,ply)
	--vm:SetMaterial("engine/occlusionproxy")
end
function SWEP:Initialize()
	self:SetNextIdle(CurTime()+5)
	self:SetNextDown(CurTime()+5)
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	if not(IsFirstTimePredicted())then
		--self:DoBFSAnimation("fists_draw")
		self.Owner:GetViewModel():SetPlaybackRate(.1)
		return
	end
	self:SetNextSecondaryFire(CurTime()+.1)

	self:SetNextDown(CurTime())
	--self:DoBFSAnimation("fists_draw")
	return true
end

function SWEP:Holster()
	self:OnRemove()
	return true
end

function SWEP:CanSecondaryAttack()
	return false
end

local pickupWhiteList = {
	["prop_ragdoll"] = true,
	["prop_physics"] = true,
	["prop_physics_multiplayer"] = true
}
function SWEP:CanPickup(ent)
	if ent:IsNPC() then return true end
	if(ent.IsLoot)then return true end
	local class=ent:GetClass()
	if pickupWhiteList[class] then return true end
	return true
end

function SWEP:PrimaryAttack()
	if not(IsFirstTimePredicted())then return end
	local tr = self.Owner:GetEyeTraceNoCursor()

 
	
	if SERVER then
		self:SetCarrying()
					  

		
		if((IsValid(tr.Entity))and(self:CanPickup(tr.Entity))and not(tr.Entity:IsPlayer()))then
			local Dist=(self.Owner:GetShootPos()-tr.HitPos):Length()
			if(Dist<self.ReachDistance)then
				if(tr.Entity.ContactPoisoned)then
					if(self.Owner.Murderer)then
						self.Owner:PrintMessage(HUD_PRINTTALK,"Отправлено!")
						return
					else
						tr.Entity.ContactPoisoned=false
						HMCD_Poison(self.Owner,tr.Entity.Poisoner)
					end
				end
				self:SetCarrying(tr.Entity,tr.PhysicsBone,tr.HitPos,Dist)
				tr.Entity.Touched=true
				self:ApplyForce()
			end
		elseif((IsValid(tr.Entity))and(tr.Entity:IsPlayer()))then
			local Dist=(self.Owner:GetShootPos()-tr.HitPos):Length()
			if(Dist<self.ReachDistance)then
				self.Owner:SetVelocity(self.Owner:GetAimVector()*20)
				tr.Entity:SetVelocity(-self.Owner:GetAimVector()*50)
				HMCD_StaminaPenalize(self.Owner,2)
				self:SetNextPrimaryFire(CurTime()+.25)
			end
		end

	end
end


function SWEP:ApplyForce()
	local target = self.Owner:GetAimVector() * self.CarryDist + self.Owner:GetShootPos()
	local phys = self.CarryEnt:GetPhysicsObjectNum(self.CarryBone)
	if IsValid(phys) and not (self.CarryEnt:GetClass()=="prop_ragdoll") then
		local TargetPos=phys:GetPos()
		if(self.CarryPos)then TargetPos=self.CarryEnt:LocalToWorld(self.CarryPos) end
		local vec = target - TargetPos
		local len,mul = vec:Length(),self.CarryEnt:GetPhysicsObject():GetMass()
		if((len>self.ReachDistance)or(mul>500))then
			self:SetCarrying()

			return
		end
		--if(self.CarryEnt:GetClass()=="prop_ragdoll")then mul=mul*2 end
		vec:Normalize()
		local avec,velo=vec*len,phys:GetVelocity()-self.Owner:GetVelocity()
		local CounterDir,CounterAmt=velo:GetNormalized(),velo:Length()
		if(self.CarryPos)then
			phys:ApplyForceOffset((avec-velo/2)*mul,self.CarryEnt:LocalToWorld(self.CarryPos))
		else
			phys:ApplyForceCenter((avec-velo/2)*mul)
		end
		phys:ApplyForceCenter(Vector(0,0,mul))
		phys:AddAngleVelocity(-phys:GetAngleVelocity()/10)
	end


--Ragdoll force
	local ragtarget = self.Owner:GetAimVector() * -50 + self.Owner:GetShootPos()
	local ragphys = self.CarryEnt:GetPhysicsObjectNum(self.CarryBone)
	

		ragvec:Normalize()
		
		local ragtvec = ragvec * raglen * 15
		local ragavec = ragtvec - ragphys:GetVelocity()
		ragavec = ragavec:GetNormal() * math.min(45, ragavec:Length())
		ragavec = ragavec / ragphys:GetMass() * 0
		
		ragphys:AddVelocity(ragavec)
	end


function SWEP:OnRemove()
	if(IsValid(self.Owner) and CLIENT and self.Owner:IsPlayer())then
		local vm=self.Owner:GetViewModel()
		if(IsValid(vm)) then vm:SetMaterial("") end
	end
end

function SWEP:GetCarrying()
	return self.CarryEnt
end

function SWEP:SetCarrying(ent,bone,pos,dist)
	if IsValid(ent) then

		self.CarryEnt = ent
		self.CarryBone = bone
		self.CarryDist=dist
		if not (ent:GetClass()=="prop_ragdoll") then
			self.CarryPos=ent:WorldToLocal(pos)
		else
			self.CarryPos=nil
		end
	else
		self.CarryEnt = nil
		self.CarryBone = nil
		self.CarryPos = nil
		self.CarryDist=nil
	end
	self.Owner:CalculateSpeed()

end


--[[function SWEP:SetCarrying(ent, bone)
	if IsValid(ent) then
		self.CarryEnt = ent
		self.CarryBone = bone

	else
		self.CarryEnt = nil
		self.CarryBone = nil
	end
	
	self.Owner:CalculateSpeed()
end]]--
 
local function lookingAtLockable(ply, ent, hitpos)
    local eyepos = ply:EyePos()
    return IsValid(ent)
        and ent:isKeysOwnable()
        and (
            ent:isDoor() and eyepos:DistToSqr(hitpos) < 2000
            or
            ent:IsVehicle() and eyepos:DistToSqr(hitpos) < 4000
        )
end

function SWEP:Think()
	local tr = self.Owner:GetEyeTraceNoCursor()
	local Dist=(self.Owner:GetShootPos()-tr.HitPos):Length()
	if((IsValid(self.Owner))and(self.Owner:KeyDown(IN_ATTACK)))then
		if IsValid(self.CarryEnt) then
			self:ApplyForce()
		end
	elseif self.CarryEnt then
		self:SetCarrying()
	end
	if((self.Owner:KeyDown(IN_ATTACK)))then
		self:SetNextSecondaryFire(CurTime()+.5)
	end
	local Owner = self:GetOwner()
	if((IsValid(tr.Entity))and(self:CanPickup(tr.Entity))and not(tr.Entity:IsPlayer()) and (Dist<self.ReachDistance)) and self.Owner:KeyPressed(IN_ATTACK) or self.Owner:KeyReleased(IN_ATTACK) then
	self:SetHoldType(self.Owner:KeyDown(IN_ATTACK) and "magic" or "normal")
	elseif self.Owner:KeyPressed(IN_ATTACK) or self.Owner:KeyReleased(IN_ATTACK) then self:SetHoldType(self.Owner:KeyDown(IN_ATTACK) and "pistol" or "normal")
	end	
end





function SWEP:Reload()
	if not(IsFirstTimePredicted())then return end

	return end

	--self:SetCarrying()
--end

function SWEP:DrawWorldModel()
	-- no, do nothing
end

--[[function SWEP:DoBFSAnimation(anim)
	local vm=self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
end]]--

function SWEP:UpdateNextIdle()
	local vm=self.Owner:GetViewModel()
	self:SetNextIdle(CurTime()+vm:SequenceDuration())
end

function SWEP:IsEntSoft(ent)
	return ((ent:IsNPC())or(ent:IsPlayer()))
end



local playerMeta = FindMetaTable( "Player" )

function playerMeta:CalculateSpeed()
	
    local walk = 95-- nut.config.get("walkSpeed", default)
    local run = 170



	local wep = self:GetActiveWeapon()
	if IsValid(wep) then
		if wep.GetCarrying and wep:GetCarrying() then
			walk = walk * 0.5
			run = run * 0.7

		end
	end 



	self:SetWalkSpeed(walk)
	self:SetRunSpeed(run)


end