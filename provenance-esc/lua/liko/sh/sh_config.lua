
Liko = Liko or {}

Liko.Settings = Liko.Settings or {}

Liko.Language = Liko.Language or {}





Liko.Settings.ResourcesEnable = false

Liko.Settings.WorkshopEnabled = false



Liko.Settings.AnnouncementEnabled = false

Liko.Settings.AnnouncementText = 

[[






]]






Liko.Settings.EscapeScreenToggle = true

Liko.Settings.KeybindAllowToggle = true

Liko.Settings.KeybindEnum = KEY_F7





Liko.Settings.NetworkName = "Provenance"                 -- Name of the network to appear in News section

Liko.Settings.NetworkNameColor = Color( 255, 255, 255, 255 )    -- Color of the network name

Liko.Settings.BottomBarColor = Color( 255, 255, 255, 170 )      -- White line at top of bottom panels

Liko.Settings.PaddingFromTop = 35

Liko.Settings.UseIconsWithText = true







Liko.Settings.BackgroundsEnable = false



Liko.Settings.Backgrounds = {

    "https://i.imgur.com/VY5K2WH.png"

}



-----------------------------------------------------------------

--	[ ADVERTISEMENT VIDEOS ]

-----------------------------------------------------------------

-- [Liko.Settings.AdvertisementEnable]

-- Setting this to true will display the video advertisements 

-- within the announcements panel to the right.

-- False will disable it completely.

-----------------------------------------------------------------



Liko.Settings.AdvertisementEnable = false



-----------------------------------------------------------------

-- [ ADVERTISEMENT VIDEOS - YOUTUBE SETTINGS ]

-----------------------------------------------------------------

-- You can control autoplay and controls by attaching parameters.

-- Read more at: http://www.w3schools.com/html/html_youtube.asp

-----------------------------------------------------------------



Liko.Settings.AdvertisementYouTubeEnabled = false

Liko.Settings.AdvertisementsYouTube = {

    "https://www.youtube.com/embed/mgnECvX3nnc?autoplay=1&controls=1"

}



-----------------------------------------------------------------

-- [ ADVERTISEMENT VIDEOS - WEBM SETTINGS ]

-----------------------------------------------------------------

-- [Liko.Settings.AdvertisementStartvol]

-- Video volume control - range between 0 and 1.

-- 0 = 0%  |  0.5 = 50%  |  1 = 100%

-----------------------------------------------------------------



Liko.Settings.AdvertisementWebmAutoplay = false

Liko.Settings.AdvertisementWebmStartvol = 0.5

Liko.Settings.AdvertisementsWebm = {

	"http://api.galileomanager.com/linx/resources/linx_codIIIadvert.webm"

}



-----------------------------------------------------------------

-- [ CLOCK ]

-----------------------------------------------------------------

-- [Liko.Settings.ClockEnabled]

-- true    :: Clock will display in bottom right.

-- false   :: Clock will NOT display in bottom right.

-----------------------------------------------------------------

-- [Liko.Settings.ClockTextColor]

-- Text color that the color will appear in.

-----------------------------------------------------------------



Liko.Settings.ClockEnabled = true 

Liko.Settings.ClockTextColor = Color ( 70, 70, 70, 255 )



-----------------------------------------------------------------

--  [ MENU BUTTONS ]

-----------------------------------------------------------------

-- Button Properties

--      name = (text to display on button)

--      description = (description under name of button)

--      icon = (icon to use for button)

--      buttonNormal = (color of button in regular state)

--      buttonHover = (color of button when mouse hovers)

--      textNormal = (color of text in regular state)

--      textHover = (color of text when mouse hovers)

--      enabled = (if button should show or not)

--      func = (what to do when button is pressed)

-----------------------------------------------------------------

-- To toggle buttons to do what you want, you will change the

-- code after each 'func = function()' line.

-----------------------------------------------------------------

-- To open a URL in the STEAM BROWSER

--      gui.OpenURL( "http://urlhere.com" )

-----------------------------------------------------------------

-- To open a URL with the BUILT IN BROWSER 

--       Liko:OpenURL( "http://urlhere.com", "Titlebar Name" )

-----------------------------------------------------------------

-- To open a Frame with JUST text (IE: Rules)

--      Liko:OpenText( "Text to display", "Titlebar Name" )

-----------------------------------------------------------------

-- To run a ConCommand:

--      RunConsoleCommand('concommand_here')

-----------------------------------------------------------------

