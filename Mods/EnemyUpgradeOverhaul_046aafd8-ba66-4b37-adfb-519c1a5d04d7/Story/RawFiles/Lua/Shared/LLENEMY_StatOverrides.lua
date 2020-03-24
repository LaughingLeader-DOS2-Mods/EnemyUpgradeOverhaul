local stat_overrides = {
	_NpcDaggers = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcUnarmed = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcWands_Water = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcSwords = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcAxes = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcClubs = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcTwoHandedSwords = {
		Talents = "ViolentMagic"
	},
	_NpcTwoHandedAxes = {
		Talents = "ViolentMagic"
	},
	_NpcTwoHandedMaces = {
		Talents = "ViolentMagic"
	},
	_NpcSpears = {
		Talents = "ViolentMagic"
	},
	_NpcStaffs = {
		Talents = "ViolentMagic;FaroutDude"
	},
	_NpcStaffs_Fire = {
		Talents = "ViolentMagic;FaroutDude"
	},
	_NpcStaffs_Water = {
		Talents = "ViolentMagic;FaroutDude"
	},
	_NpcStaffs_Poison = {
		Talents = "ViolentMagic;FaroutDude"
	},
	_NpcStaffs_Earth = {
		Talents = "ViolentMagic;FaroutDude"
	},
	_NpcStaffs_Air = {
		Talents = "ViolentMagic;FaroutDude"
	},
	_NpcBows = {
		Talents = "ViolentMagic;ElementalRanger"
	},
	_NpcCrossbows = {
		Talents = "ViolentMagic;ElementalRanger"
	},
	_NpcWands_Fire = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcWands_Air = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	_NpcWands_Poison = {
		Talents = "ViolentMagic;Ambidextrous"
	},
	LLENEMY_TALENT_COUNTER = {
		Description = "LLENEMY_TALENT_COUNTER_EXTENDER_Description",
		DescriptionParams = "CounterChance"
	},
	LLENEMY_ACTIVATE_FLAMING_TONGUES = {
		LeaveAction = "" -- NRD_ApplyActiveDefense instead
	},
	LLENEMY_ACTIVATE_HEALING_TEARS = {
		LeaveAction = "" -- NRD_ApplyActiveDefense instead
	}
}

-- v40 and up introduced a way to add talents to NPCs
local talent_belt_overrides = {
	LLENEMY_TALENT_LONEWOLF = { Items = "", StackId = "Stack_LLENEMY_Talent_LoneWolf"},
	LLENEMY_TALENT_TORTURER = { Items = "", StackId = "Stack_LLENEMY_Talent_Torturer"},
	LLENEMY_TALENT_UNSTABLE = { Items = "", StackId = "Stack_LLENEMY_Talent_Unstable"},
	LLENEMY_TALENT_WHATARUSH = { Items = "", StackId = "Stack_LLENEMY_Talent_WhatARush"},
	LLENEMY_TALENT_LEECH = { Items = "", StackId = "Stack_LLENEMY_Talent_Leech"},
	LLENEMY_TALENT_QUICKSTEP = { Items = "", StackId = "Stack_LLENEMY_Talent_Quickstep"},
	LLENEMY_TALENT_SADIST = { Items = "", StackId = "Stack_LLENEMY_Talent_Sadist"},
	LLENEMY_TALENT_GLADIATOR = { Items = "", StackId = "Stack_LLENEMY_Talent_Gladiator"},
	LLENEMY_TALENT_HAYMAKER = { Items = "", StackId = "Stack_LLENEMY_Talent_Haymaker"},
	LLENEMY_TALENT_INDOMITABLE = { Items = "", StackId = "Stack_LLENEMY_Talent_Indomitable"},
	LLENEMY_TALENT_SOULCATCHER = { Items = "", StackId = "Stack_LLENEMY_Talent_SoulCatcher"},
	LLENEMY_TALENT_MAGICCYCLES = { Items = "", StackId = "Stack_LLENEMY_Talent_MagicCycles"},
	LLENEMY_TALENT_GREEDYVESSEL = { Items = "", StackId = "Stack_LLENEMY_Talent_GreedyVessel"},
	LLENEMY_TALENT_BACKSTAB = { Items = "", StackId = "Stack_LLENEMY_Talent_Backstab"},
}

