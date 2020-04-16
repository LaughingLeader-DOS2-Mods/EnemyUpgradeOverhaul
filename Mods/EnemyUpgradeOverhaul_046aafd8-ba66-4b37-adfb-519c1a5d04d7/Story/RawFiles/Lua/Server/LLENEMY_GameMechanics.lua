function LLENEMY_Ext_RollForCounterAttack(character,target)
	local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	local chance = (math.log(1 + initiative) / math.log(1 + EnemyUpgradeOverhaul.ExtraData.LLENEMY_Counter_MaxChance))
	chance = math.floor(chance * EnemyUpgradeOverhaul.ExtraData.LLENEMY_Counter_MaxChance) * 10
	local roll = LeaderLib.Common.GetRandom(999)
	LeaderLib.Print("Counter roll: " .. tostring(roll) .. " / " .. tostring(chance))
	if roll >= chance then
		CharacterAttack(character, target)
		CharacterStatusText(character, "LLENEMY_StatusText_CounterAttack")
	end
end

function LLENEMY_Ext_AddTalent(character,talent)
	if Ext.Version() >= 40 then
		Osi.NRD_CharacterSetPermanentBoostTalent(character, talent, 1)
		CharacterAddAttribute(character, "Dummy", 0)
	end
end

---Increases rage
---@param character string
---@param damage integer
---@param handle integer
function LLENEMY_Ext_IncreaseRage(character, damage, handle, source)
	--local hp = NRD_CharacterGetStatInt(character, "CurrentVitality")
	local maxhp = NRD_CharacterGetStatInt(character, "MaxVitality")
	local damage_ratio = math.max((damage / maxhp) * 88.88, 1.0)
	local add_rage = math.ceil(damage_ratio)
	Osi.LeaderLib_Variables_DB_ModifyVariableInt(character, "LLENEMY_Rage", add_rage, 100, 0, source);
	local rage_entry = Osi.DB_LeaderLib_Variables_Integer:Get(character, "LLENEMY_Rage", nil, nil)
	LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_IncreaseRage] Added ("..tostring(add_rage)..") Rage to ("..tostring(character).."). Total: ("..tostring(rage_entry[1][3])..")")
end

function LLENEMY_Ext_MugTarget_Start(attacker, target, damage, handle)
	local hit_type = NRD_StatusGetInt(target, handle, "HitReason")
	if (hit_type == 0 or hit_type == 3) and LeaderLib.Game.HitSucceeded(target, handle, 0) then
		if Ext.IsDeveloperMode() then
			pcall(LeaderLib_Ext_Debug_TraceOnHit,target,attacker,damage,handle)
		end
		local weaponHandle = NRD_StatusGetGuidString(target, handle, "WeaponHandle")
		local hitWithWeapon = NRD_StatusGetInt(target, handle, "HitWithWeapon")
		local isMelee = hitWithWeapon == 1 or (weaponHandle ~= "NULL_00000000-0000-0000-0000-000000000000" and weaponHandle ~= nil)
		local skill = NRD_StatusGetString(target, handle, "SkillId")
		if skill ~= nil and skill ~= "" then
			skill = LeaderLib_Ext_GetSkillEntryName(skill) -- Actual skill name without the prototype level
			local skillIsMelee = Ext.StatGetAttribute(skill, "IsMelee")
			local requirement = Ext.StatGetAttribute(skill, "Requirement")
			if skillIsMelee == "Yes" or requirement == "MeleeWeapon" or requirement == "DaggerWeapon" or requirement == "StaffWeapon" then
				isMelee = true
			end
		elseif hitWithWeapon == 0 and CharacterGetEquippedWeapon(attacker) == nil then -- Unarmed attack?
			isMelee = true
		end
		if isMelee then
			--LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_Start] Hit type: " .. tostring(hit_type))
			LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_Start] ("..tostring(attacker)..") is mugging target: ", target)
			--LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_Start] Dodged: ",NRD_StatusGetInt(target, handle, "Dodged")," | Missed: ", NRD_StatusGetInt(target, handle, "Missed")," | Blocked: ",NRD_StatusGetInt(target, handle, "Blocked"))
			Osi.LLENEMY_Talents_MugTarget(attacker, target)
		end
	end
