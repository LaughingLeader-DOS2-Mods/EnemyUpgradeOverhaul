Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_Shared.lua")

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_UpgradeInfo.lua")

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_BonusSkills.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_GameMechanics.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Server/LLENEMY_Debug.lua")

local function LLENEMY_SessionLoading()
	Ext.Print("[LLENEMY:Bootstrap.lua] Session is loading.")
	if Ext.IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") then
		EnemyUpgradeOverhaul.SINGLEPLAYER = true
	end
	LLENEMY_Ext_BuildEnemySkills();

	local statuses = Ext.GetStatEntries("StatusData")
	for _,stat in pairs(statuses) do
		local status_type = Ext.StatGetAttribute(stat, "StatusType")
		if status_type == "INVISIBLE" and EnemyUpgradeOverhaul.InvisibleStatuses[stat] == nil then
			EnemyUpgradeOverhaul.InvisibleStatuses[stat] = true
		end
	end
end

Ext.RegisterListener("SessionLoading", LLENEMY_SessionLoading)

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

function LLENEMY_Ext_SendPlayerLevel()
	local host = CharacterGetHostCharacter()
	local level = CharacterGetLevel(host)
	EnemyUpgradeOverhaul.PlayerLevel = level
	Ext.BroadcastMessage("LLENEMY_SetPlayerLevel", tostring(level), nil)
	--Ext.BroadcastMessage("LLENEMY_SetPlayerLevel", tostring(CharacterGetLevel(host)), host)
end