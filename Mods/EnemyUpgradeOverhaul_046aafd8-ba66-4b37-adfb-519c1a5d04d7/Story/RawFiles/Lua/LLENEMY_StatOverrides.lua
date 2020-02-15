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
	LLENEMY_TALENT_BULLY = {
		Description = "LLENEMY_TALENT_BULLY_EXTENDER_Description"
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
	LLENEMY_TALENT_LONEWOLF = { Items = ""},
	LLENEMY_TALENT_TORTURER = { Items = ""},
	LLENEMY_TALENT_UNSTABLE = { Items = ""},
	LLENEMY_TALENT_WHATARUSH = { Items = ""},
	LLENEMY_TALENT_LEECH = { Items = ""},
	LLENEMY_TALENT_QUICKSTEP = { Items = ""},
	LLENEMY_TALENT_SADIST = { Items = ""},
	LLENEMY_TALENT_GLADIATOR = { Items = ""},
	LLENEMY_TALENT_HAYMAKER = { Items = ""},
	LLENEMY_TALENT_INDOMITABLE = { Items = ""},
	LLENEMY_TALENT_SOULCATCHER = { Items = ""},
	LLENEMY_TALENT_MAGICCYCLES = { Items = ""},
	LLENEMY_TALENT_GREEDYVESSEL = { Items = ""},
	LLENEMY_TALENT_BACKSTAB = { Items = ""},
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

local function OverrideStats()
    local total_changes = 0
    local total_stats = 0

    local debug_print = false

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
	if Ext.IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") then
		Ext.Print("LLENEMY_StatOverrides.lua] Enabling singleplayer enhancements (Upgrade Info). Hiding statuses used for info.")
		for _,statname in pairs(upgrade_info_statuses) do
			if debug_print then Ext.Print("LLENEMY_StatOverrides.lua] Overriding stat: " .. statname .. " (".. property ..") = \"".. value .."\"") end
			Ext.StatSetAttribute(statname, "Icon", "")
			total_changes = total_changes + 1
			total_stats = total_stats + 1
		end
	end
	
    Ext.Print("LLENEMY_StatOverrides.lua] Changed ("..tostring(total_changes)..") properties in ("..tostring(total_stats)..") stats (added talents to enemy weapons).")
end

local function ModuleLoading()
    Ext.Print("LLENEMY_StatOverrides.lua] Module is loading.")
	OverrideStats()
end
--Ext.StatAddCustomDescription("LLENEMY_TALENT_COUNTER", "CounterChance", "2000000%")

Ext.RegisterListener("ModuleLoading", ModuleLoading)