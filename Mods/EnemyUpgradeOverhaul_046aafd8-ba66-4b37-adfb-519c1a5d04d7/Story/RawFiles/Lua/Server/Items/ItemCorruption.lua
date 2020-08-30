local TranslatedString = LeaderLib.Classes["TranslatedString"]
local ItemBoost = LeaderLib.Classes["ItemBoost"]
local ItemBoostGroup = LeaderLib.Classes["ItemBoostGroup"]

local function RollForBoost(entry)
	if entry.Chance < 100 and entry.Chance > 0 then
		local roll = Ext.Random(1,100)
		LeaderLib.PrintDebug("[LLENEMY_ItemCorruption.lua:RollForBoost] Roll for ("..entry.Boost.."): ".. tostring(roll).."/"..tostring(entry.Chance))
		if roll <= entry.Chance then
			return true
		end
	elseif entry.Chance >= 100 then
		return true
	end
	return false
end

local function CanAddBoost(entry, stat, statType)
	if statType == "Weapon" then
		local weaponType = Ext.StatGetAttribute(stat, "WeaponType")
		local dm = Ext.GetDeltaMod(entry.Boost, statType)
		if dm ~= nil then
			if dm.WeaponType == "Sentinel" or dm.WeaponType == weaponType then
				return true
			else
				LeaderLib.PrintDebug("[LLENEMY_ItemCorruption.lua:CanAddBoost] WeaponType deltamod mismatch for ("..stat..") ("..weaponType..") => ("..dm.WeaponType..") with deltamod ["..entry.Boost.."]")
				--LeaderLib.PrintDebug(Ext.JsonStringify(dm))
				return false
			end
		else
			return true
		end
	end
	return true
end

local Boosts = {
	Weapon = {
		MinDamage = "integer",
		MaxDamage = "integer",
		DamageBoost = "integer",
		DamageFromBase = "integer",
		CriticalDamage = "integer",
		WeaponRange = "number",
		CleaveAngle = "integer",
		CleavePercentage = "number",
		AttackAPCost = "integer",
	},
	Armor = {
		ArmorValue = "integer",
		ArmorBoost = "integer",
		MagicArmorValue = "integer",
		MagicArmorBoost = "integer",
	},
	Shield = {
		ArmorValue = "integer",
		ArmorBoost = "integer",
		MagicArmorValue = "integer",
		MagicArmorBoost = "integer",
		Blocking = "integer",
	},
	Any = {
		Durability = "integer",
		DurabilityDegradeSpeed = "integer",
		StrengthBoost = "integer",
		FinesseBoost = "integer",
		IntelligenceBoost = "integer",
		ConstitutionBoost = "integer",
		Memory = "integer",
		WitsBoost = "integer",
		Willpower = "integer",
		Bodybuilding = "integer",
		SightBoost = "integer",
		HearingBoost = "integer",
		VitalityBoost = "integer",
		--SourcePointsBoost = "integer",
		MaxAP = "integer",
		StartAP = "integer",
		APRecovery = "integer",
		AccuracyBoost = "integer",
		DodgeBoost = "integer",
		LifeSteal = "integer",
		CriticalChance = "integer",
		ChanceToHitBoost = "integer",
		MovementSpeedBoost = "integer",
		RuneSlots = "integer",
		RuneSlots_V1 = "integer",
		FireResistance = "integer",
		AirResistance = "integer",
		WaterResistance = "integer",
		EarthResistance = "integer",
		PoisonResistance = "integer",
		ShadowResistance = "integer",
		PiercingResistance = "integer",
		CorrosiveResistance = "integer",
		PhysicalResistance = "integer",
		MagicResistance = "integer",
		CustomResistance = "integer",
		Movement = "integer",
		Initiative = "integer",
		MaxSummons = "integer",
		Value = "integer",
		Weight = "integer",
		Skills = "string",
		ItemColor = "string",
	}
}

local armorResistances = {
	"FireResistance",
	"AirResistance",
	"WaterResistance",
	"EarthResistance",
	"PoisonResistance",
	"PiercingResistance",
	"PhysicalResistance",
	--"ShadowResistance",
	--"CorrosiveResistance",
	--"MagicResistance",
}

