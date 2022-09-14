THIRDPERSON_ENHANCED = {}

local function IncludeFile(file)
  if SERVER then
    include(file);
    AddCSLuaFile(file);
  end
  if CLIENT then
    include(file);
  end
end

local files, directories = file.Find("thirdperson_enhanced/*.lua", "LUA");
for _, file in pairs(files) do
	IncludeFile("thirdperson_enhanced/"..file);
end
