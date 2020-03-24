EnemyUpgradeOverhaul = {
	IgnoredSkills = {},
	IgnoredWords = {},
	EnemySkills = {},
	StatusDescriptionParams = {},
	SINGLEPLAYER = false,
	InvisibleStatuses = {
		["SNEAKING"] = true,
		["INVISIBLE"] = true,
	},
	UpgradeInfo = {}
}

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared\\LLENEMY_StatOverrides.lua")

local function LLENEMY_ModuleLoading()
    Ext.Print("LLENEMY_StatOverrides.lua] Module is loading.")
	EnemyUpgradeOverhaul.OverrideStats()
end
--Ext.StatAddCustomDescription("LLENEMY_TALENT_COUNTER", "CounterChance", "2000000%")

Ext.RegisterListener("ModuleLoading", LLENEMY_ModuleLoading)