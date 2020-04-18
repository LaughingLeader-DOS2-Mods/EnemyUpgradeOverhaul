Ext.Require("Shared/LLENEMY_Shared.lua")

Ext.Require("Server/LLENEMY_UpgradeInfo.lua")
Ext.Require("Server/LLENEMY_BonusSkills.lua")
Ext.Require("Server/LLENEMY_GameMechanics.lua")
Ext.Require("Server/LLENEMY_ItemMechanics.lua")
Ext.Require("Server/LLENEMY_ItemCorruption.lua")
Ext.Require("Server/LLENEMY_TreasureGoblins.lua")
Ext.Require("Server/LLENEMY_VoidwokenSpawning.lua")
Ext.Require("Server/LLENEMY_ServerMessages.lua")
Ext.Require("Server/LLENEMY_Debug.lua")

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
local function LLENEMY_Server_SessionLoading()
	local ItemBoost = LeaderLib.Classes["ItemBoost"]
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("LLENEMY_Boost_Weapon_Damage_Shadow_Small"))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("LLENEMY_Boost_Weapon_Damage_Shadow_Medium", {MinLevel=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("LLENEMY_Boost_Weapon_Damage_Shadow_Large", {MinLevel=12}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("Boost_Weapon_Secondary_Vitality_Small", {Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("Boost_Weapon_Secondary_Vitality_Normal", {MinLevel=6, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("Boost_Weapon_Status_Set_Suffocating", {MinLevel=13, Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("Boost_Weapon_LifeSteal", {Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, ItemBoost:Create("Boost_Weapon_LifeSteal_Large", {MinLevel=12, Chance=50}))

	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage"))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage_Medium", {MinLevel=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage_Large", {MinLevel=12}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Secondary_ChillContact", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Secondary_PoisonContact", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Secondary_BurnContact", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Secondary_PainReflection", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Special_Block_Shield", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Special_Block_Shield_Medium", {MinLevel=8, Chance=20}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, ItemBoost:Create("Boost_Shield_Special_Block_Shield_Large", {MinLevel=12, Chance=15}))

	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_Ability_Sneaking", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_Ability_Sneaking_Medium", {MinLevel=8, Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_Ability_Sneaking_Large", {MinLevel=12, Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_Ability_Lockpicking", {Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_Ability_Lockpicking_Medium", {MinLevel=8, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_Ability_Lockpicking_Large", {MinLevel=12, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_PhysicalResistance", {Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_PhysicalResistance_Medium", {MinLevel=8, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("LLENEMY_Boost_Armor_PhysicalResistance_Large", {MinLevel=12, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Ability_Death", {Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Ability_Death_Medium", {MinLevel=8, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Ability_Death_Large", {MinLevel=12, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Skill_BloodBubble", {Chance=20}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Immunity_Frozen_And_Chilled", {Chance=5}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Immunity_KnockedDown_And_Crippled", {Chance=5}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, ItemBoost:Create("Boost_Armor_Pants_Crafting_Special_Ataraxian", {MinLevel=16, Chance=10}))

	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("Small"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("Normal"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("Large"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("Base"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("BaseUncommon"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("RuneEmpty", MinLevel=4})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("BaseRare", MinLevel=6})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("Primary", MinLevel=8})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, ItemBoost:Create("Legendary", MinLevel=16})

	LeaderLib.Print("[LLENEMY_ItemCorruption.lua] Boosts:\n" .. LeaderLib.Common.Dump(EnemyUpgradeOverhaul.CorruptionBoosts))
end
Ext.RegisterListener("SessionLoading", LLENEMY_Server_SessionLoading)