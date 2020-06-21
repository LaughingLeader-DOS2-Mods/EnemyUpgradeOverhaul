local Boosts = {
	Weapon = {
		MinDamage = "integer",
		MaxDamage = "integer",
		DamageBoost = "integer",
		DamageFromBase = "integer",
		CriticalDamage = "integer",
		WeaponRange = "number",
		--CleaveAngle = "integer",
		--CleavePercentage = "number",
		--AttackAPCost = "integer",
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
		--Durability = "integer",
		--DurabilityDegradeSpeed = "integer",
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
		--ItemColor = "string",
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

local function AddBoostValue(stat, boost, value, valType)
	if stat[boost] == nil then
		stat[boost] = value
	else
		if valType == "integer" then
			stat[boost] = stat[boost] + value
		elseif boost == "Skills" then
			stat[boost] = stat[boost] + ";" + value
		end
	end
end

function CreateNewCorruptedStatItem(item,stat,statType,level)
	local totalBoosts = ItemCorruption.AddRandomBoosts(item, stat, statType, level)
	if totalBoosts > 2 then
		local itemObject = Ext.GetItem(item)
		local newStat = {}

		for i,stat in ipairs(item.Stats.DynamicStats) do
			for boostName,valType in pairs(Boosts.Any) do
				AddBoostValue(newStat, boostName, stat[boostName], valType)
			end
			if stat.StatsType == "Weapon" then
				for boostName,valType in pairs(Boosts.Weapon) do
					AddBoostValue(newStat, boostName, stat[boostName], valType)
				end
			end
			if stat.StatsType == "Shield" then
				for boostName,valType in pairs(Boosts.Shield) do
					AddBoostValue(newStat, boostName, stat[boostName], valType)
				end
			end
			if stat.StatsType == "Armor" then
				for boostName,valType in pairs(Boosts.Armor) do
					AddBoostValue(newStat, boostName, stat[boostName], valType)
				end
			end
		end

		local newStatIndex = 0
		
		if PersistentVars.NewCorruptionStats[stat] == nil then
			PersistentVars.NewCorruptionStats[stat] = {}
		else
			newStatIndex = #PersistentVars.NewCorruptionStats[stat]
		end
		
		local newStatName = string.format("%s_LLENEMY_Corrupted%i", stat, newStatIndex)
		table.insert(PersistentVars.NewCorruptionStats[stat], newStatName)

		local stat = Ext.CreateStat(newStatName, statType, stat)
		for boost,val in pairs(newStat) do
			stat[boost] = val
		end
		Ext.SyncStat(newStatName)

		SetRandomShadowName(item, statType)

		NRD_ItemCloneBegin(item)
		if statType == "Weapon" then
			-- Damage type fix
			-- Deltamods with damage boosts may make the weapon's damage type be all of that type, so overwriting the statType
			-- fixes this issue.
			local damageTypeString = Ext.StatGetAttribute(stat, "Damage Type")
			if damageTypeString == nil then damageTypeString = "Physical" end
			local damageTypeEnum = LeaderLib.Data.DamageTypeEnums[damageTypeString]
			NRD_ItemCloneSetInt("DamageTypeOverwrite", damageTypeEnum)
		end
	
		NRD_ItemCloneSetString("GenerationStatsId", newStatName)
		NRD_ItemCloneSetString("StatsEntryName", newStatName)
		NRD_ItemCloneSetInt("HasGeneratedStats", 1)
		NRD_ItemCloneSetInt("GenerationLevel", level)
		NRD_ItemCloneSetInt("StatsLevel", level)
		NRD_ItemCloneSetInt("IsIdentified", 1)
		NRD_ItemCloneSetString("ItemType", "Epic")
		NRD_ItemCloneSetString("GenerationItemType", "Epic")
		local clone = NRD_ItemClone()

		local container = GetInventoryOwner(item)

		if container == nil and ItemIsInInventory(item) then
			container = GetInventoryOwner(item)
			if container == nil then
				container = NRD_ItemGetParent(item)
			end
		end
		if container ~= nil then
			ItemToInventory(clone, container, 1, 0, 0)
		else
			local x,y,z = GetPosition(item)
			if x == nil or y == nil or z == nil then
				x,y,z = GetPosition(CharacterGetHostCharacter())
			end
			TeleportToPosition(clone, x,y,z, "", 0, 1)
		end

		ItemRemove(item)
	end
end