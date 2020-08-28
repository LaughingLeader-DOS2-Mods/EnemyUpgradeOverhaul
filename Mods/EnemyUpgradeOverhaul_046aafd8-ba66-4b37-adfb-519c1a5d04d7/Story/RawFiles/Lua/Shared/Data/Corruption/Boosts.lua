local TagBoost = Classes.TagBoost
local StatBoost = Classes.StatBoost
local ItemBoost = Classes.ItemBoost
local ItemBoostGroup = Classes.ItemBoostGroup

local Boosts = {
	---@type ItemBoostGroup[]
	Weapon = {},
	---@type ItemBoostGroup[]
	Shield = {},
	---@type ItemBoostGroup[]
	Armor = {},
	---@type ItemBoostGroup
	Resistances = {},
	---@type table<string, ItemBoostGroup>
	ObjectCategory = {},
	---@type table<string, string[]>
	BonusSkills = {},
}


local OnLeaderLibResPenTag = function(item,tag)
	SetTag(item, "LeaderLib_HasResistancePenetration")
	local skills = NRD_ItemGetPermanentBoostString(item, "Skills")
	if LeaderLib.StringHelpers.IsNullOrEmpty(skills) then
		local bonusSkillChance = Ext.ExtraData["LLENEMY_Treasure_BoostChance_ResistancePenetrationBonusSkill"] or 20
		if Ext.Random(1,100) <= bonusSkillChance then
			local skill = ""
			if string.find(tag, "Piercing") then
				if NRD_ItemGetPermanentBoostInt(item, "IntelligenceBoost") > 0 then
					skill = Common.GetRandomTableEntry(Boosts.BonusSkills["Death"])
				elseif NRD_ItemGetPermanentBoostInt(item, "FinesseBoost") > 0 then
					if NRD_ItemGetPermanentBoostAbility(item, "RogueLore") > 0 then
						skill = Common.GetRandomTableEntry(Boosts.BonusSkills["Rogue"])
					elseif NRD_ItemGetPermanentBoostAbility(item, "RangerLore") > 0 then
						skill = Common.GetRandomTableEntry(Boosts.BonusSkills["Ranger"])
					else
						local ability = Common.GetRandomTableEntry({"Ranger", "Rogue"})
						skill = Common.GetRandomTableEntry(Boosts.BonusSkills[ability])
					end
				else
					local ability = Common.GetRandomTableEntry({"Death", "Rogue", "Ranger"})
					skill = Common.GetRandomTableEntry(Boosts.BonusSkills[ability])
				end
			elseif string.find(tag, "Physical") then
				skill = Common.GetRandomTableEntry(Boosts.BonusSkills["Warrior"])
			else
				for ability,skills in pairs(Boosts.BonusSkills) do
					if string.find(tag, ability) then
						skill = Common.GetRandomTableEntry(skills)
						break
					end
				end
			end
			if skill ~= "" then
				NRD_ItemSetPermanentBoostString(item, "Skills", skill)
			end
		end
	end
end

