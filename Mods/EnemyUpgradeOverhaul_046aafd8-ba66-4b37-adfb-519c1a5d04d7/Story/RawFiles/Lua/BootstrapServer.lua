Ext.Require("Shared/Init.lua")

PersistentVars = {
	NewCorruptionStats = {}
}

Ext.Require("Server/UpgradeInfo.lua")
local bonusSkillsScript = Ext.Require("Server/BonusSkills.lua")
Ext.Require("Server/GameMechanics.lua")
Ext.Require("Server/Duplicants.lua")
Ext.Require("Server/ItemMechanics.lua")
Ext.Require("Server/Items/ItemCorruption.lua")
Ext.Require("Server/Items/ItemCorruptionStatCreator.lua")
Ext.Require("Server/Items/ItemBonuses.lua")
Ext.Require("Server/TreasureGoblins.lua")
Ext.Require("Server/VoidwokenSpawning.lua")
Ext.Require("Server/ServerMessages.lua")
Ext.Require("Server/Recruiter.lua")

if Ext.IsDeveloperMode() then
	Ext.Require("Server/Debug/Init.lua")
	Ext.Require("Server/Debug/ConsoleCommands.lua")
end

local function LLENEMY_Server_ModuleLoading()
	LLENEMY_Shared_InitModuleLoading()
end
Ext.RegisterListener("ModuleLoading", LLENEMY_Server_ModuleLoading)

---@type ModSettings
local ModSettings = LeaderLib.Classes.ModSettingsClasses.ModSettings
local settings = ModSettings:Create("046aafd8-ba66-4b37-adfb-519c1a5d04d7")
settings.Global:AddFlags({
	"LLENEMY_Debug_LevelCapDisabled",
	"LLENEMY_EnemyLevelingEnabled",
	"LLENEMY_HardModeEnabled",
	"LLENEMY_RewardsDisabled",
	"LLENEMY_Scaling_LevelModifier",
	"LLENEMY_VoidwokenSourceSpawningEnabled",
	"LLENEMY_WorldUpgradesEnabled",
	"LLENEMY_AuraUpgradesDisabled",
	"LLENEMY_BonusBuffUpgradesDisabled",
	"LLENEMY_BonusSkillsUpgradesDisabled",
	"LLENEMY_BuffUpgradesDisabled",
	"LLENEMY_ClassUpgradesUpgradesDisabled",
	"LLENEMY_DuplicationUpgradesDisabled",
	"LLENEMY_ImmunityUpgradesDisabled",
	"LLENEMY_TalentUpgradesDisabled",
	"LLENEMY_WorldUpgradesEnabled",
})
settings.Global:AddVariable("LLENEMY_Scaling_LevelModifier", 0, "integer")

local function LLENEMY_Server_SessionLoaded()
	-- Odinblade's Necromancy Overhaul
	if Ext.IsModLoaded("8700ba4e-7d4b-40ca-a23f-b43816794957") then
		-- This is a skill that applies DOS1's Oath of Desecration potion for +40% damage
		IgnoredSkills["Target_EnemyTargetedDamageBoost"] = true
	end
	-- Odinblade's Aerotheurge Class Overhaul
	if Ext.IsModLoaded("961ae59d-2964-46dd-9762-073697915dc2") then
		-- Pretty brutal apparently
		IgnoredSkills["Target_OdinAERO_Enemy_InsulationShield"] = true
	end
	-- Divinity Conflux by Xorn
	if Ext.IsModLoaded("723ad06b-0241-4a2e-a9f3-4d2b419e0fe3") then
		-- Super damage
		IgnoredSkills["ProjectileStrike_Enemy_Xorn_Comdor_Smash"] = true
	end
	bonusSkillsScript.Init()

	SettingsManager.AddSettings(settings)
end
Ext.RegisterListener("SessionLoaded", LLENEMY_Server_SessionLoaded)

LeaderLib.RegisterListener("ModSettingsLoaded", function()
	Osi.DB_LLENEMY_LevelModifier:Delete(nil)
	Osi.DB_LLENEMY_LevelModifier(settings.Global.Variables.LLENEMY_Scaling_LevelModifier.Value or 0)
end)

-- local function LLENEMY_Server_SessionLoading()
	
-- end
-- Ext.RegisterListener("SessionLoading", LLENEMY_Server_SessionLoading)