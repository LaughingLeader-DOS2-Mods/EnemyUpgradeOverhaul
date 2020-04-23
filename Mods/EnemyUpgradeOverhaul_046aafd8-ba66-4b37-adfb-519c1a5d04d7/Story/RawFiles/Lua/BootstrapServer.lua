Ext.Require("Shared/LLENEMY_Shared.lua")

Ext.Require("Server/LLENEMY_UpgradeInfo.lua")
local bonusSkillsScript = Ext.Require("Server/LLENEMY_BonusSkills.lua")
Ext.Require("Server/LLENEMY_GameMechanics.lua")
Ext.Require("Server/LLENEMY_ItemMechanics.lua")
Ext.Require("Server/LLENEMY_ItemCorruption.lua")
Ext.Require("Server/LLENEMY_ItemCorruptionBoosts.lua")
--Ext.Require("Server/LLENEMY_ItemCorruptionDeltamods.lua")
Ext.Require("Server/LLENEMY_TreasureGoblins.lua")
Ext.Require("Server/LLENEMY_VoidwokenSpawning.lua")
Ext.Require("Server/LLENEMY_ServerMessages.lua")
Ext.Require("Server/LLENEMY_Debug.lua")

function Init()
	--EnemyUpgradeOverhaulSingleplayer_88d7c1d3-8de9-4494-be12-a8fcbc8171e9
	if NRD_IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") == 1 then
		GlobalSetFlag("LLENEMY_SingleplayerModeEnabled")
		Ext.Print("[LLENEMY:BootstrapServer.lua:LLENEMY_Ext_Init] EnemyUpgradeOverhaulSingleplayer_88d7c1d3-8de9-4494-be12-a8fcbc8171e9 is active.")
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
	bonusSkillsScript.Init()
end
Ext.RegisterListener("SessionLoaded", LLENEMY_Server_SessionLoaded)

-- local function LLENEMY_Server_SessionLoading()
	
-- end
-- Ext.RegisterListener("SessionLoading", LLENEMY_Server_SessionLoading)