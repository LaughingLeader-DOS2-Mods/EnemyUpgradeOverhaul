Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_Shared.lua")

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_UpgradeInfo.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_BonusSkills.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_GameMechanics.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_ItemMechanics.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_Debug.lua")

function LLENEMY_Ext_Init()
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
	LLENEMY_Ext_BuildEnemySkills()
end
Ext.RegisterListener("SessionLoaded", LLENEMY_Server_SessionLoaded)

-- Ignored skills support example
-- local function MyMod_Server_SessionLoading()
-- 	if EnemyUpgradeOverhaul ~= nil and EnemyUpgradeOverhaul.IgnoredSkills ~= nil then
-- 		EnemyUpgradeOverhaul.IgnoredSkills["MySkillEntry"] = true
-- 	end
-- end
-- Ext.RegisterListener("SessionLoading", MyMod_Server_SessionLoading)