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
	ExtraData = {
		LLENEMY_Counter_MaxChance = 75,
	},
	VoiceMetaData = {},
	VoidwokenTemplates = {
		"Animals_Bear_A_Voidwoken_a0f68491-6af5-4190-9c45-c4559d29c08f",
		"Animals_Salamander_A_Voidwoken_5c0f4a3b-1640-4925-8993-826452655435",
		"Animals_Turtle_A_Voidwoken_df421d91-2be6-4388-b3d9-fa01d915f346",
		"Creatures_GiantInsect_A_Wings_9f05d133-4220-4196-a337-80c1f444c6e7",
		"Creatures_GiantInsect_B_Wings_43d2c6db-2a93-4204-b0a0-ee19537fe14f",
		"Creatures_GiantInsect_C_Wings_5aa20d6e-e354-45c0-8433-a817674c7d98",
		"Creatures_Statue_A_Voidwoken_9001799c-26c1-4551-8bf2-17df0ca9f6c3",
		"Creatures_Statue_A_Voidwoken_B_6e948a1d-e0e4-4dcb-bb61-0392d79b6a10",
		"Creatures_VampireBat_A_42b7dd91-52e2-40c9-97a7-e38410626d9f",
		"Creatures_VampireBat_B_0fae6595-88c3-4e62-9ace-fc011a9bdbce",
		"Creatures_Voidwoken_Alan_A_Boss_8d10d59e-2060-43d9-8345-3222e3b3c424",
		"Creatures_Voidwoken_Caster_aa02c121-3200-44ce-a9e9-d22c46ac848e",
		"Creatures_Voidwoken_Caster_Ice_598c927b-7fb2-4244-a791-15668fefe715",
		"Creatures_Voidwoken_Caster_Ice_Summon_789d0350-680b-4f2b-8ee3-b69f4736e957",
		"Creatures_Voidwoken_Drillworm_A_Hatchling_ABC_1c1ca5fc-19c1-4a52-af88-8ee346d72cfe",
		"Creatures_Voidwoken_Drillworm_A_Hatchling_B_9b929973-72a8-4e06-9357-acfcf3278f5e",
		"Creatures_Voidwoken_GiantInsect_Dominator_A_187c09ee-edeb-4246-89bf-89aae0d77244",
		"Creatures_Voidwoken_Grunt_A_5c702815-5a42-43fd-83f8-f6a321803ebe",
		"Creatures_Voidwoken_Grunt_A_Ice_6ce20f23-6b29-4f3e-9b10-81e1d0a1e799",
		"Creatures_Voidwoken_Merman_A_b84112a6-b3b7-476b-b5cc-1c9c5deb1ba1",
		"Creatures_Voidwoken_Spider_A_e1e91da4-e8f7-41dc-9c1f-9ea77c5e62d8",
		"Creatures_Voidwoken_Spider_A_Poison_2a6e2e75-004a-489e-8a25-7edab7a22603",
		"Creatures_Voidwoken_Troll_A_e3727ad8-152c-4d2a-8c71-8093a5e68839",
		"Creatures_Voidwoken_Troll_A_Ice_b7ebea68-d4bf-4b8b-bace-f400f2448c94",
		"Quest_CoS_SeptaNemesis_Animals_Crab_A_Giant_a360f2c5-92e4-426e-8856-d42d7ec6467f",
		"LLENEMY_Creatures_Voidwoken_Drillworm_A_b24d5c4c-8a5a-4cd7-8518-f4684509be66",
		"LLENEMY_Creatures_Voidwoken_Drillworm_B_8713b59d-a564-4b90-910c-e5c6a384c0d9",
	}
}


function LLENEMY_Ext_GetExtraDataValue(key, fallback)
	local val = Ext.ExtraData[key]
	if val ~= nil then return val end
	return fallback
end

Ext.Require("Shared/LLENEMY_StatOverrides.lua")
Ext.Require("Shared/LLENEMY_VoiceData.lua")
Ext.Require("Shared/LLENEMY_SharedUpgradeInfo.lua")

function LLENEMY_Shared_InitModuleLoading()
	Ext.Print("LLENEMY_Shared.lua] Module is loading.")
	for key,fallback in pairs(EnemyUpgradeOverhaul.ExtraData) do
		local value = LLENEMY_Ext_GetExtraDataValue(key, fallback)
		EnemyUpgradeOverhaul.ExtraData[key] = value
		LeaderLib.Print("[LLENEMY_Shared.lua:LLENEMY_ModuleLoading] Loaded Data.txt key - [" .. tostring(key) .. "] = (" .. tostring(value) .. ")")
	end
end

local function LLENEMY_Shared_SessionLoading()
	Ext.Print("[LLENEMY:Bootstrap.lua] Session is loading.")
	if Ext.IsModLoaded("88d7c1d3-8de9-4494-be12-a8fcbc8171e9") then
		EnemyUpgradeOverhaul.SINGLEPLAYER = true
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

Ext.RegisterListener("SessionLoaded", LLENEMY_Shared_SessionLoaded)