end

function LLENEMY_Ext_MugTarget_StealGold(character, target)
	local gold = CharacterGetGold(target)
	LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_StealGold] Target ("..tostring(target)..") has ("..tostring(gold)..") gold.")
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

function LLENEMY_Ext_MugTarget_End(character, target)
	local items = Osi.DB_LLENEMY_Talents_Temp_MasterThief_Items:Get(target, nil, nil)
	LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_End] Picking items from:\n",LeaderLib.Common.Dump(items))
	local item_entry = LeaderLib.Common.GetRandomTableEntry(items)	
	if item_entry ~= nil then
		local item = item_entry[3]
		LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_End] Transfering (",item,") from (",target,") to (",character,").")
		ItemToInventory(item, character, 1, CharacterIsPlayer(character), 0)
		Osi.LLENEMY_Talents_OnTargetMugged(character, target, item, 1)
		LLENEMY_Ext_MugTarget_DisplayText(character, target, item, 1)
	end
	Osi.LLENEMY_Talents_Internal_Mug_ClearData(target)
end

function LLENEMY_Ext_MugTarget_DisplayText(character, target, item, amount)
	local lost_gold = LLENEMY_Ext_MugTarget_StealGold(character, target)
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
--Ext.NewCall(LLENEMY_Ext_MugTarget_DisplayText, "LLENEMY_Ext_MugTarget_DisplayText", "(CHARACTERGUID)_Enemy, (CHARACTERGUID)_Target, (ITEMGUID)_Item, (INTEGER)_Amount")

function LLENEMY_Ext_RemoveInvisible(target, source)
	local detected = false
	for status,b in pairs(EnemyUpgradeOverhaul.InvisibleStatuses) do
		if b == true and HasActiveStatus(target, status) == 1 then
			RemoveStatus(target, status)
			detected = true
		end
	end
	if detected then
		CharacterStatusText(target, "LLENEMY_StatusText_SeekerDiscoveredTarget")
		PlayEffect(source, "RS3_FX_GP_Status_Warning_Red_01", "Dummy_OverheadFX")
	end
	return detected
end

function LLENEMY_Ext_CharacterIsHidden(target, source)
	for status,b in pairs(EnemyUpgradeOverhaul.InvisibleStatuses) do
		if b == true and HasActiveStatus(target, status) == 1 then
			return 1
		end
	end
	return 0
end

Ext.NewQuery(LLENEMY_Ext_CharacterIsHidden, "LLENEMY_Ext_QRY_CharacterIsHidden", "[in](CHARACTERGUID)_Character, [out](INTEGER)_IsHidden")

function LLENEMY_Ext_ClearGain(char)
	--ScaleExperienceByPlayerLevel_d5e1b4bc-dc7b-43dc-8bd0-d9f2b5e3a418
	if Ext.IsModLoaded("d5e1b4bc-dc7b-43dc-8bd0-d9f2b5e3a418") then
		SetTag(char, "LLXPSCALE_DisableDeathExperience")
	end
	NRD_CharacterSetPermanentBoostInt(char, "Gain", 0)
	CharacterAddAttribute(char, "Dummy", 0)
end

function LLENEMY_Ext_HM_RollAdditionalUpgrades(char)
	local bonusRolls = Ext.Random(1,3) + 1
	for i=bonusRolls,0,-1 do
		Osi.LLENEMY_Upgrades_RollForUpgrades(char)
		--Ext.Print("Rolling bonus roll: " .. tostring(i) .. " | " .. char)
	end
end

