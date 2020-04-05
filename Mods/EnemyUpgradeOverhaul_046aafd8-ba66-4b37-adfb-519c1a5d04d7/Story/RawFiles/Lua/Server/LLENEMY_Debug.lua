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
	--CharacterLevelUpTo(host, 10)
	CharacterAddAbility(host, "Loremaster", 10)
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

function LLENEMY_Ext_Debug_TraceStats(char)
	local stats = nil
	local character = Ext.GetCharacter(char)
	if character ~= nil then
		stats = character.Stats.Name
	end
	if stats == nil then stats = GetStatString(char) end
	if stats ~= nil then
		Osi.LeaderLog_Log("DEBUG", "[LLENEMY_Debug.lua:LLENEMY_Ext_Debug_TraceStats] Character's instance stat ID is (",stats,")")
	end
end

function LLENEMY_Ext_Debug_RerollLevel(char)
	local character = Ext.GetCharacter(char)
	if character ~= nil then
		SetVarFixedString(char, "LLENEMY_Debug_Stats", character.Stats.Name)
	end
	SetStoryEvent(char, "LLENEMY_Debug_SetStats")
	CharacterRemoveAttribute(char, "Dummy", 0)
	CharacterAddAttribute(char, "Dummy", 0)
	--CharacterAddExplorationExperience(char, 1, 1, 1)
	--Ext.Print("[LLENEMY_ExperienceScaling:LLENEMY_Ext_Debug_RerollLevel] Leveling up (".. char ..").")
	--CharacterLevelUp(char)
	--Ext.Print("[LLENEMY_ExperienceScaling:LLENEMY_Ext_Debug_RerollLevel] Transforming (".. char ..").")
	--CharacterTransformFromCharacter(char, char, 1, 1, 1, 1, 1, 1, 1)
	--Transform(char, "57b70554-36bf-4b86-b9aa-8f7cc3944153", 1, 1, 1)
	--Ext.Print("[LLENEMY_ExperienceScaling:LLENEMY_Ext_Debug_RerollLevel] Leveling up (".. char ..").")
	--CharacterLevelUpTo(char, 3)
	--CharacterLevelUp(char)
end

local debugCheckEnemies = {
	"S_FTJ_SeekerCaptain_1329f018-23e4-4717-9bc8-074b28d04c54"
}

function LLENEMY_Ext_CheckFactions()
	for i,uuid in pairs(debugCheckEnemies) do
		if ObjectExists(uuid) == 1 then
			local name = CharacterGetDisplayName(uuid)
			Ext.Print("[LLENEMY_Ext_CheckFactions] ["..uuid.."]("..name..") faction ("..GetFaction(uuid)..")")
		end
	end
end

local function LLENEMY_DebugInit()
	local host = CharacterGetHostCharacter()
	local level = GetRegion(host)
	if level == "FJ_FortJoy_Main" then
		debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_Torturer_Golem_01_584db8ce-8dcf-4906-bc6f-e51eb057de08"
		debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_Torturer_Golem_02_aff8be39-58b0-4bff-8fa6-7cf501b5060b"
		debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_Torturer_Golem_03_d32d32b2-c05b-4acd-944c-f2b802ec7234"
		debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_MagisterTorturer_1d1c0ba0-a91e-4927-af79-6d8d27e0646b"
		LLENEMY_Ext_CheckFactions()
	end

	local x,y,z = GetPosition(host)
	local item = CreateItemTemplateAtPosition("537a06a5-0619-4d57-b77d-b4c319eab3e6", x, y, z)
	local shadowItem = LLENEMY_Ext_ShadowCorruptItem(item)
	ItemToInventory(shadowItem, host, 1, 1, 1)
end

local function LLENEMY_SessionLoaded()
    LeaderLib_DebugInitCalls[#LeaderLib_DebugInitCalls+1] = LLENEMY_DebugInit
end

if Ext.IsDeveloperMode() and Ext.Version() >= 43 then
	Ext.RegisterListener("SessionLoaded", LLENEMY_SessionLoaded)
end

BuiltinColorCodes = {
    "#FFFFFF",
    "#454545",
    "#AE9F95",
    "#DBDBDB",
    "#CD1F1F",
    "#188EDE",
    "#078FC8",
    "#CFECFF",
    "#7DC807",
    "#00AA00",
    "#FCD203",
    "#FF9600",
    "#FFC3C3",
    "#7F00FF",
    "#B97A57",
    "#C7A758",
    "#000000",
    "#FFFFFF",
    "#D040D0",
    "#797980",
    "#65C900",
    "#F7BA14",
    "#7D71D9",
    "#4197E2",
    "#FE6E27",
    "#46B195",
    "#B823CB",
    "#F7BA14",
    "#81AB00",
    "#639594",
    "#B260FF",
    "#73F6FF",
    "#DA2512",
    "#C9AA58",
    "#97FBFF",
    "#FFB8B8",
    "#FFAB00",
    "#7F00FF",
    "#F10000",
    "#00893A",
    "#403625",
    "#00547F",
    "#FFFFFF",
    "#9A6A46",
    "#745035",
    "#AA3938",
    "#ED9D07",
    "#FCD203",
    "#88A25B",
    "#34789C",
    "#D66565",
    "#D85B00",
    "#E4CE93",
    "#CD1F1F",
    "#318666",
    "#3C6983",
    "#85662F",
    "#87365C",
    "#F1D466",
    "#008858",
    "#CD1F1F",
    "#13D177",
    "#FCD203",
    "#188EDE",
}

local groupColours = {
	"#FFFFFF",
	"#FFCC00",
	"#FF9600",
	"#FF00CC",
	"#FE6E27",
	"#F7BA14",
	"#CD1F1F",
	"#C80030",
	"#C7A758",
	"#AE9F95",
	"#A3894A",
	"#A1D7BF",
	"#97FBFF",
	"#92755F",
	"#7DC807",
	"#7D71D9",
	"#70B10E",
	"#65C900",
	"#564132",
	"#4197E2",
	"#078FC8",
	"#078FC8"
}

local groupValueColours = {
	"#FFFFFF",
	"#FFCC00",
	"#FF9600",
	"#FF00CC",
	"#FE6E27",
	"#F7BA14",
	"#CD1F1F",
	"#C80030",
	"#C7A758",
	"#AE9F95",
	"#A3894A",
	"#A1D7BF",
	"#92755F",
	"#7DC807",
	"#7D71D9",
	"#70B10E",
	"#65C900",
	"#564132",
	"#4197E2",
	"#078FC8"
}
