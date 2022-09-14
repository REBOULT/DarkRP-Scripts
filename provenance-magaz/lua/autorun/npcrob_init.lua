
NPCRobSystem = {}

print("Loading NPC Store/Rob System")
if SERVER then

--	resource.AddWorkshop("915891086")

	include("storerob_core/config/sh_config.lua")
	include("storerob_core/config/sh_language.lua")
	include("storerob_core/core/sv_netmsg.lua")
	include("storerob_core/core/sv_buyitem.lua")

	AddCSLuaFile("storerob_core/config/sh_config.lua")
	AddCSLuaFile("storerob_core/config/sh_language.lua")
	AddCSLuaFile("storerob_core/dermas/cl_core.lua")
	AddCSLuaFile("storerob_core/dermas/cl_fonts.lua")
	AddCSLuaFile("storerob_core/dermas/cl_robui.lua")
	AddCSLuaFile("storerob_core/dermas/cl_storeui.lua")

	local savedStores = false
	hook.Add( "InitPostEntity", "savedstore_spawning", function()
		file.CreateDir( "stores" )
		if not file.Exists( "stores/storefile.txt", "DATA" ) then
			file.Write( "stores/storefile.txt", util.TableToJSON( {} ) )
		else
			savedStores = util.JSONToTable( file.Read( "stores/storefile.txt", "DATA" ) )
		end
	
		if savedStores then
			for _, data in pairs( savedStores ) do
				print("Store spawned")
				local store = ents.Create( "storerob_corenpc" )
				store:SetPos( data.pos )
				store:SetAngles( data.ang )
				store:Spawn()
			end
		end
	end )

end

if CLIENT then

	include("storerob_core/config/sh_config.lua")
	include("storerob_core/config/sh_language.lua")
	include("storerob_core/dermas/cl_core.lua") 
	include("storerob_core/dermas/cl_fonts.lua")
	include("storerob_core/dermas/cl_robui.lua")
	include("storerob_core/dermas/cl_storeui.lua")

end
print("Loaded NPC Store/Rob System")

-- t.me/urbanichka