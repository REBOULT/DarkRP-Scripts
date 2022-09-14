
NPCRobSystem.plyStoreInterface = function()

	-- Defining things for later use
	local currentselected
	local textwhite = Color(255,255,255)
	local textblack = Color(0,0,0)
	local bargrey = Color(40,40,40)
	local darkred = Color(100, 0, 0)
	local lightred = Color(200, 0, 0)

	-- Creating the base panel
	local frame = vgui.Create( "DFrame" )
	frame:SetSize(ScrW()*1.0, ScrH()*1.9)
	if NPCRobSystem.Config.AnimateUISlide == true then 
		frame:SetPos(0-ScrW()*0.5, ScrH()*0.05)
		frame:MoveTo(ScrW()/2-((ScrW()*0.5)/2), ScrH()*0.05, 0.6, 0.1, 0.6)
	else
		frame:Center()
	end
	frame:SetTitle("")
	frame:SetVisible(true)
	frame:SetDraggable(false)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function( self, w, h )
		NPCRobSystem.Core.BlurFunc(frame, 3)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
		draw.RoundedBox(0, 0, 0, w, 25, bargrey)
	end

	-- Creating the close button
	local close = vgui.Create( "DButton", frame )
	close:SetPos(frame:GetWide()-25, 0)
	close:SetSize(25, 25)
	close:SetText("")
	local tablerp = 0
	close.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, darkred)
		draw.DrawText("X", "npcrob25", w/2, 0, textwhite, TEXT_ALIGN_CENTER)
	end
	close.DoClick = function()
		frame:Close()
	end

	if NPCRobSystem.Config.RobberySystem then
		-- Creating the rob button
		local robbutt = vgui.Create( "DButton", frame )
		robbutt:SetPos(3, 3)
		robbutt:SetSize(100, 20)
		robbutt:SetText("")
		local tablerp = 0
		robbutt.Paint = function(self, w, h)
			if robbutt:IsHovered() then
				tablerp = Lerp(0.1, tablerp, 0)
			else
				tablerp = Lerp(0.1, tablerp, w)
			end
			draw.RoundedBox(0, 0, 0, w, h, lightred)
			draw.RoundedBox(0, 0, 0, tablerp, h, darkred)
			draw.DrawText(NPCRobSystem.Language.RobStore, "npcrob20", w/2, 0, textwhite, TEXT_ALIGN_CENTER)
		end
		robbutt.DoClick = function()
			NPCRobSystem.plyRobInterface()
			frame:Close()
		end
	end

	-- Creating the button panel
	local button = vgui.Create( "DPanel", frame )
	button:SetPos(0, 25)
	button:SetSize(frame:GetWide(), 30)
	button.Paint = function() end


	-- Creating the button child panel (For lists)
	buttonscont = vgui.Create( "DPanelList", button )
	buttonscont:SetPos(0, 0)
	buttonscont:SetSize(button:GetWide(), button:GetTall())
	buttonscont:EnableHorizontal(true)
	buttonscont:SetSpacing(0)
	buttonscont.Paint = function() end

	-- Creating the content panel
	local clist = vgui.Create( "DPanel", frame )
	clist:SetPos(0, 60)
	clist:SetSize(frame:GetWide(), frame:GetTall()-60)
	clist.Paint = function() end

	-- Creating the content child panel (For lists)
	clistcont = vgui.Create( "DPanelList", clist )
	clistcont:SetPos(0, 0)
	clistcont:SetSize(clist:GetWide()+15,clist:GetTall())
	clistcont:EnableHorizontal(false)
	clistcont:EnableVerticalScrollbar(false)
	clistcont:SetSpacing(5)
	clistcont.Paint = function() end

	-- Creating the tab buttons
	for b, n in ipairs(NPCRobSystem.Config.ShopTabs) do

		-- Core tab panel
		local buttonpanel = vgui.Create("DButton", buttonscont)
		buttonpanel:SetSize(buttonscont:GetWide()/#NPCRobSystem.Config.ShopTabs, buttonscont:GetTall())
		buttonpanel:SetText("")

		-- For the slide animation
		local tablerp = 0
		-- Painitng the button
		buttonpanel.Paint = function(self,w,h)
			if buttonpanel:IsHovered() then
				tablerp = Lerp(0.1, tablerp, w)
			else
				tablerp = Lerp(0.1, tablerp, 0)
			end
			local backcolor
			if currentselected == n.display then
				backcolor =  Color(n.tabcolor.r, n.tabcolor.g, n.tabcolor.b, 150)
			else
				backcolor = Color(0, 0, 0, 150)
			end
			draw.RoundedBox(0, 0, 0, w, h, backcolor)
			draw.RoundedBox(0, 0, 0, 2, h, Color(n.tabcolor.r, n.tabcolor.g, n.tabcolor.b, 150))
			draw.RoundedBox(0, 0, 0, tablerp, h, Color(n.tabcolor.r, n.tabcolor.g, n.tabcolor.b, 150))
			draw.DrawText(n.display, "npcrob20", w/2, 5, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end

		-- Adding the button to the list
		buttonscont:AddItem(buttonpanel)
		

		-- Adding correct items when tab option is picked
		buttonpanel.DoClick = function()

			currentselected = n.display
			clistcont:Clear()
			for k, v in ipairs(NPCRobSystem.Config.ShopContent) do
				if n.display == v.tab then

					if not NPCRobSystem.Config.ShowUnpurchasable then
						if v.customCheck then
							if not v.customCheck(LocalPlayer()) then continue end
						end
					end

					local backshade

					if v.customCheck ~= nil then
						if v.customCheck(LocalPlayer()) then
							backshade = Color(0,0,0,100)
						else
							backshade = Color(155,0,0,100)
						end
					else
						backshade = Color(0,0,0,100)
					end

					-- this is the core panel for the item
					clistpanel = vgui.Create( "DPanel", clistcont )
					clistpanel:SetSize(clist:GetWide(), 60)
					clistpanel.Paint = function(self,w,h)
						draw.RoundedBox(0, 0, 0, w, h, backshade)
						draw.DrawText(v.name, "npcrob40", w/2, 0, textwhite, TEXT_ALIGN_CENTER)
						draw.DrawText(v.desc, "npcrob20", w/2, h-22, textwhite, TEXT_ALIGN_CENTER)
					end

					-- this is the buy button
					local button = vgui.Create( "DButton", clistpanel )
					button:SetSize(clistpanel:GetWide()*0.2, 50)
					button:SetPos(clistpanel:GetWide()-clistpanel:GetWide()*0.2-20,5)
					button:SetText("")

					-- changes the buy button depending on if it can be afforded
					local canaffordcolor
					if LocalPlayer():getDarkRPVar("money") >= v.price then canaffordcolor = NPCRobSystem.Config.ShopBuyColor else canaffordcolor = NPCRobSystem.Config.ShopBuyDenyColor end
					button.Paint = function(self,w,h)
						draw.RoundedBox(4, 0, 0, w, h, canaffordcolor)
						draw.DrawText(NPCRobSystem.Language.Buy, "npcrob30", w/2, 0, textwhite, TEXT_ALIGN_CENTER)
						draw.DrawText("Р"..NPCRobSystem.Core.FormatFunc(v.price), "npcrob25", w/2, h-25, textwhite, TEXT_ALIGN_CENTER)
					end
					-- Send a request to the server to buy the item
					button.DoClick = function()
						if !NPCRobSystem.Config.KeepUIOpen then
							frame:Close()
						end
						local TABLE = {}
						TABLE.ent = v.ent
						TABLE.price = v.price
						net.Start("ncpstoredoact")
							net.WriteTable(TABLE)
						net.SendToServer()
					end

					-- The 3d model
					local icon = vgui.Create( "DModelPanel", clistpanel )
					icon:SetPos(0,0)
					icon:SetSize(80,80)
					icon:SetModel(v.model)
			
					-- *|* Credit: https://wiki.garrysmod.com/page/DModelPanel/SetCamPos
					local mn, mx = icon.Entity:GetRenderBounds()
					local size = 0
					size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
					size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
					size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
					icon:SetFOV( 45 )
					icon:SetCamPos( Vector( size+4, size+4, size+4 ) )
					icon:SetLookAt( ( mn + mx ) * 0.5 )
					-- *|*

					if NPCRobSystem.Config.ShopModelRotate == false then
						function icon:LayoutEntity(Entity)
						end
					end
					
					-- Adds the item to the list
					clistcont:AddItem(clistpanel)
				end
			end
		end
		-- The initial spawn of the list
		if b == 1 then 
			buttonpanel.DoClick()
		end
	end
		-- The initial spawn of the list
	for b, n in pairs(NPCRobSystem.Config.ShopTabs) do
		if b == 1 then
			currentselected = n.display
		end
	end
end


net.Receive("npcstoreui", function(len)
	NPCRobSystem.plyStoreInterface()
end)

-- t.me/urbanichka