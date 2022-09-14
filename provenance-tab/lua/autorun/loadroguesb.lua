RogueScoreboard = RogueScoreboard or {}

function RogueScoreboard.LoadingSV(filePath)
	if SERVER then
		include(filePath)
	end
end

function RogueScoreboard.LoadingCL(filePath)
	AddCSLuaFile(filePath)
	if CLIENT then
		include(filePath)
	end
end

function RogueScoreboard.LoadingSH(filePath)
	AddCSLuaFile(filePath)
	include(filePath)
end

RogueScoreboard.LoadingSH("roguescoreboard/sh_roguenetdata.lua")
RogueScoreboard.LoadingSH("roguescoreboard/configuration.lua")
RogueScoreboard.LoadingCL("roguescoreboard/cl_rogue.lua")
RogueScoreboard.LoadingSH("roguescoreboard/incog.lua")

if SERVER then
resource.AddWorkshop( "2248752220" )
end

