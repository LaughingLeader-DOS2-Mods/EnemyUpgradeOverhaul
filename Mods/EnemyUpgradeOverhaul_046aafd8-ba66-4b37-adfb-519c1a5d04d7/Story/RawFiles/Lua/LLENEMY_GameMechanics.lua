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
function LLENEMY_Ext_IncreaseRage(character, damage, handle)
	--local hp = NRD_CharacterGetStatInt(character, "CurrentVitality")
	local maxhp = NRD_CharacterGetStatInt(character, "MaxVitality")
	local damage_ratio = math.max((damage / maxhp) * 88.88, 1.0)
	local add_rage = math.ceil(damage_ratio)
	Osi.LeaderLib_Variables_DB_ModifyVariableInt(character, "LLENEMY_Rage", add_rage, 999, 0);
	Ext.Print("[LLENEMY_GameMechanics.lua:LLENEMY_Ext_IncreaseRage] Added (",add_rage,") Rage to (",character,").")
end