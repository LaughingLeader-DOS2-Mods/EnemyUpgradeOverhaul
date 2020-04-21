
-- DeltaMods

local DeltaMod = LeaderLib.Classes["DeltaMod"]
local DeltaModGroup = LeaderLib.Classes["DeltaModGroup"]

local ModBoosts = {
	--Greed - Increased Loot Variety
	["d1ba8097-dba1-d74b-7efe-8fca3ef71fe5"] = {
		Weapon = {
			DeltaModGroup:Create({
				DeltaMod:Create("Boost_Weapon_Status_Set_Deaf", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_BloodAbsorb", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Vampirism", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_DeathWish", {Chance=5}),
				DeltaMod:Create("Boost_Weapon_Status_Set_VacuumAura", {Chance=5}),
				DeltaMod:Create("Boost_Weapon_Status_Set_ChilledAura", {Chance=5}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Madness", {Chance=1}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Marked", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Cursed", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Entangled", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Remorse", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Sleeping", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Status_Set_Dazed", {Chance=20}),
			}),
			DeltaModGroup:Create({
				DeltaMod:Create("CursedSpeed_WeaponBoost", {Chance=15}),
				DeltaMod:Create("Whiplash_WeaponBoost", {Chance=15}),
				DeltaMod:Create("Decaying_WeaponBoost", {Chance=15}),
				DeltaMod:Create("UnluckyDice_WeaponBoost", {Chance=5}),
			}),
			--DeltaMod:Create("ArmorDamage_WeaponBoost", {Chance=10}),
			DeltaModGroup:Create({
				DeltaMod:Create("WeaponBoost_HeavyWeaponS", {Chance=1}),
				DeltaMod:Create("WeaponBoost_HeavyWeaponA", {Chance=5}),
				DeltaMod:Create("WeaponBoost_HeavyWeaponC", {Chance=10}),
			}),
			DeltaModGroup:Create({
				DeltaMod:Create("Boost_Weapon_Status_Set_FarSightBow", {Chance=10, WeaponType="Bow"}),
				DeltaMod:Create("Boost_Weapon_Status_Set_FarSightXBow", {Chance=10, WeaponType="Crossbow"})
			})
		},
		Armor = {
			DeltaMod:Create("ArmorBoost_APMaximum", {Chance=5}),
			DeltaMod:Create("ArmorBoost_APStart", {Chance=5}),
			DeltaMod:Create("Chest_StatVariety", {Chance=2}),
			DeltaMod:Create("Ring_Item_AddStatus_Infect_Bleeding", {Chance=2}),
			DeltaModGroup:Create({
				DeltaMod:Create("Gloves_APRecovery_BreathingBubble", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_ShockingTouch", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_FreezingTouch", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_Soulmate", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_DecayingTouch", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_ChickenTouch", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_Infect", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_Infect", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_ThrowDust", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_Barrage", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_PinDown", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_ThrowingKnife", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_CorruptingBlade", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_SawtoothKnife", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_Vault", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_BlinkStrike", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_BallisticShot", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_RainBlood", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_Bullrush", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_MedusaHead", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_SmokeCover", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_DeathsDoor", {Chance=2}),
				DeltaMod:Create("Gloves_APRecovery_MosquitoSwarm", {Chance=2}),
			}, {SlotType="Gloves"}),
			DeltaModGroup:Create({
				DeltaMod:Create("Boots_OnTurn_BloodBubble", {Chance=2}),
				DeltaMod:Create("Boots_CombatStart_ThickOfTheFight", {Chance=2}),
				DeltaMod:Create("Boots_CombatStart_SmokeCover", {Chance=2}),
			}, {SlotType="Boots"}),
			DeltaModGroup:Create({
				DeltaMod:Create("Gloves_AcidicAttacks", {Chance=2}),
				DeltaMod:Create("Gloves_SuffocatingAttacks", {Chance=2}),
				DeltaMod:Create("Gloves_DisarmingAttacks", {Chance=2}),
				DeltaMod:Create("Gloves_DazingAttacks", {Chance=2}),
				DeltaMod:Create("Gloves_BleedingAttacks", {Chance=2}),
				DeltaMod:Create("Gloves_MutingAttacks", {Chance=2}),
				DeltaMod:Create("Gloves_ShacklingAttacks", {Chance=2}),
			}, {SlotType="Gloves"})
		},
		Shield = {
			DeltaModGroup:Create({
				DeltaMod:Create("WeaponBoost_Bash", {Chance=6}),
				DeltaMod:Create("WeaponBoost_Defend", {Chance=6}),
				DeltaMod:Create("WeaponBoost_DefensiveRush", {Chance=6}),
				DeltaMod:Create("WeaponBoost_AllySwap", {Chance=6}),
				DeltaMod:Create("WeaponBoost_EqualizeAllies", {Chance=3}),
				DeltaMod:Create("WeaponBoost_BatteringRam", {Chance=10}),
			}),
			DeltaModGroup:Create({
				DeltaMod:Create("MendingShield", {Chance=1}),
				DeltaMod:Create("ShacklingShield", {Chance=1}),
				DeltaMod:Create("GuardianShield", {Chance=1}),
				DeltaMod:Create("SoulmateShield", {Chance=1}),
			})
		}
	},
	--Crafting Overhaul
	["6aaa43a9-3a72-e82e-a6f6-8c367fd82117"] = {
		Weapon = {
			DeltaModGroup:Create({
				DeltaMod:Create("Boost_Weapon_Status_Set_Crippled_Mace", {Chance=20}),
				DeltaMod:Create("Boost_Weapon_Chilled_TwoHanded", {Chance=20})
			}),
			--DeltaMod:Create("Boost_Weapon_Damage_Magic_Weapon", {Chance=1}),
			DeltaModGroup:Create({
				DeltaMod:Create("Boost_Weapon_Skill_Staff_DimensionalBolt", {Chance=10}),
				DeltaMod:Create("Boost_Weapon_Skill_BlitzAttack_Axe", {Chance=10}),
				DeltaMod:Create("Boost_Weapon_Skill_CriplingBlow_Sword", {Chance=10}),
				DeltaMod:Create("Boost_Weapon_Skill_Silence_Wand", {Chance=10}),
			})
		},
		Armor = {
			DeltaMod:Create("Boost_Armor_Gloves_CritChance", {Chance=15}),
			DeltaMod:Create("Boost_Armor_Pants_Initiative", {Chance=15}),
			DeltaMod:Create("Boost_Armor_Boots_Dodge", {Chance=15}),
			DeltaMod:Create("Boost_Armor_MagicalArmourAll", {Chance=5}),
			DeltaModGroup:Create({
				DeltaMod:Create("Boost_Armor_Pants_Skill_Adrenaline", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Gloves_Skill_Provoke", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Gloves_Skill_Teleportation", {Chance=2}),
				DeltaMod:Create("Boost_Armor_UpperBody_Skill_ChameleonSkin", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Skill_MagisterObedience", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Skill_PaladinCourage", {Chance=2}),
			}),
			DeltaModGroup:Create({
				DeltaMod:Create("Boost_Armor_Helmet_Immunity_Charm", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Helmet_Immunity_Fear", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Helmet_Immunity_Mute", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Helmet_Immunity_Blind", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Helmet_Immunity_Taunt", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Upperbody_Immunity_Freeze", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Upperbody_Immunity_Stun", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Upperbody_Immunity_Sleeping", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Upperbody_Immunity_Petrified", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Boots_Immunity_Slowed", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Boots_Immunity_Crippled", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Boots_Immunity_Warm", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Boots_Immunity_Wet", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Boots_Immunity_Teleport", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Pants_Immunity_Chill", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Pants_Immunity_Burn", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Pants_Immunity_Poison", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Pants_Immunity_Bleeding", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Gloves_Immunity_Suffocating", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Gloves_Immunity_Madness", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Gloves_Immunity_Cursed", {Chance=2}),
				DeltaMod:Create("Boost_Armor_Gloves_Immunity_Chicken", {Chance=2}),
			}),
		},
		Shield = {
			DeltaMod:Create("Boost_Shield_Special_Block_Shield_Small", {Chance=5}),
		}
	}
}

local function GetDefaultDeltamods()
	--local deltamods = Ext.GetStatEntries("DeltaModifier")
	--Ext.Print("Deltamods:\n" .. LeaderLib.Common.Dump(deltamods))
end

function LLENEMY_Server_RegisterCorruptionBoosts_DeltaMods()
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("LLENEMY_Boost_Weapon_Damage_Shadow_Small"))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("LLENEMY_Boost_Weapon_Damage_Shadow_Medium", {MinLevel=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("LLENEMY_Boost_Weapon_Damage_Shadow_Large", {MinLevel=12}))
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("Boost_Weapon_Secondary_Vitality_Small", {Chance=50}))
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("Boost_Weapon_Secondary_Vitality_Normal", {MinLevel=6, Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("Boost_Weapon_Status_Set_Suffocating", {MinLevel=13, Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("Boost_Weapon_LifeSteal", {Chance=50}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Weapon, DeltaMod:Create("Boost_Weapon_LifeSteal_Large", {MinLevel=12, Chance=50}))

	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage"))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage_Medium", {MinLevel=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("LLENEMY_Boost_Shield_Reflect_As_Shadow_Damage_Large", {MinLevel=12}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaModGroup:Create({
		DeltaMod:Create("Boost_Shield_Secondary_ChillContact", {Chance=25}),
		DeltaMod:Create("Boost_Shield_Secondary_PoisonContact", {Chance=25}),
		DeltaMod:Create("Boost_Shield_Secondary_BurnContact", {Chance=25}),
	}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("Boost_Shield_Secondary_PainReflection", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("Boost_Shield_Special_Block_Shield", {Chance=25}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("Boost_Shield_Special_Block_Shield_Medium", {MinLevel=8, Chance=20}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Shield, DeltaMod:Create("Boost_Shield_Special_Block_Shield_Large", {MinLevel=12, Chance=15}))

	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_Ability_Sneaking", {Chance=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_Ability_Sneaking_Medium", {MinLevel=8, Chance=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_Ability_Sneaking_Large", {MinLevel=12, Chance=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_Ability_Lockpicking", {Chance=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_Ability_Lockpicking_Medium", {MinLevel=8, Chance=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_Ability_Lockpicking_Large", {MinLevel=12, Chance=8}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_PhysicalResistance", {Chance=5}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_PhysicalResistance_Medium", {MinLevel=8, Chance=5}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("LLENEMY_Boost_Armor_PhysicalResistance_Large", {MinLevel=12, Chance=5}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("Boost_Armor_Pants_Ability_Death", {Chance=15}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("Boost_Armor_Pants_Ability_Death_Medium", {MinLevel=8, Chance=15}))
	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaMod:Create("Boost_Armor_Pants_Ability_Death_Large", {MinLevel=12, Chance=15}))

	table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.Armor, DeltaModGroup:Create({
		DeltaMod:Create("Boost_Armor_Pants_Skill_BloodBubble", {Chance=20}),
		DeltaMod:Create("Boost_Armor_Pants_Immunity_Frozen_And_Chilled", {Chance=5}),
		DeltaMod:Create("Boost_Armor_Pants_Immunity_KnockedDown_And_Crippled", {Chance=5}),
		DeltaMod:Create("Boost_Armor_Pants_Crafting_Special_Ataraxian", {MinLevel=16, Chance=10})
	}))

	for uuid,tbl in pairs(ModBoosts) do
		if Ext.IsModLoaded(uuid) then
			for tableName,entries in pairs(tbl) do
				if EnemyUpgradeOverhaul.CorruptionBoosts[tableName] ~= nil then
					LeaderLib.Print("[LLENEMY_ItemCorruptionDeltamods.lua] Merging entries from ("..uuid..") into main table ("..tableName..")")
					for i,entry in ipairs(entries) do
						table.insert(EnemyUpgradeOverhaul.CorruptionBoosts[tableName], entry)
					end
				end
			end
		else
			LeaderLib.Print("[LLENEMY_ItemCorruptionDeltamods.lua] Mod ("..uuid..") is not active. Skipping deltamod registration.")
		end
	end

	if Ext.IsDeveloperMode() and Ext.Version() >= 44 then
		GetDefaultDeltamods()
	end

	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("Small"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("Normal"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("Large"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("Base"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("BaseUncommon"})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("RuneEmpty", MinLevel=4})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("BaseRare", MinLevel=6})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("Primary", MinLevel=8})
	--table.insert(EnemyUpgradeOverhaul.CorruptionBoosts.All, DeltaMod:Create("Legendary", MinLevel=16})

	LeaderLib.Print("[LLENEMY_ItemCorruptionDeltamods.lua] Boosts:\n" .. LeaderLib.Common.Dump(EnemyUpgradeOverhaul.CorruptionBoosts))
end