if Ext.Version() < 42 then
	Ext.Print("[LLENEMY:Bootstrap.lua] Loading both server/client scripts for old extender version (" .. tostring(Ext.Version()) .. ").")
	Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "BootstrapClient.lua")
	Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "BootstrapServer.lua")
end