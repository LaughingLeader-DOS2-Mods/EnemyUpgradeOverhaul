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
		},{Chance=25, MinLevel=1,MaxLevel=8}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("CriticalDamage",1,20),
		},{Chance=25, MinLevel=9,MaxLevel=-1}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("MinDamage",1,5),
			Classes.StatBoost:Create("MaxDamage",1,5),
		},{Chance=10}),
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
		-- Classes.ItemBoost:Create({
		-- 	Classes.StatBoost:Create("ChanceToHitBoost",1,3),
		-- },{Chance=3, SlotType="Helmet"}),
		Classes.ItemBoost:Create({
			Classes.StatBoost:Create("RuneSlots",1,1),
		},{Chance=1, Limit=1}),
	})
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