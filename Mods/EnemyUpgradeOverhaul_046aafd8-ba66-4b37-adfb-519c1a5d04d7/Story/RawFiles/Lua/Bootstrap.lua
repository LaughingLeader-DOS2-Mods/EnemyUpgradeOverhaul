EnemyUpgradeOverhaul = {
	IgnoredSkills = {},
	IgnoredWords = {},
	EnemySkills = {},
	StatusDescriptionParams = {}
}

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "LLENEMY_StatOverrides.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "LLENEMY_BonusSkills.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "LLENEMY_DescriptionParams.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "LLENEMY_GameMechanics.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "LLENEMY_Debug.lua")

local function SessionLoading()
	Ext.Print("[LLENEMY:Bootstrap.lua] Session is loading.")
	LLENEMY_Ext_BuildEnemySkills();
end

Ext.RegisterListener("SessionLoading", SessionLoading)

function LLENEMY_Ext_ClearGain(char)
	local stats = nil
	-- if NRD_GetVersion() >= 39 then
	-- 	stats = NRD_CharacterGetStatString(char)
	-- end
	if stats == nil then stats = GetStatString(char) end
	if stats ~= nil then
		local gain = NRD_StatGetInt(stats, "Gain")
		gain = gain - 1
		Osi.LeaderLog_Log("DEBUG", "[LLENEMY:Bootstrap.lua:LLENEMY_Ext_ClearGain] Removing " .. tostring(gain) .." from ("..tostring(char)..").");
		NRD_CharacterSetPermanentBoostInt(char, "Gain", gain);
		NRD_CharacterSetPermanentBoostInt(char, "Gain", 1);
		CharacterAddAttribute(char, "Strength", 0);
	end
end

Ext.Print("[LLENEMY:Bootstrap.lua] Finished running.")