local Configuration = RogueScoreboard.Configuration

hook.Remove("ScoreboardHide", "FAdmin_scoreboard")
hook.Remove("ScoreboardShow", "FAdmin_scoreboard")

surface.CreateFont("RogueTitle", {font = "Quicksand Regular", size = 48, extended = true, antialias = true,})
surface.CreateFont("Rogue30", {font = "Quicksand Regular", size = 30, extended = true})
surface.CreateFont("Rogue24", {font = "Quicksand Regular", size = 24, extended = true})
surface.CreateFont("Rogue20", {font = "Quicksand Regular", size = 20, extended = true})
surface.CreateFont("Rogue19", {font = "Quicksand Regular", size = 19, extended = true})
surface.CreateFont("Numbers", {font = "Quicksand Regular", size = 22, extended = true})

if IsValid(RogueScoreboard.Main) then // REMOVE AFTER DEV
	RogueScoreboard.Main:Close()
	RogueScoreboard.Main = nil
end

hook.Add("Initialize", "RogueScoreboard.RemoveGamemodeFunctions", function()
	GAMEMODE.ScoreboardShow = nil
	GAMEMODE.ScoreboardHide = nil
end)

local PanelWidth = ScrW() > 1280 and 1300 or 1100

function RogueSteamFriendCheck( ply )
	return ply:GetFriendStatus() == "friend"
end

local function lerpColor(t, a, b)
	local newCol = Color(255, 255, 255, 255)
	newCol.r = Lerp(t, a.r, b.r)
	newCol.g = Lerp(t, a.g, b.g)
	newCol.b = Lerp(t, a.b, b.b)
	newCol.a = Lerp(t, a.a, b.a)
	return newCol
end

RogueScoreboard.CachedMaterials = RogueScoreboard.CachedMaterials or {}

function RogueScoreboard.Material(name, ...)
	if Scoreboard.CachedMaterials[name] then
		return Scoreboard.CachedMaterials[name]
	else
		local newMat = Material(name, ...)
		Scoreboard.CachedMaterials[name] = newMat
		return newMat
	end
end



local CmdGoto = Material( "icon16/group_go.png" )
local CmdBring = Material( "icon16/group_link.png" )
local CmdSpectate = Material( "icon16/eye.png" )
local CmdBFreeze = Material( "icon16/transmit_blue.png" )
local CmdKick = Material( "icon16/user_go.png" )
local CmdBan = Material( "icon16/status_busy.png" )
local CmdInfo = Material( "icon16/zoom_in.png" )

local FakeAvatar = Material( "icon16/status_offline.png" )
local Incognito = Material( "icon16/contrast.png" )
local HideIcon = Material( "icon16/contrast.png" )
local PingBars1 = Material( "icon16/contrast.png" )
local PingBars2 = Material( "icon16/contrast.png" )
local PingBars3 = Material( "icon16/contrast.png" )
local PingBarsFull = Material( "icon16/contrast.png" )
local TagIcon = Material( "icon16/information.png" )
local HelpIcon = Material( "icon16/email.png" )
local PropsIcon = Material( "icon16/brick.png" )
local ReportIcon = Material( "icon16/comment.png" )
local FriendIcon = Material( "icon16/heart.png" )
local MuteIcon = Material( "icon16/status_away.png" )

local PropAllowed = false

local MainBG = Configuration.MainBackground
local PanelBG =	Configuration.PanelBackground

local NameHover = Configuration.NameHover
local FriendCol = Configuration.Friends

local MutedCol =  Configuration.Muted
local ClearPCol = Configuration.ClearProps
local ClearPHov = Configuration.ClearPropsHover
local IconsDark = Configuration.IconsDarkColor
local PingFullCol = Configuration.PingFull
local Ping3Col = Configuration.Ping3
local Ping2Col = Configuration.Ping2
local PingCrit = Configuration.PingCritical
local UnderCol = Configuration.UndercoverIcon
local ReportCol = Configuration.ReportColor
local ReportColHover = Configuration.ReportHoverColor
local UnderCoverCol = Configuration.IsUndercoverIcon

local Zero = Color( 0,0,0,0 )
local White = Color( 255,255,255 )
local Grey = Color( 39,40,41,200 )

local LightGrey = Color( 121,122,123 )
local MoneyColor = Color( 0,255,140 )
local SubMenuBaseColor = Color( 14,15,16,50 )
local LightText = Color( 255,255,255,100 )
local DarkText = Color( 20,20,20,150 )

local emptyFunction = function() end

