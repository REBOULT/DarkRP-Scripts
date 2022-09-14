if SERVER then
	util.AddNetworkString( "Scoreboard.Hidden" )
	net.Receive("Scoreboard.Hidden", function(len, ply)
		if IsValid(ply) and ply:IsAdmin() then
			ply:SetRogueNetBool("Incognito", !ply:GetRogueNetBool("Incognito", false))
		end
	end)
end

-- vk.com/urbanichka