MsgC(Color(255,255,0),"𝗣𝗥𝗢𝗩𝗘𝗡𝗔𝗡𝗖𝗘")
MsgC(Color(0, 208, 255),"𝗥𝗢𝗟𝗘𝗣𝗟𝗔𝗬")
	CakeScreens = {}
	
	CakeScreens.MainScreen = {}
	
	CakeScreens.MainScreen.ActiveTab = 1
	
	local donate_text = [[Цены на донат:

	Нажми на F6 для большей информации!


● Moderator - 350 рублей 
Базовый набор привелегий. Теперь вам доступны
Админские команды!

● VIP - 100 рублей 
Базовый набор привелегий. Получите больше
каефа от игры на сервере





]]

	local rules_text = [[1.Правила могут измениться в любое время суток.
2.Незнание правил не освобождает от ответственности.
3.Запрещено выдумывать свои правила или придумывать к ним обходной путь.
4. Высшая администрация сервера не обязуется  соблюдать правила.

Правила общения в чате
- Запрещено оскорблять других игроков, а так же запрещено оскорблять родителей
- Запрещена реклама других серверов, стим-групп (За рекламу в любой форме сразу ban permanent).
- Запрещено использовать голосовой чат для создания громких шумов, пищания и других неприятных
звуков.
- Чат OOC используеться исключительно для NonRP ситуаций и т.п.
- Для вызова полиции используйте команду /cr текст .

]]
local messege =[[

Глобальное обновление!. Открытие!
17.07.22

]]