local weaponNegativeBoosts = {
	{Stat="CriticalDamage", Min=1,Max=10},
	{Stat="WeaponRange", Min=1,Max=10},
	{Stat="DamageFromBase", Min=1,Max=5},
	{Stat="CriticalChance", Min=1,Max=5},
}

local function DebugItemStats(uuid)
	local item = Ext.GetItem(uuid)
	for i,stat in ipairs(item.Stats.DynamicStats) do
		Ext.Print("Stat " .. tostring(i) ..":")
		Ext.Print("---------------------------")
		for boostName,valType in pairs(Boosts.Any) do
			Ext.Print(boostName, stat[boostName])
		end
		if stat.StatsType == "Weapon" then
			for boostName,valType in pairs(Boosts.Weapon) do
				Ext.Print(boostName, stat[boostName])
			end
		end
		if stat.StatsType == "Shield" then
			for boostName,valType in pairs(Boosts.Shield) do
				Ext.Print(boostName, stat[boostName])
			end
		end
		if stat.StatsType == "Armor" then
			for boostName,valType in pairs(Boosts.Armor) do
				Ext.Print(boostName, stat[boostName])
			end
		end
		Ext.Print("---------------------------")
	end
end

local function AddBoost(item,stat,min,max,negative)
	local currentValue = NRD_ItemGetPermanentBoostInt(item, stat)
	local valMod = 0
	if not negative then
		valMod = Ext.Random(min, max)
	else
		valMod = -Ext.Random(min, max)
	end
	local nextValue = currentValue + valMod
	NRD_ItemSetPermanentBoostInt(item, stat, nextValue)
	LeaderLib.PrintDebug("	[LLENEMY_ItemCorruption.lua:AddBoost] Adding boost ["..stat.."] to item. ("..tostring(currentValue)..") => ("..tostring(nextValue)..")")
end

local function AddRandomNegativeBoost_Old(item,stat,statType,level)
	if level == nil or level <= 0 then level = 1 end
	if statType == "Armor" or statType == "Shield" then
		local boostStat = LeaderLib.Common.GetRandomTableEntry(armorResistances)
		local min = 1 + math.ceil(level/2)
		local max = 5 + math.min(level,15)
		AddBoost(item,boostStat,min,max,true)
		if statType == "Shield" and Ext.Random(1,100) >= 50 then
			AddBoost(item,"Blocking",1,5,true)
		end
		return true
	elseif statType == "Weapon" then
		local boostStatEntry = LeaderLib.Common.GetRandomTableEntry(weaponNegativeBoosts)
		AddBoost(item,boostStatEntry.Stat,boostStatEntry.Min,boostStatEntry.Max,true)
		if Ext.Random(1,100) >= 50 then
			boostStatEntry = LeaderLib.Common.GetRandomTableEntry(weaponNegativeBoosts)
			AddBoost(item,boostStatEntry.Stat,boostStatEntry.Min,boostStatEntry.Max,true)
		end
		return true
	end
	return false
end

local function AddRandomNegativeBoosts(item,stat,statType,level,total)
	if level == nil or level <= 0 then level = 1 end
	local ranNegativeBoosts = ItemCorruption.Boosts.Resistances:GetRandomEntries(2)
	local i = 0
	while i < total do
		---@type ItemBoost
		local boost = LeaderLib.Common.GetRandomTableEntry(ranNegativeBoosts)
		boost:Apply(item, -1)
		i = i + 1
	end
end

