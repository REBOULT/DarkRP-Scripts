local positions = {
	rp_bangclaw_rld = {
		{Pos = Vector( 5578.652832, -2752.711182, 254.486450 ), Ang = Angle( 0, 0, 90.000000 ), Size = {w = 360, h = 290}, Name = "lox", URL = "https://media.discordapp.net/attachments/1007008340620103791/1007009601247522827/lox.jpg"},

	}
}

for k, v in pairs(positions[game.GetMap()]) do
	http.Fetch( v.URL, function( data )
		file.Write( v.Name .. ".jpg", data )
	end )
end

hook.Add( "PostDrawTranslucentRenderables", "UmbrellaLogo", function()
	if not positions[game.GetMap()] then return end
   local lp_pos = LocalPlayer():GetPos()
	for k, v in pairs(positions[game.GetMap()]) do
		if lp_pos:DistToSqr( v.Pos ) < 3000000 then
			local w,h = v.Size.w, v.Size.h
			cam.Start3D2D( v.Pos, v.Ang, 0.396 )
				surface.SetMaterial( Material( "data/"  .. v.Name .. ".jpg" ) )
				surface.SetDrawColor( Color( 255, 255, 255 ) )
				surface.DrawTexturedRect( -w/2, -h/2, w, h )
			cam.End3D2D( )
		end
	end
end )
