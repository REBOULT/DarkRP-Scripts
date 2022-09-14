
local nodamage = {
	prop_fix		= true,
	prop_physics 	= true,
	prop_dynamic 	= true,
	donation_box 	= true,
	gmod_winch_controller = true,
	gmod_poly 		= true,
	gmod_button 	= true,
	gmod_balloon 	= true,
	gmod_cameraprop = true,
	gmod_emitter 	= true,
	gmod_light 		= true,
	keypad          = true,
    gmod_poly       = true,
    ent_picture 	= true
}

local nocolide = {
	prop_fix		= true,
	prop_physics 		= true,
	prop_dynamic 		= true,
	func_door 			= true,
	func_door_rotating	= true,
	prop_door_rotating	= true,
	spawned_food		= true,
	func_movelinear 	= true,
	ent_picture 		= true
}


hook.Add('PlayerShouldTakeDamage', 'AntiPK_PlayerShouldTakeDamage', function(victim, attacker)
	if nodamage[attacker:GetClass()] or victim:IsPlayer() and attacker:IsVehicle() then 
		return false
	end
end)

hook.Add('EntityTakeDamage', 'AntiPK.EntityTakeDamage', function(pl, dmginfo)
	if (dmginfo:GetDamageType() == DMG_CRUSH) then
		return true
	end
end)

hook.Add('ShouldCollide', 'AntiPK_NoColide', function(ent1, ent2)
	if IsValid(ent1) and IsValid(ent2) and nocolide[ent1:GetClass()] and nocolide[ent2:GetClass()] then
		return false
	end
end)

hook.Add('PlayerSpawnedProp', 'AntiPk_OnEntityCreated', function(pl, mdl, ent)
	ent:SetCustomCollisionCheck(true)
end)



net.Receive("UserGroup",function (len, ply)
	DarkRP.notifyAll(1,4,ply:Nick().." уебан и был нахуй кикнут")
	RunConsoleCommand("sam","banid", ply:SteamID(), "0", " Пойди-ка отсоси у коня епта")
end)