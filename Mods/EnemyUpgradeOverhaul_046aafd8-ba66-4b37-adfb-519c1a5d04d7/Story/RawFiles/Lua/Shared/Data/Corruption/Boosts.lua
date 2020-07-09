local OnLeaderLibResPenTag = function(item)
	SetTag(item, "LeaderLib_HasResistancePenetration")
end

local LeaderLibResPenTags = {
	Physical5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical5", "", false, OnLeaderLibResPenTag),
	Physical10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical10", "", false, OnLeaderLibResPenTag),
	Physical15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical15", "", false, OnLeaderLibResPenTag),
	Physical20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical20", "", false, OnLeaderLibResPenTag),
	Physical25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical25", "", false, OnLeaderLibResPenTag),
	Physical30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical30", "", false, OnLeaderLibResPenTag),
	Physical35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical35", "", false, OnLeaderLibResPenTag),
	Physical40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical40", "", false, OnLeaderLibResPenTag),
	Physical45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical45", "", false, OnLeaderLibResPenTag),
	Physical50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Physical50", "", false, OnLeaderLibResPenTag),
	Earth5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth5", "", false, OnLeaderLibResPenTag),
	Earth10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth10", "", false, OnLeaderLibResPenTag),
	Earth15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth15", "", false, OnLeaderLibResPenTag),
	Earth20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth20", "", false, OnLeaderLibResPenTag),
	Earth25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth25", "", false, OnLeaderLibResPenTag),
	Earth30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth30", "", false, OnLeaderLibResPenTag),
	Earth35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth35", "", false, OnLeaderLibResPenTag),
	Earth40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth40", "", false, OnLeaderLibResPenTag),
	Earth45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth45", "", false, OnLeaderLibResPenTag),
	Earth50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Earth50", "", false, OnLeaderLibResPenTag),
	Water5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water5", "", false, OnLeaderLibResPenTag),
	Water10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water10", "", false, OnLeaderLibResPenTag),
	Water15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water15", "", false, OnLeaderLibResPenTag),
	Water20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water20", "", false, OnLeaderLibResPenTag),
	Water25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water25", "", false, OnLeaderLibResPenTag),
	Water30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water30", "", false, OnLeaderLibResPenTag),
	Water35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water35", "", false, OnLeaderLibResPenTag),
	Water40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water40", "", false, OnLeaderLibResPenTag),
	Water45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water45", "", false, OnLeaderLibResPenTag),
	Water50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Water50", "", false, OnLeaderLibResPenTag),
	Air5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air5", "", false, OnLeaderLibResPenTag),
	Air10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air10", "", false, OnLeaderLibResPenTag),
	Air15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air15", "", false, OnLeaderLibResPenTag),
	Air20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air20", "", false, OnLeaderLibResPenTag),
	Air25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air25", "", false, OnLeaderLibResPenTag),
	Air30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air30", "", false, OnLeaderLibResPenTag),
	Air35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air35", "", false, OnLeaderLibResPenTag),
	Air40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air40", "", false, OnLeaderLibResPenTag),
	Air45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air45", "", false, OnLeaderLibResPenTag),
	Air50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Air50", "", false, OnLeaderLibResPenTag),
	Piercing5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing5", "", false, OnLeaderLibResPenTag),
	Piercing10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing10", "", false, OnLeaderLibResPenTag),
	Piercing15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing15", "", false, OnLeaderLibResPenTag),
	Piercing20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing20", "", false, OnLeaderLibResPenTag),
	Piercing25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing25", "", false, OnLeaderLibResPenTag),
	Piercing30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing30", "", false, OnLeaderLibResPenTag),
	Piercing35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing35", "", false, OnLeaderLibResPenTag),
	Piercing40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing40", "", false, OnLeaderLibResPenTag),
	Piercing45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing45", "", false, OnLeaderLibResPenTag),
	Piercing50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Piercing50", "", false, OnLeaderLibResPenTag),
	Fire5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire5", "", false, OnLeaderLibResPenTag),
	Fire10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire10", "", false, OnLeaderLibResPenTag),
	Fire15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire15", "", false, OnLeaderLibResPenTag),
	Fire20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire20", "", false, OnLeaderLibResPenTag),
	Fire25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire25", "", false, OnLeaderLibResPenTag),
	Fire30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire30", "", false, OnLeaderLibResPenTag),
	Fire35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire35", "", false, OnLeaderLibResPenTag),
	Fire40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire40", "", false, OnLeaderLibResPenTag),
	Fire45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire45", "", false, OnLeaderLibResPenTag),
	Fire50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Fire50", "", false, OnLeaderLibResPenTag),
	Poison5 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison5", "", false, OnLeaderLibResPenTag),
	Poison10 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison10", "", false, OnLeaderLibResPenTag),
	Poison15 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison15", "", false, OnLeaderLibResPenTag),
	Poison20 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison20", "", false, OnLeaderLibResPenTag),
	Poison25 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison25", "", false, OnLeaderLibResPenTag),
	Poison30 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison30", "", false, OnLeaderLibResPenTag),
	Poison35 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison35", "", false, OnLeaderLibResPenTag),
	Poison40 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison40", "", false, OnLeaderLibResPenTag),
	Poison45 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison45", "", false, OnLeaderLibResPenTag),
	Poison50 = Classes.TagBoost:Create("LeaderLib_ResistancePenetration_Poison50", "", false, OnLeaderLibResPenTag),
}

