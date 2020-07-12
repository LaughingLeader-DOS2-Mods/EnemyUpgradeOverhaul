function RollForCounterAttack(character,target)
	local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	local chance = (math.log(1 + initiative) / math.log(1 + ExtraData.LLENEMY_Counter_MaxChance))
	chance = math.floor(chance * ExtraData.LLENEMY_Counter_MaxChance) * 10
	local roll = LeaderLib.Common.GetRandom(999)
	LeaderLib.PrintDebug("Counter roll: " .. tostring(roll) .. " / " .. tostring(chance))
	if roll >= chance then
		CharacterAttack(character, target)
		CharacterStatusText(character, "LLENEMY_StatusText_CounterAttack")
	end
end

function AddTalent(character,talent)
	if Ext.Version() >= 40 then
		Osi.NRD_CharacterSetPermanentBoostTalent(character, talent, 1)
		CharacterAddAttribute(character, "Dummy", 0)
	end
end

---Increases rage
---@param character string
---@param damage integer
---@param handle integer
function IncreaseRage(character, damage, handle, source)
	--local hp = NRD_CharacterGetStatInt(character, "CurrentVitality")
	local maxhp = NRD_CharacterGetStatInt(character, "MaxVitality")
	local damage_ratio = math.max((damage / maxhp) * 88.88, 1.0)
	local add_rage = math.ceil(damage_ratio)
	Osi.LeaderLib_Variables_DB_ModifyVariableInt(character, "LLENEMY_Rage", add_rage, 100, 0, source);
	local rage_entry = Osi.DB_LeaderLib_Variables_Integer:Get(character, "LLENEMY_Rage", nil, nil)
	LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:IncreaseRage] Added ("..tostring(add_rage)..") Rage to ("..tostring(character).."). Total: ("..tostring(rage_entry[1][3])..")")
end

function MugTarget_Start(attacker, target, damage, handle)
	local hit_type = NRD_StatusGetInt(target, handle, "HitReason")
	if (hit_type == 0 or hit_type == 3) and LeaderLib.GameHelpers.HitSucceeded(target, handle, 0) then
		if Ext.IsDeveloperMode() then
			pcall(Mods.LeaderLib.Debug_TraceOnHit,target,attacker,damage,handle)
		end
		local weaponHandle = NRD_StatusGetGuidString(target, handle, "WeaponHandle")
		local hitWithWeapon = NRD_StatusGetInt(target, handle, "HitWithWeapon")
		local isMelee = hitWithWeapon == 1 or (weaponHandle ~= "NULL_00000000-0000-0000-0000-000000000000" and weaponHandle ~= nil)
		local skill = NRD_StatusGetString(target, handle, "SkillId")
		if skill ~= nil and skill ~= "" then
			skill = Mods.LeaderLib.GetSkillEntryName(skill) -- Actual skill name without the prototype level
			local skillIsMelee = Ext.StatGetAttribute(skill, "IsMelee")
			local requirement = Ext.StatGetAttribute(skill, "Requirement")
			if skillIsMelee == "Yes" or requirement == "MeleeWeapon" or requirement == "DaggerWeapon" or requirement == "StaffWeapon" then
				isMelee = true
			end
		elseif hitWithWeapon == 0 and CharacterGetEquippedWeapon(attacker) == nil then -- Unarmed attack?
			isMelee = true
		end
		if isMelee then
			--LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:MugTarget_Start] Hit type: " .. tostring(hit_type))
			LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:MugTarget_Start] ("..tostring(attacker)..") is mugging target: ", target)
			--LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:MugTarget_Start] Dodged: ",NRD_StatusGetInt(target, handle, "Dodged")," | Missed: ", NRD_StatusGetInt(target, handle, "Missed")," | Blocked: ",NRD_StatusGetInt(target, handle, "Blocked"))
			Osi.LLENEMY_Talents_MugTarget(attacker, target)
		end
	end
end

function MugTarget_StealGold(character, target)
	local gold = CharacterGetGold(target)
	LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:MugTarget_StealGold] Target ("..tostring(target)..") has ("..tostring(gold)..") gold.")
	if gold > 0 then
		local add_gold = math.tointeger(math.max(math.ceil(gold / 8), 1))
		local remove_gold = math.tointeger(add_gold * -1)
		CharacterAddGold(target, remove_gold)
		CharacterAddGold(character, add_gold)
		--CharacterDisplayTextWithParam(target, "LLENEMY_DisplayText_MuggedGold_Target", add_gold);
		CharacterDisplayTextWithParam(character, "LLENEMY_DisplayText_MuggedGold_Enemy", add_gold);
		return add_gold
	end
	return 0