local function AddRandomDeltaModsFromTable(item,stat,statType,level,boostTable,isClone)
	local totalBoosts = 0
	local boosts = {}
	for i,entry in pairs(boostTable) do
		if entry["Entries"] ~= nil then
			-- Keep trying to get random entries until we find at least one that's valid
			for k=0,#entry.Entries do
				local ranEntry = entry:GetRandomEntry()
				if CanAddBoost(ranEntry, stat, statType) then
					if ranEntry.MinLevel <= 0 and ranEntry.MaxLevel <= 0 then
						boosts[#boosts+1] = ranEntry
					elseif level >= ranEntry.MinLevel and (level <= ranEntry.MaxLevel or ranEntry.MaxLevel <= 0) then
						boosts[#boosts+1] = ranEntry
					end
					break
				end
			end
		else
			if CanAddBoost(entry, stat, statType) then
				if entry.MinLevel <= 0 and entry.MaxLevel <= 0 then
					boosts[#boosts+1] = entry
				elseif level >= entry.MinLevel and (level <= entry.MaxLevel or entry.MaxLevel <= 0) then
					boosts[#boosts+1] = entry
				end
			end
		end
	end
	LeaderLib.PrintDebug("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Boosts:\n" .. LeaderLib.Common.Dump(boosts))
	local boostCount = #boosts
	local boostAdded = false
	if boostCount == 1 then
		local entry = boosts[1]
		if entry ~= nil then
			if RollForBoost(entry) then
				if isClone == true then
					NRD_ItemCloneAddBoost(entry.Type, entry.Boost)
				else
					ItemAddDeltaModifier(item, entry.Boost)
				end
				LeaderLib.PrintDebug("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Adding deltamod ["..entry.Type.."]".."("..entry.Boost..") to item ["..item.."]("..stat..")")
				totalBoosts = totalBoosts + 1
				boostAdded = true
			end
		end
	elseif boostCount > 0 then
		for i,entry in pairs(boosts) do
			if RollForBoost(entry) then
				if isClone == true then
					NRD_ItemCloneAddBoost(entry.Type, entry.Boost)
				else
					ItemAddDeltaModifier(item, entry.Boost)
				end
				LeaderLib.PrintDebug("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Adding deltamod ["..entry.Type.."]".."("..entry.Boost..") to item ["..item.."]("..stat..")")
				totalBoosts = totalBoosts + 1
				boostAdded = true
			end
		end
	end
	if not boostAdded then
		local entry = LeaderLib.Common.GetRandomTableEntry(boosts)
		if entry ~= nil then
			if isClone == true then
				NRD_ItemCloneAddBoost(entry.Type, entry.Boost)
			else
				ItemAddDeltaModifier(item, entry.Boost)
			end
			LeaderLib.PrintDebug("[LLENEMY_ItemCorruption.lua:AddRandomBoostsFromTable] Adding fallback deltamod ["..entry.Type.."]".."("..entry.Boost..") to item ["..item.."]("..stat..")")
			totalBoosts = totalBoosts + 1
		end
	end
	-- if statType == "Shield" then
	-- 	NRD_ItemCloneAddBoost("DeltaMod", "LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage")
	-- 	totalBoosts = totalBoosts + 1
	-- end
	return totalBoosts
end

local function AddRandomBoosts(item,stat,statType,level,minBoosts)
	local totalBoosts = 0
	local boostTable = ItemCorruption.Boosts[statType]
	if boostTable ~= nil then
		for i,group in ipairs(boostTable) do
			LeaderLib.PrintDebug("Applying boosts from group: " .. tostring(group.ID))
			totalBoosts = totalBoosts + group:Apply(item,stat,statType,level,1,false,nil,minBoosts)
		end
	end
	return totalBoosts
end

ItemCorruption.AddRandomBoosts = AddRandomBoosts

local function SetRandomShadowName(item,statType)
	if statType == "Weapon" or statType == "Shield" then
		local name = LeaderLib.Common.GetRandomTableEntry(ItemCorruption.Names)
		local color = LeaderLib.Common.GetRandomTableEntry(ItemCorruption.Colors)
		name = string.format("<font color='%s'>%s</font>", color, name)
		NRD_ItemCloneSetString("CustomDisplayName", name)
		--NRD_ItemCloneSetString("CustomDescription", ShadowItemDescription.Value)
	else
		-- Wrap original names in a purple color
		-- local handle,templateName = ItemTemplateGetDisplayString(GetTemplate(item))
		-- LeaderLib.PrintDebug("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] ("..item..") handle("..handle..") templateName("..templateName..")")
		-- local originalName = Ext.GetTranslatedString(handle, templateName)
		-- if originalName ~= NRD_ItemGetStatsId(item) and originalName ~= GetStatString(item) then
		-- 	-- Name isn't a stat entry name.
		-- 	local color = LeaderLib.Common.GetRandomTableEntry(ItemCorruption.Colors)
		-- 	local name = string.format("<font color='%s'>%s</font>", color, originalName)
		-- 	NRD_ItemCloneSetString("CustomDisplayName", name)
		-- 	LeaderLib.PrintDebug("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] New shadow item name is ("..name..")")
		-- end
	end
end

ItemCorruption.SetRandomShadowName = SetRandomShadowName

local AllRarities = {
	"Common",
	"Uncommon",
	"Rare",
	"Epic",
	"Legendary",
	"Divine",
	"Unique",
}

local rarityValue = {
	Common = 0,
	Uncommon = 1,
	Rare = 2,
	Epic = 3,
	Legendary = 4,
	Divine = 5,
	Unique = 6
}

local function AddRandomBoostsToItem(item,stat,statType,level,cloned)
	local minBoosts = Ext.Random(1,3)
	-- if Ext.IsDeveloperMode() then
	-- 	minBoosts = 12
	-- end
	if level >= 4 then
		minBoosts = minBoosts + Ext.Random(0,2)
	end
	if level >= 8 then
		minBoosts = minBoosts + Ext.Random(0,3)
	end
	if level >= 13 then
		minBoosts = minBoosts + Ext.Random(0,2)
	end
	if level >= 16 then
		minBoosts = minBoosts + Ext.Random(0,2)
	end

	local totalBoosts = AddRandomBoosts(cloned,stat,statType,level,minBoosts)

	local objectCategory = Ext.StatGetAttribute(stat, "ObjectCategory")
	---@type ItemBoostGroup[]
	local bonusCategoryTable = ItemCorruption.Boosts.ObjectCategory[objectCategory]
	if bonusCategoryTable ~= nil then
		--print("Adding ObjectCategory bonuses", objectCategory)
		--print(Common.Dump(bonusCategoryTable))
		for i,v in pairs(bonusCategoryTable) do
			if v.Type == "RandomGroupContainer" then
				---@type ItemBoostGroup
				local group = Common.GetRandomTableEntry(v.Entries)
				totalBoosts = totalBoosts + group:Apply(cloned,stat,statType,level,1,false,nil,minBoosts)
			elseif v.Type == "ItemBoostGroup" then
				totalBoosts = totalBoosts + v:Apply(cloned,stat,statType,level,1,false,nil,minBoosts)
			end
		end
	end

	if totalBoosts > 0 then
		AddRandomNegativeBoosts(cloned, stat, statType, level, math.max(2,math.ceil(totalBoosts/2)))
	end
end

local function GetClone(item,stat,statType,forceRarity)
	local baseStat,rarity,level,seed = NRD_ItemGetGenerationParams(item)
	if level == nil then
		level = NRD_ItemGetInt(item, "LevelOverride")
		if level == 0 or level == nil then
			level = CharacterGetLevel(CharacterGetHostCharacter())
		end
	end
    local template = GetTemplate(item)
	local last_underscore = string.find(template, "_[^_]*$")
	local stripped_template = string.sub(template, last_underscore+1)
	NRD_ItemCloneBegin(item)
	--NRD_ItemCloneResetProgression()
	NRD_ItemCloneSetString("RootTemplate", stripped_template)
	NRD_ItemCloneSetString("OriginalRootTemplate", stripped_template)
	if stat == nil or stat == "" then
		stat = baseStat
	end
	-- if seed ~= nil and seed > 0 then
	-- 	NRD_ItemCloneSetInt("GenerationRandom", seed)
	-- else
	-- 	NRD_ItemCloneSetInt("GenerationRandom", Ext.Random(1,9999999))
	-- end

	if statType == "Weapon" then
		-- Damage type fix
		-- Deltamods with damage boosts may make the weapon's damage type be all of that type, so overwriting the statType
		-- fixes this issue.
		local damageTypeString = Ext.StatGetAttribute(stat, "Damage Type")
		if damageTypeString == nil then damageTypeString = "Physical" end
		local damageTypeEnum = LeaderLib.Data.DamageTypeEnums[damageTypeString]
		NRD_ItemCloneSetInt("DamageTypeOverwrite", damageTypeEnum)
	end

	NRD_ItemCloneSetString("GenerationStatsId", stat)
	NRD_ItemCloneSetString("StatsEntryName", stat)
	NRD_ItemCloneSetInt("HasGeneratedStats", 1)
	NRD_ItemCloneSetInt("GenerationLevel", level)
	NRD_ItemCloneSetInt("StatsLevel", level)
	NRD_ItemCloneSetInt("IsIdentified", 1)
	--NRD_ItemCloneSetInt("GMFolding", 0)

	if forceRarity == "Random" then
		rarity = Common.GetRandomTableEntry(AllRarities)
	elseif forceRarity ~= nil then
		rarity = forceRarity
	end

	if rarity == nil or (rarityValue[rarity] < rarityValue["Epic"] and Ext.Random(0,100) <= 25) then
		rarity = "Epic"
	end
	NRD_ItemCloneSetString("ItemType", rarity)
	if statType == "Weapon" then
		NRD_ItemCloneSetString("ItemType", "Epic") -- Since the name is custom anyway
	end
	NRD_ItemCloneSetString("GenerationItemType", rarity)

	local value = ItemGetGoldValue(item)
	if value > 0 then
		value = math.floor(math.max(1, value * 0.40))
		NRD_ItemCloneSetInt("GoldValueOverwrite", value)
	end
	
	SetRandomShadowName(item, statType)
	local cloned = NRD_ItemClone()
	SetTag(cloned, "LLENEMY_ShadowItem")

	if Ext.IsDeveloperMode() then
		--NRD_ItemIterateDeltaModifiers(cloned, "Iterator_LeaderLib_Debug_PrintDeltamods")
	end
	local status,err = xpcall(AddRandomBoostsToItem, debug.traceback, item, stat, statType, level, cloned)
	if not status then
		print("[EnemyUpgradeOverhaul] Error calling AddRandomBoostsToItem:\n", err)
	end

	return cloned
end

local ignoredSlots = {
	Wings = true,
	Horns = true,
	Overhead = true,
}

local corruptableTypes = {
	Weapon = true,
	Shield = true,
	Armor = true,
}

---@param uuid string The item to corrupt.
---@param container string The item it's container, if any.
---@return string|nil The corrupted item.
local function TryShadowCorruptItem(uuid, container, forceRarity)
	if uuid ~= nil then
		local item = Ext.GetItem(uuid)
		local stat = item.StatsId
		local statType = NRD_StatGetType(stat)
		if statType == "Weapon" or statType == "Armor" or statType == "Shield" then
			local equippedSlot = Ext.StatGetAttribute(stat, "Slot")
			--LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ShadowCorruptItem] stat("..tostring(stat)..") SlotNumber("..tostring(item.Slot)..") Slot("..tostring(equippedSlot)..") ItemType("..tostring(item.ItemType)..")")
			if ignoredSlots[equippedSlot] ~= true and string.sub(stat, 1, 1) ~= "_" then -- Not equipped in a hidden slot, not an NPC item
				if item.Slot > 13 then
					if ItemCorruption.Boosts[statType] ~= nil then
						local cloned = GetClone(uuid, stat, statType, forceRarity)
						NRD_ItemSetIdentified(cloned,1)

						if container == nil and ItemIsInInventory(uuid) then
							container = GetInventoryOwner(uuid)
							if container == nil then
								container = NRD_ItemGetParent(uuid)
							end
						end
						if container ~= nil then
							ItemToInventory(cloned, container, 1, 0, 0)
						else
							local x,y,z = GetPosition(uuid)
							if x == nil or y == nil or z == nil then
								x,y,z = GetPosition(CharacterGetHostCharacter())
							end
							TeleportToPosition(cloned, x,y,z, "", 0, 1)
						end
						ItemRemove(uuid)
						LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Successfully corrupted ("..tostring(cloned)..")")
						return cloned
						--NRD_ItemSetIdentified(cloned, 1)
					else
						LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] No boosts table for type ("..tostring(statType)..")")
					end
				end
			elseif item.Slot > 13 then -- Not equipped
				LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ShadowCorruptItem] Deleting ("..uuid..") Stat("..tostring(stat)..") since it's an item that shouldn't be given to players.")
				ItemRemove(uuid)
				return nil
			end
		end
		return uuid
	else
		error("Item ("..tostring(uuid)..") is nil!")
		return nil
	end
end

function ShadowCorruptItem(item)
	local container = GetInventoryOwner(item)
	local b,result = xpcall(TryShadowCorruptItem, debug.traceback, item, container)
	if b then
		return result
	else
		Ext.PrintError("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Error corrupting item:\n"..tostring(result))
	end
	return nil
end

function ShadowCorruptContainerItems(uuid, forceRarity)
	local min = math.floor(GameHelpers.GetExtraData("LLENEMY_ItemCorruption_MinItemsAffected", 1))
	local max = math.ceil(GameHelpers.GetExtraData("LLENEMY_ItemCorruption_MaxItemsAffected", 3))

	local items = nil
	local level = 1

	if ObjectIsItem(uuid) == 1 then
		---@type EsvItem
		local container = Ext.GetItem(uuid)
		---@type string[]
		items = container:GetInventoryItems()
		if container.TreasureLevel > container.LevelOverride then
			level = container.TreasureLevel
		elseif container.LevelOverride > 0 then
			level = container.LevelOverride
		else
			level = CharacterGetLevel(CharacterGetHostCharacter())
		end
	elseif ObjectIsCharacter(uuid) == 1 then
		---@type EsvCharacter
		local character = Ext.GetCharacter(uuid)
		---@type string[]
		items = character:GetInventoryItems()
		level = character.Stats.Level
	end

	-- 9
	local leap1 = math.tointeger(Ext.ExtraData["FirstPriceLeapLevel"])
	-- 13
	local leap2 = math.tointeger(Ext.ExtraData["SecondPriceLeapLevel"])
	-- 16
	local leap3 = math.tointeger(Ext.ExtraData["ThirdPriceLeapLevel"])
	-- 18
	local leap4 = math.tointeger(Ext.ExtraData["FourthPriceLeapLevel"])

	if level >= leap1 then
		local rollBonus = math.tointeger(Ext.ExtraData["LLENEMY_ShadowTreasure_FirstPriceLeapRollBonus"] or 1)
		min = min + rollBonus
		max = max + rollBonus
	end
	if level >= leap2 then
		local rollBonus = math.tointeger(Ext.ExtraData["LLENEMY_ShadowTreasure_SecondPriceLeapRollBonus"] or 2)
		min = min + rollBonus
		max = max + rollBonus
	end
	if level >= leap3 then
		local rollBonus = math.tointeger(Ext.ExtraData["LLENEMY_ShadowTreasure_ThirdPriceLeapRollBonus"] or 1)
		min = min + rollBonus
		max = max + rollBonus
	end
	if level >= leap4 then
		local rollBonus = math.tointeger(Ext.ExtraData["LLENEMY_ShadowTreasure_FourthPriceLeapRollBonus"] or 2)
		min = min + rollBonus
		max = max + rollBonus
	end

	local corruptionLimit = 1
	if min == max then
		corruptionLimit = max
	else
		corruptionLimit = Ext.Random(min,max)
	end
	
	if Ext.IsDeveloperMode() then
		--corruptionLimit = 99
	end

	if items ~= nil then
		for i,v in pairs(items) do
			local stat = NRD_ItemGetStatsId(v)
			if string.sub(stat,1,1) == "_" then
				ItemRemove(v)
				Ext.PrintError("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Deleted item with NPC stat: "..stat)
			else
				if corruptionLimit <= 0 then
					break	
				end
				local b,result = xpcall(TryShadowCorruptItem, debug.traceback, v, uuid, forceRarity)
				if b then
					corruptionLimit = corruptionLimit - 1
				else
					Ext.PrintError("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Error corrupting item:\n"..tostring(result))
				end
			end
		end

		-- Reset limits
		for k,group in pairs(ItemCorruption.Boosts) do
			if group.Type == "ItemBoostGroup" then
				group:ResetApplied()
				group.Applied = 0
			elseif type(group) == "table" then
				for i,v in pairs(group) do
					if group.Type == "ItemBoostGroup" then
						group:ResetApplied()
						group.Applied = 0
					end
				end
			end
		end

		if ObjectIsItem(uuid) == 1 then
			ContainerIdentifyAll(uuid)
		end
	end
end

function CheckEmptyShadowOrb(uuid)
	local items = Ext.GetItem(uuid):GetInventoryItems()
	local itemAmount = 0
	if items ~= nil then
		itemAmount = #items
	end
	if (itemAmount == nil or itemAmount == 0) and ContainerGetGoldValue(uuid) <= 0 then
		ItemDestroy(uuid)
		LeaderLib.PrintDebug("[EUO:CheckEmptyShadowOrb] Shadow Orb ("..uuid..") is empty. Deleting.")
	end
end

ItemCorruption.AddRandomNegativeBoost = AddRandomNegativeBoost
ItemCorruption.DebugItemStats = DebugItemStats