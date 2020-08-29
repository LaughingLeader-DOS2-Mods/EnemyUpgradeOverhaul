local function ItemCorruptionTest(level,delay)
	local host = CharacterGetHostCharacter()
	local x,y,z = GetPosition(host)
	if level ~= nil then
		level = math.tointeger(tonumber(level))
	else
		level = CharacterGetLevel(host)
	end
	local backpack = CreateItemTemplateAtPosition("LOOT_LeaderLib_BackPack_Invisible_98fa7688-0810-4113-ba94-9a8c8463f830", x, y, z)
	--GenerateTreasure(backpack, "LLENEMY_ShadowOrbRewards", level, host)
	--GenerateTreasure(backpack, "ST_QuestReward_RG_3", level, host)
	--GenerateTreasure(backpack, "ST_LLENEMY_JustGloves", level, host)
	--GenerateTreasure(backpack, "ST_LLENEMY_ShadowTreasureWeaponsTest", level, host)
	GenerateTreasure(backpack, "CheatHeavyArmor", level, host)
	ShadowCorruptContainerItems(backpack)
	MoveAllItemsTo(backpack, host, 0, 0, 1)
	ItemRemove(backpack)
end

Ext.RegisterConsoleCommand("shadowitemtest", function(command,level,delaystr)
	local status,err = xpcall(function() 
		if delaystr ~= nil then
			local delay = tonumber(delaystr)
			if delay > 0 then
				LeaderLib.StartOneshotTimer("Timers_LLENEMY_Debug_ShadowItemTest", delay, function()
					ItemCorruptionTest(level, delay)
				end)
			else
				ItemCorruptionTest(level, delay)
			end
		else
			ItemCorruptionTest(level)
		end
	end, debug.traceback)
	if not status then
		print("[EUO:shadowitemtest] Error:")
		print(err)
	end
end)

Ext.RegisterConsoleCommand("goblintest", function(command)
	local combat = Osi.DB_CombatCharacters:Get(nil,nil)
	Ext.Print("[LLENEMY:Debug.lua] DB_CombatCharacters:\n[".. LeaderLib.Common.Dump(combat))
	local host = CharacterGetHostCharacter()
	local x,y,z = GetPosition(host)
	if combat ~= nil and #combat > 0 then
		local combatid = combat[1][2]
		if combatid ~= nil then
			--Osi.LLENEMY_TreasureGoblins_Spawn(combatid)
			--local x,y,z = GetPosition(combat[1][1])
			--Osi.LLENEMY_TreasureGoblins_Internal_Spawn(x, y, z, combatid)
			SpawnTreasureGoblin(x,y,z,CharacterGetLevel(host),combatid)
			LeaderLib.PrintDebug("Spawning treasure goblin at ", x, y, z)
		end
	else
		SpawnTreasureGoblin(x,y,z,CharacterGetLevel(host),0)
		LeaderLib.PrintDebug("Spawning treasure goblin at ", x, y, z)
	end
end)

Ext.RegisterConsoleCommand("shadoworb", function(command,movie)
	local host = CharacterGetHostCharacter()
	Osi.DB_LLENEMY_Rewards_Temp_TreasureToGenerate(host, "LLENEMY_ShadowOrbRewards")
	Osi.LLENEMY_Rewards_SpawnShadowOrb(host)
end)

Ext.RegisterConsoleCommand("refreshupgradeinfo", function(command)
	UpgradeInfo_SetHighestPartyLoremaster()
	UpgradeInfo_RefreshInfoStatuses()
end)

Ext.RegisterConsoleCommand("transformtest", function(command)
	local host = CharacterGetHostCharacter()
	local x,y,z = GetPosition(host)
	local dupe = CharacterCreateAtPosition(x, y, z, "Humans_Hero_Male_25611432-e5e4-482a-8f5d-196c9e90001e", 0)
	CharacterTransformFromCharacter(dupe, host, 1, 1, 1, 1, 1, 0, 0)
	local level = CharacterGetLevel(host)
	CharacterLevelUpTo(dupe, level)
end)

Ext.RegisterConsoleCommand("transformtest2", function(command)
	local host = CharacterGetHostCharacter()
	local x,y,z = GetPosition(host)
	local dupe = CharacterCreateAtPosition(x, y, z, "LLENEMY_Dupe_A_54ad4e06-b57f-46d0-90fc-5da1208250e0", 0)
	local dupe2 = CharacterCreateAtPosition(x, y, z, "LLENEMY_Dupe_A_54ad4e06-b57f-46d0-90fc-5da1208250e0", 0)
	local level = CharacterGetLevel(host)
	CharacterLevelUpTo(dupe, level)
	
	--Osi.LLENEMY_OnCharacterJoinedCombat(dupe, 0)
	CharacterTransformFromCharacter(dupe2, host, 1, 1, 1, 1, 1, 1, 1)
	LeaderLib.StartOneshotTimer("Timers_LLENEMY_Debug_TransformTest", 1250, function(...)
		CharacterTransformFromCharacter(dupe, host, 1, 1, 1, 1, 1, 1, 1)
		Osi.LLENEMY_OnCharacterJoinedCombat(dupe2, 0)
	end)
end)