end

function MugTarget_End(character, target)
	local items = Osi.DB_LLENEMY_Talents_Temp_MasterThief_Items:Get(target, nil, nil)
	LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:MugTarget_End] Picking items from:\n",LeaderLib.Common.Dump(items))
	local item_entry = LeaderLib.Common.GetRandomTableEntry(items)	
	if item_entry ~= nil then
		local item = item_entry[3]
		LeaderLib.PrintDebug("[LLENEMY_GameMechanics.lua:MugTarget_End] Transfering (",item,") from (",target,") to (",character,").")
		ItemToInventory(item, character, 1, CharacterIsPlayer(character), 0)
		Osi.LLENEMY_Talents_OnTargetMugged(character, target, item, 1)
		MugTarget_DisplayText(character, target, item, 1)
	end
	Osi.LLENEMY_Talents_Internal_Mug_ClearData(target)
end

function MugTarget_DisplayText(character, target, item, amount)
	local lost_gold = MugTarget_StealGold(character, target)
	local template = GetTemplate(item)
	local handle,name = ItemTemplateGetDisplayString(template)
	local text = ""
	if amount > 1 then
		text = "<font color='#FF3333' size='23'><font color='#FE6E27' size='26'>"..tostring(name).."</font> x"..tostring(amount).." was stolen!</font>"
	else
		text = "<font color='#FF3333' size='23'><font color='#FE6E27' size='26'>"..tostring(name).."</font> was stolen!</font>"
	end
	CharacterStatusText(target, text)
	if lost_gold > 0 then CharacterStatusText(target, "<font color='#ffbd30' size='23'>Lost "..tostring(lost_gold).." Gold!</font>") end
end
--Ext.NewCall(MugTarget_DisplayText, "LLENEMY_Ext_MugTarget_DisplayText", "(CHARACTERGUID)_Enemy, (CHARACTERGUID)_Target, (ITEMGUID)_Item, (INTEGER)_Amount")

function RemoveInvisible(target, source)
	local detected = false
	for status,b in pairs(InvisibleStatuses) do
		if b == true and HasActiveStatus(target, status) == 1 then
			RemoveStatus(target, status)
			detected = true
		end
	end
	if detected then
		CharacterStatusText(target, "LLENEMY_StatusText_SeekerDiscoveredTarget")
		PlayEffect(source, "RS3_FX_GP_Status_Warning_Red_01", "Dummy_OverheadFX")
		Osi.CharacterSawSneakingCharacter(source, target)
	end
	return detected
end

function CharacterIsHidden(target, source)
	for status,b in pairs(InvisibleStatuses) do
		if b == true and HasActiveStatus(target, status) == 1 then
			return 1
		end
	end
	return 0
end

Ext.NewQuery(CharacterIsHidden, "LLENEMY_Ext_QRY_CharacterIsHidden", "[in](CHARACTERGUID)_Character, [out](INTEGER)_IsHidden")

function ClearGain(char)
	--ScaleExperienceByPlayerLevel_d5e1b4bc-dc7b-43dc-8bd0-d9f2b5e3a418
	if Ext.IsModLoaded("d5e1b4bc-dc7b-43dc-8bd0-d9f2b5e3a418") then
		SetTag(char, "LLXPSCALE_DisableDeathExperience")
	end
	NRD_CharacterSetPermanentBoostInt(char, "Gain", 0)
	CharacterAddAttribute(char, "Dummy", 0)

	local gain = NRD_CharacterGetPermanentBoostInt(char, "Gain")
	print(char, "gain:", gain)
end

function HM_RollAdditionalUpgrades(char)
	local bonusRolls = Ext.Random(1,3) + 1
	for i=bonusRolls,0,-1 do
		Osi.LLENEMY_Upgrades_RollForUpgrades(char)
		--Ext.Print("Rolling bonus roll: " .. tostring(i) .. " | " .. char)
	end
end

