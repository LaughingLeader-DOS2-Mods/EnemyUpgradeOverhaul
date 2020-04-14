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
	CharacterAddSkill(host, "Projectile_LLENEMY_Helaene_Mirage_ChaoticBarrage", 0)
	CharacterAddSkill(host, "Target_EnemyFlurry", 0)
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

function LLENEMY_Ext_Debug_TraceItemOwnership(item)
	local inventoryOwner = GetInventoryOwner(item)
	local inventoryOwnerOwner = GetInventoryOwner(inventoryOwner)
	local goblinOwner = ItemGetOwner(item)
	Ext.Print("[LLENEMY_Ext_Debug_TraceItemOwnership] item("..tostring(item)..") inventoryOwner("..tostring(inventoryOwner)..") inventoryOwnerOwner("..tostring(inventoryOwnerOwner)..") goblinOwner("..tostring(goblinOwner)..")")
end

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
	Ext.Print("[LLENEMY:Debug.lua:LLENEMY_DebugInit] Running debug tests.")
	local host = CharacterGetHostCharacter()
	CharacterAddSkill(host, "Projectile_LLENEMY_Helaene_Mirage_ChaoticBarrage", 0)
	NRD_SkillBarSetSkill(host, 6, "Projectile_LLENEMY_Helaene_Mirage_ChaoticBarrage")
	if CharacterGetEquippedWeapon(host) == nil then
		local inventory = Ext.GetCharacter(host):GetInventoryItems()
		for k,v in pairs(inventory) do
			local item = Ext.GetItem(v)
			if NRD_ItemGetString(v, "WeaponType") ~= nil then
				CharacterEquipItem(host, v)
				break
			end
		end
	end
	ObjectSetFlag(host, "FTJ_RemoveSourceCollar", 0)
	CharacterOverrideMaxSourcePoints(host, 30)
	CharacterAddSourcePoints(host, 30)
	CharacterAddSkill(host, "Projectile_EnemyChainLightning", 0)
	CharacterAddSkill(host, "Shout_EnemyElectricFence", 0)
	CharacterAddSkill(host, "Shout_EnemyNecromancerTotems", 0)
	CharacterAddSkill(host, "Storm_EnemyLightning", 0)
	ApplyStatus(host, "LLENEMY_VENOM_AURA", -1.0, 1, host)
	ApplyStatus(host, "LLENEMY_FIRE_BRAND_AURA", -1.0, 1, host)
	local x,y,z = GetPosition(host)
	--NRD_Summon(host, "e63a712f-fc87-4469-8848-fd8941043afd", x, y, z, -1, 1, 1, 1)
	--NRD_Summon(host, "26f10a2d-910c-42ed-b629-9a3ce550c1f7", x, y, z, -1, 1, 1, 1)
	CharacterSetImmortal(host, 1)
	LLENEMY_Ext_SpawnVoidwoken(host, true)
	--Osi.Proc_StartDialog(1, "CMB_AD_Comment_EvilLaugh", host)
	-- local level = GetRegion(host)
	-- if level == "TUT_Tutorial_A" then
	-- 	debugCheckEnemies[#debugCheckEnemies+1] = "S_TUT_TopDeckMagister1_de400bda-b14e-4cff-b5f5-737781437902"
	-- 	debugCheckEnemies[#debugCheckEnemies+1] = "S_TUT_TopDeckMagister2_e2d47d73-4f9d-4de2-8a3c-c774a0ea114a"
	-- elseif level == "FJ_FortJoy_Main" then
	-- 	debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_Torturer_Golem_01_584db8ce-8dcf-4906-bc6f-e51eb057de08"
	-- 	debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_Torturer_Golem_02_aff8be39-58b0-4bff-8fa6-7cf501b5060b"
	-- 	debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_Torturer_Golem_03_d32d32b2-c05b-4acd-944c-f2b802ec7234"
	-- 	debugCheckEnemies[#debugCheckEnemies+1] = "S_FTJ_MagisterTorturer_1d1c0ba0-a91e-4927-af79-6d8d27e0646b"
	-- end
	-- LLENEMY_Ext_CheckFactions()

	if Ext.IsDeveloperMode() then
		GlobalSetFlag("LLENEMY_Ext_IsDeveloperMode")
		--local x,y,z = GetPosition(host)
		--local item = CreateItemTemplateAtPosition("537a06a5-0619-4d57-b77d-b4c319eab3e6", x, y, z)
		--local shadowItem = LLENEMY_Ext_ShadowCorruptItem(item)
		--ItemToInventory(shadowItem, host, 1, 1, 1)
	else
		GlobalClearFlag("LLENEMY_Ext_IsDeveloperMode")
	end
end

function LLENEMY_Debug_SpawnTreasureGoblinTest()
	local combat = Osi.DB_CombatCharacters:Get(nil,nil)
	Ext.Print("[LLENEMY:Debug.lua] DB_CombatCharacters:\n[".. LeaderLib.Common.Dump(combat))
	local host = CharacterGetHostCharacter()
	local x,y,z = GetPosition(host)
	if combat ~= nil and #combat > 0 then
		local combatid = combat[1][2]
		if combatid ~= nil then
			--Osi.LLENEMY_TreasureGoblins_Spawn(combatid)
			--local x,y,z = GetPosition(combat[1][1])
			--Osi.LLENEMY_TreasureGoblins_Internal_Spawn(x, y, z, combatid)
			LLENEMY_Ext_SpawnTreasureGoblin(x,y,z,CharacterGetLevel(host),combatid)
			LeaderLib.Print("Spawning treasure goblin at ", x, y, z)
		end
	else
		LLENEMY_Ext_SpawnTreasureGoblin(x,y,z,CharacterGetLevel(host),0)
		LeaderLib.Print("Spawning treasure goblin at ", x, y, z)
	end
end

local function LLENEMY_SessionLoading()
	Ext.Print("[LLENEMY:Debug.lua] Registered debug init call to LeaderLib.")
	LeaderLib_Ext_AddDebugInitCall(LLENEMY_DebugInit)
end

local function LLENEMY_Debug_SessionLoaded()
	LeaderLib.Print("[LLENEMY:Debug.lua] VENOM_AURA | StackId("..Ext.StatGetAttribute("VENOM_AURA", "StackId")..")")
	LeaderLib.Print("[LLENEMY:Debug.lua] VENOM_COATING | StackId("..Ext.StatGetAttribute("VENOM_COATING", "StackId")..")")
	LeaderLib.Print("[LLENEMY:Debug.lua] FIRE_BRAND_AURA | StackId("..Ext.StatGetAttribute("FIRE_BRAND_AURA", "StackId")..")")
	LeaderLib.Print("[LLENEMY:Debug.lua] FIRE_BRAND | StackId("..Ext.StatGetAttribute("FIRE_BRAND", "StackId")..")")
end

if Ext.IsDeveloperMode() then
	Ext.RegisterListener("SessionLoading", LLENEMY_SessionLoading)
	Ext.RegisterListener("SessionLoaded", LLENEMY_Debug_SessionLoaded)
end

function LLENEMY_Ext_Debug_PrintFlags(obj)
	local stat = nil
	if ObjectIsItem(obj) == 1 then
		stat = NRD_ItemGetStatsId(obj)
	elseif ObjectIsCharacter(obj) then
		stat = NRD_CharacterGetStatString(obj)
	end
	Ext.Print("[LLENEMY_Ext_Debug_PrintFlags] Object ("..tostring(stat)..")["..tostring(obj).."] Flags:")
	Ext.Print("==========================")
	for i=0,72,1 do
		local flagVal = NRD_ObjectGetInternalFlag(obj,i)
		Ext.Print("["..tostring(i).."] = "..tostring(flagVal))
	end
	Ext.Print("==========================")
end


local ItemProperties = {
	"MyGuid",
	"WorldPos",
	"CurrentLevel",
	"Scale",
	"CurrentTemplate",
	"CustomDisplayName",
	"CustomDescription",
	"CustomBookContent",
	"StatsId",
	"InventoryHandle",
	"ParentInventoryHandle",
	"Slot",
	"Amount",
	"Vitality",
	"Armor",
	"InUseByCharacterHandle",
	"Key",
	"LockLevel",
	"ComputedVitality",
	"ItemType",
	"GoldValueOverwrite",
	"WeightValueOverwrite",
	"TreasureLevel",
	"LevelOverride",
	"ForceSynch",
}

function LLENEMY_Ext_Debug_PrintItemProperties(obj)
	local item = Ext.GetItem(obj)
	local stat = NRD_ItemGetStatsId(obj)
	Ext.Print("[LLENEMY_Ext_Debug_PrintItemProperties] Object ("..tostring(stat)..")["..tostring(obj).."] Properties:")
	Ext.Print("==========================")
	for i,prop in pairs(ItemProperties) do
		Ext.Print("["..tostring(prop).."] = "..tostring(item[prop]))
	end
	Ext.Print("==========================")
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
