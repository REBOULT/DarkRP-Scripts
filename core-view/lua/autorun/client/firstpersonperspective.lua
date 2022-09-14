CreateClientConVar("dayn", "1", true, true)
CreateClientConVar("dodik", "0.2", true, true)
CreateClientConVar("lox", "0", true, true)
CreateClientConVar("dura", "255", true, true)
CreateClientConVar("iv_in_g", "255", true, true)
CreateClientConVar("iv_in_b", "255", true, true)
CreateClientConVar("iv_in_a", "150", true, true)
CreateClientConVar("iv_out_r", "0", true, true)
CreateClientConVar("iv_out_g", "0", true, true)
CreateClientConVar("iv_out_b", "0", true, true)
CreateClientConVar("iv_out_a", "125", true, true)

local ViewOffsetUp = 0
local ViewOffsetForward = 3
local ViewOffsetForward2 = 0
local ViewOffsetLeftRight = 0
local RollDependency = 0.1
local CurView = nil
local holdType
local traceHit = false
local eyeAt

function IFPP_ShouldDrawLocalPlayer()
	if GetConVarNumber("dayn") > 0 then
		
		if traceHit and not LocalPlayer():InVehicle() then
			return false
		else
			return true
		end
	else
		return false
	end
end

hook.Add("ShouldDrawLocalPlayer", "IFPP_ShouldDrawLocalPlayer", IFPP_ShouldDrawLocalPlayer)

local function FirstPersonPerspective(ply, pos, angles, fov)
	eyeAtt = ply:GetAttachment(ply:LookupAttachment("eyes"))
	local forwardVec = ply:GetAimVector()
	local FT = FrameTime()
	local eyeAngles = ply:EyeAngles()
	local wep = ply:GetActiveWeapon()
	
	if GetConVarNumber("dayn") < 1 or not ply:Alive() or (traceHit and not ply:InVehicle()) or not eyeAtt then
		return
	end
	
	if not CurView then
		CurView = angles
	else
		CurView = LerpAngle(FT * (15 * (1 - math.Clamp(GetConVarNumber("iv_viewsmooth"), 0, 0.6))), CurView, angles + Angle(0, 0, eyeAtt.Ang.r * RollDependency))
	end
	
	if IsValid(wep) then
		holdType = wep:GetHoldType()
	else
		holdType = "normal"
	end





	if holdType then
		if holdType == "smg" or holdType == "ar2" or holdType == "rpg" then
			ViewOffsetLeftRight = math.Approach(ViewOffsetLeftRight, -1, 0.5)
		else
			ViewOffsetLeftRight = math.Approach(ViewOffsetLeftRight, 0, 0.5)
		end
	else
		ViewOffsetLeftRight = math.Approach(ViewOffsetLeftRight, 0, 0.5)
	end

	local view = {}
	
	if ply:WaterLevel() >= 3 then
		ViewOffsetUp = math.Approach(ViewOffsetUp, 0, 0.5)
		ViewOffsetForward = math.Approach(ViewOffsetForward, 8, 0.5)
		RollDependency = Lerp(FT * 15, RollDependency, 0.5)
	else
		ViewOffsetUp = math.Approach(ViewOffsetUp, math.Clamp(eyeAngles.p * -0.1, 0, 10), 0.5)
		ViewOffsetForward = math.Approach(ViewOffsetForward, 5 + math.Clamp(eyeAngles.p * 0.1, 0, 5), 0.5)
		RollDependency = Lerp(FT * 15, RollDependency, 0.05)
	end
	
	if ply:InVehicle() then
		ViewOffsetForward2 = 2
	else
		ViewOffsetForward2 = 0
	end
	
	if eyeAtt then
		view.origin = eyeAtt.Pos + (Vector(forwardVec.x * (ViewOffsetForward + ViewOffsetForward2), forwardVec.y * (ViewOffsetForward + ViewOffsetForward2), 0)) + Vector(-2.5, 0, ViewOffsetUp) + ply:GetRight() * ViewOffsetLeftRight
		view.angles = CurView
		view.fov = 90	
		view.znear = 0.1
			
		return GAMEMODE:CalcView(ply, view.origin, view.angles, view.fov, view.znear)
	end
end

hook.Add("CalcView", "FirstPersonPerspective", FirstPersonPerspective)

function IFPP_DotCrosshair()
	if GetConVarNumber("iv_crosshair") < 1 then
		return
	end

	local ply = LocalPlayer()

	if GetConVarNumber("dayn") < 1 or not ply:Alive() or traceHit then
		return
	end
	
	local IN_R = GetConVarNumber("iv_in_r")
	local IN_G = GetConVarNumber("iv_in_g")
	local IN_B = GetConVarNumber("iv_in_b")
	local IN_A = GetConVarNumber("iv_in_a")
	
	local OUT_R = GetConVarNumber("iv_out_r")
	local OUT_G = GetConVarNumber("iv_out_g")
	local OUT_B = GetConVarNumber("iv_out_b")
	local OUT_A = GetConVarNumber("iv_out_a")
	
	local traceline = {}
	traceline.start = ply:GetShootPos()
	traceline.endpos = traceline.start + ply:GetAimVector() * 3000
	traceline.filter = ply
	local trace = util.TraceLine(traceline)
	local pos = trace.HitPos:ToScreen()
		
	surface.SetDrawColor(OUT_R, OUT_G, OUT_B, OUT_A)
	surface.DrawRect(pos.x - 2, pos.y - 1, 5, 5)
	
	surface.SetDrawColor(IN_R, IN_G, IN_B, IN_A)
	surface.DrawRect(pos.x - 1, pos.y, 3, 3)
end

hook.Add("HUDPaint", "IFPP_DotCrosshair", IFPP_DotCrosshair)

function IFPP_Think()
	local ply = LocalPlayer()
	
	if GetConVarNumber("dayn") < 1 or not ply:Alive() then
		return
	end
	
	ply.BuildBonePositions = function(ply, numbon, numphysbon)
		if GetConVarNumber("dayn") < 1 then
			return
		end
		
		local bone = ply:LookupBone("ValveBiped.Bip01_Head1")
		local matrix = ply:GetBoneMatrix(bone)
			
		if matrix then
			matrix:Scale(Vector(0.001, 0.001, 0.001))
			matrix:Translate(Vector(0, 0, 0))
			ply:SetBoneMatrix(bone, matrix)
		end
	end
	
	local eyeAng = ply:EyeAngles()
	
	if eyeAtt then
	
		local forwardVec = ply:GetAimVector()
		
		local tr = {}
		tr.start = eyeAtt.Pos
		tr.endpos = tr.start + Vector(forwardVec.x, forwardVec.y, 0) * 20 -- by getting only the X and Y values, I can get what's ahead of the player, and not up/down, because other methods seem to fail.
		tr.filter = ply
		
		local trace = util.TraceLine(tr)
		
		if trace.Hit then
			traceHit = true
		else
			traceHit = false
		end
	end
end

hook.Add("Think", "IFPP_Think", IFPP_Think)

function IFPP_SetupMove(ucmd)
	if GetConVarNumber("dayn") <= 0 or not LocalPlayer():Alive() then
		return
	end
	
	local eyeAng = ucmd:GetViewAngles()
	
	ucmd:SetViewAngles(Angle(math.min(eyeAng.p, 65), eyeAng.y, eyeAng.r))
end

hook.Add("CreateMove", "IFPP_SetupMove", IFPP_SetupMove)