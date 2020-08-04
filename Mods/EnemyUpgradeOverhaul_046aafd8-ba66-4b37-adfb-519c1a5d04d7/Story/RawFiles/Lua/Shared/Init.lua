LeaderLib = Mods["LeaderLib"]
GameHelpers = LeaderLib.GameHelpers
Common = LeaderLib.Common
StringHelpers = LeaderLib.StringHelpers

---@type table<string, boolean>
IgnoredSkills = {}
---@type string[]
IgnoredWords = {}
--- Skills ignored from the Voidwoken spawning system.
---@type table<string, boolean>
IgnoredSourceSkills = {}
--- Enemy skills used when granting enemies bonus skills.
---@type SkillGroup[]
EnemySkills = {}
StatusDescriptionParams = {}
SINGLEPLAYER = false
HighestLoremaster = 0
InvisibleStatuses = {
	["SNEAKING"] = true,
	["INVISIBLE"] = true,
}
ExtraData = {
	LLENEMY_Counter_MaxChance = 75
}
VoiceMetaData = {}
Commands = {
	CHECKLOREMASTER = "CheckLoremaster"
}

if ItemCorruption == nil then
	ItemCorruption = {}
end

Ext.Require("Shared/Classes/Init.lua")

---@type table<string, TagBoost>
ItemCorruption.TagBoosts = Ext.Require("Shared/Data/Corruption/TagBoostEntries.lua")

ItemCorruption.Boosts = {}

---@class EUOBoostsScript
---@field Init function Initializes boosts while pulling chances from Data.txt
local boostsScript = Ext.Require("Shared/Data/Corruption/Boosts.lua")

---@class ModBoostInitializer
---@field Init function Checks active mods and adds additional corruption boosts.
local modBoosts = Ext.Require("Shared/Data/Corruption/ModBoosts.lua")

---@type string[]
ItemCorruption.Colors = Ext.Require("Shared/Data/Corruption/Colors.lua")

--ItemCorruption.DeltaMods = Ext.Require("Shared/Data/Corruption/DeltaMods.lua")

---@type string[]
ItemCorruption.Names = Ext.Require("Shared/Data/Corruption/Names.lua")

local statOverrides = Ext.Require("Shared/StatOverrides.lua")
Ext.Require("Shared/VoiceData.lua")
Ext.Require("Shared/SharedUpgradeInfo.lua")
---@type ModSettings
Settings = Ext.Require("Shared/Settings.lua")

local function FixModTypos()
	-- Greed typos
	if Ext.IsModLoaded("d1ba8097-dba1-d74b-7efe-8fca3ef71fe5") then
		local dm = Ext.GetDeltaMod("Boost_Weapon_Status_Set_TankerClub", "Weapon")
		dm.WeaponType = "Club" -- Legendary -> Club
		dm.BoostType = "Legendary" -- Normal -> Legendary
		Ext.UpdateDeltaMod(dm)

		dm = Ext.GetDeltaMod("Gloves_PiercingDamage", "Armor")
		dm.BoostType = "Normal" -- Norma -> Normal
		Ext.UpdateDeltaMod(dm)

		dm = Ext.GetDeltaMod("Gloves_AirDamage", "Armor")
		dm.BoostType = "Normal" -- Norma -> Normal
		Ext.UpdateDeltaMod(dm)
	end
end

function LLENEMY_Shared_InitModuleLoading()
	statOverrides.Init()
	Ext.Print("LLENEMY_Shared.lua] Module is loading.")
	for key,fallback in pairs(ExtraData) do
		local value = LeaderLib.GameHelpers.GetExtraData(key, fallback)
		ExtraData[key] = value
		LeaderLib.PrintDebug("[LLENEMY_Shared.lua:LLENEMY_ModuleLoading] Loaded Data.txt key - [" .. tostring(key) .. "] = (" .. tostring(value) .. ")")
	end
	if Ext.IsDeveloperMode() and Ext.Version() >= 44 and Ext.GetDeltaMod ~= nil then
		FixModTypos()
	end
end

local function LLENEMY_Shared_SessionLoading()
	Ext.Print("[LLENEMY:Bootstrap.lua] Session is loading.")
	if Ext.IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") then
		SINGLEPLAYER = true
	end

	local statuses = Ext.GetStatEntries("StatusData")
	for _,stat in pairs(statuses) do
		local status_type = Ext.StatGetAttribute(stat, "StatusType")
		if status_type == "INVISIBLE" and InvisibleStatuses[stat] == nil then
			InvisibleStatuses[stat] = true
		end
	end

	boostsScript.Init()
	modBoosts.Init()
end
Ext.RegisterListener("SessionLoading", LLENEMY_Shared_SessionLoading)

local function RegisterVoiceMetaData()
	for speaker,entries in pairs(VoiceMetaData) do
		for i,data in pairs(entries) do
			Ext.Print("[LLENEMY_Shared.lua:LLENEMY_ModuleLoading] Registered VoiceMetaData - Speaker[" .. speaker .. "] Handle(" .. tostring(data.Handle) .. ") Source(" .. tostring(data.Source) .. ") Length(" .. tostring(data.Length) .. ")")
			Ext.AddVoiceMetaData(speaker, data.Handle, data.Source, data.Length, data.Priority)
		end
	end
end

Ext.RegisterListener("SessionLoaded", function()
	LeaderLib.EnableFeature("ResistancePenetration")
end)