local LeaderLibResPenTags = {
	--Physical5 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical5", "", nil, OnLeaderLibResPenTag),
	--Physical10 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical10", "", nil, OnLeaderLibResPenTag),
	--Physical15 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical15", "", nil, OnLeaderLibResPenTag),
	--Physical20 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical20", "", nil, OnLeaderLibResPenTag),
	--Physical25 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical25", "", nil, OnLeaderLibResPenTag),
	--Physical30 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical30", "", nil, OnLeaderLibResPenTag),
	--Physical35 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical35", "", nil, OnLeaderLibResPenTag),
	--Physical40 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical40", "", nil, OnLeaderLibResPenTag),
	--Physical45 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical45", "", nil, OnLeaderLibResPenTag),
	--Physical50 = TagBoost:Create("LeaderLib_ResistancePenetration_Physical50", "", nil, OnLeaderLibResPenTag),
	Earth5 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth5", "", nil, OnLeaderLibResPenTag),
	Earth10 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth10", "", nil, OnLeaderLibResPenTag),
	Earth15 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth15", "", nil, OnLeaderLibResPenTag),
	Earth20 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth20", "", nil, OnLeaderLibResPenTag),
	Earth25 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth25", "", nil, OnLeaderLibResPenTag),
	Earth30 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth30", "", nil, OnLeaderLibResPenTag),
	Earth35 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth35", "", nil, OnLeaderLibResPenTag),
	Earth40 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth40", "", nil, OnLeaderLibResPenTag),
	Earth45 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth45", "", nil, OnLeaderLibResPenTag),
	Earth50 = TagBoost:Create("LeaderLib_ResistancePenetration_Earth50", "", nil, OnLeaderLibResPenTag),
	Water5 = TagBoost:Create("LeaderLib_ResistancePenetration_Water5", "", nil, OnLeaderLibResPenTag),
	Water10 = TagBoost:Create("LeaderLib_ResistancePenetration_Water10", "", nil, OnLeaderLibResPenTag),
	Water15 = TagBoost:Create("LeaderLib_ResistancePenetration_Water15", "", nil, OnLeaderLibResPenTag),
	Water20 = TagBoost:Create("LeaderLib_ResistancePenetration_Water20", "", nil, OnLeaderLibResPenTag),
	Water25 = TagBoost:Create("LeaderLib_ResistancePenetration_Water25", "", nil, OnLeaderLibResPenTag),
	Water30 = TagBoost:Create("LeaderLib_ResistancePenetration_Water30", "", nil, OnLeaderLibResPenTag),
	Water35 = TagBoost:Create("LeaderLib_ResistancePenetration_Water35", "", nil, OnLeaderLibResPenTag),
	Water40 = TagBoost:Create("LeaderLib_ResistancePenetration_Water40", "", nil, OnLeaderLibResPenTag),
	Water45 = TagBoost:Create("LeaderLib_ResistancePenetration_Water45", "", nil, OnLeaderLibResPenTag),
	Water50 = TagBoost:Create("LeaderLib_ResistancePenetration_Water50", "", nil, OnLeaderLibResPenTag),
	Air5 = TagBoost:Create("LeaderLib_ResistancePenetration_Air5", "", nil, OnLeaderLibResPenTag),
	Air10 = TagBoost:Create("LeaderLib_ResistancePenetration_Air10", "", nil, OnLeaderLibResPenTag),
	Air15 = TagBoost:Create("LeaderLib_ResistancePenetration_Air15", "", nil, OnLeaderLibResPenTag),
	Air20 = TagBoost:Create("LeaderLib_ResistancePenetration_Air20", "", nil, OnLeaderLibResPenTag),
	Air25 = TagBoost:Create("LeaderLib_ResistancePenetration_Air25", "", nil, OnLeaderLibResPenTag),
	Air30 = TagBoost:Create("LeaderLib_ResistancePenetration_Air30", "", nil, OnLeaderLibResPenTag),
	Air35 = TagBoost:Create("LeaderLib_ResistancePenetration_Air35", "", nil, OnLeaderLibResPenTag),
	Air40 = TagBoost:Create("LeaderLib_ResistancePenetration_Air40", "", nil, OnLeaderLibResPenTag),
	Air45 = TagBoost:Create("LeaderLib_ResistancePenetration_Air45", "", nil, OnLeaderLibResPenTag),
	Air50 = TagBoost:Create("LeaderLib_ResistancePenetration_Air50", "", nil, OnLeaderLibResPenTag),
	Piercing5 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing5", "", nil, OnLeaderLibResPenTag),
	Piercing10 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing10", "", nil, OnLeaderLibResPenTag),
	Piercing15 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing15", "", nil, OnLeaderLibResPenTag),
	Piercing20 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing20", "", nil, OnLeaderLibResPenTag),
	Piercing25 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing25", "", nil, OnLeaderLibResPenTag),
	Piercing30 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing30", "", nil, OnLeaderLibResPenTag),
	Piercing35 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing35", "", nil, OnLeaderLibResPenTag),
	Piercing40 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing40", "", nil, OnLeaderLibResPenTag),
	Piercing45 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing45", "", nil, OnLeaderLibResPenTag),
	Piercing50 = TagBoost:Create("LeaderLib_ResistancePenetration_Piercing50", "", nil, OnLeaderLibResPenTag),
	Fire5 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire5", "", nil, OnLeaderLibResPenTag),
	Fire10 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire10", "", nil, OnLeaderLibResPenTag),
	Fire15 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire15", "", nil, OnLeaderLibResPenTag),
	Fire20 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire20", "", nil, OnLeaderLibResPenTag),
	Fire25 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire25", "", nil, OnLeaderLibResPenTag),
	Fire30 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire30", "", nil, OnLeaderLibResPenTag),
	Fire35 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire35", "", nil, OnLeaderLibResPenTag),
	Fire40 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire40", "", nil, OnLeaderLibResPenTag),
	Fire45 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire45", "", nil, OnLeaderLibResPenTag),
	Fire50 = TagBoost:Create("LeaderLib_ResistancePenetration_Fire50", "", nil, OnLeaderLibResPenTag),
	Poison5 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison5", "", nil, OnLeaderLibResPenTag),
	Poison10 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison10", "", nil, OnLeaderLibResPenTag),
	Poison15 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison15", "", nil, OnLeaderLibResPenTag),
	Poison20 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison20", "", nil, OnLeaderLibResPenTag),
	Poison25 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison25", "", nil, OnLeaderLibResPenTag),
	Poison30 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison30", "", nil, OnLeaderLibResPenTag),
	Poison35 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison35", "", nil, OnLeaderLibResPenTag),
	Poison40 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison40", "", nil, OnLeaderLibResPenTag),
	Poison45 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison45", "", nil, OnLeaderLibResPenTag),
	Poison50 = TagBoost:Create("LeaderLib_ResistancePenetration_Poison50", "", nil, OnLeaderLibResPenTag),
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

---@type ItemBoostGroup
Boosts.Resistances = {}
Boosts.ObjectCategory = {}

local function Init()
	local penSmallChance = 		GameHelpers.GetExtraData("LLENEMY_Treasure_BoostChance_SmallResistancePenetration", 30)
	local penMediumChance = 	GameHelpers.GetExtraData("LLENEMY_Treasure_BoostChance_MediumResistancePenetration", 10)
	local penLargeChance = 		GameHelpers.GetExtraData("LLENEMY_Treasure_BoostChance_LargeResistancePenetration", 4)
	local penExtraLargeChance = GameHelpers.GetExtraData("LLENEMY_Treasure_BoostChance_HugeResistancePenetration", 4)
	bonusSkillChance = 	GameHelpers.GetExtraData("LLENEMY_Treasure_BoostChance_ResistancePenetrationBonusSkill", 20)

	Boosts.Weapon = {
		ItemBoostGroup:Create("WeaponMain", {
			ItemBoost:Create({
				StatBoost:Create("DamageFromBase",1,5),
			},{Chance=50}),
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,5),
			},{Chance=25, BlockWeaponTypes={Knife = true}}),
			ItemBoost:Create({
				StatBoost:Create("CriticalDamage",1,10),
			},{Chance=15, WeaponType="Knife"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,5),
				StatBoost:Create("DodgeBoost",1,5),
			},{Chance=50, All=false}),
			ItemBoost:Create({
				StatBoost:Create("DamageBoost",1,5),
			},{Chance=25, MinLevel=1,MaxLevel=8}),
			ItemBoost:Create({
				StatBoost:Create("DamageBoost",1,10),
			},{Chance=25, MinLevel=9,MaxLevel=-1}),
			ItemBoost:Create({
				StatBoost:Create("CriticalDamage",1,10),
			},{Chance=25, MinLevel=1,MaxLevel=8, Limit=5}),
			ItemBoost:Create({
				StatBoost:Create("CriticalDamage",1,20),
			},{Chance=25, MinLevel=9,MaxLevel=-1, Limit=5}),
			ItemBoost:Create({
				StatBoost:Create("MinDamage",1,5),
				StatBoost:Create("MaxDamage",1,5),
			},{Chance=10, Limit=5, All=true}),
			ItemBoost:Create({
				StatBoost:Create("WeaponRange",0.10,1.0),
			},{Chance=10, Limit=1}),
		})
	}
	Boosts.Shield = {
		ItemBoostGroup:Create("ShieldMain", {
			ItemBoost:Create({
				StatBoost:Create("Blocking",1,5),
				StatBoost:Create("ArmorBoost",1,5),
			},{Chance=50}),
			ItemBoost:Create({
				StatBoost:Create("MagicArmorBoost",1,5),
				StatBoost:Create("PiercingResistance",1,5),
			},{Chance=10}),
			ItemBoost:Create({
				StatBoost:Create("MagicArmorValue",1,10),
				StatBoost:Create("ArmorValue",1,10),
			},{Chance=25}),
		})
	}
	
	---@type ItemBoostGroup[]
	Boosts.Armor = {
		ItemBoostGroup:Create("ArmorMain", {
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,3),
			},{Chance=10, MinLevel=1,MaxLevel=8,SlotType="Gloves"}),
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,5),
			},{Chance=10, MinLevel=9,MaxLevel=13,SlotType="Gloves"}),
			ItemBoost:Create({
				StatBoost:Create("CriticalChance",1,7),
			},{Chance=10, MinLevel=14,MaxLevel=-1,SlotType="Gloves"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,3),
			},{Chance=25, MinLevel=1,MaxLevel=8,SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,5),
			},{Chance=25, MinLevel=9,MaxLevel=13,SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("LifeSteal",1,7),
			},{Chance=25, MinLevel=14,MaxLevel=-1,SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("VitalityBoost",1,3),
			},{Chance=25, MinLevel=1,MaxLevel=8,SlotType="Breast"}),
			ItemBoost:Create({
				StatBoost:Create("VitalityBoost",1,5),
			},{Chance=25, MinLevel=9,MaxLevel=13,SlotType="Breast"}),
			ItemBoost:Create({
				StatBoost:Create("VitalityBoost",1,7),
			},{Chance=25, MinLevel=14,MaxLevel=-1,SlotType="Breast"}),
			ItemBoost:Create({
				StatBoost:Create("MemoryBoost",1,1),
			},{Chance=10, SlotType="Helmet", Limit=3}),
			ItemBoost:Create({
				StatBoost:Create("StartAP",1,1),
			},{Chance=2, SlotType="Ring", Limit=1}),
			ItemBoost:Create({
				StatBoost:Create("MaxAP",1,1),
			},{Chance=1, SlotType="Ring", Limit=1}),
			ItemBoost:Create({
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_CursedFire,
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_ShockingRain,
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_SlipperyRogue,
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_DefensiveStart,
			},{Chance=6, SlotType="Ring", Limit=1, All=false}),
			-- ItemBoost:Create({
			-- 	StatBoost:Create("SourcePointsBoost",1,1),
			-- },{Chance=1, SlotType="Ring"}),
			ItemBoost:Create({
				StatBoost:Create("MovementSpeedBoost",1,5),
			},{Chance=5, SlotType="Boots"}),
			ItemBoost:Create({
				StatBoost:Create("MaxSummons",1,1),
			},{Chance=1, SlotType="Helmet", Limit=1}),
			ItemBoost:Create({
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_Madness,
			},{Chance=4, SlotType="Helmet", Limit=1}),
			ItemBoost:Create({
				StatBoost:Create("RuneSlots",1,1),
			},{Chance=1, Limit=1})
			}),
	}

	local resistanceGroups = ItemBoostGroup:Create("Resistances");
	for i,v in pairs(armorResistances) do
		local a = ItemBoost:Create({
			StatBoost:Create(v,1,2),
		},{Chance=10, MinLevel=1,MaxLevel=8})
		local b = ItemBoost:Create({
			StatBoost:Create(v,2,4),
		},{Chance=10, MinLevel=9,MaxLevel=13})
		local c = ItemBoost:Create({
			StatBoost:Create(v,4,8),
		},{Chance=10, MinLevel=14,MaxLevel=-1})
		resistanceGroups.Entries[#resistanceGroups.Entries+1] = a
		resistanceGroups.Entries[#resistanceGroups.Entries+1] = b
		resistanceGroups.Entries[#resistanceGroups.Entries+1] = c
	end

	Boosts.Resistances = resistanceGroups
	
	local elementalResPen = {
		Type = "RandomGroupContainer",
		Entries = {
			ItemBoostGroup:Create("AirResPen", {
				ItemBoost:Create({
					LeaderLibResPenTags.Air5,
				},{Chance=penSmallChance}),
				ItemBoost:Create({
					LeaderLibResPenTags.Air15,
				},{Chance=penMediumChance, Limit=2}),
				ItemBoost:Create({
					LeaderLibResPenTags.Air25,
				},{Chance=penLargeChance, Limit=1}),
				ItemBoost:Create({
					LeaderLibResPenTags.Air50,
				},{Chance=penExtraLargeChance, Limit=1}),
			}),
			ItemBoostGroup:Create("EarthResPen", {
				ItemBoost:Create({
					LeaderLibResPenTags.Earth5,
				},{Chance=penSmallChance}),
				ItemBoost:Create({
					LeaderLibResPenTags.Earth15,
				},{Chance=penMediumChance, Limit=2}),
				ItemBoost:Create({
					LeaderLibResPenTags.Earth25,
				},{Chance=penLargeChance, Limit=1}),
				ItemBoost:Create({
					LeaderLibResPenTags.Earth50,
				},{Chance=penExtraLargeChance, Limit=1}),
			}),
			ItemBoostGroup:Create("PoisonResPen", {
				ItemBoost:Create({
					LeaderLibResPenTags.Poison5,
				},{Chance=penSmallChance}),
				ItemBoost:Create({
					LeaderLibResPenTags.Poison15,
				},{Chance=penMediumChance, Limit=2}),
				ItemBoost:Create({
					LeaderLibResPenTags.Poison25,
				},{Chance=penLargeChance, Limit=1}),
				ItemBoost:Create({
					LeaderLibResPenTags.Poison50,
				},{Chance=penExtraLargeChance, Limit=1}),
			}),
			ItemBoostGroup:Create("FireResPen", {
				ItemBoost:Create({
					LeaderLibResPenTags.Fire5,
				},{Chance=penSmallChance}),
				ItemBoost:Create({
					LeaderLibResPenTags.Fire15,
				},{Chance=penMediumChance, Limit=2}),
				ItemBoost:Create({
					LeaderLibResPenTags.Fire25,
				},{Chance=penLargeChance, Limit=1}),
				ItemBoost:Create({
					LeaderLibResPenTags.Fire50,
				},{Chance=penExtraLargeChance, Limit=1}),
			}),
			ItemBoostGroup:Create("WaterResPen", {
				ItemBoost:Create({
					LeaderLibResPenTags.Water5,
				},{Chance=penSmallChance}),
				ItemBoost:Create({
					LeaderLibResPenTags.Water15,
				},{Chance=penMediumChance, Limit=2}),
				ItemBoost:Create({
					LeaderLibResPenTags.Water25,
				},{Chance=penLargeChance, Limit=1}),
				ItemBoost:Create({
					LeaderLibResPenTags.Water50,
				},{Chance=penExtraLargeChance, Limit=1}),
			})
		}
	}
	
	Boosts.ObjectCategory.HeavyUpperBody = {
		ItemBoostGroup:Create("HeavyChestArmorBoosts", {
			ItemBoost:Create({
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_StunDefense,
			},{Limit=1, All=false}),
		}, {Chance=4})
	}
	Boosts.ObjectCategory.LightUpperBody = {
		ItemBoostGroup:Create("LightChestArmorBoosts", {
			ItemBoost:Create({
				ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_DotCleanser,
			},{Limit=1, All=false}),
		}, {Chance=4})
	}
	Boosts.ObjectCategory.MageGloves = {
		elementalResPen,
		ItemBoostGroup:Create("MageGlovesBoosts", {
			ItemBoost:Create({
				StatBoost:Create("IntelligenceBoost",1,1),
			},{Limit=1, All=false}),
		}, {Chance=10})
	}
	Boosts.ObjectCategory.ClothGloves = {
		elementalResPen,
		ItemBoostGroup:Create("ClothBoosts", {
			ItemBoost:Create({
				StatBoost:Create("WitsBoost",1,1),
			},{Limit=1, All=false}),
		}, {Chance=10})
	}
	
	Boosts.ObjectCategory.HeavyGloves = {
		ItemBoostGroup:Create("PhysicalResPen", {
			ItemBoost:Create({
				LeaderLibResPenTags.Physical5,
			},{Chance=20}),
			ItemBoost:Create({
				LeaderLibResPenTags.Physical15,
			},{Chance=penMediumChance, Limit=2}),
			ItemBoost:Create({
				LeaderLibResPenTags.Physical25,
			},{Chance=penLargeChance, Limit=1}),
			ItemBoost:Create({
				LeaderLibResPenTags.Physical50,
			},{Chance=penExtraLargeChance, Limit=1}),
		})
	}
	
	Boosts.ObjectCategory.LightGloves = {
		ItemBoostGroup:Create("PiercingResPen", {
			ItemBoost:Create({
				LeaderLibResPenTags.Piercing5,
			},{Chance=penSmallChance}),
			ItemBoost:Create({
				LeaderLibResPenTags.Piercing15,
			},{Chance=penMediumChance, Limit=2}),
			ItemBoost:Create({
				LeaderLibResPenTags.Piercing25,
			},{Chance=penLargeChance, Limit=1}),
			ItemBoost:Create({
				LeaderLibResPenTags.Piercing50,
			},{Chance=penExtraLargeChance, Limit=1}),
		})
	}

	---@type table<string, ItemBoostGroup[]>
	ItemCorruption.Boosts = Boosts
end

return {
	Init = Init
}