local function initCommandTable()
	local CommandTable = {}

	if IsValid(LocalPlayer()) and ( table.HasValue( Configuration.MenuAccess, LocalPlayer():GetUserGroup()) ) then

		if !Configuration.SeperateAccess or (Configuration.SeperateAccess and table.HasValue( Configuration.AllowedGoto, LocalPlayer():GetUserGroup())) then
			table.insert(CommandTable, {
				CommandName = Configuration.CommandGoto,
				CommandIcon = CmdGoto,
				Func = function(cmdPly)

					if cmdPly == LocalPlayer() then LocalPlayer():ChatPrint( Configuration.TargetSelfCheck  ) return end
					Configuration.Administration[Configuration.AdministrationMod].goto( cmdPly )

				end
			})
		end
		if !Configuration.SeperateAccess or (Configuration.SeperateAccess and table.HasValue( Configuration.AllowedBring, LocalPlayer():GetUserGroup())) then
			table.insert(CommandTable, {
				CommandName = Configuration.CommandBring,
				CommandIcon = CmdBring,
				Func = function(cmdPly)
					if cmdPly == LocalPlayer() then LocalPlayer():ChatPrint( Configuration.TargetSelfCheck  ) return end
					Configuration.Administration[Configuration.AdministrationMod].bring( cmdPly )
				end
			})
		end
		if !Configuration.SeperateAccess or (Configuration.SeperateAccess and table.HasValue( Configuration.AllowedFreeze, LocalPlayer():GetUserGroup())) then
			table.insert(CommandTable, {
				CommandName = Configuration.CommandBringFreeze,
				CommandIcon = CmdBFreeze,
				Func = function(cmdPly)

					if cmdPly == LocalPlayer() then LocalPlayer():ChatPrint( Configuration.TargetSelfCheck  ) return end
					if !cmdPly:IsFrozen() then

						Configuration.Administration[Configuration.AdministrationMod].freeze( cmdPly )

					elseif cmdPly:IsFrozen() then

						Configuration.Administration[Configuration.AdministrationMod].unfreeze( cmdPly )
						Configuration.Administration[Configuration.AdministrationMod].send( cmdPly )

					end

				end
			})
		end

		if !Configuration.SeperateAccess or (Configuration.SeperateAccess and table.HasValue( Configuration.AllowedSpectate, LocalPlayer():GetUserGroup())) then
			table.insert(CommandTable, {
				CommandName = Configuration.CommandSpectate,
				CommandIcon = CmdSpectate,
				Func = function(cmdPly)

					if cmdPly == LocalPlayer() then LocalPlayer():ChatPrint( Configuration.TargetSelfCheck  ) return end
					Configuration.Administration[Configuration.AdministrationMod].spectate( cmdPly )

				end
			})
		end

		table.insert(CommandTable, {
			CommandName = Configuration.CommandCopy,
			CommandIcon = CmdInfo,
			Func = function(cmdPly)
				if IsValid(cmdPly) and !cmdPly:IsBot() then

					SetClipboardText(cmdPly:SteamID())
					LocalPlayer():ChatPrint( "Скопирована информация игрока " .. cmdPly:Nick() )

				end
			end
		})

		if !Configuration.SeperateAccess or (Configuration.SeperateAccess and table.HasValue( Configuration.AllowedKick, LocalPlayer():GetUserGroup())) then
			table.insert(CommandTable, {
				CommandName = Configuration.CommandKick,
				CommandIcon = CmdKick,
				Func = function(cmdPly)
					if cmdPly == LocalPlayer() then LocalPlayer():ChatPrint( Configuration.TargetSelfCheck  ) return end

					Configuration.Administration[Configuration.AdministrationMod].kick( cmdPly, Configuration.CommandKickReason )

				end
			})
		end
		if !Configuration.SeperateAccess or (Configuration.SeperateAccess and table.HasValue( Configuration.AllowedBan, LocalPlayer():GetUserGroup())) then
			table.insert(CommandTable, {
				CommandName = Configuration.CommandBan,
				CommandIcon = CmdBan,
				Func = function(cmdPly)

					if cmdPly == LocalPlayer() then LocalPlayer():ChatPrint( Configuration.TargetSelfCheck  ) return end
					Configuration.Administration[Configuration.AdministrationMod].ban( cmdPly,Configuration.CommandBanTime, string.format( Configuration.CommandBanReason, Configuration.CommandBanTime) )

				end
			})
		end
	else
		table.insert(CommandTable, {
			CommandName = Configuration.CommandCopy,
			CommandIcon = CmdInfo,
			Func = function(cmdPly)
				if IsValid(cmdPly) and !cmdPly:IsBot() then
					SetClipboardText(cmdPly:SteamID())
					LocalPlayer():ChatPrint( "Скопирована информация игрока " .. cmdPly:Nick() )
				end
			end
		})
	end

	return CommandTable