function SpawnTreasureGoblin(x,y,z,level,combatid)
	local host = CharacterGetHostCharacter()
	if level == nil then
		level = CharacterGetLevel(host)
	end
	if x == nil or y == nil or z == nil then
		x,y,z = GetPosition(host)
	end
	if combatid == nil then
		combatid = 0
	end
	local goblin = CharacterCreateAtPosition(x, y, z, "444e50a0-e59b-4866-b548-49a0197a0de1", 1)
	CharacterLevelUpTo(goblin, level)
	Osi.DB_LLENEMY_TreasureGoblins_Temp_Active(goblin)
	--SetStoryEvent(goblin, "LeaderLib_Commands_EnterCombatWithPlayers")
	Osi.LLENEMY_TreasureGoblins_Internal_OnGoblinSpawned(goblin, combatid, x, y, z)
	Osi.LLENEMY_Rewards_TreasureGoblin_ToggleScript(1)
	Osi.LeaderLib_Helper_MakeHostileToPlayers(goblin)
	Osi.LeaderLib_Timers_StartObjectTimer(goblin, 1000, "Timers_LLENEMY_Goblin_EnterCombatWithPlayers", "LeaderLib_Commands_EnterCombatWithPlayers")
end

local loneWolfAbilities = {
	"WarriorLore",
	"RangerLore",
	"RogueLore",
	--"SingleHanded",
	--"TwoHanded",
	--"Reflection",
	--"Ranged",
	--"Shield",
	--"Reflexes",
	--"PhysicalArmorMastery",
	--"Sourcery",
	--"Telekinesis",
	"FireSpecialist",
	"WaterSpecialist",
	"AirSpecialist",
	"EarthSpecialist",
	"Necromancy",
	"Summoning",
	--"Polymorph",
	--"Repair",
	--"Sneaking",
	--"Pickpocket",
	--"Thievery",
	--"Loremaster",
	--"Crafting",
	--"Barter",
	--"Charm",
	--"Intimidate",
	--"Reason",
	--"Persuasion",
	--"Leadership",
	--"Luck",
	--"DualWielding",
	--"Wand",
	--"MagicArmorMastery",
	--"VitalityMastery",
	--"Perseverance",
	--"Runecrafting",
	--"Brewmaster",
}

function ApplyLoneWolfBonuses(uuid)
	for _,stat in LeaderLib.Data.Attribute:Get() do
		local baseVal = CharacterGetBaseAttribute(uuid, stat)
		local currentVal = CharacterGetAttribute(uuid, stat)
		if currentVal < Ext.ExtraData.AttributeSoftCap then
			local nextVal = math.min(Ext.ExtraData.AttributeSoftCap, baseVal * 2) -- Capped at 40
			nextVal = nextVal - baseVal
			if nextVal > 0 then
				CharacterAddAttribute(uuid, stat, nextVal);
				LeaderLib.PrintDebug("[LLENEMY_GameMechanics:ApplyLoneWolfBonuses] ("..uuid..") ["..stat.."]["..tostring(currentVal).."] => ["..tostring(currentVal+nextVal).."] Bonus("..tostring(nextVal)..")")
			end
		end
	end
	for _,stat in pairs(loneWolfAbilities) do
		local baseVal = CharacterGetBaseAbility(uuid, stat)
		local currentVal = CharacterGetAbility(uuid, stat)
		if currentVal < Ext.ExtraData.CombatAbilityCap then
			local nextVal = math.min(Ext.ExtraData.CombatAbilityCap, baseVal * 2) -- Capped at 10
			nextVal = nextVal - baseVal
			if nextVal > 0 then
				CharacterAddAbility(uuid, stat, nextVal);
				LeaderLib.PrintDebug("[LLENEMY_GameMechanics:ApplyLoneWolfBonuses] ("..uuid..") ["..stat.."]["..tostring(currentVal).."] => ["..tostring(currentVal+nextVal).."] Bonus("..tostring(nextVal)..")")
			end
		end
	end
end

local diggingLastFightMode = {}

function DigGrave_StartDigging(char)
	Osi.LeaderLib_Helper_ClearActionQueue(char)

	diggingLastFightMode[char] = CharacterIsInFightMode(char)
	
	local isLizard = IsTagged(char, "LIZARD") == 1

	if not isLizard then
		PlayAnimation(char,"use_dig_noshovel","LLENEMY_DigGrave_OnDiggingDone")
		CharacterSetFightMode(char,1,0)
	else
		PlayAnimation(char,"use_dig","LLENEMY_DigGrave_OnDiggingDone")
		CharacterSetFightMode(char,0,1)
	end
end

