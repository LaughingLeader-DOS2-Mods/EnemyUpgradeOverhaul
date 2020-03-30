Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_Shared.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Client/LLENEMY_DescriptionParams.lua")

local function LLENEMY_Client_ModuleLoading()
	LLENEMY_Shared_InitModuleLoading()
	EnemyUpgradeOverhaul.OverrideStats()
end

Ext.RegisterListener("ModuleLoading", LLENEMY_Client_ModuleLoading)
--Ext.RegisterListener("ModuleResume", LLENEMY_Client_ModuleResume)