end

function RogueRandomNameGeneration( ply )
	if ply:GetRogueNetBool("Incognito", false) and !ply.RandomName then
	  	ply.RandomName = table.Random( Configuration.UndercoverNames )
	  	ply.RandomMoney = math.random( Configuration.LowestMoney, Configuration.HighestMoney )
	  	ply.RandomKills = math.random( Configuration.LowestKills, Configuration.HighestKills )
	  	ply.RandomDeaths = math.random( Configuration.LowestDeaths, Configuration.HighestDeaths )
	elseif !ply:GetRogueNetBool("Incognito", false) and ply.RandomName then
	 	ply.RandomName = nil
	  	ply.RandomMoney = nil
	  	ply.RandomKills = nil
	  	ply.RandomDeaths = nil
	end
end

local function mainPaint(self, w, h)
	local ply = self.Player

	if !IsValid(ply) and IsValid(RogueScoreboard.Main) then RogueScoreboard.Main:Update() return end

	local RandName = ply.RandomName or ply:Name()
	local Randkill = ply.RandomKills or ply:Frags()
	local RandDeath = ply.RandomDeaths or ply:Deaths()

	surface.SetDrawColor( PanelBG )
	surface.DrawRect( 0, 0, w, h )

	draw.RoundedBox( 16, 1, 2, 3, 36, team.GetColor( ply:Team() ))
	local nextColor
	if self.Hovered or self.Opened then
		nextColor = NameHover
	else
		nextColor = White
	end

	draw.DrawText( RandName, "Rogue24", 94, 7, self.Color, TEXT_ALIGN_LEFT)

	self.Color = lerpColor(FrameTime() * 8, self.Color, nextColor)

	local DisplaySetting = Configuration.RankDisplay[ply:GetNWString("usergroup", "")]
	local DisplayName = DisplaySetting and DisplaySetting.DisplayName or ""


	if Configuration.DarkRP then
		draw.DrawText( team.GetName(ply:Team()), "Rogue24", w / 2, 7, White, TEXT_ALIGN_CENTER)
	end

	if ply:GetRogueNetBool("Incognito") then
		if Configuration.UseCustomIcon then
			surface.SetDrawColor( White )
			surface.SetMaterial( FakeAvatar )
			surface.DrawTexturedRect( 46, 4, 32,32 )
		end

		if IsValid(LocalPlayer()) and table.HasValue( Configuration.IncognitoVision, LocalPlayer():GetUserGroup()) then
			surface.SetDrawColor( UnderCol )
			surface.SetMaterial( Incognito )
			surface.DrawTexturedRect( w - w / 4 - 95 - 12, 8, 24, 24 )
		end
		draw.DrawText( "", "Rogue24", w / 2 + w / 4 - 95, 7, DisplayColor, TEXT_ALIGN_CENTER)
	else
		draw.DrawText( DisplayName, "Rogue24", w / 2 + w / 4 - 95, 7, DisplayColor, TEXT_ALIGN_CENTER)
	end

	draw.DrawText( RandDeath, "Numbers", w - 140, 7, White, TEXT_ALIGN_CENTER)
	draw.DrawText( Randkill, "Numbers", w - 190, 7, White, TEXT_ALIGN_CENTER)

	if ply:Ping() > 4 then
		draw.DrawText( ply:Ping(), "Numbers", w - 24, 7, White, TEXT_ALIGN_CENTER)
	else
		draw.DrawText( "!", "Numbers", w - 24, 7, PingCrit, TEXT_ALIGN_CENTER)
	end

	local PColor, PMaterial
	if ply:Ping() > 259 then
		PColor = PingCrit
		PMaterial = PingBars1
	elseif ply:Ping() > 170 then
		PColor = Ping2Col
		PMaterial = PingBars2
	elseif ply:Ping() > 100 then
		PColor = Ping3Col
		PMaterial = PingBars3
	elseif ply:Ping() >= 5 then
		PColor = PingFullCol
		PMaterial = PingBarsFull
	else
		PColor = Color( 255,100,0 )
		PMaterial = PingBars1
	end

	surface.SetDrawColor( Grey )
	surface.SetMaterial( PingBarsFull )
	surface.DrawTexturedRect( w - 66, 12, 20, 21 )

	surface.SetDrawColor( PColor )
	surface.SetMaterial( PMaterial )
	surface.DrawTexturedRect( w - 66, 12, 20, 21 )
end

