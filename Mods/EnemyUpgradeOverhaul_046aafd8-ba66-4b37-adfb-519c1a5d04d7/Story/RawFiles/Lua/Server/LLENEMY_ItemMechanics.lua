function LLENEMY_ItemIsRare(item, itemType)
	if itemType ~= "Common" and itemType ~= "" then
		return true
	elseif ItemGetGoldValue(item) >= 250 then
		return true
	end
end

local function LLENEMY_TryScatterInventory(uuid)
	local x,y,z = GetPosition(uuid)
	local character = Ext.GetCharacter(uuid)
	if character ~= nil then
		local inventory = character:GetInventoryItems()
		if inventory ~= nil and #inventory > 0 then
			for k,v in pairs(inventory) do
				if ObjectExists(v) == 1 then
					--LLENEMY_Ext_Debug_PrintItemProperties(v)
					--LLENEMY_Ext_Debug_PrintFlags(v)
					--local equipped = Mods.LeaderLib.ItemIsEquipped(char,v)
					local item = Ext.GetItem(v)
					local stat = item.StatsId
					local equipped = item.Slot <= 13 -- Equipped
					-- Stats that start with an underscore aren't meant for players
					if equipped == false and string.sub(stat, 1, 1) ~= "_" then
						ItemScatterAt(v, x,y,z)
						ItemClearOwner(v)
						
						LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ScatterInventory] Scattering item ("..tostring(stat)..")["..v.."] Slot("..tostring(item.Slot)..")")
						if not string.find(stat, "Gold") and (LLENEMY_ItemIsRare(v, item.ItemType)) then
							PlayEffect(v, "LLENEMY_FX_TreasureGoblin_Loot_Dropped_01");
						end
					else
						LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ScatterInventory] Item ("..tostring(stat)..")["..v.."] is equipped ("..tostring(equipped)..") or an NPC item. Skipping.")
					end
				end
			end
		else
			error("Inventory from ("..uuid..") is empty or null!")
		end
	else
		error("Character from ("..uuid..") is null!")
	end
end

function ScatterInventory(char)
	local success = pcall(LLENEMY_TryScatterInventory, char)
	if not success then
		LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ScatterInventory] Failed to scatter items for ("..char..").")
	end
end

function DestroyEmptyContainer(uuid)
	local containerGoldValue = ContainerGetGoldValue(uuid)
	local containerValue = ItemGetGoldValue(uuid)
	LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:DestroyEmptyContainer] Destroy ("..uuid..")? containerGoldValue("..tostring(containerGoldValue)..") containerValue("..tostring(containerValue)..")")
	if containerGoldValue <= 1 then
		ItemDestroy(uuid)
	end
end