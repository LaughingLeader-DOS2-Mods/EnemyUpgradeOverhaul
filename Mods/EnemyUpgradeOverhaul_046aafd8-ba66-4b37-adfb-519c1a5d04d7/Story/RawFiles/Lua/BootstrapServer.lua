Ext.Require("Shared/Init.lua")

PersistentVars = {
	NewCorruptionStats = {}
}

Ext.Require("Server/Classes/Init.lua")
Ext.Require("Server/UpgradeInfo.lua")
local bonusSkillsScript = Ext.Require("Server/BonusSkills.lua")
Ext.Require("Server/GameMechanics.lua")
Ext.Require("Server/ItemMechanics.lua")
Ext.Require("Server/ItemCorruption.lua")
Ext.Require("Server/ItemCorruptionBoosts.lua")
--Ext.Require("Server/ItemCorruptionDeltamods.lua")
Ext.Require("Server/TreasureGoblins.lua")
Ext.Require("Server/VoidwokenSpawning.lua")
Ext.Require("Server/ServerMessages.lua")
Ext.Require("Server/Recruiter.lua")
Ext.Require("Server/Debug.lua")

function Init()
	--EnemyUpgradeOverhaulSingleplayer_88d7c1d3-8de9-4494-be12-a8fcbc8171e9
	if NRD_IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") == 1 then
		GlobalSetFlag("LLENEMY_SingleplayerModeEnabled")
		Ext.Print("[LLENEMY:BootstrapServer.lua:Init] EnemyUpgradeOverhaulSingleplayer_88d7c1d3-8de9-4494-be12-a8fcbc8171e9 is active.")
	else
		GlobalClearFlag("LLENEMY_SingleplayerModeEnabled")
		--Ext.Print("EnemyUpgradeOverhaulSingleplayer_88d7c1d3-8de9-4494-be12-a8fcbc8171e9 is not active.")
	end
end

local function LLENEMY_Server_ModuleLoading()
	LLENEMY_Shared_InitModuleLoading()
end
Ext.RegisterListener("ModuleLoading", LLENEMY_Server_ModuleLoading)

local function LLENEMY_Server_SessionLoaded()
	-- Odinblade's Necromancy Overhaul
	if Ext.IsModLoaded("8700ba4e-7d4b-40ca-a23f-b43816794957") then
		-- This is a skill that applies DOS1's Oath of Desecration potion for +40% damage
		IgnoredSkills["Target_EnemyTargetedDamageBoost"] = true
	end
	bonusSkillsScript.Init()
end
Ext.RegisterListener("SessionLoaded", LLENEMY_Server_SessionLoaded)

-- local function LLENEMY_Server_SessionLoading()
	
-- end
-- Ext.RegisterListener("SessionLoading", LLENEMY_Server_SessionLoading)