local Boosts = {}

Boosts.Weapon = {
	Classes.ItemBoostGroup:Create("WeaponMain", {
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("DamageFromBase",1,5),
		},{Chance=50}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalChance",1,5),
		},{Chance=25, BlockWeaponTypes={Knife = true}}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalDamage",1,10),
		},{Chance=15, WeaponType="Knife"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("LifeSteal",1,5),
			Classes.StatBoost:Create("DodgeBoost",1,5),
		},{Chance=50}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("DamageBoost",1,5),
		},{Chance=25, MinLevel=1,MaxLevel=8}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("DamageBoost",1,10),
		},{Chance=25, MinLevel=9,MaxLevel=-1}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalDamage",1,10),
		},{Chance=25, MinLevel=1,MaxLevel=8, Limit=5}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalDamage",1,20),
		},{Chance=25, MinLevel=9,MaxLevel=-1, Limit=5}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MinDamage",1,5),
			Classes.StatBoost:Create("MaxDamage",1,5),
		},{Chance=10, Limit=5, All=true}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("WeaponRange",0.10,1.0),
		},{Chance=10, Limit=1}),
	})
}
Boosts.Shield = {
	Classes.ItemBoostGroup:Create("ShieldMain", {
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("Blocking",1,5),
			Classes.StatBoost:Create("ArmorBoost",1,5),
		},{Chance=50}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MagicArmorBoost",1,5),
			Classes.StatBoost:Create("PiercingResistance",1,5),
		},{Chance=10}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MagicArmorValue",1,10),
			Classes.StatBoost:Create("ArmorValue",1,10),
		},{Chance=25}),
	})
}