function LLENEMY_Ext_SpawnTreasureGoblin(x,y,z,level,combatid)
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
	Osi.LLENEMY_TreasureGoblins_Internal_OnGoblinSpawned(goblin, combatid)
	Osi.LLENEMY_Rewards_TreasureGoblin_ToggleScript(1)
	Osi.LeaderLib_Helper_MakeHostileToPlayers(goblin)
	Osi.LeaderLib_Timers_StartObjectTimer(goblin, 1000, "Timers_LLENEMY_Goblin_EnterCombatWithPlayers", "LeaderLib_Commands_EnterCombatWithPlayers")
end

function LLENEMY_Ext_Duplication_CopySource(source,dupe)
	local sourceCharacter = Ext.GetCharacter(source)
	for i,slot in pairs(LeaderLib.Data.VisibleEquipmentSlots) do
		local item = CharacterGetEquippedItem(source, slot)
		if item ~= nil then
			NRD_ItemCloneBegin(item)
			local clone = NRD_ItemClone()
			CharacterEquipItem(dupe, clone)
		end
	end
	local level = CharacterGetLevel(source)
	CharacterLevelUpTo(dupe, level)
	LLENEMY_Ext_Duplication_CopySourceStat(source, dupe, "LLENEMY_ApplyStats")
	LLENEMY_Ext_Duplication_CopyName(source, dupe)
	LLENEMY_Ext_Duplication_CopyCP(source, dupe)
	LLENEMY_Ext_ClearGain(dupe)
	NRD_CharacterIterateSkills(source, "LLENEMY_Dupe_CopySkill")
	Osi.LLENEMY_Duplication_Internal_SetupDupe_StageTwo(source, dupe)
end

function LLENEMY_Ext_Duplication_CopyCP(source,dupe)
	local cp = GetVarInteger(source, "LLENEMY_ChallengePoints")
	SetVarInteger(dupe, "LLENEMY_ChallengePoints", cp)
	LLENEMY_Ext_SetChallengePointsTag(dupe)
end

function LLENEMY_Ext_Duplication_CopySourceStat(source,dupe,applyevent)
	local sourceCharStat = Ext.GetCharacter(source).Stats.Name
	SetVarFixedString(dupe, "LLENEMY_Dupe_Stats", sourceCharStat)
	LeaderLib.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_Duplication_CopySourceStat] Copying stat " .. tostring(sourceCharStat) .." to dupe ("..dupe..").")
	SetStoryEvent(dupe, applyevent)
	NRD_CharacterSetPermanentBoostInt(dupe, "Gain", 0)
	CharacterAddAttribute(dupe, "Dummy", 0)
end

function LLENEMY_Ext_Duplication_CopyName(source,dupe)
	local handle,refStr = CharacterGetDisplayName(source)
	local characterName = Ext.GetTranslatedString(handle, refStr)
	local dupeNameBase = Ext.GetTranslatedString("h02023d82gc736g447fgaea3g327be0956688", "<font color='#BF5FFF'>[1] (Shadow)</font>")
	local dupeName = dupeNameBase:gsub("%[1%]", characterName)
	CharacterSetCustomName(dupe, dupeName)
end

function LLENEMY_Duplication_CopyStatus(source,dupe,status,handlestr)
	local handle = math.tointeger(handlestr)
	local auraRadius = Ext.StatGetAttribute(status, "AuraRadius")
	if auraRadius == nil or auraRadius == "" and HasActiveStatus(dupe, status, 0) then
		local duration = NRD_StatusGetReal(source, handle, "CurrentLifeTime")
		local statusSourceHandle = NRD_StatusGetGuidString(source, handle, "StatusSourceHandle")
		if statusSourceHandle == nil or statusSourceHandle == source then 
			statusSourceHandle = dupe
		end
		Osi.LLENEMY_Duplication_CopyStatus(source, dupe, status, duration, statusSourceHandle)
	end
end