-- Statuses displayed in LLENEMY_UPGRADE_INFO
local upgrade_info_statuses = {
	"LLENEMY_TALENT_BACKSTAB",
	"LLENEMY_TALENT_LEECH",
	"LLENEMY_TALENT_LONEWOLF",
	"LLENEMY_TALENT_QUICKSTEP",
	"LLENEMY_TALENT_RANGERRANGE",
	"LLENEMY_TALENT_WHATARUSH",
	"LLENEMY_TALENT_TORTURER",
	"LLENEMY_TALENT_SADIST",
	"LLENEMY_TALENT_HAYMAKER",
	"LLENEMY_TALENT_GLADIATOR",
	"LLENEMY_TALENT_INDOMITABLE",
	"LLENEMY_TALENT_SOULCATCHER",
	"LLENEMY_TALENT_MASTERTHIEF",
	"LLENEMY_TALENT_GREEDYVESSEL",
	"LLENEMY_TALENT_MAGICCYCLES",
	"LLENEMY_INF_NECROFIRE",
	"LLENEMY_INF_NECROFIRE_G",
	"LLENEMY_INF_WATER",
	"LLENEMY_INF_WATER_G",
	"LLENEMY_INF_BLESSED_ICE",
	"LLENEMY_INF_BLESSED_ICE_G",
	"LLENEMY_INF_POISON",
	"LLENEMY_INF_POISON_G",
	"LLENEMY_INF_ACID",
	"LLENEMY_INF_ACID_G",
	"LLENEMY_INF_ELECTRIC",
	"LLENEMY_INF_ELECTRIC_G",
	"LLENEMY_INF_CURSED_ELECTRIC",
	"LLENEMY_INF_CURSED_ELECTRIC_G",
	"LLENEMY_INF_BLOOD",
	"LLENEMY_INF_BLOOD_G",
	"LLENEMY_INF_OIL",
	"LLENEMY_INF_OIL_G",
	"LLENEMY_INF_FIRE",
	"LLENEMY_INF_FIRE_G",
	"LLENEMY_BONUS_TREASURE_ROLL",
	"LLENEMY_IMMUNITY_LOSECONTROL",
	"LLENEMY_DOUBLE_DIP",
	"LLENEMY_PERSEVERANCE_MASTERY",
	"LLENEMY_BONUSSKILLS_SINGLE",
	"LLENEMY_BONUSSKILLS_SET_NORMAL",
	"LLENEMY_BONUSSKILLS_SOURCE",
	"LLENEMY_BONUSSKILLS_SET_ELITE",
}

local ignore_skill_names = {
	Enemy = true,
	Quest = true,
	QUEST = true,
	NPC = true
}

local function CanChangeSkillTier(stat, tier)
	if Ext.StatGetAttribute(stat, "ForGameMaster") == "Yes" then
		if tier == "" or tier == "Starter" then
			return false
		end
		local isenemy = Ext.StatGetAttribute(stat, "IsEnemySkill")
		if isenemy == "Yes" then
			return false
		end
		for str,b in pairs(ignore_skill_names) do
			if string.find(stat, str) then
				return false
			end
		end
		return true
	else
		return false
	end
end

local function OverrideStats()
    local total_changes = 0
    local total_stats = 0

    local debug_print = EnemyUpgradeOverhaul.DeveloperMode

    --LeaderLib_7e737d2f-31d2-4751-963f-be6ccc59cd0c
    if _G["LeaderLib"] ~= nil or Ext.IsModLoaded("7e737d2f-31d2-4751-963f-be6ccc59cd0c") then
        if _G["LeaderLib_Lua_PrintEnabled"] == true then
            debug_print = true
        end
    end

    for statname,overrides in pairs(stat_overrides) do
        for property,value in pairs(overrides) do
            if debug_print then Ext.Print("LLENEMY_StatOverrides.lua] Overriding stat: " .. statname .. " (".. property ..") = \"".. value .."\"") end
            Ext.StatSetAttribute(statname, property, value)
            total_changes = total_changes + 1
        end
        total_stats = total_stats + 1
	end

	if Ext.Version() >= 40 then
		for statname,overrides in pairs(talent_belt_overrides) do
			for property,value in pairs(overrides) do
				if debug_print then Ext.Print("LLENEMY_StatOverrides.lua] Overriding stat: " .. statname .. " (".. property ..") = \"".. value .."\"") end
				Ext.StatSetAttribute(statname, property, value)
				total_changes = total_changes + 1
			end
			total_stats = total_stats + 1
		end
	end

	--EnemyUpgradeOverhaulSingleplayer_88d7c1d3-8de9-4494-be12-a8fcbc8171e9
	local enhancementsLoaded = Ext.IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9")
	if Ext.Version() >= 42 or enhancementsLoaded then
		Ext.Print("LLENEMY_StatOverrides.lua] Enabling v42+ enhancements.")
		if debug_print then
			Ext.Print("==============================================================")
			Ext.Print("LLENEMY_StatOverrides.lua] (Upgrade Info) enabled. Hiding statuses used for info.")
		end
		for _,statname in pairs(upgrade_info_statuses) do
			if debug_print then Ext.Print("LLENEMY_StatOverrides.lua] Hiding icon for stat: " .. statname) end
			Ext.StatSetAttribute(statname, "Icon", "")
			total_changes = total_changes + 1
			total_stats = total_stats + 1
		end
		if enhancementsLoaded or Ext.IsDeveloperMode() == true then
			if debug_print then Ext.Print("LLENEMY_StatOverrides.lua] Enabling skill Tier overrides.") end
			for _,stat in pairs(Ext.GetStatEntries("SkillData")) do
				local tier = Ext.StatGetAttribute(stat, "Tier")
				if CanChangeSkillTier(stat, tier) then
					Ext.StatSetAttribute(stat, "Tier", "Starter")
					if debug_print then Ext.Print("LLENEMY_StatOverrides.lua] Change Tier for skill ("..tostring(stat)..") to Starter.") end
				end
			end
		end
		Ext.Print("==============================================================")
	end
	if debug_print then
		Ext.Print("LLENEMY_StatOverrides.lua] Changed ("..tostring(total_changes)..") properties in ("..tostring(total_stats)..") stats (added talents to enemy weapons).")
	end
end

EnemyUpgradeOverhaul.OverrideStats = OverrideStats;