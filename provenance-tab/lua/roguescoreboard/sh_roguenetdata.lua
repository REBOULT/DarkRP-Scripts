

local plyMeta = FindMetaTable("Player")

local dataConverters = {
    ["Entity"] = function(a) return a end,
    ["Bool"] = function(a) return !!a end,
    ["String"] = function(a) return tostring(a) end,
    ["Int"] = function(a) return math.floor(tonumber(a)) end,
    ["Float"] = function(a) return tonumber(a) end,
    ["Vector"] = function(a) return Vector(a) end,
    ["Angle"] = function(a) return Angle(a) end,
}

RogueScoreboard.NetData = RogueScoreboard.NetData or {}

local NetData = RogueScoreboard.NetData

if SERVER then
    util.AddNetworkString("RogueScoreboard.NetData")

    function plyMeta:SetRogueNetData(key, data)
        NetData[self] = NetData[self] or {}

        NetData[self][key] = data

        net.Start("RogueScoreboard.NetData")
            net.WriteEntity(self)
            net.WriteString(key)
            net.WriteType(data)
        net.Broadcast()
    end

    for dataType, dataConverter in pairs(dataConverters) do
        plyMeta["SetRogueNet" .. dataType] = function(ply, key, data)
            ply:SetRogueNetData(key, dataConverter(data))
        end
    end

    hook.Add("PlayerInitialSpawn", "SyncNetData", function(ply)
        timer.Simple(FrameTime(), function()
            if !IsValid(ply) or !ply:IsPlayer() then return end

            for dataPly, dataTable in pairs(NetData) do
                for dataKey, data in pairs(dataTable) do
                    net.Start("RogueScoreboard.NetData", false)
                        net.WriteEntity(dataPly)
                        net.WriteString(dataKey)
                        net.WriteType(data)
                    net.Send(ply)
                end
            end
        end)
    end)
else
    net.Receive("RogueScoreboard.NetData", function()
        local ply = net.ReadEntity()
        local key = net.ReadString()
        local data = net.ReadType()

        NetData[ply] = NetData[ply] or {}

        NetData[ply][key] = data
    end)
end

function plyMeta:GetRogueNetData(key, default)
    local data = NetData[self] and NetData[self][key] or default

    return data
end

for dataType, dataConverter in pairs(dataConverters) do
    plyMeta["GetRogueNet" .. dataType] = function(ply, key, default)
        local rawData = ply:GetRogueNetData(key, default)
        if rawData == nil then
            return nil
        end
        return dataConverter(rawData)
    end
end

-- vk.com/urbanichka