--=================ДЕЛАЛ ТИТИНЕ А ТЫ БОМШ=================--
local frameColor = Color(20, 20, 20,185)
local buttonColor = Color(0, 163, 255,190)
local buttonRed = Color(200, 0, 0,255)



-- создаю шрифт
surface.CreateFont('Title', {
    size = 50, -- размер шрифта
    weight = 1300, -- ВЕС?
    antialias = true, -- сглаживагие
    extended = true, -- не ебу
    shadow = false, -- шадов
    font = 'Roboto' -- название шрифта
    
})

-- создаю шрифт
surface.CreateFont('Text', {
    size = 60, -- размер шрифта
    weight = 1300, -- ВЕС?
    antialias = true, -- сглаживагие
    extended = true, -- не ебу
    shadow = false, -- шадов
    font = 'Roboto' -- название шрифта
    
})

-- создаю шрифт
surface.CreateFont('Button', {
    size = 74, -- размер шрифта
    weight = 1300, -- ВЕС?
    antialias = true, -- сглаживагие
    extended = true, -- не ебу
    shadow = false, -- шадов
    font = 'Roboto' -- название шрифта
    
})

local function Openmenu()
    local MainPanel = vgui.Create('DFrame') -- создание DFRAME
    MainPanel:SetSize(1148, 610) -- размер
    MainPanel:SetPos(ScrW() / 2 - 450, ScrH() / 2 - 250) -- позиция
    MainPanel:SetDraggable(false) -- можно ли таскать
    MainPanel:SetTitle('') -- текст сверху
    MainPanel:ShowCloseButton(false) -- показывать ли кнопку закрытие
    MainPanel:Center() -- прорисовка от центра
    MainPanel:MakePopup() -- показывать кусор

    MainPanel:SetAlpha(0)
    MainPanel:AlphaTo(255, 0.3, 0)

    MainPanel.Paint = function(self, w, h)
        Derma_DrawBackgroundBlur(self, self.startTime)
        draw.RoundedBox(15, 0, 1, w, h, frameColor)
        
        -- draw.SimpleText("Приветствую " .. LocalPlayer():GetName() .. "!", "Text", w / 1.98, h / 2.5, Color(255, 255, 255, 180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        -- draw.SimpleText("Рады тебя видеть, удачи!", "Text", w / 1.98, h / 2.0, Color(255, 255, 255, 180), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        draw.SimpleText("СЕРВЕР", "Title", w / 1.98, h / 25.8, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

      
    end


    local MainPanel_Close_Ok = vgui.Create('DButton', MainPanel)
    MainPanel_Close_Ok:SetSize(50, 50)
    -- право право <|> лево лево --
    MainPanel_Close_Ok:SetPos(1100, 15)
    MainPanel_Close_Ok:SetText('')

    MainPanel_Close_Ok.Paint = function(me, w, h)
        draw.SimpleText("X", "Text", ScrW() / 100, ScrH() / 50, Color(200,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)        --draw.SimpleText("Хорошо", "help3", w / 2.00, h / 2.40, gay, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    MainPanel_Close_Ok.DoClick = function()
        MainPanel:AlphaTo(0, 0.2, 0, function()
            MainPanel:Remove()
        end)
    end

  

    local MainPanel_OKKKKKKK = vgui.Create('DButton', MainPanel)
    MainPanel_OKKKKKKK:SetSize(412, 84)
    -- право право <|> лево лево --
    MainPanel_OKKKKKKK:Center()
    MainPanel_OKKKKKKK:SetText('')

    MainPanel_OKKKKKKK.Paint = function(me, w, h)
        draw.RoundedBox(7, 0, 1, w, h, buttonColor)
        draw.SimpleText("???", "Button", w / 2.00, h / 2.30, gay, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    MainPanel_OKKKKKKK.DoClick = function(ply)
       if ePly.nw:GetNWString("usergroup") == "Moderator" or "admin" or "zoom" or "root" or ply:IsAdmin() then 
        RunConsoleCommand("darkrp", "admin")
       else 
        ply:ChatPrint("[?] [ЗАСЕКРЕЧЕНО]")
        MainPanel:AlphaTo(0, 0.2, 0, function()
            MainPanel:Remove()
        end)
        end
   
    end






        end
  

    

concommand.Add("adm_menu", Openmenu)

hook.Add("OnPlayerHitGround", "Anti-Bhop", function(ply)
	ply:SetVelocity(- ply:GetVelocity() / 2)
end)

