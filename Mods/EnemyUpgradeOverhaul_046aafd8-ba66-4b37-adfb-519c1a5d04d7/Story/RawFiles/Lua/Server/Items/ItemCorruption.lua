local ShadowItemNames = Ext.Require("Server/Items/Corruption/Names.lua")
local ShadowNameColors = Ext.Require("Server/Items/Corruption/Colors.lua")
local CorruptionBoosts = Ext.Require("Server/Items/Corruption/Boosts.lua")
local CorruptionDeltaMods = Ext.Require("Server/Items/Corruption/DeltaMods.lua")

local TranslatedString = LeaderLib.Classes["TranslatedString"]
local ItemBoost = LeaderLib.Classes["ItemBoost"]
local ItemBoostGroup = LeaderLib.Classes["ItemBoostGroup"]

if ItemCorruption == nil then
	ItemCorruption = {}
end

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
		if Ext.IsDeveloperMode() and Ext.Version() >= 44 and Ext.GetDeltaMod ~= nil then
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
		SourcePointsBoost = "integer",
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
	print("Adding boost:",stat,min,max,negative)
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
	local ranNegativeBoosts = CorruptionBoosts.Resistances:GetRandomEntries(2)
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

local function AddRandomBoostsFromTable(item,stat,statType,level,boostTable,minBoosts)
	local totalBoosts = 0
	for i,group in ipairs(boostTable) do
		LeaderLib.PrintDebug("Applying boosts from group: " .. tostring(group.ID))
		totalBoosts = totalBoosts + group:Apply(item,stat,statType,level,1,false,nil,minBoosts)
	end
	return totalBoosts
end

local function AddRandomBoosts(item,stat,statType,level,minBoosts)
	local totalBoosts = 0
	local boostTable = CorruptionBoosts[statType]
	if boostTable ~= nil then
		totalBoosts = AddRandomBoostsFromTable(item,stat,statType,level,boostTable,minBoosts)
	end
	--AddRandomBoostsFromTable(item,stat,statType,level,CorruptionBoosts.All)
	return totalBoosts
end

ItemCorruption.AddRandomBoosts = AddRandomBoosts

local function SetRandomShadowName(item,statType)
	if statType == "Weapon" or statType == "Shield" then
		local name = LeaderLib.Common.GetRandomTableEntry(ShadowItemNames)
		local color = LeaderLib.Common.GetRandomTableEntry(ShadowNameColors)
		name = string.format("<font color='%s'>%s</font>", color, name)
		NRD_ItemCloneSetString("CustomDisplayName", name)
		if Ext.IsDeveloperMode() then
			LeaderLib.PrintDebug("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] New shadow item name is ("..name..")")
		end
		--NRD_ItemCloneSetString("CustomDescription", ShadowItemDescription.Value)
	else
		-- Wrap original names in a purple color
		-- local handle,templateName = ItemTemplateGetDisplayString(GetTemplate(item))
		-- LeaderLib.PrintDebug("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] ("..item..") handle("..handle..") templateName("..templateName..")")
		-- local originalName = Ext.GetTranslatedString(handle, templateName)
		-- if originalName ~= NRD_ItemGetStatsId(item) and originalName ~= GetStatString(item) then
		-- 	-- Name isn't a stat entry name.
		-- 	local color = LeaderLib.Common.GetRandomTableEntry(ShadowNameColors)
		-- 	local name = string.format("<font color='%s'>%s</font>", color, originalName)
		-- 	NRD_ItemCloneSetString("CustomDisplayName", name)
		-- 	LeaderLib.PrintDebug("[LLENEMY:LLENEMY_ItemMechanics.lua:SetRandomShadowName] New shadow item name is ("..name..")")
		-- end
	end
end

ItemCorruption.SetRandomShadowName = SetRandomShadowName

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
	local minBoosts = 1
	if Ext.IsDeveloperMode() then
		minBoosts = 12
	else
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
	end

	local totalBoosts = AddRandomBoosts(cloned,stat,statType,level,minBoosts)
	if totalBoosts > 0 then
		--SetVarInteger(cloned, "LLENEMY_ItemCorruption_TotalBoosts", totalBoosts)
		--Mods.LeaderLib.StartTimer("Timers_LLENEMY_AddNegativeItemBoosts", 100, cloned)
		AddRandomNegativeBoosts(cloned, stat, statType, level, math.max(2,math.ceil(totalBoosts/2)))
	end
end

