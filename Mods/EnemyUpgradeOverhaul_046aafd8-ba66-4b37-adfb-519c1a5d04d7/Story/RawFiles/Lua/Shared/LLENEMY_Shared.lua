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
	UpgradeInfo = {},
	ExtraData = {
		LLENEMY_Counter_MaxChance = 75,
	},
	DeveloperMode = false
}

function LLENEMY_Ext_GetExtraDataValue(key, fallback)
	local val = Ext.ExtraData[key]
	if val ~= nil then return val end
	return fallback
end

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_StatOverrides.lua")

if Ext.Version() >= 42 then
	EnemyUpgradeOverhaul.DeveloperMode = Ext.IsDeveloperMode() == true
end

function LLENEMY_Shared_InitModuleLoading()
	Ext.Print("LLENEMY_Shared.lua] Module is loading.")
	for key,fallback in pairs(EnemyUpgradeOverhaul.ExtraData) do
		local value = LLENEMY_Ext_GetExtraDataValue(key, fallback)
		EnemyUpgradeOverhaul.ExtraData[key] = value
		if EnemyUpgradeOverhaul.DeveloperMode then
			Ext.Print("[LLENEMY_Shared.lua:LLENEMY_ModuleLoading] Loaded Data.txt key - [" .. tostring(key) .. "] = (" .. tostring(value) .. ")")
		end
	end
end

local function LLENEMY_SessionLoading()
	Ext.Print("[LLENEMY:Bootstrap.lua] Session is loading.")
	if Ext.IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") then
		EnemyUpgradeOverhaul.SINGLEPLAYER = true
	end
	if Ext.IsServer() then
		LLENEMY_Ext_BuildEnemySkills()
	end

	local statuses = Ext.GetStatEntries("StatusData")
	for _,stat in pairs(statuses) do
		local status_type = Ext.StatGetAttribute(stat, "StatusType")
		if status_type == "INVISIBLE" and EnemyUpgradeOverhaul.InvisibleStatuses[stat] == nil then
			EnemyUpgradeOverhaul.InvisibleStatuses[stat] = true
		end
	end
end
Ext.RegisterListener("SessionLoading", LLENEMY_SessionLoading)