local function createSubMenu(self)
	local ply = self.Player
	local SubMenu = vgui.Create( "Panel", self )
	SubMenu:SetSize( self:GetWide(), 80)
	SubMenu:SetPos( 0, 40)
	SubMenu:SetPlayer( ply )
	SubMenu.Color = Zero
	SubMenu.NextColor = Zero
	SubMenu.Color2 = Zero
	SubMenu.NextColor2 = Zero
	SubMenu.Color3 = Zero
	SubMenu.NextColor3 = Zero
	SubMenu.Color4 = LightGrey
	SubMenu.NextColor4 = ClearPCol
	SubMenu.CommandHoverText = ""

	local DisplaySetting = Configuration.RankDisplay[ply:GetNWString("usergroup", "")]
	local DisplayTag = DisplaySetting and DisplaySetting.TagName or ""
	local DisplayTagCol = DisplaySetting and DisplaySetting.TagColor or LightGrey

	local CustomTag = Configuration.CustomUserTag[ply:SteamID()]
	local PlayerTag = CustomTag and CustomTag.Tag or ""
	local CustomTagCol = CustomTag and CustomTag.TagColor or LightGrey

	local SandboxPos = 0

	local MuteButton = vgui.Create("DButton", SubMenu)
	MuteButton:SetSize( 24, 24)
	MuteButton:SetPos( SubMenu:GetWide() - 50, 8)
	MuteButton:SetPlayer( ply )
	MuteButton:SetText("")
	MuteButton:SetFont("Rogue20")
	MuteButton.Image = MuteIcon
	MuteButton.Color = Grey
	MuteButton.NextColor = Zero

	if Configuration.DarkRP then
		SandboxPos = 0
	else
		SandboxPos = 140
	end

	if Configuration.ReportEnabled then
		local ReportButton = vgui.Create("DButton", SubMenu)
		ReportButton:SetSize( 24, 24)
		ReportButton:SetPos( SubMenu:GetWide() - 50, SubMenu:GetTall() - 32)
		ReportButton:SetPlayer( ply )
		ReportButton:SetText("")
		ReportButton:SetFont("Rogue20")
		ReportButton.Color = Grey
		ReportButton.NextColor = White

		function ReportButton:Paint( w, h )
			if self.Hovered then
				self.NextColor = ReportColHover
			else
				self.NextColor = ReportCol
			end

			surface.SetDrawColor(self.Color)
			surface.SetMaterial( ReportIcon )
			surface.DrawTexturedRect( 0, 0, 24, 24 )

			self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
		end

		ReportButton.DoClick = function()
			if IsValid(ply) and !ply:IsBot() then
				if Configuration.UsingReportAddon then

					RunConsoleCommand( "say", Configuration.ReportAddonPrefix )

				else
					if Configuration.UsingReportSite then
						gui.OpenURL(Configuration.ReportURL)
					else
						RunConsoleCommand( "say", Configuration.ReportPrefix  .. Configuration.ReportedText .. " " .. ply:Nick() .. " " .. ply:SteamID() )
					end
				end
			end
		end
	end

	if table.HasValue( Configuration.PropAccess, LocalPlayer():GetUserGroup()) then
		local ClearPropButton = vgui.Create("DButton", SubMenu)
		ClearPropButton:SetSize( 24, 24)
		ClearPropButton:SetPos( 280 - SandboxPos, SubMenu:GetTall() - 32)
		ClearPropButton:SetPlayer( ply )
		ClearPropButton:SetText("")
		ClearPropButton:SetFont("Rogue20")
		ClearPropButton.Color = ClearPCol
		ClearPropButton.NextColor = Zero

		function ClearPropButton:Paint( w, h )
			if !IsValid(ply) then return end
			if self.Hovered then
				self.NextColor = ClearPHov
			else
				self.NextColor = ClearPCol
			end
			surface.SetDrawColor( self.Color )
			surface.SetMaterial( PropsIcon )
			surface.DrawTexturedRect( 0, 0, 24, 24)

			self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)

		end
		ClearPropButton.DoClick = function() RunConsoleCommand("FPP_Cleanup", ply:UserID()) end
	end
	
	local RandMoney

	if Configuration.DarkRP then
		RandMoney = ply.RandomMoney or ply:getDarkRPVar("money")
	end

	function SubMenu:Paint( w, h )
		surface.SetDrawColor( SubMenuBaseColor )
		surface.DrawRect(0, 0, w, h)
		if !IsValid(ply) then return end

		if ply:GetRogueNetBool("Incognito") == false then
			if Configuration.CustomUserTag[ply:SteamID()] then
				draw.DrawText( PlayerTag , "Rogue20", 50, 8, CustomTagCol, TEXT_ALIGN_LEFT)
			else
				draw.DrawText( DisplayTag , "Rogue20", 50, 8, DisplayTagCol, TEXT_ALIGN_LEFT)
			end
		else
			draw.DrawText( "USER" , "Rogue20", 50, 8, IconsDark, TEXT_ALIGN_LEFT)
		end

		surface.SetDrawColor( Grey )
		surface.SetMaterial( TagIcon )
		surface.DrawTexturedRect( 10, 8, 24, 24 )

		self.NextColor2 = IconsDark

		if Configuration.ReportEnabled then
			draw.DrawText( Configuration.ReportText , "Rogue20", w - 70, h - 32, self.Color2, TEXT_ALIGN_RIGHT)
		end

		self.NextColor3 = IconsDark

		draw.DrawText( ply:IsMuted() and Configuration.UnMuteText or Configuration.MuteText, "Rogue20", w - 70, 8, self.Color3, TEXT_ALIGN_RIGHT)


		if table.HasValue( Configuration.PropAccess, LocalPlayer():GetUserGroup()) then
			draw.DrawText(  Configuration.ClearPropText, "Rogue20", 50 + 280 - SandboxPos, h  - 32, IconsDark, TEXT_ALIGN_LEFT)
		end

		if Configuration.InformationViewAll then
			if Configuration.DarkRP then
				surface.SetDrawColor( Grey )
				surface.SetMaterial( HelpIcon )
				surface.DrawTexturedRect( 10, h - 32, 24, 24 )
				draw.DrawText( DarkRP.formatMoney(  RandMoney ), "Rogue20", 50, h  - 32, MoneyColor, TEXT_ALIGN_LEFT)
			end

			surface.SetDrawColor( Grey )
			surface.SetMaterial( PropsIcon )
			surface.DrawTexturedRect( 10 + 140 - SandboxPos, h - 32, 24, 24 )

			draw.DrawText(  ply:GetCount( "props" ) .. " " .. Configuration.PropText, "Rogue20", 50 + 140 - SandboxPos, h  - 32, IconsDark, TEXT_ALIGN_LEFT)

		end

		if !Configuration.InformationViewAll and (table.HasValue( Configuration.InformationView, LocalPlayer():GetUserGroup())) then

			if Configuration.DarkRP then

				surface.SetDrawColor( Grey )
				surface.SetMaterial( HelpIcon )
				surface.DrawTexturedRect( 10, h - 32, 24, 24 )

				draw.DrawText( DarkRP.formatMoney( RandMoney ) , "Rogue20", 50, h  - 32, MoneyColor, TEXT_ALIGN_LEFT)

			end

			surface.SetDrawColor( Grey )
			surface.SetMaterial( HelpIcon )
			surface.DrawTexturedRect( 10 + 140 - SandboxPos, h - 32, 24, 24 )


			draw.DrawText(  ply:GetCount( "props" ) .. " " .. Configuration.PropText, "Rogue20", 50 + 140 - SandboxPos, h  - 32, IconsDark, TEXT_ALIGN_LEFT)

		end

		self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
		self.Color2 = lerpColor(FrameTime() * 8, self.Color2, self.NextColor2)
		self.Color3 = lerpColor(FrameTime() * 8, self.Color3, self.NextColor3)

	end

	local CommandBase = vgui.Create("Panel", SubMenu)
	CommandBase:SetPos( SubMenu:GetWide() / 2 - SubMenu:GetWide() / 4, SubMenu:GetTall() / 2 - 16 )
	CommandBase:SetSize( SubMenu:GetWide() / 2, 60 )
	CommandBase.Color = Grey
	CommandBase.NextColor = White
	CommandBase.CommandHoverText = ""

	local CommandList = vgui.Create("DPanelList", CommandBase)
	CommandList:SetSize( 600, CommandBase:GetTall() )
	CommandList:SetPos( CommandBase:GetWide() / 2 - 300, 0 )
	CommandList:SetAlpha(0)
	CommandList:AlphaTo(252, 1)
	CommandList:EnableHorizontal( true )
	CommandList:EnableVerticalScrollbar( true )

	local vbar = CommandList.VBar
	vbar:SetHideButtons( true )

	function vbar.btnUp:Paint( w, h ) end
	function vbar:Paint( w, h ) end
	function vbar.btnGrip:Paint( w, h ) end

	local numofTables

	for k, v in pairs(self.commandTable) do

		numofTables = k

		local CommandMain = vgui.Create( "DButton", CommandList )
		CommandMain:SetTall( 26 )
		CommandMain:SetText( "" )
		CommandMain:SetFont( "Rogue30" )
		CommandMain:SetTextColor( LightText )
		CommandMain.Color = White

		function CommandMain:Paint( w, h )
			CommandList:SetWide( 24 * numofTables * 2, 26 )
			CommandList:SetPos( CommandBase:GetWide() / 2 - 24 * numofTables * 2 / 2, 0 )

			if self.Hovered then
				self.NextColor = White
				surface.SetDrawColor( self.Color )
				surface.SetMaterial( v.CommandIcon )
				surface.DrawTexturedRect( w / 2 - 12 , h / 2 - 12, 24, 24 )
			else
				self.NextColor = IconsDark
				surface.SetDrawColor( self.Color )
				surface.SetMaterial( v.CommandIcon )
				surface.DrawTexturedRect( w / 2 - 12 , h / 2 - 10, 24, 24 )
			end
			self:SetSize(  CommandList:GetWide() / numofTables, 26 )

			self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
		end

		CommandList:AddItem(CommandMain)

		CommandMain.DoClick = function()
			v.Func(ply)
		end

		local CommandTitle = vgui.Create("Panel", CommandBase)
		CommandTitle:SetPos( CommandBase:GetWide() / 2 - 125, CommandBase:GetTall() - 24 - 10 )
		CommandTitle:SetSize( 250, 24 )
		CommandTitle.Color = Grey
		CommandTitle.NextColor = White
		CommandTitle.CommandHoverText = ""

		function CommandTitle:Paint( w, h )
			if CommandMain:IsHovered() then
				self.NextColor = IconsDark
				draw.DrawText( v.CommandName, "Rogue20", w / 2, 0, self.Color, TEXT_ALIGN_CENTER)
			else
				self.NextColor = Zero
			end
			self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
		end
	end

	function MuteButton:Paint( w, h )

		if !IsValid(ply) then return end

		self.NextColor = (self.Hovered or ply:IsMuted()) and MutedCol or Grey

		surface.SetDrawColor(self.Color)
		surface.SetMaterial(self.Image )
		surface.DrawTexturedRect( 0, 0, 24, 24 )

		self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
	end

	MuteButton.DoClick = function() if !ply:IsMuted() then ply:SetMuted( true ) else ply:SetMuted( false ) end end

	return SubMenu