local function GetClone(item,stat,statType)
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
	if rarity == nil or (rarityValue[rarity] < rarityValue["Epic"] and Ext.Random(0,100) <= 25) then
		rarity = "Epic"
	end
	NRD_ItemCloneSetString("ItemType", rarity)
	NRD_ItemCloneSetString("GenerationItemType", rarity)

	local value = ItemGetGoldValue(item)
	if value > 0 then
		value = math.floor(math.max(1, value * 0.40))
		NRD_ItemCloneSetInt("GoldValueOverwrite", value)
	end
	
	SetRandomShadowName(item, statType)
	local cloned = NRD_ItemClone()
	SetTag(cloned, "LLENEMY_ShadowItem")

	NRD_ItemIterateDeltaModifiers(cloned, "Iterator_LeaderLib_Debug_PrintDeltamods")
	AddRandomBoostsToItem(item, stat, statType, level, cloned)

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

local function TryShadowCorruptItem(uuid, container)
	if uuid ~= nil then
		local item = Ext.GetItem(uuid)
		local stat = item.StatsId
		local statType = NRD_StatGetType(stat)
		if statType == "Weapon" or statType == "Armor" or statType == "Shield" then
			local equippedSlot = Ext.StatGetAttribute(stat, "Slot")
			LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ShadowCorruptItem] stat("..tostring(stat)..") SlotNumber("..tostring(item.Slot)..") Slot("..tostring(equippedSlot)..") ItemType("..tostring(item.ItemType)..")")
			if ignoredSlots[equippedSlot] ~= true and string.sub(stat, 1, 1) ~= "_" then -- Not equipped in a hidden slot, not an NPC item
				if item.Slot > 13 then
					if CorruptionBoosts[statType] ~= nil then
						local cloned = GetClone(uuid, stat, statType)
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

local corruptedItemLimit = {}
local shadowOrbItemAmount = {}

function ShadowCorruptItem(item)
	local stat = NRD_ItemGetStatsId(item)
	if string.sub(stat,1,1) == "_" then
		ItemRemove(item)
		Ext.PrintError("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Deleted item with NPC stat: "..stat)
	else
		local container = GetInventoryOwner(item)
		local limit = nil
		if container ~= nil then
			limit = corruptedItemLimit[container]
			if limit ~= nil and limit <= 0 then
				return nil
			end
			if shadowOrbItemAmount[container] == nil then
				shadowOrbItemAmount[container] = 1
			else
				shadowOrbItemAmount[container] = shadowOrbItemAmount[container] + 1
			end
		end

		local b,result = xpcall(TryShadowCorruptItem, debug.traceback, item, container)
		if b then
			if limit ~= nil then
				limit = limit - 1
				corruptedItemLimit[container] = limit
			end
			return result
		else
			Ext.PrintError("[LLENEMY_ItemMechanics.lua:LLENEMY_ShadowCorruptItem] Error corrupting item:\n"..tostring(result))
		end
	end
	return nil
end
Ext.NewCall(ShadowCorruptItem, "LLENEMY_ShadowCorruptItem", "(ITEMGUID)_Item");

function ShadowCorruptContainerItems(uuid)
	corruptedItemLimit[uuid] = Ext.Random(1,3)
	shadowOrbItemAmount[uuid] = 0
	InventoryLaunchIterator(uuid, "Iterators_LLENEMY_CorruptItem", "")
	--[[ local success = false
	local item = Ext.GetItem(uuid)
	if item ~= nil then
		local inventory = item:GetInventoryItems()
		if inventory ~= nil and #inventory > 0 then
			success = true
			for k,v in pairs(inventory) do
				ShadowCorruptItem(v, uuid)
			end
		end
	end
	if not success then
		LeaderLib.PrintDebug("[LLENEMY_ItemMechanics.lua:ShadowCorruptItems] Failed to get inventory for item ("..uuid..")")
		InventoryLaunchIterator(uuid, "Iterators_LLENEMY_CorruptItem", "");
	end ]]
end

function CheckEmptyShadowOrb(uuid)
	local itemAmount = shadowOrbItemAmount[uuid]
	if (itemAmount == nil or itemAmount == 0) and ContainerGetGoldValue(uuid) <= 0 then
		ItemDestroy(uuid)
		LeaderLib.PrintDebug("[EUO:CheckEmptyShadowOrb] Shadow Orb ("..uuid..") is empty. Deleting.")
	end
	shadowOrbItemAmount[uuid] = nil
	corruptedItemLimit[uuid] = nil
end

ItemCorruption = {
	AddRandomNegativeBoost = AddRandomNegativeBoost,
	DebugItemStats = DebugItemStats,
	InitDeltaMods = function() CorruptionDeltaMods.Init() end
}