function DigGrave_OnDiggingDone(char, target)
	local diggingLastFightMode = diggingLastFightMode[char]
	if diggingLastFightMode == 1 then
		CharacterSetFightMode(char,1,0)
	end
	diggingLastFightMode[char] = nil
	local region = GetRegion(char)

	local isBurialMound = IsTagged(target, "LLENEMY_BurialMound") == 1
	if not isBurialMound then
		if IsTagged(target, "LLENEMY_Buried") == 0 then
			local x,y,z = GetPosition(target)
			--PUZ_SandWhitepile_A_fa197087-94d6-4d0f-adec-b4a350c023b1
			--LLENEMY_Dirtpile_A_88f7fe8f-24d8-4e48-b449-f7179ca59709
			local dirtMound = CreateItemTemplateAtPosition("88f7fe8f-24d8-4e48-b449-f7179ca59709", x, y, z)
			SetTag(target, "BLOCK_RESURRECTION")
			SetTag(target, "LLENEMY_Buried")
			SetVisible(target, 0)
			DB_LLENEMY_Skills_Temp_DigGraveMound(region, char, target, dirtMound)
			Osi.LLENEMY_Skills_DigGrave_SaveDirtMound(region, char, target, dirtMound)
			Osi.LLENEMY_Skills_DigGrave_OnBuried(char, target)
		else
			SetStoryEvent(target, "LLENEMY_DigGrave_ReleaseTarget")
		end
	else
		local entry = Osi.DB_LLENEMY_Skills_Temp_DigGraveMound:Get(region, nil, nil, target)
		if entry ~= nil and #entry > 0 then
			local buriedTarget = entry[1][3]
			SetStoryEvent(buriedTarget, "LLENEMY_DigGrave_ReleaseTarget")
		end
	end
end

function DigGrave_OnDirtPileUsed(char, dirtMound)
	if IsTagged(char, "LIZARD") == 1 then
		diggingLastFightMode[char] = CharacterIsInFightMode(char)
		PlayAnimation(char,"use_dig","LLENEMY_DigGrave_OnDiggingDone")
		CharacterSetFightMode(char,0,1)
	else
		if equippedShovelWeapon then
			diggingLastFightMode[char] = CharacterIsInFightMode(char)
			PlayAnimation(char,"use_dig_noshovel","LLENEMY_DigGrave_OnDiggingDone")
			CharacterSetFightMode(char,1,0)
		else
			diggingLastFightMode[char] = CharacterIsInFightMode(char)
			PlayAnimation(char,"use_dig","LLENEMY_DigGrave_OnDiggingDone")
			CharacterSetFightMode(char,0,1)
		end
	end
end

local function DigGrave_GrantBonusLoot(char)
	PlayEffect(char, "RS3_FX_GP_ScriptedEvent_Lucky_01", "Dummy_OverheadFX")
	local min = math.floor(Ext.ExtraData["LLENEMY_Treasure_DigGrave_BonusLootMinDrop"] or 1)
	local max = math.max(Ext.ExtraData["LLENEMY_Treasure_DigGrave_BonusLootMaxDrop"] or 2)
	local amount = Ext.Random(min,max)
	for i=amount,1,-1 do
		CharacterGiveReward(char, "LLENEMY_DigGraveBonusLoot", 1)
		--CharacterGiveReward(CharacterGetHostCharacter(), "ST_RingAmuletBeltRare", 0)
	end
end

function DigGrave_RollForBonusLoot(char, target)
	local chance = math.floor(Ext.ExtraData["LLENEMY_Treasure_DigGrave_BonusLootChance"] or 30)
	local roll = Ext.Random(1,100)
	if roll <= chance then
		DigGrave_GrantBonusLoot(char)
	else
		local luckMult = math.floor(Ext.ExtraData["LLENEMY_Treasure_DigGrave_BonusPerLuck"] or 2)
		local highestLuck = 0
		local sharedLuckFrom = nil
		for i,entry in pairs(Osi.DB_IsPlayer:Get(nil)) do
			local luck = CharacterGetAbility(entry[1], "Luck")
			if luck > highestLuck then
				highestLuck = luck
				sharedLuckFrom = GetUUID(entry[1])
			end
		end
		
		if highestLuck > 0 then
			if roll <= chance + (luckMult * highestLuck) then
				if CharacterIsPlayer(char) == 1 and CharacterIsControlled(char) == 1 then
					if sharedLuckFrom ~= char then
						local text,textHandle = Ext.GetTranslatedStringFromKey("LLENEMY_Notification_DigGrave_BonusLoot_SharedLuckBonus")
						local nameHandle,ref = CharacterGetDisplayName(sharedLuckFrom)
						local name = Ext.GetTranslatedString(nameHandle, ref)
						text = text:gsub("%[1%]", name)
						ShowNotification(char, text)
					else
						local text,textHandle = Ext.GetTranslatedStringFromKey("LLENEMY_Notification_DigGrave_BonusLoot_LuckBonus")
						ShowNotification(char, text)
					end
				end
				DigGrave_GrantBonusLoot(char)
			end
		end
	end
end