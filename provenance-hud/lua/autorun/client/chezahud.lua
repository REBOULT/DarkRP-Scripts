surface.CreateFont("hptext", {
    font = "Roboto",
    extended = true,
    size = 25,
    weight = 0,
    
    shadow = true,
    blursize = 0
})
local a = Material("icon16/money.png")
local b = Material("icon16/user.png")
local c = Material("icon16/clock.png")
local
function d(e, f, g, h, i)
surface.SetDrawColor(e)
surface.DrawRect(f, g, h, i)
end
local
function j(k, l, m, n, o)

surface.SetTextColor(k)
surface.SetFont(l)
surface.SetTextPos(m, n) surface.DrawText(o) end;
local function p(q, m, n, h, i) surface.SetDrawColor(color_white) surface.SetMaterial(q) surface.DrawTexturedRect(m, n, h, i) end;
local function r() if GetGlobalBool("DarkRP_Lockdown") then surface.SetDrawColor(color_white) surface.SetMaterial(c) surface.DrawTexturedRect(15, ScrH() - 170, 32, 32) surface.SetTextColor(Color(225, 84, 84)) surface.SetFont("hptext") surface.SetTextPos(55, ScrH() - 163) surface.DrawText("Комендантский час!") end end;
local
function s() 
    local t = LocalPlayer() 
    if not t: Alive() then
return end
local u = t:Health()
 local v = t:Armor()
  local w = t:getDarkRPVar("money") 
  local x = DarkRP.formatMoney(w)
   local y = t:getDarkRPVar("salary")
    local z = DarkRP.formatMoney(y)
     local A = t:getDarkRPVar("job") 
     local B = t:getDarkRPVar("rpname")
      local C, D = ScrW(), ScrH() 
      local k = {}
k.hp = Color(73, 252, 103) 
k.arm = Color(73, 124, 252) 
k.hpa = Color(73, 252, 103, 75) 
k.arma = Color(73, 124, 252, 75) 
if input.IsKeyDown(KEY_T) then
d(k.hpa, 15, D - 25, 133, 5) 
d(k.hp, 15, D - 25, math.Clamp(u, 0, 100) * 1.33, 5)
 d(k.arm, 170, D - 25, math.Clamp(v, 0, 100) * 1.33, 5)
  j(color_white, "hptext", 15, D - 50, "ЗДОРОВЬЕ: "..u) 
  if v == 0 then d(k.arma, 190, D - 25, 133, 5) 
    j(color_white, "hptext", 170, D - 50, "\nБРОНЯ: "..v) end;
p(a, 15, D - 90, 32, 32)
 j(color_white, "hptext", 55, D - 85, x.. " (+"..z.. ")")
  p(b, 15, D - 130, 32, 32)
   j(color_white, "hptext", 55, D - 123, B.. " ("..t:getDarkRPVar("job")..")", r())end end
hook.Add("HUDPaint", "eptaaaaaa", s)
 local E = {
    ['CHudHealth'] = true,
    ['CHudBattery'] = true,
    ['CHudSuitPower'] = true,
    ['CHudAmmo'] = false,
    ['CHudSecondaryAmmo'] = false,
    ['DarkRP_LocalPlayerHUD'] = true,
    ['DarkRP_Hungermod'] = true,
    ['DarkRP_LockdownHUD'] = true,
    ['CHudVoiceSelfStatus'] = true,
    ['CHudVoiceStatus'] = true
}
hook.Add("HUDShouldDraw", "HideHUD", function (F) if E[F] then
    return false end end)
