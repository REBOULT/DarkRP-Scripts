
NPCRobSystem.plyRobInterface = function()
	-- Colors
	local textwhite = Color(255,255,255)
	local textblack = Color(0,0,0)
	local bargrey = Color(40,40,40)
	local darkred = Color(100, 0, 0)
	local lightred = Color(200, 0, 0)
	local realred = Color(255, 0, 0)

	-- Creates the base frame
	local frame = vgui.Create( "DFrame" )
	frame:SetSize(ScrW()*0.3, ScrH()*0.3)
	frame:Center()
	frame:SetTitle("")
	frame:SetVisible(true)
	frame:SetDraggable(true)
	frame:MakePopup()
	frame:ShowCloseButton(false)
	frame.Paint = function( self, w, h )
		NPCRobSystem.Core.BlurFunc(frame, 3)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 85))
		draw.RoundedBox(0, 0, 0, w, 25, bargrey)
		draw.DrawText( string.format( NPCRobSystem.Language.HoldUp, isfunction(NPCRobSystem.Config.RobAmount) and NPCRobSystem.Config.RobAmount() or NPCRobSystem.Config.RobAmount), "npcrob44", w/2, 35, textwhite, TEXT_ALIGN_CENTER)
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

	-- The button to start a robbery
	local button = vgui.Create( "DButton", frame )
	button:SetSize( frame:GetWide()-40, (frame:GetTall()-49)/2)
	button:SetPos( 20, frame:GetTall()-((button:GetTall())+20) )
	button:SetText("")
	button.Paint = function( self, w, h )
		draw.RoundedBox(0, 0, 0, w, h, Color(75, 75, 75, 255))
		draw.DrawText(NPCRobSystem.Language.RobStore, "npcrob44", w/2, h/2-22, textwhite, TEXT_ALIGN_CENTER )
	end
	button.DoClick = function()
		frame:Close()
		net.Start("ncprobdoact")
		net.SendToServer()
	end

end

net.Receive("ncprobpolicecall", function()
	local entbeingrobbed = net.ReadEntity()

	-- This displays an active robbery notification to the police
	function RobNotificationHUD()
		for _, v in pairs(NPCRobSystem.NPCStores) do
			if v == entbeingrobbed then
				local pos = v:GetPos():ToScreen()
				draw.DrawText(string.format( NPCRobSystem.Language.CopRobTitle, NPCRobSystem.Config.NPCText), "npcrob30", pos.x, pos.y-60, realred, TEXT_ALIGN_CENTER)
				draw.DrawText(string.format( NPCRobSystem.Language.CopRobDis, math.Round(v:GetPos():Distance(LocalPlayer():GetPos()))), "npcrob30", pos.x, pos.y-30, textwhite, TEXT_ALIGN_CENTER)
			end
		end
	end
	hook.Add("HUDDrawTargetID", "ROB_GovernmentNotification", RobNotificationHUD)
end)
net.Receive("ncprobpolicecallend", function()
	hook.Remove("HUDDrawTargetID", "ROB_GovernmentNotification")
end)


net.Receive("ncprobdoani",function()
	local targetent = net.ReadEntity()
	if not IsValid(targetent) then return end
	targetent:SetSequence( targetent:LookupSequence( NPCRobSystem.Config.RobActiveAni ) )
end)

net.Receive("ncprobdoanires",function()
	local targetent = net.ReadEntity()
	if not IsValid(targetent) then return end
	targetent:SetSequence( targetent:LookupSequence( "idle_subtle" ) )
end)

-- t.me/urbanichka