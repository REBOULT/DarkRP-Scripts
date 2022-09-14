Liko = Liko or {}

Liko.Settings = Liko.Settings or {}

    	

surface.CreateFont( "LikoFontCloseGUI", 

{

	size = 14,

	weight = 700,

	antialias = true,

	shadow = false,

	font = "Marlett"

})



surface.CreateFont( "LikoFontNetworkName", 

{

	size = 34,

	weight = 400,

	antialias = true,

	shadow = false,

	font = "Advent Pro Light"

})



surface.CreateFont( "LikoFontMenuItem", 

{

	size = 22,

	weight = 600,

	antialias = true,

	shadow = false,

	font = "Oswald Light"

})



surface.CreateFont( "LikoFontBrowserTitle", 

{

	size = 26,

	weight = 100,

	antialias = true,

	shadow = false,

	font = "Teko Light"

})



surface.CreateFont( "LikoFontMenuSubinfo", 

{

	size = 18,

	weight = 300,

	antialias = true,

	shadow = false,

	font = "Oswald Light"

})



surface.CreateFont( "LikoFontAnnouncementText", 

{

	size = 14,

	weight = 500,

	antialias = true,

	shadow = false,

	font = "Marlett"

})



surface.CreateFont("LikoFontServerInfo",

{

	size = 22,

	weight = 300,

	antialias = true,

	shadow = false,

	font = "Oswald Light"

})



surface.CreateFont( "LikoFontServerTitle", 

{

	size = 38,

	weight = 100,

	antialias = true,

	shadow = false,

	font = "Teko Light"

})



surface.CreateFont( "LikoFontButtonItem", 

{

	size = 25,

	weight = 400,

	antialias = true,

	shadow = false,

	font = "Oswald Light"

})



surface.CreateFont( "LikoFontClock", 

{

	size = 40,

	weight = 100,

	antialias = true,

	shadow = false,

	font = "Teko Light"

})






function draw.LikoBox( x, y, w, h, color )

	surface.SetDrawColor( color )

	surface.DrawRect( x, y, w, h )

end



local blur = Material("pp/blurscreen")

function DrawBlurPanel( panel, amount, heavyness )

	local x, y = panel:LocalToScreen(0, 0)

	local scrW, scrH = ScrW(), ScrH()



	surface.SetDrawColor( 255, 255, 255 )

	surface.SetMaterial( blur )



	for i = 1, ( heavyness or 3 ) do

		blur:SetFloat( "$blur", ( i / 2 ) * ( amount or 6 ) )

		blur:Recompute()



		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect( x * -1, y * -1, scrW, scrH )

	end

end



