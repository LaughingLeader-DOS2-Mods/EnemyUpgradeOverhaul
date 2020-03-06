local character_stats = {
	"CurrentVitality",
	"CurrentArmor",
	"CurrentMagicArmor",
	"ArmorAfterHitCooldownMultiplier",
	"MagicArmorAfterHitCooldownMultiplier",
	"CurrentAP",
	"BonusActionPoints",
	"Experience",
	"Reputation",
	"Flanked",
	"Karma",
	"MaxVitality",
	"BaseMaxVitality",
	"MaxArmor",
	"BaseMaxArmor",
	"MaxMagicArmor",
	"BaseMaxMagicArmor",
	"Sight",
	"BaseSight",
	"MaxSummons",
	"BaseMaxSummons"
}

local character_stats_computed = {
	"MaxMp",
	"APStart",
	"APRecovery",
	"APMaximum",
	"Strength",
	"Finesse",
	"Intelligence",
	"Vitality",
	"Memory",
	"Wits",
	"Accuracy",
	"Dodge",
	"CriticalChance",
	"FireResistance",
	"EarthResistance",
	"WaterResistance",
	"AirResistance",
	"PoisonResistance",
	"ShadowResistance",
	"CustomResistance",
	"LifeSteal",
	"Sight",
	"Hearing",
	"Movement",
	"Initiative",
	"ChanceToHitBoost"
}

function LLENEMY_Ext_TraceCharacterStats_Restricted(char)
	Ext.Print("====== Stats: "..tostring(char).." ======")
	Ext.Print("==== COMPUTED ====")
	for _,stat in pairs(character_stats_computed) do
		Ext.Print(stat..": "..tostring(LeaderLib.Common.Dump(char[stat])))
	end
	Ext.Print("==== REGULAR ====")
	for _,stat in pairs(character_stats) do
		Ext.Print(stat..": "..tostring(LeaderLib.Common.Dump(char[stat])))
	end
end

function LLENEMY_Ext_TraceCharacterStats(char)
	Ext.Print("====== Stats: "..tostring(char).." ======")
	Ext.Print("==== COMPUTED ====")
	for _,stat in pairs(character_stats_computed) do
		local base = NRD_CharacterGetComputedStat(char, stat, 1)
		local current = NRD_CharacterGetComputedStat(char, stat, 0)
		Ext.Print(stat..": "..tostring(current).."("..tostring(base)..")")
	end
	Ext.Print("==== REGULAR ====")
	for _,stat in pairs(character_stats) do
		local val = NRD_CharacterGetStatInt(char, stat)
		Ext.Print(stat..": "..tostring(val))
	end
end

function LLENEMY_Ext_InitDebugLevel()
	local char = "Lizards_Hero_Male_Undead_000_09478f32-8fbf-4502-a59d-011e4d1b3d4d"
	ApplyStatus(char, "LLENEMY_RAGE", -1.0, 1, char)

	local host = CharacterGetHostCharacter()
	CharacterApplyPreset(host, "Rogue_Act2")
	CharacterLevelUpTo(host, 10)
	CharacterAddAttribute(host, "Memory", 20)
	--CharacterTransformAppearanceToWithEquipmentSet(host, host, "ArenaRogue", 0)
	for k,skill in pairs(Ext.GetSkillSet("ArenaRogue")) do
		CharacterAddSkill(host, skill, 0)
	end
	
	CharacterRemoveSkill(host, "Projectile_Chloroform")
	CharacterAddSkill(host, "Projectile_Chloroform", 0)
	NRD_SkillBarSetSkill(host, 0, "Projectile_Chloroform")

	local slots = Osi.DB_LeaderLib_EquipmentSlots:Get(nil)
	for k,v in pairs(slots) do
		local slot = v[1]
		local item = CharacterGetEquippedItem(host, slot)
		if item ~= nil then
			ItemLevelUpTo(host, 10)
		end
	end

	--ApplyStatus(host, "LLENEMY_TALENT_BULLY", -1.0, 1, host)
	CharacterSetImmortal(host, 1)
end

local indexMap_DB_LLENEMY_Upgrades_TypeRollValues = {
	"Group",
	"Type",
	"Start",
	"MaxEnd"
}

local indexMap_DB_LLENEMY_Upgrades_Statuses = {
	"Group", 
	"Type", 
	"Status", 
	"MinRoll",
	"MaxRoll",
	"Duration",
	"CP"
}

function LLENEMY_Ext_DumpUpgradeTables()
--SysLog("DB_LLENEMY_Upgrades_TypeRollValues", 4);
--SysLog("DB_LLENEMY_Upgrades_Statuses", 7);
	local typeRolls = Osi.DB_LLENEMY_Upgrades_TypeRollValues:Get(nil,nil,nil,nil)
	Ext.Print("DB_LLENEMY_Upgrades_TypeRollValues:\n" .. LeaderLib.Common.Dump(typeRolls, indexMap_DB_LLENEMY_Upgrades_TypeRollValues, true))

	local upgrades = Osi.DB_LLENEMY_Upgrades_Statuses:Get(nil,nil,nil,nil,nil,nil,nil)
	--DB_LLENEMY_Upgrades_Statuses(_Group, _Type, _Status, _MinRoll, _MaxRoll, _Duration, _ChallengePoints);
	Ext.Print("DB_LLENEMY_Upgrades_Statuses:\n" .. LeaderLib.Common.Dump(upgrades, indexMap_DB_LLENEMY_Upgrades_Statuses, true))
end