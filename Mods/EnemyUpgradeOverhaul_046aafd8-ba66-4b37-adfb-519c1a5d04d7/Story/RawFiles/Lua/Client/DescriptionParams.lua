---@class TranslatedString
local TranslatedString = LeaderLib.Classes["TranslatedString"]

local counterParamText = TranslatedString:Create("h662390f7gfd9eg4a56g95e5g658283cc548a", "<font color='#D416FF'>[1]%</font>")

local function StatDescription_Counter(status, target, param, statusSource)
	--local initiative = NRD_CharacterGetComputedStat(character, "Initiative", 0)
	--Ext.Print("Char: " .. tostring(character) .. " | " .. LeaderLib.Common.Dump(character))
	local initiative = target.Initiative
	local counterMax = (Ext.ExtraData.LLENEMY_Counter_MaxChance or 75)
	--local percent = (initiative - COUNTER_MIN) / (COUNTER_MAX - COUNTER_MIN)
	local chance = (math.log(1 + initiative) / math.log(1 + counterMax))
	--Ext.Print("Chance: " .. tostring(chance))
	--local chance = (math.log(initiative/COUNTER_MIN) / math.log(COUNTER_MAX/COUNTER_MIN)) * COUNTER_MAX
	return string.gsub(counterParamText.Value, "%[1%]", tostring(math.floor(chance * counterMax)))
end

StatusDescriptionParams["LLENEMY_Talent_CounterChance"] = StatDescription_Counter

---@param status EsvStatus
---@param statusSource EsvGameObject
---@param target StatCharacter
---@param param string
local function StatusGetDescriptionParam(status, statusSource, target, param, ...)
	--LeaderLib.PrintDebug("[LLENEMY_StatusGetDescriptionParam] status("..tostring(status.Name)..") statusSource("..tostring(statusSource.Name)..")["..tostring(statusSource.NetID).."] character("..tostring(target.Name)..")["..tostring(target.NetID).."] param("..tostring(param)..")")
	local func = StatusDescriptionParams[param]
	if func ~= nil then
		if target.Character ~= nil then
			local b,result = xpcall(func, debug.traceback, status, target, param, statusSource)
			if not b then
				Ext.PrintError("[LLENEMY_StatusGetDescriptionParam] Error getting status param | status("..tostring(status.Name)..") param("..tostring(param)..")")
				Ext.PrintError(tostring(result))
			elseif result ~= nil then
				return result
			end
		else
			Ext.PrintError("[LLENEMY_StatusGetDescriptionParam] Error: target.Character is nil?")
			return ""
		end
	end
end
Ext.RegisterListener("StatusGetDescriptionParam", StatusGetDescriptionParam)

local function SkillGetDescriptionParam(skill, character, param)

end
--Ext.RegisterListener("SkillGetDescriptionParam", SkillGetDescriptionParam)