---@type ItemBoostGroup[]
Boosts.Armor = {
	Classes.ItemBoostGroup:Create("ArmorMain", {
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalChance",1,3),
		},{Chance=10, MinLevel=1,MaxLevel=8,SlotType="Gloves"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalChance",1,5),
		},{Chance=10, MinLevel=9,MaxLevel=13,SlotType="Gloves"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalChance",1,7),
		},{Chance=10, MinLevel=14,MaxLevel=-1,SlotType="Gloves"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("LifeSteal",1,3),
		},{Chance=25, MinLevel=1,MaxLevel=8,SlotType="Ring"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("LifeSteal",1,5),
		},{Chance=25, MinLevel=9,MaxLevel=13,SlotType="Ring"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("LifeSteal",1,7),
		},{Chance=25, MinLevel=14,MaxLevel=-1,SlotType="Ring"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("VitalityBoost",1,3),
		},{Chance=25, MinLevel=1,MaxLevel=8,SlotType="Breast"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("VitalityBoost",1,5),
		},{Chance=25, MinLevel=9,MaxLevel=13,SlotType="Breast"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("VitalityBoost",1,7),
		},{Chance=25, MinLevel=14,MaxLevel=-1,SlotType="Breast"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MemoryBoost",1,1),
		},{Chance=10, SlotType="Helmet", Limit=3}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("StartAP",1,1),
		},{Chance=2, SlotType="Ring", Limit=1}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MaxAP",1,1),
		},{Chance=1, SlotType="Ring", Limit=1}),
		-- Classes.ItemBoost:Create({
		-- 	Classes.StatBoost:Create("SourcePointsBoost",1,1),
		-- },{Chance=1, SlotType="Ring"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MovementSpeedBoost",1,5),
		},{Chance=5, SlotType="Boots"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MaxSummons",1,1),
		},{Chance=1, SlotType="Helmet", Limit=1}),
		Classes.ItemBoost:Create({
			ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_Madness,
		},{Chance=80, SlotType="Helmet", Limit=1}),
		-- Classes.ItemBoost:Create({
		-- 	Classes.StatBoost:Create("ChanceToHitBoost",1,3),
		-- },{Chance=3, SlotType="Helmet"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("RuneSlots",1,1),
		},{Chance=1, Limit=1})
		}),
	Classes.ItemBoostGroup:Create("ArmorResistancePenetration", {
		-- Resistane Penetration
		Classes.ItemBoost:Create({
			LeaderLibResPenTags.Air5,
			LeaderLibResPenTags.Earth5,
			LeaderLibResPenTags.Fire5,
			LeaderLibResPenTags.Poison5,
			LeaderLibResPenTags.Water5,
		},{Chance=40, SlotType="Gloves", ObjectCategories={"MageGloves","ClothGloves"}, Limit=1, All=false}),
		Classes.ItemBoost:Create({
			LeaderLibResPenTags.Air15,
			LeaderLibResPenTags.Earth15,
			LeaderLibResPenTags.Fire15,
			LeaderLibResPenTags.Poison15,
			LeaderLibResPenTags.Water15,
		},{Chance=20, SlotType="Gloves", ObjectCategories={"MageGloves","ClothGloves"}, Limit=1, All=false}),
		Classes.ItemBoost:Create({
			LeaderLibResPenTags.Air25,
			LeaderLibResPenTags.Earth25,
			LeaderLibResPenTags.Fire25,
			LeaderLibResPenTags.Poison25,
			LeaderLibResPenTags.Water25,
		},{Chance=5, SlotType="Gloves", ObjectCategories={"MageGloves","ClothGloves"}, Limit=1, All=false}),
		Classes.ItemBoost:Create({
			LeaderLibResPenTags.Air50,
			LeaderLibResPenTags.Earth50,
			LeaderLibResPenTags.Fire50,
			LeaderLibResPenTags.Poison50,
			LeaderLibResPenTags.Water50,
		},{Chance=1, SlotType="Gloves", ObjectCategories={"MageGloves","ClothGloves"}, Limit=1, All=false}),
	}, {Limit=1})
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

local resistanceGroups = Classes.ItemBoostGroup:Create("Resistances");
for i,v in pairs(armorResistances) do
	local a = Classes.ItemBoost:Create({
		Classes.StatBoost:Create(v,1,2),
	},{Chance=10, MinLevel=1,MaxLevel=8})
	local b = Classes.ItemBoost:Create({
		Classes.StatBoost:Create(v,2,4),
	},{Chance=10, MinLevel=9,MaxLevel=13})
	local c = Classes.ItemBoost:Create({
		Classes.StatBoost:Create(v,4,8),
	},{Chance=10, MinLevel=14,MaxLevel=-1})
	resistanceGroups.Entries[#resistanceGroups.Entries+1] = a
	resistanceGroups.Entries[#resistanceGroups.Entries+1] = b
	resistanceGroups.Entries[#resistanceGroups.Entries+1] = c
end

---@type Classes.ItemBoostGroup
Boosts.Resistances = resistanceGroups

return Boosts