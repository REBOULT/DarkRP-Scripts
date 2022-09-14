if CLIENT then

	local bindPressed = false
	local lastAng = Angle()
	local recoilCone = 0
	
	local cameraPos = Vector()
	local cameraAng = Angle()
	local cameraZoom = false
	local zoom = 0
	
	local cameraFree = false;
	
	
	concommand.Add("+thirdperson_etp_free", function(ply, cmd, args)
		cameraFree = true
	end)

	concommand.Add("-thirdperson_etp_free", function(ply, cmd, args)
		cameraFree = false
	end)
	
	concommand.Add("thirdperson_enhanced_toggle", function(ply, cmd, args)
		local thirdperson = GetConVar("thirdperson_etp")
		
		thirdperson:SetBool(!thirdperson:GetBool())
		
		if thirdperson then
			cameraPos = ply:EyePos()
			cameraAng = ply:EyeAngles()
		end

		if GetConVar("thirdperson_etp_addons_sync"):GetBool() and ConVarExists("gtvh_firstperson") then
			if thirdperson:GetBool() then
				if GetConVar("gtvh_firstperson"):GetInt() == 1 then
					ply:ConCommand("gtvh_firstperson 0")
				end
			else
				if GetConVar("gtvh_firstperson"):GetInt() == 0 then
					ply:ConCommand("gtvh_firstperson 1")
				end
			end
		end
		
		local vsync = GetConVar("thirdperson_etp_vehicles_sync"):GetBool()

		if vsync and ply:InVehicle() then
			local veh = ply:GetVehicle()
			if thirdperson:GetBool() then
				veh:SetThirdPersonMode(true)
			else
				veh:SetThirdPersonMode(false)
			end
		end
	end)

	hook.Add("CalcView", "ThirdpersonEnhanced_CalcView", function(ply, pos, ang, fov, znear, zfar)
		local crouchadd = GetConVar("thirdperson_etp_crouchadd"):GetFloat()
		local thirdperson = GetConVar("thirdperson_etp"):GetBool()
		local offsetX = GetConVar("thirdperson_etp_offset_x"):GetFloat()
		local offsetY = GetConVar("thirdperson_etp_offset_y"):GetFloat()
		local offsetZ = GetConVar("thirdperson_etp_offset_z"):GetFloat()
		local angleX = GetConVar("thirdperson_etp_angle_x"):GetFloat()
		local angleY = GetConVar("thirdperson_etp_angle_y"):GetFloat()
		local angleZ = GetConVar("thirdperson_etp_angle_z"):GetFloat()
		local headPos = GetConVar("thirdperson_etp_headpos"):GetBool()
		local fov = GetConVar("thirdperson_etp_fov"):GetInt()
		local smoothing = GetConVar("thirdperson_etp_smoothing"):GetBool()
		local smoothingSpeed = GetConVar("thirdperson_etp_smoothing_speed"):GetFloat() / 3.5
		
		if ply:Crouching() and !headPos then 
			offsetZ = offsetZ + crouchadd 
		end
		
		if thirdperson and !ply:InVehicle() and ply:Alive() then
		
			ply.CustomView = ply.CustomView or Angle()
			
			local newAng = ply.CustomView
			local newPos = Vector(pos.x, pos.y, pos.z)
			
			if (headPos) then
				local headBone = ply:LookupBone("ValveBiped.Bip01_Head1")

				if (headBone and headBone > 0) then
					local headPos = ply:GetBonePosition(headBone)
					newPos = headPos
				end
			end

			newPos = newPos + newAng:Right() * offsetY
			newPos = newPos + newAng:Up() * offsetZ
			newPos = newPos + newAng:Forward() * offsetX

			local tr = util.TraceHull({
				start = pos,
				endpos = newPos,
				filter = ply,
				maxs = Vector(5, 5, 5),
				mins = Vector(-5, -5, -5)
			})
			
			pos = tr.HitPos
			
			if !GetConVar("thirdperson_etp_aim"):GetBool() then
				newAng.x = angleX
				newAng.y = angleY
				newAng.z = angleZ
			end
			
			if smoothing then
				cameraPos = LerpVector( FrameTime() * smoothingSpeed, cameraPos, pos )
				cameraAng = LerpAngle( FrameTime() * smoothingSpeed, cameraAng, newAng )
			else 
				cameraPos = pos
				cameraAng = newAng
			end

			local view = {
				drawviewer = true,
				origin = cameraPos,
				fov = fov,
				angles = cameraAng + ply:GetViewPunchAngles(),
				znear = znear,
				zfar = zfar
			}
			
			return view
		end
	end)
	
	hook.Add("RenderScreenspaceEffects", "ThirdpersonEnhanced_RenderScreenspaceEffects", function()
		cam.Start3D(EyePos(),EyeAngles())
		cam.End3D()
	end)
	
	hook.Add("ShouldDrawLocalPlayer", "ThirdpersonEnhanced_ShouldDrawLocalPlayer", function(ply)
		if GetConVar("thirdperson_etp"):GetBool() then 
			return true
		end
	end)

	hook.Add("CreateMove", "ThirdpersonEnhanced_CreateMove", function(cmd)
		local ply = LocalPlayer()
		local thirdperson = GetConVar("thirdperson_etp"):GetBool()
		local aim = GetConVar("thirdperson_etp_aim"):GetBool()

		if aim and thirdperson and !ply:InVehicle() and ply:Alive() then
			ply.CustomView = ply.CustomView or Angle()
			
			local pos = EyePos()
			
			local tr = util.TraceLine({
				start = pos,
				endpos = pos + ply.CustomView:Forward() * 100000,
				filter = ply
			})

			local newEyeAng = Angle()
			
			if cameraFree then
				newEyeAng = (ply:EyePos()):Angle()
			else
				newEyeAng = (tr.HitPos - ply:EyePos()):Angle()
			end
			
			newEyeAng = Angle(newEyeAng.p, newEyeAng.y, 0)
			newEyeAng = LerpAngle(FrameTime() * 20, ply:EyeAngles(), newEyeAng)
			
			local plyang = cmd:GetViewAngles()

			if lastAng ~= plyang then
				local dif = (plyang - lastAng)
				ply.CustomView.y = ply.CustomView.y + dif.y
				ply.CustomView.p = math.Clamp(ply.CustomView.p + dif.p, -89, 89)
			end

			cmd:SetViewAngles(newEyeAng)
			
			lastAng = newEyeAng
			
			net.Start("EnhancedThirdperson_SendCustomView")
			net.WriteAngle(ply.CustomView)
			net.SendToServer()
		end
		
		if (system.IsLinux() or system.HasFocus()) and !vgui.GetKeyboardFocus() and !gui.IsGameUIVisible() and !gui.IsConsoleVisible() then
			local bindKey = GetConVar("thirdperson_etp_bind"):GetInt()
			
			if input.IsKeyDown(bindKey) then
				bindPressed = true
			else
				if bindPressed then
					ply:ConCommand("thirdperson_enhanced_toggle")
					bindPressed = false
				end
			end
		end
	end)

	if game.SinglePlayer() then
		net.Receive("EnhancedThirdpersonShoot", function()
			local spread = net.ReadDouble()
			recoilCone = math.Clamp(recoilCone + spread * 200, 0, 30)
		end)
	end

	hook.Add("EntityFireBullets", "ThirdpersonEnhanced_EntityFireBullets", function(ent, tabl)
		local style = GetConVar("thirdperson_etp_crosshair_style"):GetInt() != 0
		if style and IsValid(ent) and ent:IsPlayer() and ent == LocalPlayer() then
			recoilCone = math.Clamp(recoilCone + tabl.Spread:Length2D() * 200, 0, 30)
		end
	end)

	hook.Add("HUDPaint", "ThirdpersonEnhanced_HUDPaint", function()
		local ply = LocalPlayer()
		local thirdperson = GetConVar("thirdperson_etp"):GetBool()
		local crosshair = GetConVar("thirdperson_etp_crosshair"):GetBool()
		local outline = GetConVar("thirdperson_etp_crosshair_outline"):GetBool()
		local style = GetConVar("thirdperson_etp_crosshair_style"):GetInt()
		local dot = GetConVar("thirdperson_etp_crosshair_dot"):GetBool()
		local gap = 0
		
		local crosshairColor = Color(
			GetConVar("thirdperson_etp_crosshair_r"):GetInt(),
			GetConVar("thirdperson_etp_crosshair_g"):GetInt(),
			GetConVar("thirdperson_etp_crosshair_b"):GetInt(),
			GetConVar("thirdperson_etp_crosshair_alpha"):GetInt()
		)
		
		local outlineColor = Color(
			GetConVar("thirdperson_etp_crosshair_outline_r"):GetInt(), 
			GetConVar("thirdperson_etp_crosshair_outline_g"):GetInt(), 
			GetConVar("thirdperson_etp_crosshair_outline_b"):GetInt(),
			GetConVar("thirdperson_etp_crosshair_outline_alpha"):GetInt()
		)
		
		local crosshairSize = GetConVar("thirdperson_etp_crosshair_size"):GetFloat()
		local outlineSize = crosshairSize + 1
		
		if thirdperson and crosshair and !ply:InVehicle() and ply:Alive() then

			local px = (ScrW() / 2)
			local py = (ScrH() / 2)
			
			if dot then
				if outline then
					surface.DrawCircle(px, py, outlineSize + 0.1, outlineColor)
				end
				
				for i = 1, crosshairSize do
					surface.DrawCircle(px, py, i + 0.1, crosshairColor)
				end
			end
			
			if style != 0 then
			
				local wep = ply:GetActiveWeapon()
				
				if IsValid(wep) and wep.CalculateConeRecoil then
					recoilCone = math.Clamp((wep:CalculateConeRecoil() * 90) / ply:GetFOV() * ScrH() / 1.44, 6, py)
				else
					recoilCone = Lerp(math.min(FrameTime() * 12, 1), recoilCone, 13)
				end
				
				gap = GetConVar("thirdperson_etp_crosshair_gap"):GetFloat() * recoilCone
				
			end
			
			if style == 1 then

				if outline then
					surface.DrawCircle(px, py, gap + outlineSize + 0.1, outlineColor)
					surface.DrawCircle(px, py, gap + 0.1, outlineColor)
				end
				
				for i = 1, crosshairSize do
					surface.DrawCircle(px, py, gap + i + 0.1, crosshairColor)
				end
				
			elseif style == 2 then
			
				local length = 15
				local x1 = gap + px
				local y1 = py - crosshairSize / 2
				local x2 = px - gap - length
				local y2 = py - crosshairSize / 2
				local x3 = px - crosshairSize / 2
				local y3 = gap + py
				local x4 = px - crosshairSize / 2
				local y4 = py - gap - length
				
				if outline then
					surface.SetDrawColor( outlineColor )
					surface.DrawOutlinedRect( x1 - 1, y1 - 1, length + 2, crosshairSize + 2 )
					surface.DrawOutlinedRect( x2 - 1, y2 - 1, length + 2, crosshairSize + 2 )
					surface.DrawOutlinedRect( x3 - 1, y3 - 1, crosshairSize + 2, length + 2 )
					surface.DrawOutlinedRect( x4 - 1, y4 - 1, crosshairSize + 2, length + 2 )
				end
				
				surface.SetDrawColor( crosshairColor )
				surface.DrawRect( x1, y1, length, crosshairSize )
				surface.DrawRect( x2, y2, length, crosshairSize )
				surface.DrawRect( x3, y3, crosshairSize, length )
				surface.DrawRect( x4, y4, crosshairSize, length )
			end
		end
	end)

	hook.Add( "HUDShouldDraw", "ThirdpersonEnhanced_HUDShouldDraw", function(name)
		local thirdperson = GetConVar("thirdperson_etp"):GetBool()
		local crosshair = GetConVar("thirdperson_etp_crosshair"):GetBool()
		
		if thirdperson and crosshair then
			if (name == "CHudCrosshair") then
				return false
			end
		else
			if (name == "CHudCrosshair") then
				return true
			end
		end
	end)

