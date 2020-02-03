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
	}
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
            if debug_print then Ext.Print("[LLENEMY:Bootstrap.lua] Overriding stat: " .. statname .. " (".. property ..") = \"".. value .."\"") end
            Ext.StatSetAttribute(statname, property, value)
            total_changes = total_changes + 1
        end
        total_stats = total_stats + 1
	end
	
    Ext.Print("[LLENEMY:Bootstrap.lua] Changed ("..tostring(total_changes)..") properties in ("..tostring(total_stats)..") stats (added talents to enemy weapons).")
end

local function ModuleLoad()
    Ext.Print("[LLENEMY:Bootstrap.lua] Module is loading.")
	OverrideStats()
end
--Ext.StatAddCustomDescription("LLENEMY_TALENT_COUNTER", "CounterChance", "2000000%")

local COUNTER_MIN = 10
local COUNTER_MAX = 75

local StatusGetDescriptionParam = function (status, statusSource, character, param)
    if status.Name == "LLENEMY_TALENT_COUNTER" and param == "CounterChance" then
		--local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
		--Ext.Print("Char: " .. tostring(character) .. " | " .. LeaderLib.Common.Dump(character))
		local initiative = character.Initiative
		--local percent = (initiative - COUNTER_MIN) / (COUNTER_MAX - COUNTER_MIN)
		local chance = (math.log(1 + initiative) / math.log(1 + COUNTER_MAX))
		--Ext.Print("Chance: " .. tostring(chance))
		--local chance = (math.log(initiative/COUNTER_MIN) / math.log(COUNTER_MAX/COUNTER_MIN)) * COUNTER_MAX
		return "<font color='#D416FF'>" .. tostring(math.floor(chance * COUNTER_MAX)) .. "%</font>"
    end
end

function LLENEMY_Ext_RollForCounterAttack(character,target)
	local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	local chance = (math.log(1 + initiative) / math.log(1 + COUNTER_MAX))
	chance = math.floor(chance * COUNTER_MAX) * 10
	local roll = LeaderLib.Common.GetRandom(999)
	Ext.Print("Counter roll: " .. tostring(roll) .. " / " .. tostring(chance))
	if roll >= chance then
		CharacterAttack(character, target)
		CharacterStatusText(character, "LLENEMY_StatusText_CounterAttack")
	end
end

--v36 and higher
if Ext.RegisterListener ~= nil then
	Ext.RegisterListener("ModuleLoading", ModuleLoad)
	Ext.RegisterListener("StatusGetDescriptionParam", StatusGetDescriptionParam)
else
    Ext.Print("[LLENEMY:Bootstrap.lua] [*WARNING*] Extender version is less than v36! Stat overrides ain't happenin', chief.")
end