local clanes = [[

 ● Стоимость создания клана 50.000 Р 






 ► Список кланов:

 
		dev 
		ГУСЬ

]]
	CakeScreens.MainScreen.Tabs = {
		
		[1] = {
			
			Name = "Главная",
			
			Draw = function(x,y,w,h)
				
				
				
				draw.SimpleText( "Provenance", 'MainScreenLogoLabel', x + w/2, -30 + h/2, Color( 255,255,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText( '', 'MainScreenLogoLabel', x + w/2, -90 + h/2, Color( 255,255,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText( 'Добро пожаловать', 'MainScreenLogoSmallLabel', x + w/2, 10 + h/2, Color( 255,255,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				
				draw.RoundedBox( 0, x + w/2 - 300, h - 130, 600, 100, Color( 0,0,0,100) )
				draw.DrawText( "Цена на донат", "MainScreenLogoSmallLabel", x + w/2, h-117, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
				draw.DrawText( "От 50 РУБ.", "MainScreenLogoMoarSmallLabel", x + w/2, h-77, Color( 255,255,255 ), TEXT_ALIGN_CENTER )

				
				
			end,
			
		},
		
		[2] = {
			
			Name = "Донат",
			
			Draw = function(x,y,w,h)
				
				draw.RoundedBox( 0, x, y, w, 60, Color( 0,0,0,140 ) )
				draw.SimpleText( 'Привелегии', 'MainScreenHeader', x + w/2, y + 13, HSVToColor( CurTime() % 6 * 60, 1, 1 ), TEXT_ALIGN_CENTER, _ )
				
				draw.DrawText( donate_text, 'MainScreenLogoMoarSmallLabel', x + 3, y + 63, Color( 255,255,255 ) )
				
				draw.RoundedBox( 10, x + w - 200, y + h/2 - 50, 190, 100, Color( 0,0,0,100 ) )
				
				draw.DrawText( 'Покупка', 'MainScreenLogoSmallLabel', x + w - 105, y + h/2 - 40, Color( 255,255,255 ), TEXT_ALIGN_CENTER )
				
				draw.DrawText( 'Нажми ниже!', 'MainScreenLogoSmallLabel', x + w - 105, y + h/2, HSVToColor( CurTime() % 6 * 60, 1, 1 ), TEXT_ALIGN_CENTER )
					
			---
			
				local id = CakeScreens.Buttons.CreateButton( x + 590, y + 360, 222, 30, function()
					gui.OpenURL( "https://discord.gg/YMJ9d63yeK" )
				end)
				
				draw.RoundedBox( 6, x + 590, y+360, 200, 40, Color( 60,60,60,255 ) )
				
				if CakeScreens.Buttons.getButtonHover( id ) then
					draw.RoundedBox( 6, x + 590, y+360, 200, 40, Color( 255,255,255,10 ) )
				end
				
				draw.DrawText( 'Купить', 'MainScreenLogoSmallLabel', x + 660, y + 362, Color( 255,255,255 ) )
			---
			end,
			
		},
		
		[3] = {
			
			Name = "Инфо",
			
			Draw = function(x,y,w,h)
				draw.RoundedBox( 0, x, y, w, 60, Color( 0,0,0,140 ) )
				draw.SimpleText( 'Правила', 'MainScreenHeader', x + w/2, y + 13, HSVToColor( CurTime() % 6 * 60, 1, 1 ), TEXT_ALIGN_CENTER, _ )
				
				draw.DrawText( rules_text, 'MainScreenLogoMoarSmallLabel', x + 3, y + 63, Color( 255,255,255 ) )
				
				local id = CakeScreens.Buttons.CreateButton( x + 10, y + 360, 222, 30, function()
					gui.OpenURL( "https://goo.su/chsjhrC" )
				end)
				
				draw.RoundedBox( 6, x + 10, y+360, 222, 30, Color( 60,60,60,255 ) )
				
				if CakeScreens.Buttons.getButtonHover( id ) then
					draw.RoundedBox( 6, x + 10, y+360, 222, 30, Color( 255,255,255,10 ) )
				end
				
				draw.DrawText('Полный список правил', 'MainScreenLogoSmallLabel', x + 14, y + 362, HSVToColor( CurTime() % 6 * 60, 1, 1 ) )
				
				
				--
				
				---
				
			end,
			
		},
		
	[4] = {
			
			Name = "Кланы",
			
			Draw = function(x,y,w,h)
				
				draw.RoundedBox( 0, x, y, w, 60, Color( 0,0,0,140 ) )
				draw.SimpleText( 'Кланы', 'MainScreenHeader', x + w/2, y + 13, HSVToColor( CurTime() % 6 * 60, 1, 1 ), TEXT_ALIGN_CENTER, _ )
				
				draw.DrawText( clanes, 'MainScreenLogoMoarSmallLabel', x + 3, y + 63, Color( 255,255,255 ) )


			end,
			
		},
		
		[5] = {
			
			Name = "Вопросы?",
			
			Draw = function(x,y,w,h)
				
				draw.RoundedBox( 0, x, y, w, 60, Color( 0,0,0,140 ) )
				draw.SimpleText( 'ИНФОРМИРОВАНИЕ ИГРОКОВ', 'MainScreenHeader', x + w/2, y + 13, HSVToColor( CurTime() % 6 * 60, 1, 1 ), TEXT_ALIGN_CENTER, _ )
				
				draw.DrawText( messege, 'MainScreenLogoMoarSmallLabel', x + 3, y + 63, Color( 255,255,255 ) )

			draw.DrawText( 'Заходите в наш дискорд для большей информации!', 'MainScreenLogoSmallLabel', x + 90, y + 362, Color( 255,255,255 ) )
			draw.DrawText( '\nhttps://discord.gg/YMJ9d63yeK', 'MainScreenLogoSmallLabel', x + 90, y + 362, Color( 255,255,255 ) )
			draw.DrawText( '', 'MainScreenLogoSmallLabel', x + 90, y + 362, Color( 100,255,255 ) )
			
			end,
			
		},
		
	}
		

	
	local origin = Vector(0, 0, 0)
	local angle = Angle(0, 0, 0)
	local normal = Vector(0, 0, 0)
	local scale = 0

	CakeScreens.canTouchThis = function()
		return LocalPlayer():GetPos():Distance( origin ) < 350
	end
	
	CakeScreens.Start3D2D = function( pos,ang,res )
	
		origin = pos
		scale = res
		angle = ang:Forward()
		
		normal = Angle( ang.p, ang.y, ang.r )
		normal:RotateAroundAxis( ang:Forward(), -90 )
		normal:RotateAroundAxis( ang:Right(), 90 )
		normal = normal:Forward()
		
		cam.Start3D2D( pos,ang,res )
		
	end
	
	CakeScreens.getCursorPos = function()
		local p = util.IntersectRayWithPlane(LocalPlayer():EyePos(), LocalPlayer():GetAimVector(), origin, normal)

		-- if there wasn't an intersection, don't calculate anything.
		if not p then return 0, 0 end

		local offset = origin - p
		
		local angle2 = angle:Angle()
		angle2:RotateAroundAxis( normal, 90 )
		angle2 = angle2:Forward()
		
		local offsetp = Vector(offset.x, offset.y, offset.z)
		offsetp:Rotate(-normal:Angle())

		local x = -offsetp.y
		local y = offsetp.z

		return x/scale, y/scale
	end


	
	function CakeScreens.InRange( val, min, max )
		return val >= min and val <= max
	end
	
	CakeScreens.Buttons = {}
	
	CakeScreens.Buttons.List ={}
	
	CakeScreens.Buttons.ClearButtons = function()
		
		CakeScreens.Buttons.List = {}
		
	end
	
	CakeScreens.Buttons.CreateButton = function(...)
		
		return table.insert( CakeScreens.Buttons.List, { ... } )
		
	end
	
	CakeScreens.Buttons.getButtonHover = function ( id )
		
		local x,y = CakeScreens.getCursorPos()
		
		local button = CakeScreens.Buttons.List[id]
		
		local bx, by, bw, bh = unpack( button )
		
		return CakeScreens.InRange( x, bx, bx+bw ) and CakeScreens.InRange( y, by, by+bh )
		
	end
	
	local MainScreenTabs = CakeScreens.MainScreen.Tabs
	
	surface.CreateFont("MainScreenTabLabel", {
		size = 23,
		weight = 300,
		antialias = true,
		shadow = false,
		font = "Arial",
	})
	
	surface.CreateFont("MainScreenLogoLabel", {
		size = 64,
		weight = 300,
		antialias = true,
		shadow = false,
		font = "Arial",
	})
	
	surface.CreateFont("MainScreenLogoSmallLabel", {
		size = 24,
		weight = 300,
		antialias = true,
		shadow = false,
		font = "Arial",
	})
	
	surface.CreateFont("MainScreenHeader", {
		size = 32,
		weight = 300,
		antialias = true,
		shadow = false,
		font = "Arial",
	})
	
	surface.CreateFont("MainScreenLogoMoarSmallLabel", {
		size = 20,
		weight = 300,
		antialias = true,
		shadow = false,
		font = "Arial",
	})
	
	function CakeScreens.MainLuaScreen()
		
		CakeScreens.Start3D2D( Vector(570.136047, -2496.540000, 180.911000), Angle(0,0,90), 0.2 )
		
		draw.RoundedBox( 15, 105, 0, 800, 500, Color( 50, 50, 50,200 ) )
		draw.RoundedBox( 6, 108, 3, 794, 494, Color( 50, 50, 50,100 ) )
		
		CakeScreens.Buttons.ClearButtons()
		
		for i=1, #MainScreenTabs do
			
			local tab = MainScreenTabs[i]
			
			local y = (i-1) * 42
			
			local id = CakeScreens.Buttons.CreateButton( 0, y, 100, 40, function() CakeScreens.MainScreen.ActiveTab = i end )
			local hw = CakeScreens.Buttons.getButtonHover( id )
			
			
			draw.RoundedBox( 6, 0, y, 100, 40, Color( 60,60,60 ) )
			if hw then
				draw.RoundedBox( 6, 0, y, 100, 40, Color( 255,255,255,80 ) )
			end
			draw.SimpleText( tab.Name, "MainScreenTabLabel", 50, y + 18, Color( 255,255,255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			
			
			
			if CakeScreens.MainScreen.ActiveTab == i then
				draw.RoundedBoxEx( 6, 93, y, 10, 40, Color( 54,100,54 ), false, true, false, true )
				tab.Draw( 108, 3, 794, 494 )
			end
			
		end
		
		local x,y = CakeScreens.getCursorPos()
		
		draw.RoundedBox( 6, math.Clamp( x, 0, 800 ), math.Clamp( y, 0, 500 ), 6, 6, Color( 255,255,255 ) )
		
		cam.End3D2D()
	end
	
	hook.Add( 'PlayerBindPress', 'CakeRP Screens', function( ply, bind )
		
		if bind:find( "+use" ) or bind:find("+attack") then
			for k,v in pairs( CakeScreens.Buttons.List ) do
				if CakeScreens.Buttons.getButtonHover( k ) then
					v[5]()
				end
			end
		end
		
	end )
	
	local LineColor, BoxColor = Color(255,0,0,250), Color(0,0,0,30)
	

	
	function CakeScreens.Draw()
		if LocalPlayer():GetPos():Distance(Vector(669.510193, -2499.583252,148.294083)) < 800 then
			CakeScreens.MainLuaScreen()
		end
		if LocalPlayer():GetPos():Distance(Vector( -1283.229614, -1187.653931, 138.392151 )) < 300 then
		end
	end
	
	hook.Add( 'PostDrawTranslucentRenderables', 'Cakerp lua screens', CakeScreens.Draw )