Ext.RegisterConsoleCommand("euo_printrespentags", function(command)
	for damageType,_ in pairs(LeaderLib.Data.DamageTypeToResistance) do
		for i,entry in ipairs(LeaderLib.Data.ResistancePenetrationTags[damageType]) do
			print(string.format("%s = Classes.TagBoost:Create(\"%s\", \"\", false),", entry.Tag, entry.Tag))
		end
	end
end)

Ext.RegisterConsoleCommand("euo_tagtest", function(command,reset)
	local host = CharacterGetHostCharacter()
	for i,entry in pairs(ItemCorruption.TagBoosts) do
		if reset == nil then
			ObjectSetFlag(host, entry.Flag, 0)
			CharacterStatusText(host, entry.Flag .. " Set")
		else
			ObjectClearFlag(host, entry.Flag, 0)
			CharacterStatusText(host, entry.Flag .. " Cleared")
		end
	end
end)

Ext.RegisterConsoleCommand("euo_ringtest", function(command)
	local host = CharacterGetHostCharacter()
	local ring = GameHelpers.Item.CreateItemByStat("ARM_Ring", 12, "Epic", true, 1)
	SetTag(ring, "LLENEMY_ShadowItem")
	--SetTag(ring, ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_CursedFire.Tag)
	--SetTag(ring, ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_ShockingRain.Tag)
	SetTag(ring, ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_SlipperyRogue.Tag)
	SetTag(ring, ItemCorruption.TagBoosts.LLENEMY_ShadowBonus_DefensiveStart.Tag)
	ItemToInventory(ring, host)
	CharacterAddSkill(host, "Projectile_EnemyFireball", 0)
	CharacterAddAbilityPoint(host, 2)
	CharacterAddSkill(host, "Rain_Water", 0)
end)

Ext.RegisterConsoleCommand("enemytest1", function(cmd)
	print("[enemytest1] Spawning enemy")
	local status,err = xpcall(function()
		local host = CharacterGetHostCharacter()
		local x,y,z = GetPosition(host)
		local tx,ty,tz = FindValidPosition(x,y,z, 12.0, host)
		local template = GetTemplate(host)
		local enemy = TemporaryCharacterCreateAtPosition(tx,ty,tz, template, 0)
		CharacterAddSkill(enemy, "Projectile_EnemyFireball", 0)
		CharacterAddSkill(enemy, "Projectile_EnemyFlamingDaggers", 0)
		CharacterAddSkill(enemy, "Projectile_EnemyPyroclasticRock", 0)
		CharacterAddSkill(enemy, "Projectile_EnemyLightningBolt", 0)
		CharacterAddSkill(enemy, "Target_FirstAidEnemy", 0)
		CharacterAddSkill(enemy, "Target_EnemyElementalArrowheads", 0)
		CharacterAddSkill(enemy, "Target_EnemyMosquitoSwarm", 0)
		CharacterAddSkill(enemy, "Target_EnemyDecayingTouch", 0)
		CharacterAddSkill(enemy, "Target_EnemyFortify", 0)
		CharacterAddSkill(enemy, "Target_EnemyFrostyShell", 0)
		CharacterAddSkill(enemy, "Target_EnemyRestoration", 0)
		CharacterAddSkill(enemy, "Target_EnemyHaste", 0)
		CharacterAddSkill(enemy, "Target_EnemyTentacleLash", 0)
		CharacterAddSkill(enemy, "Shout_EnemyBullHorns", 0)
		SetFaction(enemy, "Evil NPC")
	end, debug.traceback)
	if not status then
		print(err)
	end
end)

local presets = {
	"Knight_Act2",
	"Rogue_Act2",
	"Wizard_Act2",
	"Battlemage_Act2",
	"Witch_Act2",
	"Enchanter_Act2",
}

Ext.RegisterConsoleCommand("enemytest2", function(cmd)
	local host = CharacterGetHostCharacter()
	local x,y,z = GetPosition(host)
	local tx,ty,tz = FindValidPosition(x,y,z, 20.0, host)
	local template = GetTemplate(host)
	local enemy = TemporaryCharacterCreateAtPosition(tx or x,ty or y,tz or z, template, 0)
	SetFaction(enemy, "Evil NPC")

	local preset = LeaderLib.Common.GetRandomTableEntry(presets)
	CharacterApplyPreset(enemy, preset)

	AddBonusSkills(enemy, "25", "5")
end)