function Liko:guiMenu()



	if IsValid( LikoPanelMenu ) then

		if not LikoPanelMenu.Closed then 

			LikoPanelMenu:SetVisible( false ) 

			LikoPanelMenu.Closed = true 

			return

		elseif LikoPanelMenu.Closed then

			LikoPanelMenu:SetVisible( true ) 

			LikoPanelMenu.Closed = false 

			return

		end

	end



	LikoPanelMenu = vgui.Create( "DPanel" )

	LikoPanelMenu:SetSize( ScrW(), ScrH() )

	LikoPanelMenu:MakePopup()

	LikoPanelMenu.Paint = function( self, w, h )

		DrawBlurPanel( self )
		LikoPanelMenu:AlphaTo(0, 1.2, 10)
		draw.LikoBox( 0, 0, w, h, Color( 0, 0, 0, 150 ) )

	end



	local dhtmlBackground = LikoPanelMenu

	if Liko.Settings.BackgroundsEnable and Liko.Settings.Backgrounds then

		dhtmlBackground = vgui.Create( "DHTML", LikoPanelMenu )

		dhtmlBackground:SetSize( ScrW(), ScrH() )

		dhtmlBackground:SetScrollbars( false )

		dhtmlBackground:SetHTML(

		[[

			<body style="overflow: hidden; height: 100%; width: 100%;">

	 			<img src="]] .. table.Random( Liko.Settings.Backgrounds ) .. [[" style="position: absolute; height: auto; width: auto; top: -50%; left: -50%; bottom: -50%; right: -50%; margin: auto;">

	 		</body>

		]])

		dhtmlBackground.Paint = function( self, w, h )

			DrawBlurPanel( self )

		end

	end



	if Liko.Settings.AnnouncementEnabled then



		local panelRight = vgui.Create( "DPanel", dhtmlBackground )

		if Liko.Settings.AdvertisementEnable then

			panelRight:SetSize( 400, 500 )

		else

			panelRight:SetSize( 400, 400 )

		end

		panelRight:SetPos( ScrW() - 550, Liko.Settings.PaddingFromTop )

		panelRight.Paint = function( self, w, h )

			DrawBlurPanel( self )

			draw.RoundedBox( 0, 0, 0, 400, 500, Color( 64, 105, 126, 200 ) )



			surface.SetDrawColor( Color ( 255, 255, 255, 255 ) )

			surface.DrawLine( 0, 15, 0, 0 ) 

			surface.DrawLine( 15, 0, 0, 0 ) 



			surface.SetDrawColor( Color ( 255, 255, 255, 255 ) )

			surface.DrawLine( w - 20, h - 1, w, h - 1 ) 

			surface.DrawLine( w - 1, h, w - 1, h - 20 ) 



			surface.DrawLine( w - 14, 80, 14, 80 ) 



		end



		local txtNewsPlaceholder = vgui.Create( "DTextEntry", panelRight )

		txtNewsPlaceholder:SetPos( 15, 45 )

		txtNewsPlaceholder:SetMultiline( true )

		txtNewsPlaceholder:SetDrawBackground( false )

		txtNewsPlaceholder:SetEnabled( true )

		txtNewsPlaceholder:SetSize( 350, 300 ) 

		txtNewsPlaceholder:SetVerticalScrollbarEnabled( false )

		txtNewsPlaceholder:SetFont( "LikoFontNetworkName" )

		txtNewsPlaceholder:SetText( Liko.Settings.NetworkName )

		txtNewsPlaceholder:SetTextColor( Liko.Settings.NetworkNameColor )



		local txtServerMap = vgui.Create( "DLabel", panelRight )

		txtServerMap:SetPos( 20, 15 )

		txtServerMap:SetSize( 250, 35 )

		txtServerMap:SetText( game.GetMap() )

		txtServerMap:SetFont( "LikoFontServerInfo" )



		local txtServerPlayers = vgui.Create( "DLabel", panelRight )

		txtServerPlayers:SetPos( txtNewsPlaceholder:GetWide() - 35, 15 )

		txtServerPlayers:SetSize( 250, 35 )

		txtServerPlayers:SetText( table.Count( player.GetAll() ) .. " / " .. game.MaxPlayers() .. " людей"  )

		txtServerPlayers:SetFont( "LikoFontServerInfo" )



		local txtNews = vgui.Create( "DTextEntry", panelRight )

		txtNews:SetPos( 15, 95 )

		txtNews:SetMultiline( true )

		txtNews:SetDrawBackground( false )

		txtNews:SetEnabled( true )

		if ( Liko.Settings.AdvertisementEnable and Liko.Settings.AdvertisementsWebm ) or ( Liko.Settings.AdvertisementEnable and Liko.Settings.AdvertisementsYouTube ) then

			txtNews:SetSize( 370, 160 ) 

		else

			txtNews:SetSize( 370, 285 ) 

		end

		txtNews:SetVerticalScrollbarEnabled( true )

		txtNews:SetFont( "LikoFontAnnouncementText" )

		txtNews:SetText( Liko.Settings.AnnouncementText  )

		txtNews:SetTextColor( Color(255, 255, 255, 255) )



		local dhtmlVideo = LikoPanelMenu

		if ( Liko.Settings.AdvertisementEnable and Liko.Settings.AdvertisementsWebm ) or ( Liko.Settings.AdvertisementEnable and Liko.Settings.AdvertisementsYouTube ) then

			dhtmlVideo = vgui.Create( "DHTML", panelRight )

			dhtmlVideo:Dock( BOTTOM )

			dhtmlVideo:SetSize( 330, 250 )

			dhtmlVideo:SetScrollbars( false )

			if !Liko.Settings.AdvertisementYouTubeEnabled then

				if Liko.Settings.AdvertisementWebmAutoplay then

					dhtmlVideo:SetHTML(

					[[

						<body style="overflow: hidden; height: 100%; width: 100%;">

				 			<video controls width="384" height="233" autoplay id="likovidbg"><source src="]] .. table.Random( Liko.Settings.AdvertisementsWebm ) .. [[" type="video/webm"></video>

				 		</body>

					]])

				else

					dhtmlVideo:SetHTML(

					[[

						<body style="overflow: hidden; height: 233px; width: 384px;">

				 			<video controls width="384" height="233" id="likovidbg"><source src="]] .. table.Random( Liko.Settings.AdvertisementsWebm ) .. [[" type="video/webm"></video>

				 		</body>

					]])

				end

				dhtmlVideo:RunJavascript( "var vid = document.getElementById('likovidbg'); vid.volume = " .. Liko.Settings.AdvertisementWebmStartvol .. ";" )

			else

				dhtmlVideo:SetHTML(

				[[

					<body style="overflow: hidden; height: 233px; width: 384px;">

				 		<iframe frameborder="0" width="384" height="233" src="]] .. table.Random( Liko.Settings.AdvertisementsYouTube ) .. [["></iframe> 

				 	</body>

				]])

			end

			dhtmlVideo.Paint = function( self, w, h )



			end

		end



	end



	local i = 0

	for k, v in pairs( Liko.Settings.Buttons ) do



		if v.enabled then



			local buttonCustom = vgui.Create( "DButton", dhtmlBackground )

			buttonCustom:SetText( "" )

			buttonCustom:SetSize( 300, 65 )

			buttonCustom:SetPos( 80, Liko.Settings.PaddingFromTop + i )



			local mat = false

			if v.icon and Liko.Settings.UseIconsWithText then

				mat = Material( v.icon, "noclamp smooth" )

				buttonCustom:SetSize( buttonCustom:GetWide() + 32, buttonCustom:GetTall() )

			elseif v.icon and Liko.Settings.UseServerIconsOnly then

				mat = Material( v.icon, "noclamp smooth" )

				buttonCustom:SetSize( 64, buttonCustom:GetTall() )

			end



			buttonCustom.Paint = function( self, w, h )



				local color = v.buttonNormal

				local txtColor = v.textNormal

				if self:IsHovered() or self:IsDown() then 

					color = v.buttonHover

					txtColor = v.textHover

				end

						

				surface.SetDrawColor( color )

				surface.DrawRect( 0, 0, w, h )



				surface.SetDrawColor( Color ( 255, 255, 255, 255 ) )

				surface.DrawLine( 0, 15, 0, 0 ) 

				surface.DrawLine( 15, 0, 0, 0 ) 



				surface.SetDrawColor( Color ( 255, 255, 255, 255 ) )

				surface.DrawLine( w - 20, h - 1, w, h - 1 ) 

				surface.DrawLine( w - 1, h, w - 1, h - 20 ) 



				if Liko.Settings.UseIconsWithText and mat then

							

					surface.SetDrawColor( txtColor )

					surface.SetMaterial( mat )

					surface.DrawTexturedRect( 25, self:GetTall() * .3, 32, 32 )



					surface.SetDrawColor( Color ( 190, 190, 190, 200 ) )

					surface.DrawLine( 85, self:GetTall(), 85, 0 ) 



					draw.SimpleText( string.upper( v.name ), "LikoFontMenuItem", 100, self:GetTall() * .4, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

					draw.SimpleText( string.upper( v.description ), "LikoFontMenuSubinfo", 100, self:GetTall() * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )



				else



					draw.SimpleText( string.upper( v.name ), "LikoFontMenuItem", 15, self:GetTall() * .4, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

					draw.SimpleText( string.upper( v.description ), "LikoFontMenuSubinfo", 15, self:GetTall() * .65, txtColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )



				end



			end



			buttonCustom.DoClick = v.func



			i = i + 75

			

		end



	end



	if table.Count( Liko.Settings.Servers ) > 0 and Liko.Settings.ServersEnabled then



		local ServerBox = vgui.Create("DPanel", dhtmlBackground)

		ServerBox:Dock( BOTTOM )

		ServerBox:SetTall( 60 )

		ServerBox.Paint = function( self, w, h )

			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 240 ) )

			draw.LikoBox( 0, 60, w, 2, Liko.Settings.BottomBarColor )

			surface.SetDrawColor( Liko.Settings.BottomBarColor )

			if Liko.Settings.ClockEnabled then

				surface.DrawLine( w - 200, 0, 0, 0 ) 

			else

				surface.DrawLine( w, 0, 0, 0 ) 

			end

		end



		local buttonCount = 0

		for k, v in pairs( Liko.Settings.Servers ) do



			local buttonCustom = vgui.Create( "DButton", ServerBox )

			buttonCustom:SetText( "" )



			surface.SetFont( "LikoFontButtonItem" )

			local sizex, sizey = surface.GetTextSize( string.upper( v.hostname ) )



			buttonCustom:SetSize( sizex + 20, 60 )

			buttonCustom:Dock( LEFT )

			buttonCustom:DockMargin( 20, 0, 0, 2)



			local mat = false

			if v.icon and Liko.Settings.UseIconsWithText then

			

				buttonCustom:SetSize( buttonCustom:GetWide() + 32, buttonCustom:GetTall() )

			elseif v.icon and Liko.Settings.UseServerIconsOnly then

			

				buttonCustom:SetSize( 64, buttonCustom:GetTall() )

			end



			buttonCustom.Paint = function( self, w, h )



				local color = Liko.Settings.ServerButtonColor

				local txtColor = Liko.Settings.ServerButtonTextColor

				if self:IsHovered() or self:IsDown() then 

					color = Liko.Settings.ServerButtonHoverColor

					txtColor = Liko.Settings.ServerButtonHoverTextColor

				end

				

				surface.SetDrawColor( color )

				surface.DrawRect( 0, 0, w, h )



				if Liko.Settings.UseIconsWithText and mat then

					

					surface.SetDrawColor( txtColor )

				
					

					surface.DrawTexturedRect( 5, 14, 32, 32 )



					draw.SimpleText( string.upper( v.hostname ), "LikoFontButtonItem", self:GetWide() / 2 + 16, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )



				elseif Liko.Settings.UseServerIconsOnly and mat then

					

					surface.SetDrawColor( txtColor )


					surface.DrawTexturedRect( 17, 14, 32, 32 )



				else



					draw.SimpleText( string.upper( v.hostname ), "LikoFontButtonItem", self:GetWide() / 2, self:GetTall() / 2, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )



				end

			end

			buttonCustom.DoClick = function()

				LocalPlayer():ConCommand("connect " .. v.ip)

			end



			buttonCount = buttonCount + 1



		end

	

	end





	function Liko:OpenURL( likoURL, LikoTitle )



		if IsValid(panelBrowser) then panelBrowser:Remove() end



		panelBrowser = vgui.Create( "DFrame", LikoPanelMenu )

		panelBrowser:SetPos( 100, 70 )

		if Liko.Settings.ServersEnabled then 

			panelBrowser:SetSize( ScrW() - 200, ScrH() - 250 )

		else

			panelBrowser:SetSize( ScrW() - 200, ScrH() - 190 )

		end

		panelBrowser:SetVisible( true )

		panelBrowser:MakePopup( )

		panelBrowser:ShowCloseButton(false)

		panelBrowser:SetTitle( "" )

		panelBrowser.Paint = function( self, w, h )

			DrawBlurPanel( self )

			surface.SetDrawColor(0,0,0,0)

			draw.RoundedBox( 4, 0, 0, w, h, Liko.Settings.BrowserColor )

			draw.DrawText( LikoTitle, "LikoFontBrowserTitle", panelBrowser:GetWide() / 2, 8, color_white, TEXT_ALIGN_CENTER )

		end



		local closeButton = vgui.Create("DButton", panelBrowser)

		closeButton:SetColor( Color( 255, 255, 255, 255 ) )

		closeButton:SetFont( "LikoFontCloseGUI" )

		closeButton:SetText("")

		closeButton.Paint = function()

			surface.SetDrawColor( Color(255,255,255,255) )



			surface.DrawTexturedRect( 0, 10, 16, 16 ) 

		end

		closeButton:SetSize( 32, 32 )

		closeButton:SetPos( panelBrowser:GetWide() - 30, 0)

		closeButton.DoClick = function()

			if IsValid( panelBrowser ) then panelBrowser:Remove() end

		end



		local dhtmlWindow = vgui.Create( "DHTML", panelBrowser )

		dhtmlWindow:SetSize( ScrW() - 200, 300 )

		dhtmlWindow:DockMargin( 10, 10, 5, 10 )

		dhtmlWindow:Dock( FILL )



		local dhtmlControlsBar = vgui.Create( "DHTMLControls", panelBrowser )

		dhtmlControlsBar:Dock( TOP )

		dhtmlControlsBar:SetWide( ScrW() - 200 )

		dhtmlControlsBar:SetPos( 0, 0 )

		dhtmlControlsBar:SetHTML( dhtmlWindow )

		dhtmlControlsBar.AddressBar:SetText( likoURL )



		dhtmlWindow:MoveBelow( dhtmlControlsBar )

		dhtmlWindow:OpenURL( likoURL )



	end



	function Liko:OpenText( likoText, LikoTitle )



		if IsValid( panelBrowser ) then panelBrowser:Remove() end



		panelBrowser = vgui.Create( "DFrame", LikoPanelMenu )

		panelBrowser:SetPos( 100, 70 )

		if Liko.Settings.ServersEnabled then 

			panelBrowser:SetSize( ScrW() - 200, ScrH() - 250 )

		else

			panelBrowser:SetSize( ScrW() - 200, ScrH() - 190 )

		end

		panelBrowser:SetVisible( true )

		panelBrowser:MakePopup( )

		panelBrowser:ShowCloseButton(false)

		panelBrowser:SetTitle( "" )

		panelBrowser.Paint = function( self, w, h )

			DrawBlurPanel( self )

			surface.SetDrawColor(0,0,0,0)

			draw.RoundedBox( 4, 0, 0, w, h, Liko.Settings.BrowserColor )

			draw.DrawText( LikoTitle, "LikoFontBrowserTitle", panelBrowser:GetWide() / 2, 8, color_white, TEXT_ALIGN_CENTER )

		end



		local closeButton = vgui.Create("DButton", panelBrowser)

		closeButton:SetColor( Color( 255, 255, 255, 255 ) )

		closeButton:SetFont( "LikoFontCloseGUI" )

		closeButton:SetText( "" )

		closeButton.Paint = function()

			surface.SetDrawColor( Color(255,255,255,255) )

		

			surface.DrawTexturedRect( 0, 10, 16, 16 ) 

		end

		closeButton:SetSize( 32, 32 )

		closeButton:SetPos( panelBrowser:GetWide() - 30, 0)

		closeButton.DoClick = function()

			if IsValid( panelBrowser ) then panelBrowser:Remove() end

		end



		local txtEntryMessage = vgui.Create( "DTextEntry", panelBrowser )

		txtEntryMessage:SetPos( 15, 80 )

		txtEntryMessage:SetMultiline( true )

		txtEntryMessage:SetDrawBackground( false )

		txtEntryMessage:SetEnabled( true )

		txtEntryMessage:SetSize( ScrW() - 225, ScrH() / 2 ) 

		txtEntryMessage:SetVerticalScrollbarEnabled( true )

		txtEntryMessage:SetFont( "LikoFontStandardText" )

		txtEntryMessage:SetText( likoText )

		txtEntryMessage:SetTextColor( Color(255, 255, 255, 255) )



	end



end



if Liko.Settings.KeybindAllowToggle then



	local nextThink = 0

	Liko.MenuKey = Liko.Settings.KeybindEnum or KEY_F7

	hook.Add("Think", "LikoOpenKey", function()

		if nextThink > CurTime() then return end



		if input.IsKeyDown( Liko.MenuKey ) then

			if ValidPanel( LikoPanelMenu ) then

				gui.HideGameUI()

				LikoPanelMenu:Remove()

			else

				gui.HideGameUI()

				Liko:guiMenu()

			end

			nextThink = CurTime() + 0.5

		end



	end)



end



if Liko.Settings.EscapeScreenToggle then



	hook.Add('PreRender', 'Liko:PreRender', function()

		if gui.IsGameUIVisible() and input.IsKeyDown( KEY_ESCAPE ) then

			if ValidPanel( LikoPanelMenu ) then

				gui.HideGameUI()

				LikoPanelMenu:Remove()

			else

				gui.HideGameUI()

				Liko:guiMenu()

			end

		end

	end)



end

-- vk.com/urbanichka