end

local function playerButtonDoClick(self)

	if self.Opened then
		return
	end

	local ply = self.Player

	self.Opened = true
	self:SizeTo( self:GetWide(), 120, 0.3, 0, - 1 )

	local CloseButton = vgui.Create("DButton", self)
	CloseButton:SetSize( PanelWidth, 40)
	CloseButton:SetPos( 40, 0)
	CloseButton:SetPlayer( ply )
	CloseButton:SetText("")
	CloseButton:SetFont("Rogue20")
	CloseButton.Paint = emptyFunction

	local SubMenu = createSubMenu(self)

	CloseButton.DoClick = function()
		self:SizeTo( self:GetWide(), 40, 0.3, 0, - 1 )
		SubMenu:Remove()
		CloseButton:Remove()
		self.Opened = false
	end

end

local function PlayerPanel( ply )
	local PlayerMain = vgui.Create("DButton")

	PlayerMain:SetSize( PanelWidth, 40)
	PlayerMain.commandTable = initCommandTable()
	PlayerMain:SetPlayer( ply )
	PlayerMain.Player = ply
	PlayerMain:SetText("")
	PlayerMain:SetFont("Rogue20")
	PlayerMain.Color = White
	PlayerMain.Opened = false
	PlayerMain.PlayerName = ply:Nick()

	RogueRandomNameGeneration(ply)

	PlayerMain.Paint = mainPaint

	PlayerMain.DoClick = playerButtonDoClick

	local ProfileButton = vgui.Create("DButton", PlayerMain)
	ProfileButton:SetSize( 24, 24)
	ProfileButton:SetPos( 10, 8)
	ProfileButton:SetPlayer( ply )
	ProfileButton:SetText("")
	ProfileButton:SetFont("Rogue20")
	ProfileButton.Color = Grey
	ProfileButton.NextColor = Zero
	ProfileButton.IsFriend = RogueSteamFriendCheck(ply)
	function ProfileButton:Paint( w, h )
		if !IsValid(ply) then return end
		if self.Hovered or self.IsFriend or ply:IsBot() then
			self.NextColor = FriendCol
		else
			self.NextColor = Grey
		end

		surface.SetDrawColor(self.Color)
		surface.SetMaterial( FriendIcon )
		surface.DrawTexturedRect( 0, 0, 24, 24 )

		self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
	end

	ProfileButton.DoClick = function()
		ply:ShowProfile()
	end

	if !ply:GetRogueNetBool("Incognito") or ( !Configuration.UseCustomIcon && ply:GetRogueNetBool("Incognito") ) then
		local avatar = PlayerMain:Add("AvatarImage")
		avatar:SetSize(32, 32)
		avatar:SetPos(46, 4)
		avatar:SetPlayer(ply)
		avatar:SetMouseInputEnabled(false)

		avatar.PaintOver = function(self, w, h)
			surface.SetDrawColor( DarkText )
			surface.DrawOutlinedRect(0, 0, w, h)
		end
	end

	return PlayerMain
