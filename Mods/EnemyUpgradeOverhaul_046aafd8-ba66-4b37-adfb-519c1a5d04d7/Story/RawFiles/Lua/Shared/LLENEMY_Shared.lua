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
	VoiceMetaData = {},
	DeveloperMode = false,
	GetInfoID = function(uuid)
		if Ext.Version() >= 43 then
			local character = Ext.GetCharacter(uuid)
			if character.NetID ~= nil then
				return tostring(character.NetID)
			end
		end
		return uuid
	end
}

function LLENEMY_Ext_GetExtraDataValue(key, fallback)
	local val = Ext.ExtraData[key]
	if val ~= nil then return val end
	return fallback
end

Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_StatOverrides.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_VoiceData.lua")
Ext.Require("EnemyUpgradeOverhaul_046aafd8-ba66-4b37-adfb-519c1a5d04d7", "Shared/LLENEMY_SharedUpgradeInfo.lua")

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

local function LLENEMY_Shared_SessionLoading()
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
Ext.RegisterListener("SessionLoading", LLENEMY_Shared_SessionLoading)


local function RegisterVoiceMetaData()
	for speaker,entries in pairs(EnemyUpgradeOverhaul.VoiceMetaData) do
		for i,data in pairs(entries) do
			Ext.Print("[LLENEMY_Shared.lua:LLENEMY_ModuleLoading] Registered VoiceMetaData - Speaker[" .. speaker .. "] Handle(" .. tostring(data.Handle) .. ") Source(" .. tostring(data.Source) .. ") Length(" .. tostring(data.Length) .. ")")
			Ext.AddVoiceMetaData(speaker, data.Handle, data.Source, data.Length, data.Priority)
		end
	end
end

local function LLENEMY_Shared_SessionLoaded()
	RegisterVoiceMetaData()
end

if Ext.Version() >= 43 then
	Ext.RegisterListener("SessionLoaded", LLENEMY_Shared_SessionLoaded)
end