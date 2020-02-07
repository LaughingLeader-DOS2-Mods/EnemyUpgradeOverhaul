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