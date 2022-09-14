
include("shared.lua")
include("storerob_core/config/sh_config.lua")
include("storerob_core/dermas/cl_fonts.lua")

function ENT:Draw()
	self:DrawModel()
	local Pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Forward(), 90);
	ang:RotateAroundAxis(ang:Right(), -90);
	cam.Start3D2D(self:GetPos()+Vector(0,0,15), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.07);
		draw.SimpleTextOutlined(" Р"..NPCRobSystem.Core.FormatFunc(isfunction(NPCRobSystem.Config.RobAmount) and NPCRobSystem.Config.RobAmount() or NPCRobSystem.Config.RobAmount), "npcrob120", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
	cam.Start3D2D(self:GetPos()+Vector(0,0,15), Angle(180, LocalPlayer():EyeAngles().y-90, -90), 0.07);
		draw.SimpleTextOutlined(" Р"..NPCRobSystem.Core.FormatFunc(isfunction(NPCRobSystem.Config.RobAmount) and NPCRobSystem.Config.RobAmount() or NPCRobSystem.Config.RobAmount), "npcrob120", 0, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
	cam.End3D2D()
end

-- t.me/urbanichka