end

local function createScoreboard()
	local Main = vgui.Create("DFrame")
	Main:SetSize( ScrW(), ScrH() )
	Main:SetAlpha( 0 )
	Main:AlphaTo( 255, 0.1 )
	Main:Center()
	Main:SetTitle("")
	Main:ShowCloseButton( false )
	Main:SetDraggable( false )

	function Main:Paint( w, h )
		surface.SetDrawColor( MainBG )
		surface.DrawRect( 0, 0, w, h )
		draw.DrawText(  Configuration.ServerTitle , "RogueTitle", w / 2, 140, Configuration.ServerTitleColor, TEXT_ALIGN_CENTER)

		if Configuration.ShowOnlineCount then

			local Pcount = table.Count( player.GetAll() )
			draw.DrawText(  Configuration.CurrentPlayersText .. " " .. Pcount, "Rogue24", w / 2, h - 114, White, TEXT_ALIGN_CENTER)

		end

	end

	local InformationBar = vgui.Create("Panel", Main)
	InformationBar:SetSize( PanelWidth, 30 )
	InformationBar:SetPos( Main:GetWide() / 2 - PanelWidth / 2, 266 )
	function InformationBar:Paint( w, h )

		if Configuration.InformationBar == false then return end
		if Configuration.InformationBackground then

			surface.SetDrawColor( PanelBG )
			surface.DrawRect( 0,0,w,h )

		end

		draw.DrawText(  Configuration.NameText, "Rogue24", 94, h / 2 - 12, White, TEXT_ALIGN_LEFT)
		if Configuration.DarkRP then
			draw.DrawText(  Configuration.JobText, "Rogue24", w / 2, h / 2 - 12, White, TEXT_ALIGN_CENTER)
		end
		draw.DrawText(  Configuration.KillsText, "Rogue24", w - 190, h / 2 - 12, White, TEXT_ALIGN_CENTER)
		draw.DrawText(  Configuration.DeathsText, "Rogue24", w - 140, h / 2 - 12, White, TEXT_ALIGN_CENTER)

	end

	local ScrollMain = Main:Add("DScrollPanel")
	ScrollMain:Center()
	ScrollMain:SetPos( ScrW() / 2 - PanelWidth / 2, 300)
	ScrollMain:SetSize( PanelWidth, Main:GetTall() - 420)

	ScrollMain.VBar:SetHideButtons(true)
	ScrollMain.VBar.Paint = function() end

	ScrollMain.VBar:SetWide(0)
	ScrollMain.VBar.btnUp.Paint = ScrollMain.VBar.Paint
	ScrollMain.VBar.btnDown.Paint = ScrollMain.VBar.Paint
	ScrollMain.VBar.btnGrip.Paint = function(self, w, h) end

	HiddenButton = vgui.Create("DButton", Main)
	HiddenButton:SetSize( 100, 60)
	HiddenButton:SetPos( Main:GetWide() / 2 - 50, Main:GetTall() - 80)
	HiddenButton:SetText("")
	HiddenButton:SetFont("Rogue20")
	HiddenButton.Color = IconsDark
	HiddenButton.Color2 = IconsDark
	HiddenButton.NextColor = IconsDark
	HiddenButton.NextColor2 = Zero
	HiddenButton.Activated = true
	HiddenButton:Hide()
	function HiddenButton:Paint( w, h )

		if self.Hovered then
			self.NextColor = White
			self.NextColor2 = IconsDark
		else
			self.NextColor = IconsDark
			self.NextColor2 = Zero
		end

		if LocalPlayer():GetRogueNetBool("Incognito") then
			self.Color = UnderCoverCol
			draw.DrawText(  Configuration.DeactivateIncog, "Rogue19", w / 2, h - 24, self.Color2, TEXT_ALIGN_CENTER)
		else
			draw.DrawText(  Configuration.ActivateIncog, "Rogue20", w / 2, h - 24, self.Color2, TEXT_ALIGN_CENTER)
		end

		surface.SetDrawColor(self.Color)
		surface.SetMaterial( HideIcon )
		surface.DrawTexturedRect( w / 2 - 16, 0, 32, 32 )

		self.Color = lerpColor(FrameTime() * 8, self.Color, self.NextColor)
		self.Color2 = lerpColor(FrameTime() * 8, self.Color2, self.NextColor2)
	end

	HiddenButton.DoClick = function()
		net.Start("Scoreboard.Hidden")
		net.SendToServer()
		gui.EnableScreenClicker(false)
   		Main:AlphaTo(0, 0.3)
   		timer.Create("ScoreboardFade", 0.3, 0, function()
	  		Main:Close()
	  		timer.Remove("ScoreboardFade")
		end)

	end


	Main.Update = function()
		if table.HasValue( Configuration.IncognitoAccess, LocalPlayer():GetUserGroup()) and !HiddenButton:IsVisible() then
			HiddenButton:Show()
		elseif !table.HasValue( Configuration.IncognitoAccess, LocalPlayer():GetUserGroup()) and HiddenButton:IsVisible() then
			HiddenButton:Hide()
		end

		ScrollMain:Clear()

		if Configuration.DarkRP then
			local Categories = DarkRP.getCategories().jobs
			for k,category in pairs( Categories ) do
				local Validation = table.Count( category.members ) > 0

				if Validation then
					if Configuration.SortByCategories then
						local shouldRemove = true

						local CategorySort = vgui.Create("DCollapsibleCategory", ScrollMain)
						CategorySort.Header:SetTall(40)
						CategorySort:SetLabel("")
						function CategorySort:Paint( w, h ) end
						function CategorySort.Header:Paint( w, h )

							surface.SetDrawColor( White )
							surface.SetMaterial( FriendIcon )
							surface.DrawTexturedRect( 10, 8, 24, 24 )

							draw.SimpleText(category.name, "Rogue24", 48, h / 2, category.color, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
						end
						ScrollMain:AddItem(CategorySort)
						CategorySort:DockMargin( 0, 0, 0, 0 )
						CategorySort:Dock(TOP)

						local ListContents = vgui.Create("DPanelList", CategorySort)
						ListContents:SetPadding(0)
						ListContents:SetSpacing(4)
						ListContents:Dock(FILL)
						local oldValidate = ListContents.PerformLayout
						function ListContents:PerformLayout(...)
							self:InvalidateParent()
							oldValidate(self, ...)
						end
						CategorySort:SetContents(ListContents)

						for _,v in pairs(category.members) do
							local count = team.NumPlayers(v.team)
							if count > 0 then
								shouldRemove = false
								local plys = team.GetPlayers(v.team)
								for _, ply in pairs(plys) do
									local plyPanel = PlayerPanel(ply)
									plyPanel:DockMargin( 0, 0, 0, 4 )
									plyPanel:Dock(TOP)
									ListContents:AddItem(plyPanel)
								end
							end
						end

						CategorySort:Dock(TOP)
						if shouldRemove then
							CategorySort:Remove()
						end
					else
						for _, member in pairs(category.members) do
							local count = team.NumPlayers(member.team)
							if count > 0 then
								local plys = team.GetPlayers(member.team)
								for _, ply in pairs(plys) do
									local plyPanel = PlayerPanel(ply)
									ScrollMain:AddItem(plyPanel)
									plyPanel:DockMargin(0, 0, 0, 4)
									plyPanel:Dock(TOP)
								end
							end
						end

					end
				end
			end
		else
			for k, v in pairs(player.GetAll()) do
				local plyPanel = PlayerPanel(v)
				ScrollMain:AddItem(plyPanel)
				plyPanel:DockMargin(0, 0, 0, 4)
				plyPanel:Dock(TOP)
			end
		end
	end
	Main:Update()
	return Main
end

hook.Add("ScoreboardShow", "RogueScoreboard.Activate", function()
	hook.Remove("ScoreboardHide", "FAdmin_scoreboard")
	hook.Remove("ScoreboardShow", "FAdmin_scoreboard")
	local Main = RogueScoreboard.Main
	gui.EnableScreenClicker(true) 
	if IsValid(Main) && Main:IsVisible() then
		Main:Update()
		Main:SetVisible(true)
		Main:SetAlpha(0)
		Main:AlphaTo(252, 0.3)
	else
		RogueScoreboard.Main = createScoreboard()
	end
end)

hook.Add( "ScoreboardHide", "RogueScoreboard.Hide", function()
	local Main = RogueScoreboard.Main
	
	gui.EnableScreenClicker(false)

	if IsValid(Main) then			
		Main:AlphaTo( 0, 0.15, 0,
		function()
			Main:SetVisible( false )
		end)
	end
end)

-- vk.com/urbanichka