elseif SERVER then

	util.AddNetworkString("EnhancedThirdperson_SendCustomView")
	
	if game.SinglePlayer() then
		util.AddNetworkString("EnhancedThirdpersonShoot")

		hook.Add("EntityFireBullets", "EnhancedThirdpersonShootCLWorkaround", function(ent, tabl)
			if IsValid(ent) and ent:IsPlayer() then
				local thirdPerson = ent:GetInfoNum("thirdperson_etp", 0) == 1

				local style = ent:GetInfoNum("thirdperson_etp_crosshair_style", 0) != 0
				if thirdPerson and style then
					net.Start("EnhancedThirdpersonShoot")
						net.WriteDouble(tabl.Spread:Length2D())
					net.Send(ent)
				end
			end
							
		end)

	end

	net.Receive("EnhancedThirdperson_SendCustomView", function(len, ply)
		ply.CustomView = net.ReadAngle()
	end)

	hook.Add("PlayerEnteredVehicle", "ThirdpersonEnhanced_PlayerEnteredVehicle", function(ply, veh, role)
		local thirdperson = ply:GetInfoNum("thirdperson_etp", 0) == 1
		local vsync = ply:GetInfoNum("thirdperson_etp_vehicles_sync", 0) == 1
		
		if IsValid(veh) and vsync then
			if thirdperson then
				veh:SetThirdPersonMode(true)
			else
				veh:SetThirdPersonMode(false)
			end
		end
	end)

	hook.Add("PlayerLeaveVehicle", "ThirdpersonEnhanced_PlayerLeaveVehicle", function(ply, veh)
		local vsync = ply:GetInfoNum("thirdperson_etp_vehicles_sync", 0) == 1
		
		if IsValid(veh) and vsync then
			if veh:GetThirdPersonMode() then
				ply:ConCommand("thirdperson_etp 1")
			else
				ply:ConCommand("thirdperson_etp 0")
			end
		end
	end)
end

hook.Add("SetupMove", "ThirdpersonEnhanced_SetupMove", function(ply, mv)

	local thirdperson = ply:GetInfoNum("thirdperson_etp", 0) == 1
	
	if thirdperson and !ply:InVehicle() and ply:Alive() then
		ply.CustomView = ply.CustomView or Angle()
		mv:SetMoveAngles(ply.CustomView)
	end
end)