-- [IMPORTANT!] ** [IMPORTANT!] ** [IMPORTANT!] ** [IMPORTANT!] 

-----------------------------------------------------------------

-- If you modify the functions for each button; MAKE SURE YOU 

-- END THE FUNCTION with the word end.

--

-- Example: 

-- func = function() Liko:OpenURL( "http://url.com", "A link" ) end 

--

-- You will notice the word end as the very last thing of the line.

-- Without this, Liko will error out.

-----------------------------------------------------------------



Liko.Settings.MenuLinkDonate = ""

Liko.Settings.MenuLinkWebsite = ""

Liko.Settings.MenuLinkWorkshop = ""



Liko.Settings.Buttons = {

    { 

        enabled = true,

    	name = "Вернуться в игру", 

    	description = "", 

		buttonNormal = Color( 70, 70, 70, 190 ), 

		buttonHover = Color( 70, 70, 70, 240 ), 

		textNormal = Color( 255, 255, 255, 255 ),

		textHover = Color( 255, 255, 255, 255 ),

    	func = function() LikoPanelMenu:SetVisible( false ) end 

    },


    { 

        enabled = true,

        name = "Настройки", 

        description = "Сделай свою игру приятнее!",



        buttonNormal = Color( 70, 70, 70, 190 ), 

        buttonHover = Color(70, 70, 70, 240 ),

        textNormal = Color( 255, 255, 255, 255 ),

        textHover = Color( 255, 255, 255, 255 ), 

        func = function() 

            RunConsoleCommand( "gamemenucommand", "openoptionsdialog" ) 

            timer.Simple( 0, function() RunConsoleCommand( "gameui_activate" ) end )

        end

    },

    { 

        enabled = true,

    	name = "Отключиться", 

    	description = "Покинуть город...",

    	buttonNormal = Color( 70, 70, 70, 190 ), 

    	buttonHover = Color( 70, 70, 70, 240 ),

		textNormal = Color( 255, 255, 255, 255 ),

		textHover = Color( 255, 255, 255, 255 ), 

    	func = function() RunConsoleCommand( "disconnect" ) end 

    },

    { 

        enabled = true,

    	name = "Стандартное меню", 

    	description = "Вернуться в обычное меню", 


		buttonNormal = Color( 70, 70, 70, 190 ), 

		buttonHover = Color( 70, 70, 70, 240 ),

		textNormal = Color( 255, 255, 255, 255 ),

		textHover = Color( 255, 255, 255, 255 ),

    	func = function() LikoPanelMenu:SetVisible( false ) gui.ActivateGameUI() end 

    },

}



-----------------------------------------------------------------

-- [ SERVER LISTINGS ]

-----------------------------------------------------------------

-- [Liko.Settings.ServersEnabled]

-- true    :: Server list WILL display.

-- false   :: Server list WILL NOT display.

-----------------------------------------------------------------

-- [Liko.Settings.ServersEnabled]

-- A list of your servers, as well as properties for each one.

-----------------------------------------------------------------



Liko.Settings.ServersEnabled = false



Liko.Settings.Servers = {

--    {

 --       hostname = "Hostname",

  --      icon = "icon",

 --       ip = "ip"

 --   },

}



Liko.Settings.ServerButtonColor = Color( 15, 15, 15, 0 )

Liko.Settings.ServerButtonHoverColor = Color( 255, 255, 255, 220 )

Liko.Settings.ServerButtonTextColor = Color( 255, 255, 255, 255 )

Liko.Settings.ServerButtonHoverTextColor = Color( 0, 0, 0, 255 )



-----------------------------------------------------------------

-- [ INTEGRATED WEB BROWSER ]

-----------------------------------------------------------------

-- [Liko.Settings.BrowserColor]

-- The color to use for the integrated web browser panel.

-----------------------------------------------------------------



Liko.Settings.BrowserColor = Color( 0, 0, 0, 240 )



-----------------------------------------------------------------

--	[ BROADCASTING SYSTEM - DO NOT TOUCH ]

-----------------------------------------------------------------



Liko.BCColorServer = Color( 255, 255, 0 )

Liko.BCColorName = Color( 77, 145, 255 )

Liko.BCColorMsg = Color( 255, 255, 255 )

Liko.BCColorValue = Color( 255, 0, 0 )

Liko.BCColorValue2 = Color( 255, 166, 0 )

Liko.BCColorBind = Color( 255, 255, 0 )

-- vk.com/urbanichka