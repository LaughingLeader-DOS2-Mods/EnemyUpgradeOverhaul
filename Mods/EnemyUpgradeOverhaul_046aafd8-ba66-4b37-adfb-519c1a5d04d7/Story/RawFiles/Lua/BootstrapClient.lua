Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_Shared.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Client/LLENEMY_DescriptionParams.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Client/LLENEMY_ExperienceScaling.lua")

local function LLENEMY_ModuleLoading()
	Ext.StatSetLevelScaling("Character", "Gain", LLENEMY_Ext_ScaleExperience)
	Ext.Print("[LLENEMY:BootstrapServer.lua:LLENEMY_ModuleLoading] Registered Gain scaling function.")
end

local function LLENEMY_ModuleResume()
	Ext.StatSetLevelScaling("Character", "Gain", LLENEMY_Ext_ScaleExperience)
	Ext.Print("[LLENEMY:BootstrapServer.lua:LLENEMY_ModuleResume] Registered Gain scaling function.")
end

Ext.RegisterListener("ModuleLoading", LLENEMY_ModuleLoading)
Ext.RegisterListener("ModuleResume", LLENEMY_ModuleResume)