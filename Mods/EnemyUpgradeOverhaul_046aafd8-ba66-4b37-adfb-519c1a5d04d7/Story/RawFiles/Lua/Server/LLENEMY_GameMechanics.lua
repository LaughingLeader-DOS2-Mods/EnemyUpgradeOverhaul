local COUNTER_MIN = 10
local COUNTER_MAX = 75

function LLENEMY_Ext_RollForCounterAttack(character,target)
	local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	local chance = (math.log(1 + initiative) / math.log(1 + COUNTER_MAX))
	chance = math.floor(chance * COUNTER_MAX) * 10
	local roll = LeaderLib.Common.GetRandom(999)
	Ext.Print("Counter roll: " .. tostring(roll) .. " / " .. tostring(chance))
	if roll >= chance then
		CharacterAttack(character, target)
		CharacterStatusText(character, "LLENEMY_StatusText_CounterAttack")
	end
end

local function StatDescription_Counter(character, param, statusSource)
	if param == "CounterChance" then
		--local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
		--Ext.Print("Char: " .. tostring(character) .. " | " .. LeaderLib.Common.Dump(character))
		local initiative = character.Initiative
		--local percent = (initiative - COUNTER_MIN) / (COUNTER_MAX - COUNTER_MIN)
		local chance = (math.log(1 + initiative) / math.log(1 + COUNTER_MAX))
		--Ext.Print("Chance: " .. tostring(chance))
		--local chance = (math.log(initiative/COUNTER_MIN) / math.log(COUNTER_MAX/COUNTER_MIN)) * COUNTER_MAX
		return "<font color='#D416FF'>" .. tostring(math.floor(chance * COUNTER_MAX)) .. "%</font>"
	end
end

EnemyUpgradeOverhaul.StatusDescriptionParams["LLENEMY_TALENT_COUNTER"] = StatDescription_Counter

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
	Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_IncreaseRage] Added ("..tostring(add_rage)..") Rage to ("..tostring(character).."). Total: ("..tostring(rage_entry[1][3])..")")
end

function LLENEMY_Ext_MugTarget_Start(character, target, handle)
	local hit_type = NRD_StatusGetInt(target, handle, "HitReason")
	Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_Start] Hit type: " .. tostring(hit_type))
	if (hit_type == 0 or hit_type == 3) and LeaderLib.Game.HitSucceeded(target, handle, 0) then
		Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_Start] ("..tostring(character)..") is mugging target: ", target)
		Osi.LLENEMY_Talents_MugTarget(character, target)
	else
		Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_Start] Dodged: ",NRD_StatusGetInt(target, handle, "Dodged")," | Missed: ", NRD_StatusGetInt(target, handle, "Missed")," | Blocked: ",NRD_StatusGetInt(target, handle, "Blocked"))
	end
end

function LLENEMY_Ext_MugTarget_StealGold(character, target)
	local gold = CharacterGetGold(target)
	Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_StealGold] Target ("..tostring(target)..") has ("..tostring(gold)..") gold.")
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
	Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_End] Picking items from:\n",LeaderLib.Common.Dump(items))
	local item_entry = LeaderLib.Common.GetRandomTableEntry(items)	
	if item_entry ~= nil then
		local item = item_entry[3]
		Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_MugTarget_End] Transfering (",item,") from (",target,") to (",character,").")
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
--Ext.NewCall(LLENEMY_Ext_MugTarget_DisplayText, "LLENEMY_Ext_MugTarget_DisplayText", "(CHARACTERGUID)_Enemy, (CHARACTERGUID)_Target, (ITEMGUID)_Item, (INTEGER)_Amount");

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
	local stats = nil
	-- if NRD_GetVersion() >= 39 then
	-- 	stats = NRD_CharacterGetStatString(char)
	-- end
	local character = Ext.GetCharacter(char)
	if character ~= nil then
		stats = character.Stats.Name
	end
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