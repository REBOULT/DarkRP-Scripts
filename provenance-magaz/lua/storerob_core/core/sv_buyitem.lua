
local number1000
function number1000(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    local sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end

net.Receive("ncpstoredoact", function(len, pl)
	if not pl.npcstorerob_cooldown then pl.npcstorerob_cooldown = 0 end
	if pl.npcstorerob_cooldown > CurTime() then return end
	pl.npcstorerob_cooldown = CurTime() + 1
	-- Remaps the table
	local item = net.ReadTable()
	local buyer = pl
	local usergroupaccess = false

	if not item then return end

	-- Checks if the item exists
	local ItemExists = nil
	for k, v in pairs(NPCRobSystem.Config.ShopContent) do
		if (item.ent == v.ent) and (item.price == v.price) then
			ItemExists = v
			continue
		end
	end

	-- Checks if the item was found
	if not ItemExists then return end

	-- Checks the player can affor the item
	if buyer:getDarkRPVar("money") < ItemExists.price then
		net.Start( "ncpshopmsg" )
			net.WriteString( string.format( NPCRobSystem.Language.NoBuyMoney, ItemExists.name ) )
		net.Send(buyer)
		return
	end

	-- Checks if the player has permission to buy the item
	if ItemExists.customCheck ~= nil then
		if !(ItemExists.customCheck(buyer)) then
			net.Start( "ncpshopmsg" )
				net.WriteString( string.format( NPCRobSystem.Language.NoBuyRank, ItemExists.name ) )
			net.Send(buyer)
			return
		end
	end

	-- If the item is a weapon, give it to the player
	if ItemExists.isWep then
		buyer:Give( ItemExists.ent )
		buyer:addMoney(-ItemExists.price)
		net.Start( "ncpshopmsg" )
			net.WriteString( string.format( NPCRobSystem.Language.Brought, ItemExists.name, number1000(ItemExists.price) ) )
		net.Send(buyer)
		return
	end

	-- Spawns the entity
	local entity = ents.Create( ItemExists.ent )
	if ( !IsValid( entity ) ) then return end 
	entity:SetPos( buyer:GetPos() + (buyer:GetForward()* 50) + Vector(0,0,50))
	if ItemExists.preSpawn ~= nil then ItemExists.preSpawn(buyer, entity) end
	entity:Spawn()
	if ItemExists.postSpawn ~= nil then ItemExists.postSpawn(buyer, entity) end

	entity:CPPISetOwner(buyer)

	hook.Run("NPCStoreRobPostPurchase", entity, buyer, ItemExists)

	buyer:addMoney(-ItemExists.price)
	net.Start( "ncpshopmsg" )
		net.WriteString( string.format( NPCRobSystem.Language.Brought, ItemExists.name, number1000(ItemExists.price) ) )
	net.Send(buyer)
end)

-- t.me/urbanichka